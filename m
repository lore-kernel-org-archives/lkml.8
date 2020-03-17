Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52297C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 15:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25A1220752
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 15:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WmxBBoG5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgCQPMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 11:12:52 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35540 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbgCQPMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 11:12:51 -0400
Received: by mail-wm1-f65.google.com with SMTP id m3so22426779wmi.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 08:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qSvV6OpvBf1rvB8ZBQIuOtC3wOEjkhtAfFvjmoSxpKM=;
        b=WmxBBoG5elQBlBCwz/IKHCH6X8PLjSl3o7xDvcMXnSYgcDH0kY8VRjtCj4hcRNV6A7
         fk8jrU2lU4vRGuUNpGtbaCAEw5Mvk/hmhCOG/Hgy0Mjn4wCpCmTgXalHUGZqaFietR4i
         CjUlos6iU1ZwxhBrMZeQipNk22v/IRLWfubb5Yro3QO0ODAntEvNngOuRTlm0O/QjLYM
         s5mDVj5YXXSU3y9GQUmUlsGfv+p+qJb8OykUFdiwyat8H+1ysUWqrw8CgOE/3NtKS357
         fPBQWxhTvv+j5ahpe5nauXfhZBCQO7sfepDmqjVpZXpz8Rd4aWEiZKb8VcCIjSRskYQf
         9OGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qSvV6OpvBf1rvB8ZBQIuOtC3wOEjkhtAfFvjmoSxpKM=;
        b=YTV/FqHzovdSx1MXfYRZgc2EDgfRYEGOERfpihNr7ALkZJRSOLY8wMUkfkwA6MLSrh
         5jhVehCw3Z/LEgUrLSQHlRWPA1pa2sKwmjXcIQNehQzDwU7mcU2Jc6Du5xlSFH/NnGsc
         KiXet5u3r3GNMBhOz4AsVuDpZ6fCyfNuCvPQmqJ2Xo+iAcz0PtfWrgJ0x8TrUNE1sEdz
         FCbeqaoKBwjgRy1QSoFrRSDOV/h9Q8zKywlNyREvGOx/Hk2yiicGQ1RCk1Kh4m9sBTNm
         BozlwgbB+8g24UoGloyAEKISkNvjEeu2gJW+qF6RcfdmPLvSTjfprZFmeK8b/bTS47wF
         b/NQ==
X-Gm-Message-State: ANhLgQ0sfznzolhsRC38dNvJwELBNfRo4nxGFQ+kWzBYEYXF2KxP0oO6
        +YCH02X1HIkVOafLvMg/bFJ7Cg==
X-Google-Smtp-Source: ADFU+vtqacOkLRon1SKHEZrSi/5Duy8tSRlCpBE1YWumTSvdeh3MQP9RyTMTg8QT2IBi3zf9JuGpng==
X-Received: by 2002:a1c:8090:: with SMTP id b138mr5983445wmd.55.1584457969777;
        Tue, 17 Mar 2020 08:12:49 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id u8sm4711089wrn.69.2020.03.17.08.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 08:12:48 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
        vkoul@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 0/2] ASoC: sdm845: fix soundwire stream handling
Date:   Tue, 17 Mar 2020 15:12:31 +0000
Message-Id: <20200317151233.8763-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent addition of SoundWire stream state-machine checks in linux-next
have shown an existing issue with handling soundwire streams in codec drivers.

In general soundwire stream prepare/enable/disable can be called from either
codec/machine/controller driver. However calling it in codec driver means
that if multiple instances(Left/Right speakers) of the same codec is
connected to the same stream then it will endup calling stream
prepare/enable/disable more than once. This will mess up the stream
state-machine checks in the soundwire core.

Moving this stream handling to machine driver would fix this issue
and also allow board/platform specfic power sequencing.

Changes since v1:
	- removed false error check while setting sruntime.

Srinivas Kandagatla (2):
  ASoC: qcom: sdm845: handle soundwire stream
  ASoC: codecs: wsa881x: remove soundwire stream handling

 sound/soc/codecs/wsa881x.c | 44 +------------------------
 sound/soc/qcom/Kconfig     |  2 +-
 sound/soc/qcom/sdm845.c    | 67 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 69 insertions(+), 44 deletions(-)

-- 
2.21.0

