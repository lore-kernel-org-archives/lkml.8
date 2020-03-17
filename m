Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BD9C1975A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 20:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52FA020753
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 20:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dbpcp/Ru"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgCQULW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 16:11:22 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:37790 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbgCQULW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 16:11:22 -0400
Received: by mail-qv1-f65.google.com with SMTP id n1so7861621qvz.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 13:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6FuZZoVTFoFF+1kD/gUu0wVHL7she4RE1ISWVv5X9/Y=;
        b=dbpcp/RuzqPmQK6KVQzTxDWpN0UCo5KtMvqAZZPoxySTTmsfREbl0sQgsgpEDhLZnX
         r3oFKW5hojLd7kUsqJEN+Ikmj44Nl3ZqNZPM+u3MITdDCFpcWbB4ki3tUpiTLKen/X6y
         fg91QHgWSXyPEwVDlXGU2mMKuE2VhQ8Mk+kzw8ru6uWCAex+uWeYeXBqwaNdsIaXxqi2
         JrWak7xDWraqmi7X83SRMvSdJ/BXyASjCV+Ji6pmZ015CFgOHa2K7HsdPhkNONJQEW+X
         CjCcdrr8nJ7ojvE5TY8xoOgB24kdAKbvFOShtZ1dJaScDluHltgJvAWJb+XLy9cNEegD
         FU0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6FuZZoVTFoFF+1kD/gUu0wVHL7she4RE1ISWVv5X9/Y=;
        b=EYPtTxyBpE/mPj3grddi+XB2CqGbMPxcgk4bkZaNu/n7sVfYRmRk+Y63NtfVD0fmHH
         aNCq9oo8c/X/1lL37UMJU9avgMrjeAHYNBTEUQHu3sWX1iTqaYCZrnSiUZzs6Z+9L+Zr
         17ehBiB2x3nea+ntJLQ6jiVMBnRRi/Mtjwf/AX3jCpEWBJatYUFXNChRueY7F3i0ADq3
         QDLhcCCXAzzVj12l7aTGVMWcksTdrXf3Ma68h9bhcvHrGXFS3OF33Jnp55YzZJL3r08A
         ggEs4AV2l3kOjqvRMgbOxKMwbBtubCs3vc+aU5lLN9ngeFxV01e+Kig7zut4pA22Xxlm
         jlUw==
X-Gm-Message-State: ANhLgQ1VtT9ZdZCF9bKRNjmKksby67v18fe5ZJNrzM/h4jnOEeEXRe55
        e81J4HCxejkZ45R8QQBJPOrX3AOBtlT2Og==
X-Google-Smtp-Source: ADFU+vuT1Ym7m/1ayMnfgO0ZcMOck2lWOFvio2W1ILFfrT2EJs/LZjoAZ45vaZoYBkzzqaJILQKAwA==
X-Received: by 2002:a05:6214:164d:: with SMTP id f13mr926612qvw.214.1584475881076;
        Tue, 17 Mar 2020 13:11:21 -0700 (PDT)
Received: from localhost.localdomain ([179.159.236.147])
        by smtp.googlemail.com with ESMTPSA id t7sm2831852qtr.88.2020.03.17.13.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 13:11:20 -0700 (PDT)
From:   Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        sumit.semwal@linaro.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        Rodrigo.Siqueira@amd.com, rodrigosiqueiramelo@gmail.com,
        andrealmeid@collabora.com
Subject: [PATCH v2] drm: Alligne a comment block
Date:   Tue, 17 Mar 2020 17:11:09 -0300
Message-Id: <20200317201109.1619-1-igormtorrente@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200317133959.pdimegprq3gn4gsf@outlook.office365.com>
References: <20200317133959.pdimegprq3gn4gsf@outlook.office365.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a checkpatch warning caused by a misaligned comment block.

Signed-off-by: Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
---
 drivers/gpu/drm/drm_gem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/drm_gem.c b/drivers/gpu/drm/drm_gem.c
index 000fa4a1899f..6e960d57371e 100644
--- a/drivers/gpu/drm/drm_gem.c
+++ b/drivers/gpu/drm/drm_gem.c
@@ -222,10 +222,10 @@ drm_gem_object_handle_put_unlocked(struct drm_gem_object *obj)
 		return;
 
 	/*
-	* Must bump handle count first as this may be the last
-	* ref, in which case the object would disappear before we
-	* checked for a name
-	*/
+	 * Must bump handle count first as this may be the last
+	 * ref, in which case the object would disappear before we
+	 * checked for a name
+	 */
 
 	mutex_lock(&dev->object_name_lock);
 	if (--obj->handle_count == 0) {
-- 
2.20.1

