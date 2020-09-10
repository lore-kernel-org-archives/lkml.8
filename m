Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3C3C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDC492078E
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 10:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CoqKYihr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730715AbgIJKSG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 06:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgIJKRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 06:17:49 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04B0C061573
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 03:17:48 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id c19so1549673wmd.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 03:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Yn9H//prDI3nzfubjnDYZsOWLfIwC4u9zL7Q5L5NuY=;
        b=CoqKYihr/LAknPrSQbIbvPU2gLR7FOIH7ggzqjsh9z15qaPyfyrhevRI2T+LSxmQdS
         /P944BCbCATI4ndCviuSg3z7h8gkBd8AfUpk756wQ+QVHhVwnUc377v33rnx4r+I0y7f
         yy653d0neKXvV6G2HNZkJj83sq3Msz98IJgqrW69nlqAok2crk4ny0zWgR/aqRekA1Jq
         XZNJDRralB2ssmWk3SdWzDwtmUwOmx0lIIqwgvNHyH9ex2vs/wkUa74vJAlCN3LgsRPk
         Ks9dVnyXV19La4pBynnDCb/3LbWV7O3S8cBbM9ztVpG9cWD+Zt3yh95JlWyP1YnOClAd
         2+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8Yn9H//prDI3nzfubjnDYZsOWLfIwC4u9zL7Q5L5NuY=;
        b=qSoAGDmLGU6AmHi0nVW18UFU/jSOafGjVhKEC5gVg1cq47YB5orwK9l1G2mVeKGd0F
         afQpHrG5rOR9CsxGNABaQFUoY2T2XDMhaYLnTt3vRNclxfEiXXOcnIIOtLjSC4kg5UwJ
         NBGzMIHHBhFHGSvqW3HuuokFwCl+vKB89pW4yq1FbmB/ZjEOqx8ilkfc4Tq7sH/sMi40
         4mvekxcsB4GgrHzxSQFJ+TVPNMOJRHBF6NsiYEjWz3DHICNxd5I594kVWLJaIsThORJn
         IOAU9dCNK6Uebp7A2AGi2HlA9nF6zW5WaKVMZQiInECmI2WdS5bU57rDE3JfxPm2+K5w
         +ZcQ==
X-Gm-Message-State: AOAM532Zkx8VFF0XyhDVj+DEe5tslW/dBN6QMYrYMcerAI45YpFN50Ml
        80GGTgTxkppWbrW7hVdCPcnYgg==
X-Google-Smtp-Source: ABdhPJxcPLylHepCovWDrGxeRaGOCbbA84z0OyPHZyCk3TmQmQLuLKvH4O+kUQQuUZyJGZRCB5Texw==
X-Received: by 2002:a05:600c:4103:: with SMTP id j3mr7653661wmi.130.1599733067588;
        Thu, 10 Sep 2020 03:17:47 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id m4sm8851731wro.18.2020.09.10.03.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 03:17:46 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/8] ASoC: q6dsp: Add support to Codec Ports.
Date:   Thu, 10 Sep 2020 11:17:24 +0100
Message-Id: <20200910101732.23484-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LPASS IP on SoCs like SM8250 has Digital Codec part integrated into it.
This ports are exposed in Q6DSP as Codec ports. This patchset adds
support to those q6afe ports along with q6routing and q6afe-dai.

This patchset has been tested along with other patches on
Qualcomm Robotics RB5 Platform with Soundwire and WSA8815 Codec.

Thanks,
srini

Srinivas Kandagatla (8):
  ASoC: q6dsp: q6afe: add support to Codec DMA ports
  ASoC: q6dsp: q6routing: add support to Codec DMA ports
  ASoC: q6dsp: q6afe: prepare afe_apr_send_pkt to take response opcode
  ASoC: q6dsp: q6afe: add global q6afe waitqueue
  ASoC: q6dsp: q6afe: add lpass hw voting support
  ASoC: q6dsp: q6afe: update q6afe_set_param to support global clocks
  ASoC: q6dsp: q6afe: add codec lpass clocks
  ASoC: q6dsp: q6afe-dai: add support to Codec DMA ports

 include/dt-bindings/sound/qcom,q6afe.h |  22 ++
 sound/soc/qcom/qdsp6/q6afe-dai.c       | 229 ++++++++++++++++++
 sound/soc/qcom/qdsp6/q6afe.c           | 308 +++++++++++++++++++++++--
 sound/soc/qcom/qdsp6/q6afe.h           |  33 ++-
 sound/soc/qcom/qdsp6/q6routing.c       | 121 +++++++++-
 5 files changed, 689 insertions(+), 24 deletions(-)

-- 
2.21.0

