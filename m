Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98208C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 12:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74476207C3
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 12:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HcEC6fng"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgFKMmE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 08:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbgFKMmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 08:42:04 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152FBC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 05:42:04 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id c71so4834827wmd.5
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 05:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=laaD8UzobffiSB7u/5lmFKPGdNh3SaNEg044mEgCOBI=;
        b=HcEC6fngLw1IZqkT0ZIy+oG6vVaoYiMCjA8WXTD6kOmX6PYqcXlqNDWF+erPuhsaMR
         DcFWuqFYRudvJ9ovOg1TZOlCy8A/3/7NoBBY6gspp4Orn4ouFiZ0Gqb4fzGI6L+HHqNo
         H0XOKf/lRwl63UBjf3l+xpzxFV8pKefuNDEfmkTTujeTMTgQTdqH/4QvG5yun5hS2Imf
         7U3S/kw5CpvBWo/mK8nLXp8og7BuQ5hTLCY2XQ4RdX6lKyUT0lcj7avg3MxIqdM45HZm
         sw5iYvwxKdnO358y8foLqVakrDznBYfMmrz7GZ1OsUOMt/P4fMUsOW/8agLupo63yHxy
         Jd2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=laaD8UzobffiSB7u/5lmFKPGdNh3SaNEg044mEgCOBI=;
        b=Q8bv7zu23AcciSWjyZqTK4/b+jPL4XcnmgEHx4eCWxbrmNk4MZI1pAfSt9Ta6XmrSb
         VcwNzaWzrnpfQI+rriwV0H3XFWLN+pSolFS4iz6ftCu4/+s5h8S2z+sKBtw9g8ZkU+kT
         19sOhX5hTmSH42wMBkyqdSoUYYPQf9vmkya5ybPxCMuC1giDpU6Jbh3tdMvpDpBp1Mj2
         vH/mJ2mIJHpegsF1vnZuyt/e2X9754pBLJhld/QEmmyEbddA+aI9RAIf3nSIwb3ejR4H
         +dwrNCzBagSATG82v39vZY446byC/syaMGEkBr9AnZlj8u9L0tVOn4FWBT6ojw2SuaYX
         ipXg==
X-Gm-Message-State: AOAM5327/BS5FCWfNFxiVo/t7Bf6nj0J9oSy+xjo+1Xpm/aaUOXiVETy
        gz8AzW9zrps+1zvpLZHFlmTXlQ==
X-Google-Smtp-Source: ABdhPJzvBtbsGiyEJ2M2wwSnsUCNIIAH/NTq4ytV5PjJtR+k7rhHBIsvR0HqZbvh+Gzl+RqDvytt2A==
X-Received: by 2002:a1c:7e41:: with SMTP id z62mr7603110wmc.113.1591879322750;
        Thu, 11 Jun 2020 05:42:02 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id q13sm4810355wrn.84.2020.06.11.05.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 05:42:01 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     vkoul@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/8] ASoC: qcom: q6asm: few fixes and enhancements.
Date:   Thu, 11 Jun 2020 13:41:51 +0100
Message-Id: <20200611124159.20742-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While trying out gapless playback, I found few issues with the existing code
This patchset has few fixes and some enhancement to the code to handle
multiple streams per asm session and also handle buffers that are not aligned
to period sizes.

I will send Gapless support patches once compressed gapless state machine is fixed.

Thanks,
srini

Srinivas Kandagatla (8):
  ASoC: q6asm: add command opcode to timeout error report
  ASoC: q6asm: handle EOS correctly
  ASoC: q6asm: rename misleading session id variable
  ASoC: q6asm: make commands specific to streams
  ASoC: q6asm: use flags directly from asm-dai
  ASoC: q6asm: add length to write command token
  ASoC: q6asm-dai: check available buffer size before sending
  ASoC: q6asm: allow to specify buffer offset in q6asm_write

 sound/soc/qcom/qdsp6/q6asm-dai.c | 100 ++++++++++++++--------
 sound/soc/qcom/qdsp6/q6asm.c     | 138 ++++++++++++++++++-------------
 sound/soc/qcom/qdsp6/q6asm.h     |  42 ++++++----
 3 files changed, 172 insertions(+), 108 deletions(-)

-- 
2.21.0

