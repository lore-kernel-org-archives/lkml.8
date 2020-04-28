Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BEDC83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:37:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0CDE20730
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgD1Vh5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:37:57 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:33851 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbgD1Vh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 17:37:57 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MHWvH-1jPPBf34gD-00DTbe; Tue, 28 Apr 2020 23:37:50 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: oabi-compat: fix epoll_ctl build failure
Date:   Tue, 28 Apr 2020 23:37:30 +0200
Message-Id: <20200428213747.3663311-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:QyK016Hxxs2OI4rE97oUpmPh5N6kM6aosbQ68YRzxwtX1/dXUdB
 0fLRccOS5TJ87dAmY5lXl9hW1mtKzy1fGKgq9RNLog1tdehYxRSgCgGna6b1uMemS+9wHoe
 rNWTE6gw/UJL2G2Qn05rWe1T/9MZjqOx6FxxB+6NR8CV4+zXSOgBwl18+6FYbs2xSWNmJee
 Xqz7IsH8BXfAZ++8EKbIg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:n3DbFsskL/8=:ufFsxFEofaBBL5hPfYnX/M
 vYmoPRuqG/pTgqLiBKcFYUBpL0n5JYHwrercUv1AGgsWwhImbmeEGiXaj89YPzFUAOynMGTbf
 SR6p1XMH2qbHfLV2nOB6azj6FCzFsI7nITIsc35DM8GuTJCJ7WLHEJOawhJPXOVAiJaDzluWY
 Qm1+/d8OsmNnxWhNU1jmAkm5f1qdDEnhg3+idDBqQNaMeb1Sbaa0zfVvNhb8kN2hT3GjhwWDq
 rxulETf53DdM5nU3rSSl+P1HAPGrDNUEO+9uE6RIpkumvOD0O77GCLTYrH+QJ3vYCv9P6pq1A
 aYfTENKozkzGUrb6jhupmjhMELSsktlSuUbLPDDN3kgo5wV7PBBNzB1H7BDxIqWp9KKFRNuU2
 Wg4xCrjlIwb8IglvQJuBzBm71aObtO8S1Gw72zSS+i7zWkx1fjSiCFmHvVrnw0WWleTLLIIMS
 4GtGd7Auh7BKCZvP6hbd1cSh43KhvTOBqUknyscRVU0/ZOcjQnXyionmytafK3p1gbXDl5Y8a
 sExzl0I8J1779HHSP/Gyu52Rb1y7CMLY5IBVOG0qj3r3M8KjlY8oj726h43ROT+op8shNB+TI
 eWl+MqLE0TznaMCt1gBeDcJbfopyG0FY7bLb9QTQaItss6RDjpFmLarFu8M0govtKnrK8Orho
 HmwYnz1yVwhYho3JWiCkrCrTcMB1cwRRivcCiAa73ad6+p+ZKhoSlcpDRSmCmW1eMtwYxrCbN
 n3CIU0EDaBRWyRCsBPxP1Abj7FrDs1yNnMUY0olmw2lBjuAnaDkMa8x57olbjNLVFHgtIUhKu
 CJHYhqp4uvTPh8lseagc6OACse+P8dNGSBzErGPZbJNyjaJF8E=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two functions are not declared or defined when CONFIG_EPOLL is
disabled:

arch/arm/kernel/sys_oabi-compat.c: In function 'sys_oabi_epoll_ctl':
arch/arm/kernel/sys_oabi-compat.c:258:6: error: implicit declaration of function 'ep_op_has_event' [-Werror=implicit-function-declaration]
  258 |  if (ep_op_has_event(op) &&
      |      ^~~~~~~~~~~~~~~
arch/arm/kernel/sys_oabi-compat.c:265:9: error: implicit declaration of function 'do_epoll_ctl'; did you mean 'sys_epoll_ctl'? [-Werror=implicit-function-declaration]
  265 |  return do_epoll_ctl(epfd, op, fd, &kernel, false);
      |         ^~~~~~~~~~~~
      |         sys_epoll_ctl

Blank out the entire function contents in this case.

Fixes: c281634c8652 ("ARM: compat: remove KERNEL_DS usage in sys_oabi_epoll_ctl()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Alternatively, we could use stub functions in the header file, or
hide the entire function and use sys_ni_syscall() to provide a
stub entry point.
---
 arch/arm/kernel/sys_oabi-compat.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/kernel/sys_oabi-compat.c b/arch/arm/kernel/sys_oabi-compat.c
index 85a1e95341d8..cdc99bab1a1d 100644
--- a/arch/arm/kernel/sys_oabi-compat.c
+++ b/arch/arm/kernel/sys_oabi-compat.c
@@ -252,6 +252,7 @@ struct oabi_epoll_event {
 asmlinkage long sys_oabi_epoll_ctl(int epfd, int op, int fd,
 				   struct oabi_epoll_event __user *event)
 {
+#ifdef CONFIG_EPOLL
 	struct oabi_epoll_event user;
 	struct epoll_event kernel;
 
@@ -263,6 +264,9 @@ asmlinkage long sys_oabi_epoll_ctl(int epfd, int op, int fd,
 	kernel.data   = user.data;
 
 	return do_epoll_ctl(epfd, op, fd, &kernel, false);
+#else
+	return -ENOSYS;
+#endif
 }
 
 asmlinkage long sys_oabi_epoll_wait(int epfd,
-- 
2.26.0

