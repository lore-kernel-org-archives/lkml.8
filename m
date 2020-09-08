Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5B3C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 07:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FD7E20C09
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 07:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="MxNjfFU5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729784AbgIHHzI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 03:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729732AbgIHHyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 03:54:33 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36774C061756
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 00:54:32 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id k18so1016905wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 00:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/f+R+j91elfFPYf4zfHO7Bzdv43BgZ5CODvbZ0Vzlb0=;
        b=MxNjfFU5x28KJlZdrPqrtuP/t/v6fpMsOEGKTByYw9wYcIW0u58tAcThwi5E3fhxqB
         h21f/DHXzKl4OvbTBs3aSplhH2HVm6KfAHFRK5SZUmHpJR1dta3Aj0gP5K5CbBkPqK9z
         0x2pd1lMp81JR0y7njeN0eyfuVcHKkSKMFviptB0N2mLXjOWQ4tpYGJGg9BgWrEGv740
         Q1lfR/LQhdaE7+f41hH2B4x8Zm9GU2tWmojTn1qlBm3qzwcRnyR9ySDG+xvRyZ6DtsDw
         vxtKdPOFunXKV4iEh70MZOt8aCBPi89cWCv7xWN6VH0CoLMosxpvCCF4nyG2bA2GK5iM
         vAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/f+R+j91elfFPYf4zfHO7Bzdv43BgZ5CODvbZ0Vzlb0=;
        b=I0JmEOmg9OYg3mLXDPAbpuyLsOkaRbFMWUu3bX7c0YKORmTseAdi/DWtKHMvHY181Z
         wOJ8XsV7iVBl+Uy++rSNCyehVu8O8AJ+N5kyoibHnsUUEXwfylLfeIjfBUPJgH1o0m+g
         ed6xj6Vh/xG5fw507HusprwY1lmTdStUKxtegAtpN3e5WGpK3QWr5gXTK37QWYE3xQtE
         74Ba6wCG5/RZUF/qrMYVGyY35/GHH8eR1KvwZK1rNT5WWvBGcD8SLiU9cz/WQXadqpJx
         qzGvHzOv4U1BkVdmyfcBuZQQlj1abIUlBZgkHvI/3MVD5LRWoqmnvKPfBcboxIsvpaSQ
         SdSA==
X-Gm-Message-State: AOAM5324EyRkfZikMRuotmeEj3yhMx6STmuEmhnIg8oOubplg1qmu0DQ
        5e0JVEnyrlwO/3GJKbTn+92kqA==
X-Google-Smtp-Source: ABdhPJw2+vRPCVSoCJ8uTyZkM4qdXjUF9o+idDfbH3aRRZ1MhJ6/KLpRbqP0cqmVYb5dpgJwHdOuUg==
X-Received: by 2002:a1c:4303:: with SMTP id q3mr3013678wma.158.1599551669694;
        Tue, 08 Sep 2020 00:54:29 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5405:9623:e2f1:b2ac])
        by smtp.gmail.com with ESMTPSA id f14sm33788291wrv.72.2020.09.08.00.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 00:54:29 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     thierry.reding@gmail.com, sam@ravnborg.org,
        devicetree@vger.kernel.org
Cc:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v3 2/4] dt-bindings: display: panel-simple-dsi: add optional reset gpio
Date:   Tue,  8 Sep 2020 09:54:19 +0200
Message-Id: <20200908075421.17344-3-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200908075421.17344-1-narmstrong@baylibre.com>
References: <20200908075421.17344-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simple DSI panels can also have a reset GPIO signal in addition/instead of an
enable GPIO signal.

This adds an optional reset-gpios property.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../devicetree/bindings/display/panel/panel-simple-dsi.yaml      | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
index c0dd9fa29f1d..4d08e746cb21 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple-dsi.yaml
@@ -54,6 +54,7 @@ properties:
 
   backlight: true
   enable-gpios: true
+  reset-gpios: true
   port: true
   power-supply: true
 
-- 
2.22.0

