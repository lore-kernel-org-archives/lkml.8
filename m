Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5767C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 16:18:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB3EA2464B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 16:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PEkhro1u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbgCIQSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 12:18:10 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41356 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727314AbgCIQSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 12:18:04 -0400
Received: by mail-pl1-f195.google.com with SMTP id t14so4168039plr.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 09:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7xeSTI2PbxEvahk22xqv3ZE8AVSlO4Qu6bmPMYJwd5c=;
        b=PEkhro1u1yGzYmZTU8Bne+MaDe5ejs2U5Hcuozmig8TyI58+GiwGJVRN8bvIWnbEhY
         XQ2tPcGOLhR7RaQ4v51SV8JCyKWxIRs5l210IkWxqQVVWpAgw4rcT87XdJjGoHtB3tvN
         4I87zcESvjYABtg5IHAXmJZIxSQg/wUa+XFQYJ4p1rqoMlxL5C5IIasbSBafTE23ROjI
         DnMoTaHDykmdVlyqOgAsYbgXppGyRGTmOqUo4KnlxlWACLDYcc4GpY1Cddo8t7Xm7z53
         xSscZ5Y3x2sGpd+vA7GrjXgJVwLJl2vnkW59GN+/+l9D5MKIJRBLwVCRY2zIezOte3aH
         PixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7xeSTI2PbxEvahk22xqv3ZE8AVSlO4Qu6bmPMYJwd5c=;
        b=T+bML1BPiav2A4KYZKeAiXt99Cddjb2aNJEcMKsw9W3RpCDXr7eehzz+cTBq3+Z126
         62SlTlD2sjzr2YYWYyRabud+44FacHPQXWwv/P+B52OCtQ2w4drX/bzpL5BazAfpv3Xg
         DFCgnmA44ljkCt6kepRkMiLwnmUGX+456/PStnzJSulHhJy1IIGg6sxRiOA2ksB12Ezf
         O7WOWezhy7FIxlTedj4kQLkqtMoNcv3vabEFaB5FViKFm2P9xvYr3CL9MhQhPZrU/ujX
         1q2HeEFTcXqvT6mPk/tbZNwpF3cQLNC5oxJ+TzdV0mabds9fUKd3+5HVA2M8jAKY+vVb
         twzg==
X-Gm-Message-State: ANhLgQ1ucqrlvBQNvLSJu642CDyicQMDBv1Khj9OeXUCT2y9NfWj1Gfc
        gj7DOyLtptX8WET8+E7QY2UKYg==
X-Google-Smtp-Source: ADFU+vtAGFavg5y+woyAvDRLrRF5zVCt/vK71+0RG5tHtfC4A5+BoGo4jFTkg1HQiWCbxhaqGppDOg==
X-Received: by 2002:a17:902:8498:: with SMTP id c24mr11968583plo.233.1583770683209;
        Mon, 09 Mar 2020 09:18:03 -0700 (PDT)
Received: from xps15.cg.shawcable.net (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id m11sm38403pjl.18.2020.03.09.09.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 09:18:02 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 13/13] coresight: cti: Remove unnecessary NULL check in cti_sig_type_name
Date:   Mon,  9 Mar 2020 10:17:48 -0600
Message-Id: <20200309161748.31975-14-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200309161748.31975-1-mathieu.poirier@linaro.org>
References: <20200309161748.31975-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>

Clang warns:

drivers/hwtracing/coresight/coresight-cti-sysfs.c:948:11: warning:
address of array 'grp->sig_types' will always evaluate to 'true'
[-Wpointer-bool-conversion]
        if (grp->sig_types) {
        ~~  ~~~~~^~~~~~~~~
1 warning generated.

sig_types is at the end of a struct so it cannot be NULL.

Fixes: 85b6684eab65 ("coresight: cti: Add connection information to sysfs")
Link: https://github.com/ClangBuiltLinux/linux/issues/914
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
Reported-by: kbuild test robot <lkp@intel.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-cti-sysfs.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-cti-sysfs.c b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
index abb7f492c2cb..214d6552b494 100644
--- a/drivers/hwtracing/coresight/coresight-cti-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
@@ -945,10 +945,8 @@ cti_sig_type_name(struct cti_trig_con *con, int used_count, bool in)
 	int idx = 0;
 	struct cti_trig_grp *grp = in ? con->con_in : con->con_out;
 
-	if (grp->sig_types) {
-		if (used_count < grp->nr_sigs)
-			idx = grp->sig_types[used_count];
-	}
+	if (used_count < grp->nr_sigs)
+		idx = grp->sig_types[used_count];
 	return sig_type_names[idx];
 }
 
-- 
2.20.1

