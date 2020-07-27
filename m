Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA964C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B24D82075D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lnCjxacw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728216AbgG0JiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 05:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbgG0JiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 05:38:15 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00C3C061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 02:38:14 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id a5so4173817wrm.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 02:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qC3CDVB7kR9rDCfdJZLYs8Kg8/UF5PfbuV6G/eCKZfg=;
        b=lnCjxacwzAHt2R2k9vsjrdHuJnI9NhyZHxDnyjUtKw3U3MmDCQItie9CkfkDYGGHP4
         XeIJSyMymz5IBuuDlALyaYlWVolg41q8s0BMs5KnJSgEC+z12CqdbFFDfIGpb4Og423o
         E6nI+IaFvBgExDGodgtOz0Tz29Asee8YhO4Ki2rz96JlHwJq3mpulS+TTbtHes6lz6mm
         agVrRM7NEvOHEJ3eos3/a8VYbO7GGmY4ORLWoiUOi90zOpNzf0mNcd+YnzCifx4dSJRk
         NPfTLC1SQmXjvNVyRsoLvKWt987ynlEeq2R9Wvk2HMScrHBtax0Ufx8i0LwyLQ1WH6Sn
         +Aew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qC3CDVB7kR9rDCfdJZLYs8Kg8/UF5PfbuV6G/eCKZfg=;
        b=nyc7Pb6BxaIeYYzoPOTPPahQrP76Jv4xC6D8wQeYcCy5BwAAOVE4mD/HWvT1YbwV/B
         HvJpoRpeoBqJxOwnchVs0JBxQXtuhADw2X4NqDmF60PPNjTovaXDQYoYbq9FXkziazTl
         lPREe9hSVteMOWaDJ8/5pAx+hN1EPzzX8x/RUtOlrX5+Lfvy8mG6t8vkwrDYfFjDUY/X
         rmqiVRct7zvshfQooKyw17zTq+izm/j0IvMZ6xzuguHi5Y6jEXdZViSuOdMqH0Vvep2i
         DGA7Cf4FdRojuO1dt6Z7XuiZKaAgP+jOEIjk3hloKjPYKIHnSxLIIZ5tqS50QxCgSmEH
         4hZA==
X-Gm-Message-State: AOAM532JB/VTeiyyRIF2t25wNWPVjmRWrBJxajeGwJKLaQhRfUuInGxw
        /5iFPrWQw1SWfihrGH661/ZI9A==
X-Google-Smtp-Source: ABdhPJxkg+f3gXXkXPzVNhCME4nqb/wHXSFJO1dBNFDBKMoDQ8HkFPldWS7rLgHDBWRBxPareMatjg==
X-Received: by 2002:adf:ded0:: with SMTP id i16mr19318452wrn.389.1595842693413;
        Mon, 27 Jul 2020 02:38:13 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id y189sm20566099wmd.27.2020.07.27.02.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 02:38:12 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     vkoul@kernel.org, perex@perex.cz, tiwai@suse.com,
        lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, ckeepax@opensource.cirrus.com,
        pierre-louis.bossart@linux.intel.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 00/10] ASoC: qdsp6: add gapless compressed audio support
Date:   Mon, 27 Jul 2020 10:37:56 +0100
Message-Id: <20200727093806.17089-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds gapless compressed audio support on q6asm.
Gapless on q6asm is implemented using 2 streams in a single q6asm session.

First few patches such as stream id per each command, gapless flags
and silence meta data are for preparedness for adding gapless support.
Last patch implements copy callback to allow finer control over buffer offsets,
specially in partial drain cases.

This patchset is tested on RB3 aka DB845c platform.

This patchset as it is will support gapless however QDSP can also
support switching decoders on a single stream. Patches to support such feature
are send in different patchset which involves adding generic interfaces.

Thanks,
srini


Changes since v2:(mostly suggested by Pierre)
- removed unnessary kernel style comments,
- moved TIMESTAMP flag to respective patch.
- move preparatory code from gapless support patch to new one.
- fix subject prefix of one patch.
- add comments to clarify valid stream_ids

Srinivas Kandagatla (10):
  ASoC: q6asm: rename misleading session id variable
  ASoC: q6asm: make commands specific to streams
  ASoC: q6asm: use flags directly from q6asm-dai
  ASoC: q6asm: add length to write command token
  ASoC: q6asm: add support to remove intial and trailing silence
  ASoC: q6asm: add support to gapless flag in q6asm open
  ASoC: q6asm-dai: add next track metadata support
  ASoC: q6asm-dai: prepare set params to accept profile change
  ASoC: q6asm-dai: add gapless support
  ASoC: q6asm-dai: add support to copy callback

 sound/soc/qcom/qdsp6/q6asm-dai.c | 414 +++++++++++++++++++++++--------
 sound/soc/qcom/qdsp6/q6asm.c     | 169 +++++++++----
 sound/soc/qcom/qdsp6/q6asm.h     |  49 ++--
 3 files changed, 469 insertions(+), 163 deletions(-)

-- 
2.21.0

