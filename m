Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94198C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FC67206F1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pesu-pes-edu.20150623.gappssmtp.com header.i=@pesu-pes-edu.20150623.gappssmtp.com header.b="d7RGwmjs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731285AbgF2TNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731094AbgF2TMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:12:43 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9284C014A42
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 01:09:33 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id s14so6793727plq.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 01:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=f7mzmYEZ90niD9lpV23xIyu8jzdfLFeCZQFxCAagons=;
        b=d7RGwmjsilF1uieXeXCwjyX46zkjF0CPwMH+1SXCeq1TYFvl7vveSIbI/M2deJlujm
         r2tKT65aSxJH6tQsCoSGCtWShjlQg6+gl6YUzTwBPgRb8aFlT80tmQ7tHVQYNBRi/cqm
         VEfjiENxZdDLbUzBZvFeMEHmhSycGNiPOuvxKxM1tgxFx8446PVfCutaA3nAhlndlPIe
         kCmw/f769wdc3bvigI76pEe2/7GMbvXHUX21bG+vvgc1YLsr4OvtNvj/1j+zrNwn+ZAF
         myYXasWD35If0kzz4vYddPksBJcGabQlptcPZxuJ46TFGP6MOpotFGjFaTQtUhFMmhaR
         m2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=f7mzmYEZ90niD9lpV23xIyu8jzdfLFeCZQFxCAagons=;
        b=FIMNBZO9CCFDYiR0owHOvAsvrat3brx3ofnevi0QYa2uBIjYaYXgVFXIRMAvtRJM30
         uD60y2iCkmDBFOI9EbCj/k1uLAAPlvnXkS2uZ+hiOvfQ+77ZCBAh5mLpAXo/x0wzwsND
         7R1WUpQCYxjJFVDWpABXW7ahs5ZodlDvIqf2ImnD8HNo7WJ1xsdAgVgQ6SfB3DDFKU9F
         fNw0rwATclruX7S+T7ltOpMv7p/R9cEHhhWhth8p80XIvtXcUQ7sQ0Aorc9RgtXoFkkF
         NqQDGjWhnZnmQsF9VhmrPLP3+PTFHdY3CcxSJ/AxUqbHZVsXEDmUzEJY+LR7mgU8k1wc
         lgfw==
X-Gm-Message-State: AOAM5302QIJ5GTZuYK8LeesWX+QpaDLWZBFc0OP9z1LtJPNVTAbG07Wg
        yBUTmZHy075XpOHwBM3gHkV1iw==
X-Google-Smtp-Source: ABdhPJzeqeWulbzG+1u84D/dmk/gQ0Cad1akAqYZj+mABVhiBf5N0Idkigo9ffle7lMT+GTOJakKng==
X-Received: by 2002:a17:90a:4bc7:: with SMTP id u7mr2294632pjl.217.1593418173517;
        Mon, 29 Jun 2020 01:09:33 -0700 (PDT)
Received: from localhost ([2406:7400:73:703c:908:f18a:1156:5c38])
        by smtp.gmail.com with ESMTPSA id a8sm7457402pfi.29.2020.06.29.01.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 01:09:32 -0700 (PDT)
From:   B K Karthik <bkkarthik@pesu.pes.edu>
X-Google-Original-From: B K Karthik <karthik.bk2000@live.com>
Date:   Mon, 29 Jun 2020 04:09:27 -0400
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8188eu: include: ieee80211.h: fixed multiple
 blank line coding style issues.
Message-ID: <20200629080927.ivzvczusduxtrc2g@pesu-pes-edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p3svisjutkhbdlvx"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p3svisjutkhbdlvx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

removed multiple blank lines to improve code readability.

Signed-off-by: B K Karthik <karthik.bk2000@live.com>
---
 drivers/staging/rtl8188eu/include/ieee80211.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/staging/rtl8188eu/include/ieee80211.h b/drivers/staging/rtl8188eu/include/ieee80211.h
