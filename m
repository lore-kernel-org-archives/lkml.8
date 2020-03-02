Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D440AC3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 20:48:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A59012173E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 20:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="b+fJO1GC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgCBUsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 15:48:01 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:34759 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726232AbgCBUr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 15:47:58 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1583182078; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=O+9e9Rw4vOt5ge1vzMdXqb5oDjeStYlgakftUbm5IH4=; b=b+fJO1GC1LltphZZZ2JlKv6xwrxGHT45mQCSyezcyTpgbCgr7gOwrt/B//8yUryoO7F5TNot
 CEhcCmYdhNFs4W8aI4FcE26e9nd3DxZvQfIEKUYrHmx7Jq0uii+6QtGeTAP84FH6pt4CC2Ry
 NR0Q/zXZCv8LCK4qSzDgW2LPW2o=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e5d70f9.7fb601d03e68-smtp-out-n01;
 Mon, 02 Mar 2020 20:47:53 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 629EBC4479C; Mon,  2 Mar 2020 20:47:53 +0000 (UTC)
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jcrouse)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4B845C43383;
        Mon,  2 Mar 2020 20:47:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4B845C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jcrouse@codeaurora.org
From:   Jordan Crouse <jcrouse@codeaurora.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     smasetty@codeaurora.org, John Stultz <john.stultz@linaro.org>,
        Sean Paul <sean@poorly.run>, devicetree@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Rob Herring <robh+dt@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        David Airlie <airlied@linux.ie>,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        freedreno@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v4 0/2] msm/gpu/a6xx: use the DMA-API for GMU memory allocations
Date:   Mon,  2 Mar 2020 13:47:45 -0700
Message-Id: <1583182067-16530-1-git-send-email-jcrouse@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_INIT_ON_ALLOC_DEFAULT_ON the GMU memory allocator runs afoul of
cache coherency issues because it is mapped as write-combine without clearing
the cache after it was zeroed.

Rather than duplicate the hacky workaround we use in the GEM allocator for the
same reason it turns out that we don't need to have a bespoke memory allocator
for the GMU anyway. It uses a flat, global address space and there are only
two relatively minor allocations anyway. In short, this is essentially what the
DMA API was created for so replace a bunch of memory management code with two
calls to allocate and free DMA memory and we're fine.

In a previous version of this series I added the dma-ranges property to the
device tree file for the GMU and updated the bindings to YAML. Rob correctly
pointed out that we didn't need dma-ranges any more but I'm still pushing the
YAML conversion because it is good and we'll eventually need it anyway so why
not.

v4: Use dma_alloc_wc() wrappers per Michael Ruhl.

v3: Fix YAML description per RobH and remove dma-ranges and replace it with the
correct DMA mask in the GMU device. Convert the iova type to a dma_attr_t to
make it 32 bit friendly.

v2: Fix the example bindings for dma-ranges - the third item is the size
Pass false to of_dma_configure so that it fails probe if the DMA region is not
set up.

Jordan Crouse (2):
  dt-bindings: display: msm: Convert GMU bindings to YAML
  drm/msm/a6xx: Use the DMA API for GMU memory objects

 .../devicetree/bindings/display/msm/gmu.txt        | 116 -------------------
 .../devicetree/bindings/display/msm/gmu.yaml       | 123 +++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c              | 113 ++-----------------
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h              |   6 +-
 4 files changed, 135 insertions(+), 223 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/msm/gmu.txt
 create mode 100644 Documentation/devicetree/bindings/display/msm/gmu.yaml

-- 
2.7.4
