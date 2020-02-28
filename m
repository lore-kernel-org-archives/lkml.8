Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB02C3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 02:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AF05246A0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 02:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nhdW5Ajt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730737AbgB1CIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 21:08:19 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60050 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730460AbgB1CIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 21:08:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=FfsYsRfTjNajsD2GsxdnNUOvzZKpPZHuyvHpz7l7J88=; b=nhdW5AjtAMws3EgTqeFy6/vuK3
        R+rbnqCVk7u1xiWaE92B5CCcaqderIiBwZEd2FLW9uraQMhSxMwOYdPR8n2ae+E+yB5+sDNuYSkE/
        FkfZUQodVnuZN0g4b3ENHV+/rBLU13yHjQ5c/0GHEBvNgccrNtmuPiAoE312h+jnzDekR1wdUHrsT
        Q+aoif/BXs0+olsOPhzZfPhDSrIN4cIIMN8XkB/MWrDDHsc3/ZnyqtkMnH9SBioY3VHMkuY4MGZU6
        QD4HYbnZ4b/Kjpn8JFl0dJ6zRPrMsOobUzDeFKv7lBelGHYouIsrklpvPhEmwjXTkGWaY8kTLShAB
        qM0CwVnA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j7V4a-0003dZ-6m; Fri, 28 Feb 2020 02:08:16 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        linux-parport@lists.infradead.org
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] parport: fix if-statement empty body warnings
Message-ID: <e7868a5c-5356-bbbb-f416-799a7f75f7ad@infradead.org>
Date:   Thu, 27 Feb 2020 18:08:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

When debugging via DPRINTK() is not enabled, make the DPRINTK()
macro be an empty do-while block.

This fixes gcc warnings when -Wextra is set:

../drivers/parport/ieee1284.c:262:18: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
../drivers/parport/ieee1284.c:285:17: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
../drivers/parport/ieee1284.c:298:17: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]
../drivers/parport/ieee1284_ops.c:576:18: warning: suggest braces around empty body in an ‘if’ statement [-Wempty-body]

I have verified that there is no object code change (with gcc 7.5.0).

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
Cc: linux-parport@lists.infradead.org
---
 drivers/parport/ieee1284.c     |    2 +-
 drivers/parport/ieee1284_ops.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200225.orig/drivers/parport/ieee1284.c
+++ linux-next-20200225/drivers/parport/ieee1284.c
@@ -34,7 +34,7 @@
 #ifdef DEBUG
 #define DPRINTK(stuff...) printk (stuff)
 #else
-#define DPRINTK(stuff...)
+#define DPRINTK(stuff...) do {} while (0)
 #endif
 
 /* Make parport_wait_peripheral wake up.
--- linux-next-20200225.orig/drivers/parport/ieee1284_ops.c
+++ linux-next-20200225/drivers/parport/ieee1284_ops.c
@@ -30,7 +30,7 @@
 #ifdef DEBUG
 #define DPRINTK(stuff...) printk (stuff)
 #else
-#define DPRINTK(stuff...)
+#define DPRINTK(stuff...) do {} while (0)
 #endif
 
 /***                                *