index 75f0ebe0faf5..93fd0e9c49dc 100644
--- a/drivers/staging/rtl8188eu/include/ieee80211.h
+++ b/drivers/staging/rtl8188eu/include/ieee80211.h
@@ -90,7 +90,6 @@ enum {
 #define IEEE_CRYPT_ERR_TX_KEY_SET_FAILED		6
 #define IEEE_CRYPT_ERR_CARD_CONF_FAILED		7

-
 #define	IEEE_CRYPT_ALG_NAME_LEN			16

 #define WPA_CIPHER_NONE		BIT(0)
@@ -99,8 +98,6 @@ enum {
 #define WPA_CIPHER_TKIP		BIT(3)
 #define WPA_CIPHER_CCMP		BIT(4)

-
-
 #define WPA_SELECTOR_LEN 4
 extern u8 RTW_WPA_OUI_TYPE[];
 extern u8 WPA_AUTH_KEY_MGMT_NONE[];
@@ -113,7 +110,6 @@ extern u8 WPA_CIPHER_SUITE_WRAP[];
 extern u8 WPA_CIPHER_SUITE_CCMP[];
 extern u8 WPA_CIPHER_SUITE_WEP104[];

-
 #define RSN_HEADER_LEN 4
 #define RSN_SELECTOR_LEN 4

@@ -192,7 +188,6 @@ enum NETWORK_TYPE {
 #define IsSupportedTxMCS(NetType)				\
 	((NetType) & (WIRELESS_11_24N | WIRELESS_11_5N) ? true : false)

-
 struct ieee_param {
 	u32 cmd;
 	u8 sta_addr[ETH_ALEN];
@@ -270,11 +265,9 @@ struct sta_data {
  * WEP IV and ICV. (this interpretation suggested by Ramiro Barreiro)
  */

-
 #define IEEE80211_HLEN			30
 #define IEEE80211_FRAME_LEN		(IEEE80211_DATA_LEN + IEEE80211_HLEN)

-
 /* this is stolen from ipw2200 driver */
 #define IEEE_IBSS_MAC_HASH_SIZE 31

@@ -297,7 +290,6 @@ enum eap_type {
 #define RTW_IEEE80211_SCTL_FRAG	0x000F
 #define RTW_IEEE80211_SCTL_SEQ	0xFFF0

-
 #define RTW_ERP_INFO_NON_ERP_PRESENT BIT(0)
 #define RTW_ERP_INFO_USE_PROTECTION BIT(1)
 #define RTW_ERP_INFO_BARKER_PREAMBLE_MODE BIT(2)
@@ -354,7 +346,6 @@ struct ieee80211_snap_hdr {
 #define IEEE80211_CCK_RATE_LEN			4
 #define IEEE80211_NUM_OFDM_RATESLEN	8

-
 #define IEEE80211_CCK_RATE_1MB			0x02
 #define IEEE80211_CCK_RATE_2MB			0x04
 #define IEEE80211_CCK_RATE_5MB			0x0B
--
2.20.1


--p3svisjutkhbdlvx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEpIrzAt4LvWLJmKjp471Q5AHeZ2oFAl75obcACgkQ471Q5AHe
Z2qjswv/aC80O/zH6WxMngmgZjQPQG9ROeE506BjzkkAUtP90pFLQIJKDY/0dwt0
Q3SmIJyFEuv6tkAIfYQEAbDFuWDC0iK6B+pIq6+FZ4y91d20NcUZ1bGjEuYWtKV2
Ue5P+MoMvNoycsHDktLlz/EoM8veJXUkoc9UNOes5sgTptlOR6AGbbOVQu/86Qqi
RhmOz8/zpPp2MI0Rta1CEIJtYUGmRwnLq8omQu3kSv51GDjTI2uvO+nJGSvelSu3
6ck0lgblyH2uwlUBy3A1qwLgt76qn/mFsVb1Yg5Qrc3JUl5BITP0d+3NBAXkFHKL
ly8Z8+lFvA/OJFGQACcsMYekM3bnMgt6t15Rt7tbrCh3luVXRP9FZT8RNYW4eDij
0mHeKgiTCZJEWxhIkG29FbP8obki6XFZLzeDGaolgtfNEP3BI4vpzJGU9Tm63MNE
BeYxhvAnwZ+HPNsdvT71gYv/WkymMBYNayLAt7KpWdfQfoUDtgIWDAJii1H9MiFz
mynQ/tUZ
=1zZ0
-----END PGP SIGNATURE-----

--p3svisjutkhbdlvx--
