Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31616C0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A56EF20738
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M3bjxGks"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730692AbgCKSEp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 14:04:45 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46604 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730363AbgCKSEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 14:04:44 -0400
Received: by mail-wr1-f68.google.com with SMTP id n15so3804609wrw.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 11:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uSWL2FmY7zpKu733UysN5ObefdtHGdo1xnjVfRmXsfs=;
        b=M3bjxGksxSB2uD4exfypPyvoUCoNhuYHVu0Z7MqkcbU24JUr39s/S5w2HTfIBfk8Gt
         qvyGcxu9THPrvu/aO9SGE5ImXArh3scmpeWqi7SwDUsnUKyiSePi2qxnIhWu2eR0N40D
         jP9cTxfo/cMkuwroo9gS3LZzbkIEzd3rU8wGYX0ygDWBuKI6fwLXlz/xtgJ/aQqFt+Q1
         wdkU4M+LdGcUDA4KdxkDA4pt48DMP7F0FLVJLgJ/doKJcBQ4rVy8quGpLLbWnyFM5viI
         HtLbFbgQb9/ku1o3OmTW6d4p76eqt/6x1eO/WjPqZ4DCDHjVdvyxmQSAFxJVp5a2W+S+
         sMOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uSWL2FmY7zpKu733UysN5ObefdtHGdo1xnjVfRmXsfs=;
        b=Q8aTvW/n2arab0fSTk2NfSA+Ln0HgsqlYgZLTxIydBzxCxCK2b8878fGcXOkUNblxu
         vZGsyhuVUrX86sUbbPD8wWynmQPTywxw3/hQOCe+KkRtfIOIcpvcwJorsqS2w34JKMbl
         4D2apuK3+TryN5HaxAISIX/QdsHOvEni0jGX9g2jtBpnccV8qHOkKDwM4B1rJaH/DgKH
         JJvFs4jBJOnIpaAVsCbGDAcJdfM8dFExjYchC/FZP81al01pI5XuULXPMk1hI6O6Zetk
         izO0EEuPK8B2qBNMZr1QspZUd1Lgr2LAQME4+pdyXF6GWLen4aTUMYDeBqPlE17JwZ/i
         SfEw==
X-Gm-Message-State: ANhLgQ18ZsnMRugAGQ3/DH9mQbwS+FISfm40ffTqvTR6rxE0ySjc8Tg0
        nXxNLpvWAji+NvTX5uGLx+2p2YKy160=
X-Google-Smtp-Source: ADFU+vvWK8hKheKVDZ1BgJb12Z0r9+RePhfmT1iLPBixkKd5N5IR5u2BasLAy4m4UbOiD5vTW3YbfQ==
X-Received: by 2002:adf:f044:: with SMTP id t4mr5493484wro.287.1583949882618;
        Wed, 11 Mar 2020 11:04:42 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id z11sm8997840wmd.47.2020.03.11.11.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 11:04:40 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, lgirdwood@gmail.com, perex@perex.cz,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/2] ASoC: qdsp6: fix default FE dais and routings.
Date:   Wed, 11 Mar 2020 18:04:20 +0000
Message-Id: <20200311180422.28363-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QDSP6 Frontend dais can be configured to work in rx or tx or both rx/tx mode,
however the default routing do not honour this DT configuration making sound
card fail to probe. FE dais are also not fully honouring device tree configuration.
Fix both of them.

Originally  issue was reported by Vinod Koul

Srinivas Kandagatla (2):
  ASoC: qdsp6: q6asm-dai: only enable dais from device tree
  ASoC: qdsp6: q6routing: remove default routing

 sound/soc/qcom/qdsp6/q6asm-dai.c | 30 +++++++++++++++++++++++-------
 sound/soc/qcom/qdsp6/q6routing.c | 19 -------------------
 2 files changed, 23 insertions(+), 26 deletions(-)

-- 
2.21.0

