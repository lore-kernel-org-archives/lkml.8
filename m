Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE39C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 21:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3912F20734
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 21:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uyHInhaJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbgENViV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 17:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgENViN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 17:38:13 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1889C05BD43;
        Thu, 14 May 2020 14:38:12 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id z22so76667lfd.0;
        Thu, 14 May 2020 14:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1qLiLZq7FNwrmfOWv+rYatcR7Rmj1NqpWdK2xLqqCWw=;
        b=uyHInhaJmucS0GDmNxok35/6pIqJbjtPhLu4ZpKtuIkBVTz7GFj58ycODr54o92LkW
         mO9VoMre4qGQrK6796PbfzcKjtQ+O6koku7GPHk5Xv/8/uF9QJ+8TQrhy+Mcg6qGkQKY
         eboZf/vvspYv6QWY67W7DTXH8LFOXYHLwiXUygqiU6yXQRtUK+MPl6TmCzPEMNyt+vmm
         9fgJyfqvkXwVpjdVHfFiZ3+80NPz2bnKbrpsjaHBD0qYDmTo0h4omaZrzxc7lBMsve/r
         lSNAQztBQG9x78xejdnZjGDWCWWiY/m7WveFAK7ICRZXHymPQ/aC4qEGOJgLnZ/Xho4f
         22wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1qLiLZq7FNwrmfOWv+rYatcR7Rmj1NqpWdK2xLqqCWw=;
        b=m47SRBQz9A+sB/h/aKGVqxyJ9gydMS6165tVGxRLT2W1IEFcWawtAr2Titt4SX8tBz
         31g1J3cgnnsxgXr2u/SMOw+k/AyCWvcdU8TkY71sJVonUhPy/u1fyfmMjxZ++7GUra+O
         SG/t1jkovquq//bHnlUnYPTZgGQg7k4fkfVHLh+VYSYDZrSPhwx4UJ5Ou+FTo5PLUd5u
         0iz2ISVt0OHgpyqxMOibcKmtRNVTbdWf5BQbc1KvvIpWDiHvfin6QVvsLkwUIFTXqyKI
         XRHrPgbJwMGcrimXjz6gCqBDvo2ZDr3Hh4VhhXgTUaERXmTWeXac3jbFqAMbmLddkEdH
         kIug==
X-Gm-Message-State: AOAM532az6K2rbVCM6kL50d2kzyLs1N7TlZzjuVEJyMInu42ehqat3Xu
        CHYg3qrSRUl4Fn9GkmZi+oE=
X-Google-Smtp-Source: ABdhPJyXUP2kwowfCMXT1P2sxVFdvAFt5NLpSyRDiJ8f44EfdN5gWg4PANPfgKGQD522mALa99dn+w==
X-Received: by 2002:a05:6512:6ca:: with SMTP id u10mr137119lff.184.1589492291254;
        Thu, 14 May 2020 14:38:11 -0700 (PDT)
Received: from localhost.localdomain (ppp91-78-208-152.pppoe.mtu-net.ru. [91.78.208.152])
        by smtp.gmail.com with ESMTPSA id a12sm63628ljj.64.2020.05.14.14.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 14:38:10 -0700 (PDT)
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
Subject: [PATCH v8 4/6] dt-bindings: ARM: tegra: Add Acer Iconia Tab A500
Date:   Fri, 15 May 2020 00:36:52 +0300
Message-Id: <20200514213654.12834-5-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200514213654.12834-1-digetx@gmail.com>
References: <20200514213654.12834-1-digetx@gmail.com>
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

