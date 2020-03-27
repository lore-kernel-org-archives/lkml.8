Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52DBCC43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 16:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25AAC2072F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 16:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="VFK791c3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbgC0QaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 12:30:02 -0400
Received: from mout.gmx.net ([212.227.15.18]:41461 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727560AbgC0QaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 12:30:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1585326580;
        bh=1Em0LI/KVl1xxriM0SUJ9ct2bhqg2n0IpV9lkveMp00=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=VFK791c33sNkRSMGCC6CNnw4TjESkCF/FwFciz50fiUiWEs64KqatwrlDZHe+emQp
         rWNhqpucHDYR+D1pl8ySVMmJipSGdf9fIDSMZVSUOGmERFbpKWEA3ueQevXpV4nb84
         ontBHXKtafBRP0og9+BsQvmsbehQNJlQWDObOTOY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([82.19.195.159]) by mail.gmx.com
 (mrgmx004 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1N7i8O-1jLuL343CU-014kxm; Fri, 27 Mar 2020 17:29:40 +0100
From:   Alex Dewar <alex.dewar@gmx.co.uk>
Cc:     alex.dewar@gmx.co.uk, Russell King <linux@armlinux.org.uk>,
        Enrico Weigelt <info@metux.net>,
        Allison Randal <allison@lohutok.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm: dma-mapping: Remove unneeded NULL checks
Date:   Fri, 27 Mar 2020 16:29:13 +0000
Message-Id: <20200327162914.24948-1-alex.dewar@gmx.co.uk>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Vflazi5to4WwXtKcR0FGBcrbXYZ36lA8poJ8iwEZ1rnQsK7j7s+
 vIXToVShPwP07aJxDadCHyZ17J4FxImijCtv9DLX+5kelt88bP010UqQ+tgUfqY4D+VrHqI
 edxmB2JsfLaq4YGG+FFW2MzZ6NZwsKBBU/dEVynpi98lDdFQC653JBhMwkP+LbPWGnahLkd
 vQAb2/t/ANGz4Otdqi45Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:f09u4bQ98iM=:Y494TvphxhbHLCNgofeeX+
 1ZQxJ8nYdLhJBywlKG8jb6GRAVO6ZyGB+S+cp9/LFS5iCIyuXU8qlr3wMHr/c3YroRZPNXm2V
 DknnZTDhLb0uEt7Cc5w6Ko/ZoV6ZVvvC0l9KOWH0YBXGyAraQjTx3H/ov3yF/buELAGrboG9X
 hohBcPDICNMhzNBxXZC15AQlLrDa3fR8j4u/Adr/wJmu3Zyxk3wpzIoQM9cpEPB88ur32dBHy
 DY/99Nop+CHZuaqENdmmGHx+oJpuPPaN5IRHKgsFJTbDbp/Lbo0WHomEUdAv8fAyUaFaEamUX
 8F/tgtE0QXSwjAVZ/ypSpveEVqR7I3LrOpdStLvahGaOYG8qK+6O+lorw1aECIvzYLtZjiBd8
 fOSTSvleyEd1J8JaSmNDbbYo6ooRddqB206p9Lb6z5i3K/wEsoqZZdWt7B+fjNHjH983cc8kl
 xjibT3NKIgIUrEt2nUHsKayIgtADr904PNlUqe0HrnvUc06ZyQuqyCEGGuhmpwtmO2lDBgSvm
 huAy9LE2wAkfwGkNLYJhEPlZWIEmJhHWJzf1uU6n9TxAwV/7LZekvuUAaMZWZxhN0qcE6F76D
 GZeAgWmG48SYkvateeah8GNwmK0ZSBc2IMoICM8rC7WVZypFQhHeGHZqc5At+6N5BfKj0s2wf
 Y81XFC3s6kozQbEtNECuWWZ9Oh43nplPvK43h3faIIeSeHo1qi+V6Zknzy1BqrO4YjwsY6fOP
 3Eb5JbtGYNn7b4pqPnE/86ojXYQ+5dhns8W0hZFHGzEuTdnzh41lMmtW4EBjNseO3eUtd36+7
 cOZ/QN96cco9Q/G6AGiTEgYG8HYDFfenQ2RNAX15VeGXDP37GL1LB8/kjSZq0IOcd+muP8HZj
 ozgMVU1EFK5PxmsrO2Y3BixwA6B9HZ4RjYhU8gGHzez8ekxTCSm9r7WvEPgkyYD3d39ZTOL4y
 o/cpE6/qQfK2ZwcsWV9w2CESvlugL0sedgF+s2zMkm2PtWEfqO3SzAw5xiVaipO57J2sUWCjy
 m1Na9JCCikwA8F3rjS9oD+oYDzJPQ6fMOGDf+zoEP1JGZ7uejsbI54JqWmS6eiAbk+q0MYd/J
 qURvUgvRgd4inLTinChk+vhsFs2BI4liqzVbK8tVTQp8oSFxlEmglymz0VhqJpLcsp0kXsFFn
 H+b5MnjzP2LAL/b1S+w5gp86kYyCiWCbrnpQVu+hNj7+hOWikYUtqT2bP5IsoeCkq0MaE5BWT
 JTuqgtCMB1aqg4ouW
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_pool_destroy() already checks for NULL arguments, so the extra check
is unnecessary.

Signed-off-by: Alex Dewar <alex.dewar@gmx.co.uk>
=2D--
 arch/arm/common/dmabounce.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/common/dmabounce.c b/arch/arm/common/dmabounce.c
index f4b719bde763..a7c776cdc38f 100644
=2D-- a/arch/arm/common/dmabounce.c
+++ b/arch/arm/common/dmabounce.c
@@ -560,10 +560,8 @@ void dmabounce_unregister_dev(struct device *dev)
 		BUG();
 	}

-	if (device_info->small.pool)
-		dma_pool_destroy(device_info->small.pool);
-	if (device_info->large.pool)
-		dma_pool_destroy(device_info->large.pool);
+	dma_pool_destroy(device_info->small.pool);
+	dma_pool_destroy(device_info->large.pool);

 #ifdef STATS
 	if (device_info->attr_res =3D=3D 0)
=2D-
2.26.0

