Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED1C2C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 22:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B740520658
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 22:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0LQdQfY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbgCYW3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 18:29:16 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34620 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbgCYW3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 18:29:16 -0400
Received: by mail-pg1-f194.google.com with SMTP id d37so1360227pgl.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 15:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=LyYXufOUFN5oWBOpcmZRLdaTepJDZ4LbjSQe+KjRvBE=;
        b=I0LQdQfYqfNHczc5FQJqWphRXlzTHmVhPGME+4aT+Ilzoe8LG3uOCvcu28FImaWJb/
         ioLl16u2QiATn4zBW7UhDlJLfax8+0z1CHkw+aKwhU2QKAxS+oYyY24YZhtOaIf1fz0x
         R7U2Zl12Yb9fA67w6yzcdbvksYK/jrEKu8+7L988J04CgE6QYM8XR2yBx1WeRsLJGrR6
         ST/YLPsroAsBaLG+BmmQWPMz/EHFQtX6sjxr9Urd7HC0WOh0y5Of/AO+FzSXMD2B/0hi
         ITbX7G4tNsJK5VoeM1kfVcjo9esgd92BTt+pR/oAGpl5gsVOqcFE8uUwmff/eDQHIMGi
         Stlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=LyYXufOUFN5oWBOpcmZRLdaTepJDZ4LbjSQe+KjRvBE=;
        b=hrnSwbs296iQdqy50Gxj0qizkyj+uKacGlW0GlWTPcaFsu6tOjHkLE7fTrpNk/soWp
         YW2KAHC9yBpkM9vO6fS6QTdDhi5yHKk1a9ZYeNYLXda87JwestdtAgmGrEgcQ4uonQIo
         lM4Sd+jIfZVsS25N+27GUs746dtqvAkFPlEM5Z36bW0zJVNUjl4b8ZngA1v124tHZJYS
         iE7pXccNzB6SA/9KDXrq1LAsrQLz+y0u/KktspHXjwx7OiphHF2YFuhKvAlr+jnK7pAq
         ZZ9Mop11IW66BqrQ09/PFy4otJU2OJ2P13sr+aV5RiWtStXj5/XzTBkCy0H2d/++d9CV
         q9Hw==
X-Gm-Message-State: ANhLgQ2MS/KKi5oCKUZqIpLgRFF5UpviUjpvYW6Or3+bGJNlcr0L8u+N
        V7u13XY0HORnLdTVV70beBA=
X-Google-Smtp-Source: ADFU+vskN9dl4CYBR4iDfuGwX4JISYcceiwBsa4I0J+YF6SJDdgg9p3v8JvtXd0mzKn7fMZ2j1IUKg==
X-Received: by 2002:a63:ef41:: with SMTP id c1mr5068479pgk.195.1585175354567;
        Wed, 25 Mar 2020 15:29:14 -0700 (PDT)
Received: from simran-Inspiron-5558 ([2409:4052:78f:bb47:8124:5e4b:ea06:7595])
        by smtp.gmail.com with ESMTPSA id k3sm129301pfp.142.2020.03.25.15.29.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 15:29:13 -0700 (PDT)
Date:   Thu, 26 Mar 2020 03:59:08 +0530
From:   Simran Singhal <singhalsimran0@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel <outreachy-kernel@googlegroups.com>
Subject: [PATCH] staging: rtl8723bs: Clean up tests if NULL returned on
 failure
Message-ID: <20200325222908.GA5370@simran-Inspiron-5558>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some functions like kmalloc/kzalloc return NULL on failure.
When NULL represents failure, !x is commonly used.

This was done using Coccinelle:
@@
expression *e;
identifier l1;
@@

e = \(kmalloc\|kzalloc\|kcalloc\|devm_kzalloc\)(...);
...
- e == NULL
+ !e

Signed-off-by: Simran Singhal <singhalsimran0@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 29f36cca3972..5c27c11f006a 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -474,7 +474,7 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 			wep_key_len = wep_key_len <= 5 ? 5 : 13;
 			wep_total_len = wep_key_len + FIELD_OFFSET(struct ndis_802_11_wep, KeyMaterial);
 			pwep = kzalloc(wep_total_len, GFP_KERNEL);
-			if (pwep == NULL) {
+			if (!pwep) {
 				RT_TRACE(_module_rtl871x_ioctl_os_c, _drv_err_, (" wpa_set_encryption: pwep allocate fail !!!\n"));
 				goto exit;
 			}
@@ -2137,7 +2137,7 @@ static int rtw_wx_set_enc_ext(struct net_device *dev,
 
 	param_len = sizeof(struct ieee_param) + pext->key_len;
 	param = kzalloc(param_len, GFP_KERNEL);
-	if (param == NULL)
+	if (!param)
 		return -1;
 
 	param->cmd = IEEE_CMD_SET_ENCRYPTION;
@@ -3491,7 +3491,7 @@ static int rtw_set_encryption(struct net_device *dev, struct ieee_param *param,
 			wep_key_len = wep_key_len <= 5 ? 5 : 13;
 			wep_total_len = wep_key_len + FIELD_OFFSET(struct ndis_802_11_wep, KeyMaterial);
 			pwep = kzalloc(wep_total_len, GFP_KERNEL);
-			if (pwep == NULL) {
+			if (!pwep) {
 				DBG_871X(" r871x_set_encryption: pwep allocate fail !!!\n");
 				goto exit;
 			}
-- 
2.17.1

