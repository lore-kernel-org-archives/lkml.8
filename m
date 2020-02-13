Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C78C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C86C42467C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 16:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GTU4/l0L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgBMQkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 11:40:10 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:35925 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727671AbgBMQkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 11:40:10 -0500
Received: by mail-wm1-f54.google.com with SMTP id p17so7500522wma.1;
        Thu, 13 Feb 2020 08:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U9NzKrnsK6arcq1Stt3BEs5RjKuMGTXTF0ludE/ZUXY=;
        b=GTU4/l0L1dLFrTu9OEv/PL4t7RvMbpp0XWwcP6zntmaWC5q3XEkJ5pOLF8yJ9XYRHd
         xjOrhXV5nTSbp/z+C9yy0mbL/OgKwy3/HgTgFl9Ru67LCp9inGm6KhQGawl/xgHb80x7
         Dl0L0fuRMkDOSg/CT9/3W4xnw4LycRzo/nIvHZ3KdAHmjuXde+gp6CfA60H54/TMSeqN
         TZMDvdfuWTctyKOHza/dvWNF1VJ4lJhD5bzidgTXu176rg4iGhm6VMfiPKzb1F5K6n5T
         nFLxjiGvNbIv7oLr+nZ3/6OKiq5zBkc81E6owMQYNbSwIAHoZi6S9OpjIot/CfnYbbVL
         XNrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U9NzKrnsK6arcq1Stt3BEs5RjKuMGTXTF0ludE/ZUXY=;
        b=rG6ggnORUvQLKqHV7CxbuRTjfxJUz1c0HBpvfp01mH2j4ydbRz814G+BrlVVd6kkZe
         z6+5gZ1+9gThJm8EyJsPRCyiCAuW87pbEfMg6t9JMB18FxBJwIkfjZha7aVkcWyBLM29
         lwKsubS/BsMhrvJHr0ZgtoKCsiwQmbEbqiGk1DnJZhagP6SoQYv1lB03El1qwPG4/u2E
         9BrV8d3bZvL56ra23DV3KS5NBjSNhwBW9E+3V4bzzoim8NwVr3AYXZtiaSnUUAr6VsBX
         nIURjapW78z0wBE2syCmP24hCEe+ef780qDzozhQPiBGDt9JmVQq4VE38omOY0US7lSJ
         fX3Q==
X-Gm-Message-State: APjAAAUvd/ELY4CrAiqqKQ5E7OnQPd6I/+RlychlqKGvlvsQOCSAjiAF
        lok1nAQg2e9i2ABPlIT4xVw=
X-Google-Smtp-Source: APXvYqyw+7OwayCrFaSi1FHtOjrVg7Ijl4xMXki8QHzS05nbvc7DFuI+y8+pzrJHUJ0/jIgfdpXXPw==
X-Received: by 2002:a05:600c:2c13:: with SMTP id q19mr6875106wmg.144.1581612007455;
        Thu, 13 Feb 2020 08:40:07 -0800 (PST)
Received: from localhost (p2E5BEF3F.dip0.t-ipconnect.de. [46.91.239.63])
        by smtp.gmail.com with ESMTPSA id f11sm3567493wml.3.2020.02.13.08.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 08:40:06 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Olof Johansson <olof@lixom.net>,
        linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/5] memory: Introduce memory controller mini-framework
Date:   Thu, 13 Feb 2020 17:39:54 +0100
Message-Id: <20200213163959.819733-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Hi,

this set of patches adds a new binding that allows device tree nodes to
explicitly define the DMA parent for a given device. This supplements
the existing interconnect bindings and is useful to disambiguate in the
case where a device has multiple paths to system memory. Beyond that it
can also be useful when there aren't any actual interconnect paths that
can be controlled, so in simple cases this can serve as a simpler
variant of interconnect paths.

One other case where this is useful is to describe the relationship
between devices such as the memory controller and an IOMMU, for example.
On Tegra186 and later, the memory controller is programmed with a set of
stream IDs that are to be associated with each memory client. This
programming needs to happen before translations through the IOMMU start,
otherwise the used stream IDs may deviate from the expected values. The
memory-controllers property is used in this case to ensure that the
memory controller driver has been probed (and hence has programmed the
stream ID mappings) before the IOMMU becomes available.

Patch 1 introduces the memory controller bindings, both from the
perspective of the provider and the consumer. Patch 2 makes use of a
memory-controllers property to determine the DMA parent for the purpose
of setting up DMA masks (based on the dma-ranges property of the DMA
parent). Patch 3 introduces a minimalistic framework that is used to
register memory controllers with along with a set of helpers to look up
the memory controller from device tree.

An example of how to register a memory controller is shown in patch 4
for Tegra186 (and later) and finally the ARM SMMU driver is extended to
become a consumer of an (optional) memory controller. As described
above, the goal is to defer probe as long as the memory controller has
not yet programmed the stream ID mappings.

Thierry

Thierry Reding (5):
  dt-bindings: Add memory controller bindings
  of: Use memory-controllers property for DMA parent
  memory: Introduce memory controller mini-framework
  memory: tegra186: Register as memory controller
  iommu: arm-smmu: Get reference to memory controller

 .../bindings/memory-controllers/consumer.yaml |  14 +
 .../memory-controllers/memory-controller.yaml |  32 +++
 drivers/iommu/arm-smmu.c                      |  11 +
 drivers/iommu/arm-smmu.h                      |   2 +
 drivers/memory/Makefile                       |   1 +
 drivers/memory/core.c                         | 248 ++++++++++++++++++
 drivers/memory/tegra/tegra186.c               |   9 +-
 drivers/of/address.c                          |  25 +-
 include/linux/memory-controller.h             |  34 +++
 9 files changed, 366 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/consumer.yaml
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/memory-controller.yaml
 create mode 100644 drivers/memory/core.c
 create mode 100644 include/linux/memory-controller.h

-- 
2.24.1

