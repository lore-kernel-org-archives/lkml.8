Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3E3C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB66E20B80
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="qYuLDE6c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbgFPMRf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728636AbgFPMRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:17:17 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A664C08C5C4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 05:17:15 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id m2so1491041pjv.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 05:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LJO92mvN8G5Ck3uoTs8tbtHokwelI/PjMZ8RoMwKBik=;
        b=qYuLDE6cUJWd5a4DmxyscuvyFglYOxees6+5yxZbHCeW4dVK/TAHc5qEfavEUmqtku
         4jynq09mMyw7LfQBSZ2XkmvVR0xQfwjDSx/aPlX3EdAOGqTBfN+Rd7VzMBFpksIDfWrd
         jSI6ZMBqHU3nd1Kvqh3mtN33mVSeNv9oMvyIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LJO92mvN8G5Ck3uoTs8tbtHokwelI/PjMZ8RoMwKBik=;
        b=JVRtK2sq//320U8hbwLVHVrsNHGZgtJBW+TC0SAKdu9SkXAj0JkKeaQd19WJzdIDy7
         jZcmYc2T4oGETxkCjuTXaY6vqII03oM0raBEIvqY6lL+6F3NPZxrhGxO4VCjhYSTOAjr
         PiO9tEeyGRnDi6ESsDC7wSj+pdFSbjY9vARfRq7DBQJ5TmuWQV0l5YY3mDHeXbKkOUt2
         yo7Fx9H/P8i+AAt1oF62v1/3aL4CXddLov0hil3SGt9NnJBfKsCYmEwVs3VBXu1cnkHc
         gES6H2ywvlZY5ZtGPmOkZoyzsnqKEKBIyzo6ZC6qS9mzFzea/YZUACZEo1EiWmH3KcGX
         q4hw==
X-Gm-Message-State: AOAM53347kaRdWkFcpKaCVQ6lvchkNoG4+irIV6nRwDWd8ZlugdV7PBj
        zUi9fT3vGllDN1QDjhgCZQCikw==
X-Google-Smtp-Source: ABdhPJxh4mja4k9jxSfXKuDqMXATuL0/kxNng8htaYKY7QzDnrSNVuiHfGFh8qWBfZavfBpJSAz/kA==
X-Received: by 2002:a17:902:9b92:: with SMTP id y18mr1756775plp.228.1592309834497;
        Tue, 16 Jun 2020 05:17:14 -0700 (PDT)
Received: from shiro.work (p1285116-ipngn200805sizuokaden.shizuoka.ocn.ne.jp. [114.171.61.116])
        by smtp.googlemail.com with ESMTPSA id f23sm2360703pja.8.2020.06.16.05.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 05:17:13 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v4 02/12] dt-bindings: vendor-prefixes: Add sstar vendor prefix
Date:   Tue, 16 Jun 2020 21:15:15 +0900
Message-Id: <20200616121525.1409790-3-daniel@0x0f.com>
X-Mailer: git-send-email 2.27.0.rc0
In-Reply-To: <20200616121525.1409790-1-daniel@0x0f.com>
References: <20200612130032.3905240-2-daniel@0x0f.com>
 <20200616121525.1409790-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add prefix for Xiamen Xingchen Technology Co., Ltd

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index b09b6c9911c3..ba5bd3b0ed9a 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -986,6 +986,8 @@ patternProperties:
     description: Spreadtrum Communications Inc.
   "^sst,.*":
     description: Silicon Storage Technology, Inc.
+  "^sstar,.*":
+    description: Xiamen Xingchen(SigmaStar) Technology Co., Ltd. (formerly part of MStar Semiconductor, Inc.)
   "^st,.*":
     description: STMicroelectronics
   "^starry,.*":
-- 
2.27.0.rc0

