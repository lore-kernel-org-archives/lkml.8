Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFCEC10F25
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 00:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A30A0206D7
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 00:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="j1sLhFYa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgCGAUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 19:20:06 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38242 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726314AbgCGAUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 19:20:05 -0500
Received: by mail-pg1-f196.google.com with SMTP id x7so1820448pgh.5
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 16:20:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=34J28lgHrpYhHjKOEF2LFXrP2R68/iu1HhoAglQIiu8=;
        b=j1sLhFYaHguaJXa97cYJ42mzQj+XxEOiLC8RHWmJdh65QSlxFjrxBP498kLkxgmGnZ
         guiewPA+UUcIG15xzS3RPoskofT39l8eZkbG5nMxs3/mZyDtfJI6Yez3lwWzuAgCnm+z
         4etgWiZOirvqtBmuG4qy8yK6L3fIwsx0AmhrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=34J28lgHrpYhHjKOEF2LFXrP2R68/iu1HhoAglQIiu8=;
        b=J0pM2h2W5YypgkUIYYJB+Mw9w0xF9UQ8VLlOPD/Eqp+skahOwu33xAmi7NumjshYy+
         NNrCrHmc47b7CpqTcgYNwBKnjJqH12PL+VZTG1FUJ0wf1HcvsAPsnlDYBO73AjM9BfE+
         qdP/O5k3ArxWJ/DW2lD2DNzQUBk1jPgQPCUJMJkmb81IkS07jcKIr41slm/7ukwbujx8
         2KCPViEfzhqV+eqyROg+ZSN/2ijzpzfaj01XYDYUh5D6+K8PphgntCwA1AbTJl05avKS
         9PSjErgWXDGt90OnJCDjTYckaJQNpUk/tgxzpc4ybmd/XEXSGESU40YV5Yr01zVcbaz3
         pYMw==
X-Gm-Message-State: ANhLgQ2xevys5tJ+O5Zw46NkSL+Jm/nSa0F9dCln0cc8m92KlqJh+CTw
        6KiNevCNhQCc9Au84Q5APMKgTaaGeV8=
X-Google-Smtp-Source: ADFU+vuzIIoftwyB2+mS5QJZvibeBUZGiH3Fg/M4pv/0zP7Xiq47/0vF+lo4/psqqym1fXDQXpqZ/w==
X-Received: by 2002:a63:fe0a:: with SMTP id p10mr5484311pgh.96.1583540404467;
        Fri, 06 Mar 2020 16:20:04 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v123sm11797272pfv.146.2020.03.06.16.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 16:20:03 -0800 (PST)
Date:   Fri, 6 Mar 2020 16:20:02 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs_parse: Remove pr_notice() about each validation
Message-ID: <202003061617.A8835CAAF@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This notice fills my boot logs with scary-looking asterisks but doesn't
really tell me anything. Let's just remove it; validation errors
are already reported separately, so this is just a redundant list of
filesystems.

$ dmesg | grep VALIDATE
[    0.306256] *** VALIDATE tmpfs ***
[    0.307422] *** VALIDATE proc ***
[    0.308355] *** VALIDATE cgroup ***
[    0.308741] *** VALIDATE cgroup2 ***
[    0.813256] *** VALIDATE bpf ***
[    0.815272] *** VALIDATE ramfs ***
[    0.815665] *** VALIDATE hugetlbfs ***
[    0.876970] *** VALIDATE nfs ***
[    0.877383] *** VALIDATE nfs4 ***

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/fs_parser.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/fs_parser.c b/fs/fs_parser.c
index 7e6fb43f9541..ab53e42a874a 100644
--- a/fs/fs_parser.c
+++ b/fs/fs_parser.c
@@ -368,8 +368,6 @@ bool fs_validate_description(const char *name,
 	const struct fs_parameter_spec *param, *p2;
 	bool good = true;
 
-	pr_notice("*** VALIDATE %s ***\n", name);
-
 	for (param = desc; param->name; param++) {
 		/* Check for duplicate parameter names */
 		for (p2 = desc; p2 < param; p2++) {
-- 
2.20.1


-- 
Kees Cook
