Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B257C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 07:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC8EA2072D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 07:20:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dnImnfFj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbgHUHUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 03:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728249AbgHUHSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 03:18:12 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EDBC06137C
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 00:17:19 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id l2so999869wrc.7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 00:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1SwOdl3qsamQLekmEElFc9JqMKayOsDgTAbLZhvVikk=;
        b=dnImnfFjiDNFfYpg8z5tV2sLsHw86tH7Jc+5orDMUB1MplgaOUwBUiMJ0coiV8t5Kd
         Or89x62EZ7WSqJVpjl7E99tdGFe+lsMtoIH10bCg02O6sO49kSY4rsdAdJVbVlh3TD0n
         DJyysjPrA0/1PGaxfT/LMg2NKe4hbmVZ+Yv9z6bnSvoFmfFGbGbwMYp1E6HayrUv2xtW
         HS9HkdRvxF/37JBgu/O0LgLDthdxhBLW/LweO6uEmAJCnyLhN5NGgZPAYZJvboD4IxOm
         LVzeDQJpHAr3qxOYXxUm78DPtzRAOJKYRfIJOQviyRNQq8V7nG85PDxgJkyPVNN9xHsL
         77cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1SwOdl3qsamQLekmEElFc9JqMKayOsDgTAbLZhvVikk=;
        b=jW659mZaWBvwFvy4LBwRx87N55gKKyZGIEZX6zNzJ7tK/ppfAdcNjPuXFbpM/1AZPD
         oCuLOkiCUlTXdZDLtK4EZYKtWtJEES4BCMAQlVizFcyy+JAXGOe7WKvG4WORdwlWylQD
         VE9Hea5+FTpDuJtXJyfSHZy1e0ORQS9Ucpa3/iWau+//Yh5kvl3WvS6n9W/7NToISJK1
         dLLuDm7KM8xeDRnbojzTdy1jqYbndvHPt2wrIlugliyeOyFk4mG5nY6808+j+EV36f0b
         OQmNPiSFHD+f4OpBg+SmrA/525S3KaFtNkab/hNXBNRVYAet2W4OKXI6ZHweZ/u0odWR
         NYhg==
X-Gm-Message-State: AOAM532C4733eoazdhcwgpo2OcD/R1m4g9ZU/nWS73c6Y2EfvgcTqLpV
        hbstad7L/Gv8QUdVxX+1fAVClQ==
X-Google-Smtp-Source: ABdhPJzJi0T0vD0alFijUDBN82QjCRhNnnHBSeBmNRlzlDy6K5aaLeA4aB21h/7nMVFAL/QHiEZKmA==
X-Received: by 2002:a5d:526d:: with SMTP id l13mr1324804wrc.279.1597994238166;
        Fri, 21 Aug 2020 00:17:18 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id y24sm2667957wmi.17.2020.08.21.00.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 00:17:17 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        brcm80211-dev-list.pdl@broadcom.com, brcm80211-dev-list@cypress.com
Subject: [PATCH 24/32] wireless: brcmfmac: fwsignal: Remove unused variable 'brcmf_fws_prio2fifo'
Date:   Fri, 21 Aug 2020 08:16:36 +0100
Message-Id: <20200821071644.109970-25-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821071644.109970-1-lee.jones@linaro.org>
References: <20200821071644.109970-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c:504:18: warning: ‘brcmf_fws_prio2fifo’ defined but not used [-Wunused-const-variable=]

Cc: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: Franky Lin <franky.lin@broadcom.com>
Cc: Hante Meuleman <hante.meuleman@broadcom.com>
Cc: Chi-Hsien Lin <chi-hsien.lin@cypress.com>
Cc: Wright Feng <wright.feng@cypress.com>
Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: brcm80211-dev-list.pdl@broadcom.com
Cc: brcm80211-dev-list@cypress.com
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../broadcom/brcm80211/brcmfmac/fwsignal.c         | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
index 2df6811c066ef..902b2f65d4605 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fwsignal.c
@@ -498,20 +498,6 @@ struct brcmf_fws_info {
 	bool avoid_queueing;
 };
 
-/*
- * brcmf_fws_prio2fifo - mapping from 802.1d priority to firmware fifo index.
- */
-static const int brcmf_fws_prio2fifo[] = {
-	BRCMF_FWS_FIFO_AC_BE,
-	BRCMF_FWS_FIFO_AC_BK,
-	BRCMF_FWS_FIFO_AC_BK,
-	BRCMF_FWS_FIFO_AC_BE,
-	BRCMF_FWS_FIFO_AC_VI,
-	BRCMF_FWS_FIFO_AC_VI,
-	BRCMF_FWS_FIFO_AC_VO,
-	BRCMF_FWS_FIFO_AC_VO
-};
-
 #define BRCMF_FWS_TLV_DEF(name, id, len) \
 	case BRCMF_FWS_TYPE_ ## name: \
 		return len;
-- 
2.25.1

