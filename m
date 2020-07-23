Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D65BC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 09:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC1A120709
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 09:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nTv6M9U+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbgGWJWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 05:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgGWJWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 05:22:02 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD77C0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 02:22:01 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id k71so2901385pje.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 02:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=1tevanNxDhJg1GvBFwQNHjGBshZF989STYuUI5BEaVI=;
        b=nTv6M9U+LkckfUlUptFWmwigPk3hlwkgJ86Fdgu91lRmSbIaxAac9z3380eh+r+nzZ
         iginwYt4BOTehF47opYv46hs6wJuymOXkoEQXNLF4zwmeFeSndUn8OSXY/URZp/v263U
         bn1w6XXxf8SFO//uo00a/6IOz8s7i5r8mNkJc2/T4jVaWMHGURKk8MK47x0TDqOSOc/I
         XvyiEVYqULOAxW9Ppj8U3OAwr2GIj1MZDWbW2mzbDvgDP8VA1ysZs4i3N7qyDVxcIMIf
         vEDnj/MHGkJGNvl4e29bp0qqTl7hvtO4zhJaGHLEYJwa9radBaJaozTkPeMs2q23o+r6
         k7dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=1tevanNxDhJg1GvBFwQNHjGBshZF989STYuUI5BEaVI=;
        b=FfsDmshQ785jVo6N+yGlBLkErhWilMRB+KxCQ42X90hnpaNrdtAnqwLNsc/T88mbWj
         ia+KgWURyQPxAQrVmodRBJHweWuMC8BMNu/oYnLi5wUxddFGumeWdE7xbCpk+TtEDaAK
         sRgAlpzu1tT4+Id8tBl9A3wN3l2xMVCRiLFxK5YyEV5qJc8rr9dLGF7sNfIxyJzi0qQ+
         mRCyVv397QUzczfsGL7YBxHWJsqmh1SjerNyJJDm/aPXwva0PxZbyEFbDw2lG3/cW+8Y
         gz/hritqIKrvSh3M0LDbH3D+bwP09X/EeHfj9sYFsrx5kM7hNcEHPh0Vhe4gZdx41nDV
         XSbQ==
X-Gm-Message-State: AOAM532FVZ61s7Y0oTxRqW4EKR7fz5vufUcARSQyD4dYNMqcnzSv/adc
        ARfYstgu3PqZL57rVEJH1iI=
X-Google-Smtp-Source: ABdhPJyD3MhVcD+iw3xvkNHJUhXqKC5CDL2Gd1e0iT+UgXq2QFhhTFKGBYDvqEIHzSl7+PblSR1QZw==
X-Received: by 2002:a17:90a:ac06:: with SMTP id o6mr211990pjq.219.1595496121268;
        Thu, 23 Jul 2020 02:22:01 -0700 (PDT)
Received: from localhost ([117.211.62.241])
        by smtp.gmail.com with ESMTPSA id i7sm2295464pgh.58.2020.07.23.02.21.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Jul 2020 02:22:00 -0700 (PDT)
Date:   Thu, 23 Jul 2020 14:51:55 +0530
From:   Priti Chattopadhyay <pritias81@gmail.com>
To:     Larry.Finger@lwfinger.net, gregkh@linuxfoundation.org,
        straube.linux@gmail.com, pritias81@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Staging: rtl8188eu: Fix a constant comparison coding style
 issue
Message-ID: <20200723092150.y34bentngeeci2oc@pritichattopadhyay>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="djjjinv2dvv7gkgs"
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--djjjinv2dvv7gkgs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Modify equality comparison involving constants by shifting the constant
operand to the right side of the comparison as suggested by=20
scripts/checkpatch.pl

Signed-off-by: Priti Chattopadhyay <pritias81@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_wlan_util.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c b/drivers/stagi=
ng/rtl8188eu/core/rtw_wlan_util.c
index 6df873e..be843fd 100644
--- a/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8188eu/core/rtw_wlan_util.c
@@ -967,7 +967,7 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pf=
rame, u32 packet_len)
 		pbuf =3D rtw_get_wpa_ie(&bssid->ies[12], &wpa_ielen,
 				      bssid->ie_length - 12);
 		if (pbuf && (wpa_ielen > 0)) {
-			if (_SUCCESS =3D=3D rtw_parse_wpa_ie(pbuf, wpa_ielen + 2, &group_cipher=
, &pairwise_cipher, &is_8021x)) {
+			if (rtw_parse_wpa_ie(pbuf, wpa_ielen + 2, &group_cipher, &pairwise_ciph=
er, &is_8021x) =3D=3D _SUCCESS) {
 				RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
 					 ("%s pnetwork->pairwise_cipher: %d, group_cipher is %d, is_8021x is =
%d\n", __func__,
 					 pairwise_cipher, group_cipher, is_8021x));
@@ -977,7 +977,7 @@ int rtw_check_bcn_info(struct adapter  *Adapter, u8 *pf=
rame, u32 packet_len)
 					       bssid->ie_length - 12);
=20
 			if (pbuf && (wpa_ielen > 0)) {
-				if (_SUCCESS =3D=3D rtw_parse_wpa2_ie(pbuf, wpa_ielen + 2, &group_ciph=
er, &pairwise_cipher, &is_8021x)) {
+				if (rtw_parse_wpa2_ie(pbuf, wpa_ielen + 2, &group_cipher, &pairwise_ci=
pher, &is_8021x) =3D=3D _SUCCESS) {
 					RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
 						 ("%s pnetwork->pairwise_cipher: %d, pnetwork->group_cipher is %d, i=
s_802x is %d\n",
 						  __func__, pairwise_cipher, group_cipher, is_8021x));
--=20
2.7.4


--djjjinv2dvv7gkgs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEQsRqLLgZkq19UkrvgZtUbyBrZHkFAl8ZVq4ACgkQgZtUbyBr
ZHlbQAwAncf5AU8htX12PiCw7iQPZqB83seI/7foHEiVzY4NuwluLez7dUpmMMFz
NIhvmV4GU+084SDJsVhIO9/X/WlsX01iYZXwX/TBe8MYKPErG38P6pZvsI6v5CDe
3RC03k2Br8Dv83eYsWCKKtQq3znAQjfqnX9NkiOpprJomf9cwVOb2OYznZjjLCx0
1Op1CArZZhHpWjs5k5YEo3IigAROGCI8r/HigKjAtNm1ET4nYDR4qzJSMxpAIVCp
TfoKi8OXEwZJ5au+47xS0VdPvTI3EG5ScITt6Qycdvfsm7YUq1oriqTL9P9tw98j
r3CNqDiGemjpfXjCtcm+X9cXAqFUixlNOoeY/ff9XdVyJtDoVfFtP9sJFIbtk692
iar61Vi97ejPA3XU4nqnAAeQ9fEU5FhvKBowNSOnzN8/Zc/T2QhO5cEv4yfAo5GA
51epeQ2k6hAB4UVgl7CcdH5niCxP/5dikqwexl8sx77xiDCpjX8nb3+7viR1MUf8
TUSz6sm4
=YL6g
-----END PGP SIGNATURE-----

--djjjinv2dvv7gkgs--
