Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFAB7C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 04:30:22 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D99620678
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 04:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cn5OcRmn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D99620678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbgDMEaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 00:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:60282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgDMEaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 00:30:20 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154FBC0A3BE0;
        Sun, 12 Apr 2020 21:30:19 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id o81so2745770wmo.2;
        Sun, 12 Apr 2020 21:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EbnZSiEMnHgTN/mDIIGBsmHUVd2FaPr3+pRi3ydpxdc=;
        b=Cn5OcRmnV/FsOvZHrEClH/vFv+XEOER2nAVKrUXl5glM2qw6RE+Qimvigbr0HpL5PE
         qW2u8NBJP2sTfEG0OOEVGdHU1bNJ5XdZ+ebOd2rMYFi+W3O2CpygbEoGuPTx7cVa6pjj
         5TgG1I09ERhcmzIfUj7B4P0aQJK5DJTQmrO2ZHHcbD1mTOFZC9qHG44Kgxbfnh99qeGQ
         A2R7xn7yy1gYCwHwHBpY25uKCIfYUv2deoLcjQkUMmq9s1uI+oysogt0rSqkip72k8Z5
         0XEj2P1EOccs5zvL+u4A7eY/kJ/1flUR3w82q6XDEfriPdBEXPUYBHAglyZT4eyki1MG
         R3Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EbnZSiEMnHgTN/mDIIGBsmHUVd2FaPr3+pRi3ydpxdc=;
        b=CyikhUeedBX/ULxSrtjMC85hNbicqKKsdENt2LMhZ5flUtQqf1TbZETWoICPSl0kJ/
         QcD9pOT8kMJqYSWpRoundQXaNdESmyvyaWW5Sw8euHuTpHAYYlLRqb3pO4YeWD0An7L5
         yjTJm3UO/pNJ6E83bt0TNvZGgWdePcW3FxkbqaaKSpOtmVxOHhNbwvWhT43clpHFX/r+
         jfJWBu3PylxoueLWcy60DaYWvKor+hwpY7QTNANpHeMBQ7fksiIy/Wh49Gdxoc1+RRet
         Mh6z0162YI4BPtfLQO2RZcISMyivkfbIhUY5VDezgNmd+JlHO3TaGAD4iDOKI9L21L1V
         +Jnw==
X-Gm-Message-State: AGi0PuZ6p2ds1MSqFIbkWU5NjQ5ckEge+V4T4g/tJM+CODGNofsouNFl
        6s8JAxt9+Q7z1xQoYDnxfKooILc090I=
X-Google-Smtp-Source: APiQypJqzsG5xE7UIV/7jHME578hAykas9gVz9OtdHMsoHKH3Nw7qn3xHFVFEoe++RD96wFYJR3fag==
X-Received: by 2002:a1c:7308:: with SMTP id d8mr17695093wmb.31.1586752217830;
        Sun, 12 Apr 2020 21:30:17 -0700 (PDT)
Received: from basti.fritz.box (p200300D1FF00AD00593005B1452DFD52.dip0.t-ipconnect.de. [2003:d1:ff00:ad00:5930:5b1:452d:fd52])
        by smtp.gmail.com with ESMTPSA id b82sm13668229wmh.1.2020.04.12.21.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2020 21:30:17 -0700 (PDT)
From:   Sebastian Fricke <sebastian.fricke.linux@gmail.com>
To:     olivier.moysan@st.com
Cc:     sebastian.fricke.linux@gmail.com, kernel-janitors@vger.kernel.org,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        alsa-devel@alsa-project.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] soc/stm/stm32_sub_sai: Add missing '\n' in log messages
Date:   Mon, 13 Apr 2020 06:29:52 +0200
Message-Id: <20200413042952.7675-1-sebastian.fricke.linux@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Message logged by 'dev_xxx()' or 'pr_xxx()' should end with a '\n'.

Fixes: 3e086ed("ASoC: stm32: add SAI drivers")

Signed-off-by: Sebastian Fricke <sebastian.fricke.linux@gmail.com>
---
 sound/soc/stm/stm32_sai_sub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index 0d0c9afd8791..34a7c3d6fb91 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -837,7 +837,7 @@ static int stm32_sai_set_config(struct snd_soc_dai *cpu_dai,
 		cr1 = SAI_XCR1_DS_SET(SAI_DATASIZE_32);
 		break;
 	default:
-		dev_err(cpu_dai->dev, "Data format not supported");
+		dev_err(cpu_dai->dev, "Data format not supported\n");
 		return -EINVAL;
 	}
 
-- 
2.20.1

