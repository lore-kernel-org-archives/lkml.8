Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77BA4C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 02:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56825206F2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 02:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wcl2Dqoc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgF2Czq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 22:55:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgF2CzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 22:55:22 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B893C03E979;
        Sun, 28 Jun 2020 19:55:22 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id s9so16289329ljm.11;
        Sun, 28 Jun 2020 19:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1qLiLZq7FNwrmfOWv+rYatcR7Rmj1NqpWdK2xLqqCWw=;
        b=Wcl2DqocSxSs3AV5P8qGRrF0a0VmKu0wuJALfiDzn/V6c73u/IST3buU5xPKvYbzx9
         tn2xdj+sDmLxZcC1jCK4Y1KW/azSbdAqerN+lnf4B6IiQCV5kEMtxu/VdrCGVSbW46EW
         dyTmqdeg0DdfnFcBNwcdViRqBfhJEgKrkZ1q/TRrZa3SxnT4XhsCdvAkoWzzX3K3KtIh
         NYO8NOEZ9Ib49NAHRB/wHyRmohCCmqkCpQoThENIJtOMKtebHXX8Z7jDrQo7CTLhvydm
         ap1n3x+0VHIDXaOlB8RWjalge5BWtBmjEIHYEUY5kDCPCi3zpVEdudSTOciWqb+b7JZC
         mynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1qLiLZq7FNwrmfOWv+rYatcR7Rmj1NqpWdK2xLqqCWw=;
        b=uK49bvLRniuftvzbl86ajs6IpHk3lrEE7w8SVPXmPjNKknqTL68usBc4JvpyPrWW8e
         mzRmZ11Tpc+q7sqszXSwwznjUT5NeDthBS0S1zg+NI+5q9EXu9hpR2n+pS+r5S/a/NJW
         iIKYG35PMB9xnU/bsR6Gg9L0EBM1UCDUf1IaUfgTdbTTb1Sn+ucuWRE5eJeXkLcypziB
         qijOqIRKGJ+u+LQwVlRwEtij1QMAnxVFimtq1J1/cAHPDSF97YC+MOMV6gJpRRrt8A7y
         G0qzO9WtAPKF3x0dipIAjFL938rSbi1Oxe2sW8o4V3TLv/opFAAWROI1CMeJegu2Dwak
         w3kQ==
X-Gm-Message-State: AOAM530nxenHEZpQ6YXK9+BFevB6Pxp29d/tHxZYz4Cw72e3cFufn6zQ
        CAT1f1ri3TAlx/Zu0PWJL08=
X-Google-Smtp-Source: ABdhPJzddhu8nUbV/+5iF9XYH9HvhNxIkYcrt1OMwJAMLn3V+gPiVMqU6FV6aSPiq1SOAi9/f3V0fw==
X-Received: by 2002:a2e:780e:: with SMTP id t14mr2186888ljc.444.1593399320778;
        Sun, 28 Jun 2020 19:55:20 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id o4sm8820527lfb.52.2020.06.28.19.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2020 19:55:20 -0700 (PDT)
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
Subject: [PATCH v10 4/6] dt-bindings: ARM: tegra: Add Acer Iconia Tab A500
Date:   Mon, 29 Jun 2020 05:54:54 +0300
Message-Id: <20200629025456.28124-5-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200629025456.28124-1-digetx@gmail.com>
References: <20200629025456.28124-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a binding for the Tegra20-based Acer Iconia Tab A500 tablet device.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 Documentation/devicetree/bindings/arm/tegra.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/tegra.yaml b/Documentation/devicetree/bindings/arm/tegra.yaml
index 60b38eb5c61a..7fd0b66c69b2 100644
--- a/Documentation/devicetree/bindings/arm/tegra.yaml
+++ b/Documentation/devicetree/bindings/arm/tegra.yaml
@@ -34,6 +34,9 @@ properties:
               - toradex,colibri_t20-iris
           - const: toradex,colibri_t20
           - const: nvidia,tegra20
+      - items:
+          - const: acer,picasso
+          - const: nvidia,tegra20
       - items:
           - enum:
               - nvidia,beaver
-- 
2.26.0

