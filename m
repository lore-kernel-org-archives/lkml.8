Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6047FC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B19420706
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KctYodQa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbgFZPi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 11:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbgFZPi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 11:38:28 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EAEBC03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 08:38:28 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id d27so7772243qtg.4
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 08:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o2Ikny20NfFg5ztOT9jAikHgTETSs1qvvd29P7rUpwk=;
        b=KctYodQaUev1ai4UhpD8v7HeRQ1nE5DkSA/YHk67OSvh1IkDnPE7ajWn/DAeNHOGCF
         fyzEJcP+tALrgcJ1i87NF9E0p320bHQWVwdwErj8didSW50bdbm6bk9VSLoMsfYQJrOP
         yQOjSoYsuW7crDXe2CIJfb/V2TEWMfH0Tih4SBB0XeMjjx5pfjC4FFYtCMA5yzUOq2S2
         b6vSyNV3mg1pziGKybKV/Kyeu25pb6IS5gNGx2rT13Hl2hb3Ng6QSRldjAM8GFjoFr/3
         CE0dg6Dq+JETFSiYejiDyC+/BfnXGL+bQ1OZWugOTHU9Bk1CWsZ8r0FgWEcB/4ILHG4R
         KXYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o2Ikny20NfFg5ztOT9jAikHgTETSs1qvvd29P7rUpwk=;
        b=KjWAd1bqFqGV/bTonBCbnuRj6L/QSibMSiuM9evrJYNFUrin7XrTbFPq6zDdTPSPRC
         8pp7KOfeRXfYNp59pPsIF/CCEsvokrCDW6XJDyuWKO4d8CLwCUJw7Tx7YPq0AbxtFlqk
         xyyhfuNOTn2776oWvD02rerCHRpyih5q3spk9m3YcTmwEVT/evJzD2KgWgHDE7Nd1C7U
         SCYaJdIq9bQ4ZOqAhOatTSw4fsoSyO1pHOiiPueFWllYIFO6LTeTFv5/PGYa+fdm/UNX
         w1zLHAloNx9/MJ1NIwEjBq9+3PBpmPYXHmv9LbJ0EHRKd2rH3uk30VBG/ojLBuARtSPR
         LyEw==
X-Gm-Message-State: AOAM533mFSKDYve6jlQdDE+qhHlIJspc3PIIgiE7TK/NZQ8a+2G+BsTP
        HZLnRFP5HsvQosw19VCf6So=
X-Google-Smtp-Source: ABdhPJzqsrT4UOsb4GHqiS3w6FcocsJ90qUR+xiX55JN9a0QBfF1+uiMfkCrKM4mwQvMVWMvzKffsg==
X-Received: by 2002:ac8:6746:: with SMTP id n6mr3421897qtp.307.1593185907777;
        Fri, 26 Jun 2020 08:38:27 -0700 (PDT)
Received: from mooncell.myfiosgateway.com (pool-173-75-208-99.phlapa.fios.verizon.net. [173.75.208.99])
        by smtp.gmail.com with ESMTPSA id y40sm9719918qtc.29.2020.06.26.08.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 08:38:27 -0700 (PDT)
From:   Brooke Basile <brookebasile@gmail.com>
To:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        straube.linux@gmail.com, colin.king@canonical.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Brooke Basile <brookebasile@gmail.com>
Subject: [PATCH 4/4] staging: rtl8188eu: Replace function name with __func__
Date:   Fri, 26 Jun 2020 11:36:42 -0400
Message-Id: <20200626153639.8097-4-brookebasile@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200626153639.8097-3-brookebasile@gmail.com>
References: <20200626153639.8097-1-brookebasile@gmail.com>
 <20200626153639.8097-2-brookebasile@gmail.com>
 <20200626153639.8097-3-brookebasile@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following checkpatch warning:
	WARNING: Prefer using '"%s...", __func__' to using 'rtw_get_bcn_info', this function's name, in a string

Signed-off-by: Brooke Basile <brookebasile@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_ieee80211.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c b/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
index bf6b2fe9735f..0c43c0dcf95c 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ieee80211.c
@@ -986,10 +986,10 @@ void rtw_get_bcn_info(struct wlan_network *pnetwork)
 		if (bencrypt)
 			pnetwork->BcnInfo.encryp_protocol = ENCRYP_PROTOCOL_WEP;
 	}
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_get_bcn_info: pnetwork->encryp_protocol is %x\n",
-		 pnetwork->BcnInfo.encryp_protocol));
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_get_bcn_info: pnetwork->encryp_protocol is %x\n",
-		 pnetwork->BcnInfo.encryp_protocol));
+	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("%s: pnetwork->encryp_protocol is %x\n",
+		 __func__, pnetwork->BcnInfo.encryp_protocol));
+	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("%s: pnetwork->encryp_protocol is %x\n",
+		 __func__, pnetwork->BcnInfo.encryp_protocol));
 	rtw_get_cipher_info(pnetwork);
 
 	/* get bwmode and ch_offset */
-- 
2.27.0

