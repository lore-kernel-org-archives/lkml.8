Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE03C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 22:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 542FC20684
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 22:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595543205;
	bh=4I6K2bstw8whHHQ3mWdIbhXto4R03CtTeG7e4+0kzFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fqT454Dsv+mQdMthdE5VidRF3Wkj0Jo6Lq9+ZopJbPcRqEvudL4l5wVh35z1/F9Vn
	 Ipv67sE+dRvoYO/FeFlNmKn1fzfhvsXlezThv1Mu1eNVxvQbuSdAPO5HFsSmPWHrzY
	 Zf/XZetwNAZh0oxTl3oMLqakXXoGH3Q8U6M1opIA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgGWW0o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 18:26:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:39764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726417AbgGWW0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 18:26:43 -0400
Received: from embeddedor (unknown [201.162.245.27])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D618620684;
        Thu, 23 Jul 2020 22:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595543203;
        bh=4I6K2bstw8whHHQ3mWdIbhXto4R03CtTeG7e4+0kzFc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LRShgveQJG+PEGpRtCQ3fo2lUNePVuucYahn31B5+daFQkrttyecjlfSjqxna+dtC
         2uJrxE8rgrfIKxopUHROGeuhzdRaxlB5NoHCPClwlJ6+01+uL/33jj6l5YgYdada1k
         jcD8/OaTsvBhJ0ZpSzr0otmo2OuKYtubcwr6YZg0=
Date:   Thu, 23 Jul 2020 17:32:25 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH 2/3] tty: Fix identation issues in struct serial_struct32
Message-ID: <77576843397aeab0af8aa0423a9768f3ca8dedfb.1595543280.git.gustavoars@kernel.org>
References: <cover.1595543280.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1595543280.git.gustavoars@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following checkpatch.pl warnings together with all the
identation issues in struct serial_struct32:

ERROR: code indent should use tabs where possible
+        char    reserved_char;$

WARNING: please, no spaces at the start of a line
+        char    reserved_char;$

ERROR: code indent should use tabs where possible
+        compat_int_t    reserved;$

WARNING: please, no spaces at the start of a line
+        compat_int_t    reserved;$

Acked-by: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/tty/tty_io.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 3b6e5ec3ba54..629fbafc9b7e 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2673,25 +2673,25 @@ long tty_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 #ifdef CONFIG_COMPAT
 
 struct serial_struct32 {
-        compat_int_t    type;
-        compat_int_t    line;
-        compat_uint_t   port;
-        compat_int_t    irq;
-        compat_int_t    flags;
-        compat_int_t    xmit_fifo_size;
-        compat_int_t    custom_divisor;
-        compat_int_t    baud_base;
-        unsigned short  close_delay;
-        char    io_type;
-        char    reserved_char;
-        compat_int_t    hub6;
-        unsigned short  closing_wait; /* time to wait before closing */
-        unsigned short  closing_wait2; /* no longer used... */
-        compat_uint_t   iomem_base;
-        unsigned short  iomem_reg_shift;
-        unsigned int    port_high;
-     /* compat_ulong_t  iomap_base FIXME */
-        compat_int_t    reserved;
+	compat_int_t    type;
+	compat_int_t    line;
+	compat_uint_t   port;
+	compat_int_t    irq;
+	compat_int_t    flags;
+	compat_int_t    xmit_fifo_size;
+	compat_int_t    custom_divisor;
+	compat_int_t    baud_base;
+	unsigned short  close_delay;
+	char    io_type;
+	char    reserved_char;
+	compat_int_t    hub6;
+	unsigned short  closing_wait; /* time to wait before closing */
+	unsigned short  closing_wait2; /* no longer used... */
+	compat_uint_t   iomem_base;
+	unsigned short  iomem_reg_shift;
+	unsigned int    port_high;
+	/* compat_ulong_t  iomap_base FIXME */
+	compat_int_t    reserved;
 };
 
 static int compat_tty_tiocsserial(struct tty_struct *tty,
-- 
2.27.0

