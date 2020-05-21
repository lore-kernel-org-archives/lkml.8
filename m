Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A1E6C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 12:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 292632078B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 12:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590063656;
	bh=ajfo6P7BYx287i+EILRdYZT2mOSu7ADSA6cIK6mA8yY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=J7ipWFCg/gWxs3nGC/tbmBl7kDs3Bzdy1uJlFoHSJqONFsZurkVqCEPwP4/xdKqKP
	 1CrmL53jsDe2E91aFw4p+GCulF5kUEc7yfpbDRWnf6HC5toBScmf9X3B75UNXGC6CS
	 m0PftOGYPpuyVBEAUuoaPP5Rx6qklGnanUi97AjY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729295AbgEUMUz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 08:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729214AbgEUMUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 08:20:54 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93CDAC061A0E;
        Thu, 21 May 2020 05:20:54 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a5so2987007pjh.2;
        Thu, 21 May 2020 05:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=stWt/FkAV3whglFbcJ+xccRha/qYgrl6lOTok0wajJI=;
        b=CiG6I0E9MNcMSok6mI8B8l0WOE1Jhf4njbivNxYqT7m/509HAlg43f4SsWgLClFI3k
         fPmF/ufGTX6mkSwQC/igr02SXod+141NPaGRZ7sLICSHsL56s0ik5TAAa8y30cKSOPRM
         CMoxuY75TWChVAaVKQiZaRHVRuk+Y1YaOtjNLsSWyrie6gnUkakPWqR1Jqjq6Tq1y+D6
         kghA+TLKRNzgzGEXpUfiVJE4Wuv032OxkssdEaGuAwD4q8UITu0Fizu9isEYlXfPd0zE
         zWvAx5Zj2RCqSjoe6pczEQzxw4AGTaK7gn5LiQ3kJ3i2OrSwLfppVw88uzoC+63qzH7G
         0w9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=stWt/FkAV3whglFbcJ+xccRha/qYgrl6lOTok0wajJI=;
        b=alzrpHBfpS17gAdnoMtVlMiqRdGcnGT1VJUMRIIdkuQtIi4H9h2DuF5LX5Hjm0XjRa
         OGrg+XE9zEcQUdYpScE5noHeaTfpf6+0glE/3L5hjaJ2nq+buv2rLj6ptxLPJoiQT3dD
         Tj7pVKMNHfJ6xpYe1ilcEJW2U/6VZ+NfvQ3vRCfeUB1wYsiZhzVD/Hukn32vjdcaIpUS
         UbbnustAyuZKK0eSZuoGptiZ37BhHnnGdALKWSWaVdRqYyifI5suXtGi6T10b6rqRxgb
         Tl2xeXeuBWydz18CmW02nEGJX6ukQFqk3Jlp6znl/Sox8OCGt761uGdiAOwQVv6i9sDc
         xDCg==
X-Gm-Message-State: AOAM530slUdHSXjpqmus1N9ab1vCnVl1GzzyHvVU4Q/apW1GMl0svFNK
        aYRCni2I6WNRQqCbBVNdafzSIdRp
X-Google-Smtp-Source: ABdhPJyFihLfVSUUClYWBD16iRFax2GMCdIhiO8QpL/RTTsIlojruoS1SI49pxTjv8nLltLWKBHuMA==
X-Received: by 2002:a17:902:6bcb:: with SMTP id m11mr9164799plt.264.1590063653750;
        Thu, 21 May 2020 05:20:53 -0700 (PDT)
Received: from localhost.localdomain ([221.146.116.86])
        by smtp.gmail.com with ESMTPSA id m12sm4142169pgj.46.2020.05.21.05.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 05:20:53 -0700 (PDT)
From:   Namjae Jeon <linkinjeon@kernel.org>
X-Google-Original-From: Namjae Jeon <namjae.jeon@samsung.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: [PATCH] exfat: add the dummy mount options to be backward compatible with staging/exfat
Date:   Thu, 21 May 2020 21:20:34 +0900
Message-Id: <20200521122034.2254-1-namjae.jeon@samsung.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Ubuntu and Fedora release new version used kernel version equal to or
higher than v5.4, They started to support kernel exfat filesystem.

Linus Torvalds reported mount error with new version of exfat on Fedora.

	exfat: Unknown parameter 'namecase'

This is because there is a difference in mount option between old
staging/exfat and new exfat.
And utf8, debug, and codepage options as well as namecase have been
removed from new exfat.

This patch add the dummy mount options as deprecated option to be backward
compatible with old one.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
---
 fs/exfat/super.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 0565d5539d57..26b0db5b20de 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -203,6 +203,12 @@ enum {
 	Opt_errors,
 	Opt_discard,
 	Opt_time_offset,
+
+	/* Deprecated options */
+	Opt_utf8,
+	Opt_debug,
+	Opt_namecase,
+	Opt_codepage,
 };
 
 static const struct constant_table exfat_param_enums[] = {
@@ -223,6 +229,10 @@ static const struct fs_parameter_spec exfat_parameters[] = {
 	fsparam_enum("errors",			Opt_errors, exfat_param_enums),
 	fsparam_flag("discard",			Opt_discard),
 	fsparam_s32("time_offset",		Opt_time_offset),
+	fsparam_flag("utf8",			Opt_utf8),
+	fsparam_flag("debug",			Opt_debug),
+	fsparam_u32("namecase",			Opt_namecase),
+	fsparam_u32("codepage",			Opt_codepage),
 	{}
 };
 
@@ -278,6 +288,18 @@ static int exfat_parse_param(struct fs_context *fc, struct fs_parameter *param)
 			return -EINVAL;
 		opts->time_offset = result.int_32;
 		break;
+	case Opt_utf8:
+		pr_warn("exFAT-fs: 'utf8' mount option is deprecated and has no effect\n");
+		break;
+	case Opt_debug:
+		pr_warn("exFAT-fs: 'debug' mount option is deprecated and has no effect\n");
+		break;
+	case Opt_namecase:
+		pr_warn("exFAT-fs: 'namecase' mount option is deprecated and has no effect\n");
+		break;
+	case Opt_codepage:
+		pr_warn("exFAT-fs: 'codepage' mount option is deprecated and has no effect\n");
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.25.1

