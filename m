Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F13C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D21E22087D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VMAJCEXV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgHZJjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 05:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728255AbgHZJeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 05:34:25 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D78AC0617AA
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 02:34:13 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id z9so1078110wmk.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 02:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H1Hym68LxPW6ieroM4xJcJiJE9iF0Bx9WVLyM7RpmKc=;
        b=VMAJCEXVaQPRQW4gxdp2T0I4w6Fkr+KH5/mhPAGjP1DL6oyleISyvd9DQAKOzs0FX1
         eVIf6cJvx9yMkSzp4f0GsVwlGX85gm9hQkwFI34e0LFeLMwJfj+6WSxT0unCNYTCj87I
         AabQg0KwlhDsrv+LdxMz0xevrNsZmGSBtUOwEyRd2euIkDDsg9DTfzsIygKmREbe0B4J
         4VBNrG+t3XHGBzfhHHp0qo5um0VmechaZSEE3DDgCGOU7VJIP6eSaq0ShZmhNkMN8xIC
         ZNeaaa80cwkuF0CZPTqD3lkdOEMxwzC1orivKyHVJekmnUNEofldDtnPnGWp9dxBZ4Ee
         z/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H1Hym68LxPW6ieroM4xJcJiJE9iF0Bx9WVLyM7RpmKc=;
        b=C8I9ogIrSbeN9Icr37SvWZ6lohlrSyfsTR72MZD43cgweLFIlaa6FOGgt/bc65DLGg
         sOY9s41L6kR23z/O2U3voQY2zTnnMVM0N/8OSUsidgR9GQK/SD4qBSFxACyBRp3N0Ptg
         m5rdsIc3aRbfDiopw4gb4rwlhc/HJx8SSBAGGlW9a9uX4c3odxSjOWNgTVNeKlFOqShA
         /NOZYlaMltEQsxfL2r7EKdkCXgW41Q5aIvlvhsUnUvTHWOTQecPAAPLg/qhEqbHWWnpd
         0EAFoRho4+7HRpTp3AASn+QJLD6B1IDSu+iwWEPAKpEIyu4DHjg8AD2ahAX0NQLmobA5
         iYiw==
X-Gm-Message-State: AOAM533WyVXzJZ7bP6axOodhG3L3n2R9yBblXqjwMKDYFFdRUOijpjG9
        KMTqbsL4z0nC1te6eqA9MBWghw==
X-Google-Smtp-Source: ABdhPJxipHFvSbtI71RiJ8e+6GlXBjE75iLabDbjuqbugxVTsHIlg3NaDpwhxRrncYAyD0QVRVRp2w==
X-Received: by 2002:a1c:7718:: with SMTP id t24mr3435825wmi.137.1598434452265;
        Wed, 26 Aug 2020 02:34:12 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id u3sm3978759wml.44.2020.08.26.02.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 02:34:11 -0700 (PDT)
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
Subject: [PATCH 06/30] wireless: broadcom: brcmfmac: p2p: Fix a couple of function headers
Date:   Wed, 26 Aug 2020 10:33:37 +0100
Message-Id: <20200826093401.1458456-7-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200826093401.1458456-1-lee.jones@linaro.org>
References: <20200826093401.1458456-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most likely caused by doc-rot.

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c:977: warning: Function parameter or member 'wdev' not described in 'brcmf_p2p_remain_on_channel'
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c:2048: warning: Function parameter or member 'cfg' not described in 'brcmf_p2p_ifchange'
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c:2048: warning: Excess function parameter 'mac' description in 'brcmf_p2p_ifchange'

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
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
index dc0bc1f6c8023..ec6fc7a150a6a 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/p2p.c
@@ -966,7 +966,7 @@ brcmf_p2p_discover_listen(struct brcmf_p2p_info *p2p, u16 channel, u32 duration)
  * brcmf_p2p_remain_on_channel() - put device on channel and stay there.
  *
  * @wiphy: wiphy device.
- * @wiphy: wireless device.
+ * @wdev: wireless device.
  * @channel: channel to stay on.
  * @duration: time in ms to remain on channel.
  * @cookie: cookie.
@@ -2038,8 +2038,7 @@ static void brcmf_p2p_get_current_chanspec(struct brcmf_p2p_info *p2p,
 
 /**
  * Change a P2P Role.
- * Parameters:
- * @mac: MAC address of the BSS to change a role
+ * @cfg: driver private data for cfg80211 interface.
  * @if_type: interface type.
  * Returns 0 if success.
  */
-- 
2.25.1

