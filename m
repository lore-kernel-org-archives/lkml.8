Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84D86C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 02:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EC99206F2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 02:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gayC6Upj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbgF2CzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 22:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbgF2CzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 22:55:21 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E269C03E97A;
        Sun, 28 Jun 2020 19:55:21 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id q7so3093668ljm.1;
        Sun, 28 Jun 2020 19:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3jYAyhoWO96DwU8aVF+4Uno1zYQiOFU7cQs+3bijby4=;
        b=gayC6UpjHvuYyaK2vJ/yvNZ+T/KBG4rpw9XhwaXIyhsIfUp4G+/8OdBJ3G0qiZ34O7
         Eawm2PMwnAzEL9w1/7pcmWA6Zzk2HC9Nc+vvC7Iv5+wU45QnlQBRxi1i6aRMj+kRnHg5
         0kQUGX0uyO6gjn6hiEvwvzbEP/dlw0jHEeivO07m4HxM9IZp7KLDfHocSHP4vdiavOsq
         2akZJ+PZMrGwd3t3B3wd4NrRvIWMWNyco2NbObBKcIbkQJyrHFulWZO2Y/lHVTUU/D50
         ulZ0w+A7J3nLaRMnguuW8cYRJpl/Bss/Hr+LQOM7pyRPihgvq6oSWjAtnqYKd15xiKS1
         42gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3jYAyhoWO96DwU8aVF+4Uno1zYQiOFU7cQs+3bijby4=;
        b=HVx2VZLVa1sHRAH7lOfic7D0K2XFtNVhEX9nAXoig9Iuo4h0RGE+IMhf7Hd9v76BJR
         c6KWEeUumMUW9fpgkivnGki9qUTdvi7aIDyWEPbxQ0p7XuE7/wb+93yJD872joD+wyfT
         joiyeiI+QKc0wSYZeLUiSa4hnS6t3P1quhCQRYEseQ15i7z1bOcreCv6qnVPmJ0sa5cG
         RYAb5jpcrdqimsh7/wHuPI700FmIwCqOzKyiy/CM6RZu8BsO00Hymkh2p/oqWS98XnRw
         id2rqs9BKMBo+gTYvAx9yvBaqkVwAhvtFuH9f6pBwktQ5e5O3hMWDnKMzd8Drj6IiTfU
         /PIw==
X-Gm-Message-State: AOAM531axV2jwP5fF3oY++PB+O8rZgiRiUxVDXLSW5qrrKj2AjqNRrSp
        bUrb4fzb8m+w/an5aHK+CCY=
X-Google-Smtp-Source: ABdhPJyIiIUZav3QGX1+1fRjCAZNfb8Hdj9e3DtxzPcz/IKDMbY2kjVqqGczH2o2LgNRBZbolZ+0IA==
X-Received: by 2002:a2e:b6cc:: with SMTP id m12mr4997986ljo.330.1593399319700;
        Sun, 28 Jun 2020 19:55:19 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id o4sm8820527lfb.52.2020.06.28.19.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 19:55:19 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        =?UTF-8?q?Pedro=20=C3=82ngelo?= <pangelo@void.io>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Zack Pearsall <zpearsall@yahoo.com>
Cc:     linux-tegra@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 3/6] dt-bindings: Add vendor prefix for Acer Inc.
Date:   Mon, 29 Jun 2020 05:54:53 +0300
Message-Id: <20200629025456.28124-4-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200629025456.28124-1-digetx@gmail.com>
References: <20200629025456.28124-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acer is a hardware and electronics corporation, specializing in advanced
electronics technology. Acer's products include desktop PCs, laptop PCs,
tablets, servers, displays, storage devices, virtual reality devices,
smartphones and peripherals. Their web site is http://www.acer.com/.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 9aeab66be85f..9f7af78d6864 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -27,6 +27,8 @@ patternProperties:
     description: Abilis Systems
   "^abracon,.*":
     description: Abracon Corporation
+  "^acer,.*":
+    description: Acer Inc.
   "^acme,.*":
     description: Acme Systems srl
   "^actions,.*":
-- 
2.26.0

