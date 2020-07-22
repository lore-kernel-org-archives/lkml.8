Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,
	BODY_QUOTE_MALF_MSGID,DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EA7C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A883207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595442575;
	bh=pcktKZTCKWzaS110Do5EGzs0M7bM7qaMMzdkMG5ZuDw=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=eQm2npGJLlk4YcKUSNGD4u5MeAvB2PBdY7QgHGQiy5jmTWButwABcfcEBymwA3xeR
	 W+5nIlNNl+9TPYj2eRczt9oLtNFh3/QYAbR9/WkXdQEKgJy7jeagBEPxF9OiBoFuuN
	 fowXqhLWaAE3/FiYARVvmyeeDbWrDuuJX4y9d5+8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730346AbgGVS3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 14:29:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:39788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbgGVS3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 14:29:33 -0400
Received: from embeddedor (unknown [201.162.161.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC133207E8;
        Wed, 22 Jul 2020 18:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595442573;
        bh=pcktKZTCKWzaS110Do5EGzs0M7bM7qaMMzdkMG5ZuDw=;
        h=Date:From:To:Cc:Subject:From;
        b=JxAdibxk6IwAlHU5ThKQU/QSdWXFNsJ4H+cQSgYbkLB19jELsXbfv64N5ZG6O758a
         u4YBjcDMc9GzmJt45kIEoSq1QFAWPyWE6cusnNlKEoQfr6jAhKc/C77lqSMbZ2Tlkh
         wyrweeCS7Y1O7C+ZEA+MKOCSz3sC/LiEHDOm82ns=
Date:   Wed, 22 Jul 2020 13:35:11 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH v2][next] tty: Avoid the use of one-element arrays
Message-ID: <20200722183511.GA15383@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One-element arrays are being deprecated[1]. Replace the one-element arrays
with simple value types 'char reserved_char' and 'compat_int_t reserved'[2],
once it seems these are just placeholders for alignment.

Also, while there, use the preferred form for passing a size of a struct.
The alternative form where struct name is spelled out hurts readability
and introduces an opportunity for a bug when the variable type is changed
but the corresponding sizeof that is passed as argument is not.

Lastly, fix the checkpatch.pl warnings below:

ERROR: code indent should use tabs where possible
+        char    reserved_char;$

WARNING: please, no spaces at the start of a line
+        char    reserved_char;$

ERROR: code indent should use tabs where possible
+        compat_int_t    reserved;$

WARNING: please, no spaces at the start of a line
+        compat_int_t    reserved;$

[1] https://github.com/KSPP/linux/issues/79
[2] https://github.com/KSPP/linux/issues/86

Tested-by: kernel test robot <lkp@intel.com>
Link: https://github.com/GustavoARSilva/linux-hardening/blob/master/cii/0-day/tty-20200716.md
Acked-by: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Fix indentation issues in struct serial_struct32.
 - Add Jiri's Acked-by.

 drivers/tty/tty_io.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 5a6f36b391d9..bb74c2ffcced 100644
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
-        char    reserved_char[1];
-        compat_int_t    hub6;
-        unsigned short  closing_wait; /* time to wait before closing */
-        unsigned short  closing_wait2; /* no longer used... */
-        compat_uint_t   iomem_base;
-        unsigned short  iomem_reg_shift;
-        unsigned int    port_high;
-     /* compat_ulong_t  iomap_base FIXME */
-        compat_int_t    reserved[1];
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
@@ -2705,7 +2705,7 @@ static int compat_tty_tiocsserial(struct tty_struct *tty,
 	struct serial_struct v;
 	int flags;
 
-	if (copy_from_user(&v32, ss, sizeof(struct serial_struct32)))
+	if (copy_from_user(&v32, ss, sizeof(*ss)))
 		return -EFAULT;
 
 	memcpy(&v, &v32, offsetof(struct serial_struct32, iomem_base));
@@ -2743,7 +2743,7 @@ static int compat_tty_tiocgserial(struct tty_struct *tty,
 			0xfffffff : ptr_to_compat(v.iomem_base);
 		v32.iomem_reg_shift = v.iomem_reg_shift;
 		v32.port_high = v.port_high;
-		if (copy_to_user(ss, &v32, sizeof(struct serial_struct32)))
+		if (copy_to_user(ss, &v32, sizeof(v32)))
 			err = -EFAULT;
 	}
 	return err;
-- 
2.27.0

