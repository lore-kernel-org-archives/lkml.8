Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05913C3524A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 06:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCB6220674
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 06:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iXUE6ebm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgBDGDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 01:03:15 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:40056 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgBDGDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 01:03:14 -0500
Received: by mail-oi1-f193.google.com with SMTP id a142so17325907oii.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 22:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XMN+K684Z/eVZ2yqWGF8j0z6j6M569qkTkBF8k40oto=;
        b=iXUE6ebm4DNRaybXe8E5MJV+zuFNTp8YtrjhZBJpVahnRtRlo/wlsroYUWsbzOcqpB
         ZrD9bBlQE23F5TGK2maz/caplkgCljAVe/NWWPzOTvJESIZqSQ0tLvEinV0j79S2sgCh
         NqGXfWe/nIqgwPvone2XLITAudSxoARaNlFO2Rw7eFWcs0zfv+F6Qw4SfiTNwxppZVXg
         yX32n16CFb5WLXAm05/f0NiNfKnbSCdfAsBJC1tdAgIWD7NHiUe9pDBtj8WHq4e7pY61
         0wZn9jjAC0bAWM31CCckaMxVAePFzTxouLcpqwRCJaT/8E98hn+W/cygJo9iH7G5hRsH
         IfGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XMN+K684Z/eVZ2yqWGF8j0z6j6M569qkTkBF8k40oto=;
        b=T3mOpRA/6hq+Ha+xxvV1WpVV64C3JMS+1AZw1F2rsEWNJ1bGsagKD6AFPDIO1BVH8R
         g2pDgiejJvSPqyRNy2Jnw/0np2YiKqqe9PWyeKYeIg53VwnievX5xzP0YYbgtvHE+zPv
         228GhG8rCEYk1jBRJbyynIlNiqpVHhPHm1zbep5BxQUmY3vjKRLwHIdPOr31U+stb+n4
         N4xi/3uRH5DlrAzWRHy5Yy5rSueIES6AANOowiKBo4ElqJm6tUwNDXMI64O/U+mbd1D0
         UtP/saHj7y9e1+LuM+OFKgV/CvMVEaLShl99pIVaWdPIRedG5a48F1yGJJJH+X0uEVK1
         uLog==
X-Gm-Message-State: APjAAAUTmJPfGLq6dXNvOm1YtdXfjV0uphGRp76/fQ1AVsD6+8mXYdu7
        8RhkURAZOjHTK1hh/jdlRS3ln2bP
X-Google-Smtp-Source: APXvYqzmORnsr5YKAbx545QjhZhcUKYFi/BJlFYlcOrBRtot49y/1d6gwfVV0ShbmWEKuNCpqRV6Nw==
X-Received: by 2002:aca:fc0c:: with SMTP id a12mr2264517oii.118.1580796193543;
        Mon, 03 Feb 2020 22:03:13 -0800 (PST)
Received: from localhost.localdomain ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id d131sm6501708oia.36.2020.02.03.22.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 22:03:11 -0800 (PST)
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] ASoC: wcd934x: Remove some unnecessary NULL checks
Date:   Mon,  3 Feb 2020 23:01:44 -0700
Message-Id: <20200204060143.23393-1-natechancellor@gmail.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

../sound/soc/codecs/wcd934x.c:1886:11: warning: address of array
'wcd->rx_chs' will always evaluate to 'true' [-Wpointer-bool-conversion]
        if (wcd->rx_chs) {
        ~~  ~~~~~^~~~~~
../sound/soc/codecs/wcd934x.c:1894:11: warning: address of array
'wcd->tx_chs' will always evaluate to 'true' [-Wpointer-bool-conversion]
        if (wcd->tx_chs) {
        ~~  ~~~~~^~~~~~
2 warnings generated.

Arrays that are in the middle of a struct are never NULL so they don't
need a check like this.

Fixes: a61f3b4f476e ("ASoC: wcd934x: add support to wcd9340/wcd9341 codec")
Link: https://github.com/ClangBuiltLinux/linux/issues/854
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---

Also, turns out this was fixed in the wcd9335 driver in
commit d22b4117538d ("ASoC: wcd9335: remove some unnecessary
NULL checks")...

 sound/soc/codecs/wcd934x.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index 158e878abd6c..e780ecd554d2 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -1883,20 +1883,16 @@ static int wcd934x_set_channel_map(struct snd_soc_dai *dai,
 		return -EINVAL;
 	}
 
-	if (wcd->rx_chs) {
-		wcd->num_rx_port = rx_num;
-		for (i = 0; i < rx_num; i++) {
-			wcd->rx_chs[i].ch_num = rx_slot[i];
-			INIT_LIST_HEAD(&wcd->rx_chs[i].list);
-		}
+	wcd->num_rx_port = rx_num;
+	for (i = 0; i < rx_num; i++) {
+		wcd->rx_chs[i].ch_num = rx_slot[i];
+		INIT_LIST_HEAD(&wcd->rx_chs[i].list);
 	}
 
-	if (wcd->tx_chs) {
-		wcd->num_tx_port = tx_num;
-		for (i = 0; i < tx_num; i++) {
-			wcd->tx_chs[i].ch_num = tx_slot[i];
-			INIT_LIST_HEAD(&wcd->tx_chs[i].list);
-		}
+	wcd->num_tx_port = tx_num;
+	for (i = 0; i < tx_num; i++) {
+		wcd->tx_chs[i].ch_num = tx_slot[i];
+		INIT_LIST_HEAD(&wcd->tx_chs[i].list);
 	}
 
 	return 0;
-- 
2.25.0

