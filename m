Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C158C3F68F
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 05:06:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DB372084E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 05:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgBDFGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 00:06:12 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:59896 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725813AbgBDFGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 00:06:12 -0500
Received: from mr2.cc.vt.edu (inbound.smtp.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id 01456Apj002924
        for <linux-kernel@vger.kernel.org>; Tue, 4 Feb 2020 00:06:10 -0500
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
        by mr2.cc.vt.edu (8.14.7/8.14.7) with ESMTP id 0145652L005691
        for <linux-kernel@vger.kernel.org>; Tue, 4 Feb 2020 00:06:10 -0500
Received: by mail-qt1-f199.google.com with SMTP id o24so11577173qtr.17
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 21:06:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=pz98ZlR3bR56pQ1i3ZQP3uFsFMXbwH6n0r2XfZ1ia0I=;
        b=HUZtdYBhIgXPRCF9LwyvcjKuhPOAFNuONwzGhkwwDGO8dSvwmBosVWwsiXt+VXpcDX
         F7Ph1ShFuuvKn0i07HM65HpQHllOJtW+P2XihREGmoMmjaaGnYG0R2ItIBijY3+y2swf
         trVYNLIyviHV0SQ4bq8m+e7U/sSLyKAhWTl0fLa1Z54KYiL+MUImu2pCDt1vIuslNv2J
         eocUwpY4CbgUqLN7QW8K5r3VuJk02slsIqcPdsPqpFdfD/tCfFr/dIP6aVK81fcnfQT+
         DDZa5L/nlXMKBS322MVBYfovaRHAF7M3GWLtl1AF/D2OO5VZHV0f/0pTM13nuW0RGL7H
         Xs+g==
X-Gm-Message-State: APjAAAXjrlUb6QSsQYjtSCFF79/fa0p83Xp7KMTWJBbRW7Y/KtL6c//q
        LQwtuw9i3I8RUIBf31VG/gDm8VRDVgSicRW6AdQoUCbUrDrkC1JAb927AcwOxy8bJwz41u3iawE
        U7N9c+4Es3FtWeCY5BB8GeNXSlgXZCylq/6s=
X-Received: by 2002:ac8:4e43:: with SMTP id e3mr27432120qtw.129.1580792765281;
        Mon, 03 Feb 2020 21:06:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqxVWoIMwNoBeStRaw+j6XUPYd1HIGxOIIrMq0t70HtTsVrjAec0Q+NTOrEhNh1FQevpnMDynA==
X-Received: by 2002:ac8:4e43:: with SMTP id e3mr27432090qtw.129.1580792764954;
        Mon, 03 Feb 2020 21:06:04 -0800 (PST)
Received: from turing-police ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id z11sm10600747qkj.91.2020.02.03.21.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 21:06:03 -0800 (PST)
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Namjae Jeon <linkinjeon@gmail.com>
cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, hch@lst.de, sj1557.seo@samsung.com,
        pali.rohar@gmail.com, arnd@arndb.de, namjae.jeon@samsung.com,
        viro@zeniv.linux.org.uk
Subject: [PATCH v2] exfat: update file system parameter handling
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Tue, 04 Feb 2020 00:06:02 -0500
Message-ID: <328657.1580792762@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro recently reworked the way file system parameters are handled
Update super.c to work with it in linux-next 20200203.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
---
Changes in v2: make patch work with -p1 rather than -p0.

--- a/fs/exfat/super.c.orig	2020-02-03 21:11:02.562305585 -0500
+++ b/fs/exfat/super.c	2020-02-03 22:17:21.699045311 -0500
@@ -214,7 +214,14 @@ enum {
 	Opt_time_offset,
 };
 
-static const struct fs_parameter_spec exfat_param_specs[] = {
+static const struct constant_table exfat_param_enums[] = {
+	{ "continue",		EXFAT_ERRORS_CONT },
+	{ "panic",		EXFAT_ERRORS_PANIC },
+	{ "remount-ro",		EXFAT_ERRORS_RO },
+	{}
+};
+
+static const struct fs_parameter_spec exfat_parameters[] = {
 	fsparam_u32("uid",			Opt_uid),
 	fsparam_u32("gid",			Opt_gid),
 	fsparam_u32oct("umask",			Opt_umask),
@@ -222,25 +229,12 @@ static const struct fs_parameter_spec ex
 	fsparam_u32oct("fmask",			Opt_fmask),
 	fsparam_u32oct("allow_utime",		Opt_allow_utime),
 	fsparam_string("iocharset",		Opt_charset),
-	fsparam_enum("errors",			Opt_errors),
+	fsparam_enum("errors",			Opt_errors, exfat_param_enums),
 	fsparam_flag("discard",			Opt_discard),
 	fsparam_s32("time_offset",		Opt_time_offset),
 	{}
 };
 
-static const struct fs_parameter_enum exfat_param_enums[] = {
-	{ Opt_errors,	"continue",		EXFAT_ERRORS_CONT },
-	{ Opt_errors,	"panic",		EXFAT_ERRORS_PANIC },
-	{ Opt_errors,	"remount-ro",		EXFAT_ERRORS_RO },
-	{}
-};
-
-static const struct fs_parameter_description exfat_parameters = {
-	.name		= "exfat",
-	.specs		= exfat_param_specs,
-	.enums		= exfat_param_enums,
-};
-
 static int exfat_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
 	struct exfat_sb_info *sbi = fc->s_fs_info;
@@ -248,7 +242,7 @@ static int exfat_parse_param(struct fs_c
 	struct fs_parse_result result;
 	int opt;
 
-	opt = fs_parse(fc, &exfat_parameters, param, &result);
+	opt = fs_parse(fc, exfat_parameters, param, &result);
 	if (opt < 0)
 		return opt;
 
@@ -665,7 +659,7 @@ static struct file_system_type exfat_fs_
 	.owner			= THIS_MODULE,
 	.name			= "exfat",
 	.init_fs_context	= exfat_init_fs_context,
-	.parameters		= &exfat_parameters,
+	.parameters		= exfat_parameters,
 	.kill_sb		= kill_block_super,
 	.fs_flags		= FS_REQUIRES_DEV,
 };

