Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8BADC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 17:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD2C52065F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 17:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593192089;
	bh=+OoI5HO5jec01TiPSARTaK/vibaKquih75HHyaat+zo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gTstW0Iut7jUUL/UBAYmxUspa6GpYPvWI7VVIDF9fPB06kINjaTWQR5fKXeiGyr2O
	 HlXbjKWcN3E6BAbCFQt1c++5txdH54HpQzHdedmuISu3FY45T/DSAVR8JP18sG1baT
	 iClJGuv89lnTm/MBD81XhDZnFi7detiWMdBO9Qb0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbgFZRV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 13:21:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:39944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbgFZRVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 13:21:23 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7446120823;
        Fri, 26 Jun 2020 17:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593192083;
        bh=+OoI5HO5jec01TiPSARTaK/vibaKquih75HHyaat+zo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H+u5bmyC/WoHUHYRd7qLu7rHCXOADNouAEKHXurNm/t/6K0jy4ofab4A/8+OrrYP/
         kvT+zTgfXpMlj4OJo9kyANSJG+Fx/DonmgNUMIAUwIUuinIEclamwBPY5+JNC2gq5o
         WrwlcqqCongJHi1JIzhPrfAWoZocNLBLHbNrIVX4=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Juergen Gross <jgross@suse.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 5/6] selftests/x86/syscall_nt: Clear weird flags after each test
Date:   Fri, 26 Jun 2020 10:21:15 -0700
Message-Id: <907bfa5a42d4475b8245e18b67a04b13ca51ffdb.1593191971.git.luto@kernel.org>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <cover.1593191971.git.luto@kernel.org>
References: <cover.1593191971.git.luto@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clear the weird flags before logging to improve strace output --
logging results while, say, TF is set does no one any favors.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 tools/testing/selftests/x86/syscall_nt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/x86/syscall_nt.c b/tools/testing/selftests/x86/syscall_nt.c
index f060534b66a0..5fc82b9cebed 100644
--- a/tools/testing/selftests/x86/syscall_nt.c
+++ b/tools/testing/selftests/x86/syscall_nt.c
@@ -59,6 +59,7 @@ static void do_it(unsigned long extraflags)
 	set_eflags(get_eflags() | extraflags);
 	syscall(SYS_getpid);
 	flags = get_eflags();
+	set_eflags(X86_EFLAGS_IF | X86_EFLAGS_FIXED);
 	if ((flags & extraflags) == extraflags) {
 		printf("[OK]\tThe syscall worked and flags are still set\n");
 	} else {
-- 
2.25.4

