Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81029C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 13:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5513E20728
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 13:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOPPV64R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbgDXNsw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 09:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726968AbgDXNsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 09:48:51 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8B7C09B045;
        Fri, 24 Apr 2020 06:48:51 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id hi11so3892954pjb.3;
        Fri, 24 Apr 2020 06:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=2DVzAqGlB49JWp0oL1SmWG/HV+R8mjoqAyRBZUTC0pU=;
        b=bOPPV64RPDBHzaQCub7+qxmIkVRKLLx9dXUsZVhdnxzZELOEd7nWTk9yh9bNlsAk1K
         v/QDJ/blGUmOLQksv+nBOD+qYuaXd5Q9n6XTYgnGpN9se+i+Dzoq+YAuxh/5dFqJw8IW
         /J6QBVnK6cNrW4AUqvD/eQe4FKvAPKiUUrB5Dp8MIu+IgxbXHMQuSQqK00TLlfMl7G51
         1U+N28WQuxCVor4U9oJeP9uSePchSha12ib4c+ONYUDNnpW1fhwF0Jo13+WyW1acSlZS
         m5JoxaogYsqjZzHNjH7wZXRUmEVxMqdgUfymHco1kZkLOROEhT7X2a37fgf4/WJxO9uz
         pp+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=2DVzAqGlB49JWp0oL1SmWG/HV+R8mjoqAyRBZUTC0pU=;
        b=EHdPYKQ1oaUTd1uDZhEgf2zNIeh4e/uyM5KpLYKJffCAL4/l22cebsw+Ku4aDcCqH5
         r+ptHxs04oUlnn0iEJVX1V03lc+WIrZQVExMPPoHaTiYVJRAu/QZ/nGn1QmtVLxpKvJQ
         pGKpigjBH/t1aj1Zskj+pll8tj4KBEvPC4m2sIzYi9mbjKzAw2eysPWk1DoRjJ6tJsSU
         pWcJiN1i5ok1GvXRwzylZabnWnyBCvBKFuq6gL+RaIEMILHUvxOtoOgLxqTCzNXfMHVr
         CvkcpWOxN/k1m/gQtFe6Jw+P8INkOXZJWX3nncJS2NPEQxmxQ14kHPtb0+jdnoheXSgw
         Chjw==
X-Gm-Message-State: AGi0PuZINfC12a3FurA2O6h7OQHGLUTvAjv7G9ocmgMja1OyBWq96zKU
        kVEfeGile2Y4AMNtoRhdxhA=
X-Google-Smtp-Source: APiQypJOJqWEP4BGjmSiTcz0csz/1eE5bCGQliVA3G7R4LwsLZ2pWYC/AzGT371/Ei6MFHUpfaTtag==
X-Received: by 2002:a17:902:fe87:: with SMTP id x7mr9426287plm.282.1587736131263;
        Fri, 24 Apr 2020 06:48:51 -0700 (PDT)
Received: from blackclown ([171.60.179.95])
        by smtp.gmail.com with ESMTPSA id i6sm5917356pfg.138.2020.04.24.06.48.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 24 Apr 2020 06:48:50 -0700 (PDT)
Date:   Fri, 24 Apr 2020 19:18:34 +0530
From:   Suraj Upadhyay <usuraj35@gmail.com>
To:     jerome.pouiller@silabs.com, gregkh@linuxfoundation.org,
        dan.carpenter@oracle.com
Cc:     kernel-janitors@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] staging: wfx: cleanup long lines in data_tx.c
Message-ID: <20200424134834.GA19700@blackclown>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="YZ5djTAD1cGYuMQK"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Break lines with length over 80 characters to conform
to the linux coding style and refactor wherever necessary.

Signed-off-by: Suraj Upadhyay <usuraj35@gmail.com>
---

Changes in v3:
	- Changed the temporary variable name for the memzcmp statement
	  to is_used. (as suggested).
	- Added a temporary ieee80211_supported_band variable to address
	  the problem in wfx_get_hw_rate() more efficiently. (not
	  suggested, but still).

Changes in v2:
        - Introduced a temporary variable for the memzcmp statement.
        - Addressed the checkpatch problem with wfx_get_hw_rate().
        - Restored the function definition of wfx_tx_get_tx_parms
          as suggested by the reviewer.
        - Added suggested changes for req->packet_id statement.

 drivers/staging/wfx/data_tx.c | 40 +++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/wfx/data_tx.c b/drivers/staging/wfx/data_tx.c
index 9c1a91207dd8..717155975345 100644
--- a/drivers/staging/wfx/data_tx.c
+++ b/drivers/staging/wfx/data_tx.c
@@ -20,6 +20,8 @@
 static int wfx_get_hw_rate(struct wfx_dev *wdev,
 			   const struct ieee80211_tx_rate *rate)
 {
+
+	struct ieee80211_supported_band *band;
 	if (rate->idx < 0)
 		return -1;
 	if (rate->flags & IEEE80211_TX_RC_MCS) {
@@ -31,7 +33,8 @@ static int wfx_get_hw_rate(struct wfx_dev *wdev,
 	}
 	// WFx only support 2GHz, else band information should be retrieved
 	// from ieee80211_tx_info
-	return wdev->hw->wiphy->bands[NL80211_BAND_2GHZ]->bitrates[rate->idx].hw_=
value;
+	band =3D wdev->hw->wiphy->bands[NL80211_BAND_2GHZ];
+	return band->bitrates[rate->idx].hw_value;
 }
=20
 /* TX policy cache implementation */
@@ -159,14 +162,16 @@ static int wfx_tx_policy_upload(struct wfx_vif *wvif)
 {
 	struct tx_policy *policies =3D wvif->tx_policy_cache.cache;
 	u8 tmp_rates[12];
-	int i;
+	int i, is_used;
=20
 	do {
 		spin_lock_bh(&wvif->tx_policy_cache.lock);
-		for (i =3D 0; i < HIF_TX_RETRY_POLICY_MAX; ++i)
-			if (!policies[i].uploaded &&
-			    memzcmp(policies[i].rates, sizeof(policies[i].rates)))
+		for (i =3D 0; i < HIF_TX_RETRY_POLICY_MAX; ++i) {
+			is_used =3D memzcmp(policies[i].rates,
+					  sizeof(policies[i].rates));
+			if (!policies[i].uploaded && is_used)
 				break;
+		}
 		if (i < HIF_TX_RETRY_POLICY_MAX) {
 			policies[i].uploaded =3D true;
 			memcpy(tmp_rates, policies[i].rates, sizeof(tmp_rates));
@@ -290,7 +295,8 @@ static void wfx_tx_fixup_rates(struct ieee80211_tx_rate=
 *rates)
 		if (rates[i].idx =3D=3D -1) {
 			rates[i].idx =3D 0;
 			rates[i].count =3D 8; // =3D=3D hw->max_rate_tries
-			rates[i].flags =3D rates[i - 1].flags & IEEE80211_TX_RC_MCS;
+			rates[i].flags =3D rates[i - 1].flags &
+					 IEEE80211_TX_RC_MCS;
 			break;
 		}
 	}
@@ -318,7 +324,8 @@ static u8 wfx_tx_get_rate_id(struct wfx_vif *wvif,
 	return rate_id;
 }
=20
-static struct hif_ht_tx_parameters wfx_tx_get_tx_parms(struct wfx_dev *wde=
v, struct ieee80211_tx_info *tx_info)
+static struct hif_ht_tx_parameters wfx_tx_get_tx_parms(struct wfx_dev *wde=
v,
+						       struct ieee80211_tx_info *tx_info)
 {
 	struct ieee80211_tx_rate *rate =3D &tx_info->driver_rates[0];
 	struct hif_ht_tx_parameters ret =3D { };
@@ -381,7 +388,8 @@ static int wfx_tx_inner(struct wfx_vif *wvif, struct ie=
ee80211_sta *sta,
 	hif_msg->id =3D HIF_REQ_ID_TX;
 	hif_msg->interface =3D wvif->id;
 	if (skb->len > wvif->wdev->hw_caps.size_inp_ch_buf) {
-		dev_warn(wvif->wdev->dev, "requested frame size (%d) is larger than maxi=
mum supported (%d)\n",
+		dev_warn(wvif->wdev->dev,
+			 "requested frame size (%d) is larger than maximum supported (%d)\n",
 			 skb->len, wvif->wdev->hw_caps.size_inp_ch_buf);
 		skb_pull(skb, wmsg_len);
 		return -EIO;
@@ -392,9 +400,10 @@ static int wfx_tx_inner(struct wfx_vif *wvif, struct i=
eee80211_sta *sta,
 	// packet_id just need to be unique on device. 32bits are more than
 	// necessary for that task, so we tae advantage of it to add some extra
 	// data for debug.
-	req->packet_id =3D queue_id << 28 |
-			 IEEE80211_SEQ_TO_SN(le16_to_cpu(hdr->seq_ctrl)) << 16 |
-			 (atomic_add_return(1, &wvif->wdev->packet_id) & 0xFFFF);
+	req->packet_id =3D atomic_add_return(1, &wvif->wdev->packet_id) & 0xFFFF;
+	req->packet_id |=3D IEEE80211_SEQ_TO_SN(le16_to_cpu(hdr->seq_ctrl)) << 16;
+	req->packet_id |=3D queue_id << 28;
+
 	req->data_flags.fc_offset =3D offset;
 	if (tx_info->flags & IEEE80211_TX_CTL_SEND_AFTER_DTIM)
 		req->data_flags.after_dtim =3D 1;
@@ -517,7 +526,8 @@ void wfx_tx_confirm_cb(struct wfx_vif *wvif, const stru=
ct hif_cnf_tx *arg)
 		if (tx_count < rate->count &&
 		    arg->status =3D=3D HIF_STATUS_RETRY_EXCEEDED &&
 		    arg->ack_failures)
-			dev_dbg(wvif->wdev->dev, "all retries were not consumed: %d !=3D %d\n",
+			dev_dbg(wvif->wdev->dev,
+				"all retries were not consumed: %d !=3D %d\n",
 				rate->count, tx_count);
 		if (tx_count <=3D rate->count && tx_count &&
 		    arg->txed_rate !=3D wfx_get_hw_rate(wvif->wdev, rate))
@@ -554,7 +564,8 @@ void wfx_tx_confirm_cb(struct wfx_vif *wvif, const stru=
ct hif_cnf_tx *arg)
 		else
 			tx_info->flags |=3D IEEE80211_TX_STAT_ACK;
 	} else if (arg->status =3D=3D HIF_REQUEUE) {
-		WARN(!arg->tx_result_flags.requeue, "incoherent status and result_flags"=
);
+		WARN(!arg->tx_result_flags.requeue,
+		     "incoherent status and result_flags");
 		if (tx_info->flags & IEEE80211_TX_CTL_SEND_AFTER_DTIM) {
 			wvif->after_dtim_tx_allowed =3D false; // DTIM period elapsed
 			schedule_work(&wvif->update_tim_work);
@@ -588,7 +599,8 @@ void wfx_flush(struct ieee80211_hw *hw, struct ieee8021=
1_vif *vif,
 		if (wait_event_timeout(wdev->tx_dequeue,
 				       wfx_tx_queue_empty(wdev, queue, vif_id),
 				       msecs_to_jiffies(1000)) <=3D 0)
-			dev_warn(wdev->dev, "frames queued while flushing tx queues?");
+			dev_warn(wdev->dev,
+				 "frames queued while flushing tx queues?");
 	}
 	wfx_tx_flush(wdev);
 	if (wdev->chip_frozen)
--=20
2.17.1


--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE7AbCa0kOsMJ4cx0j+gRsbIfe744FAl6i7jIACgkQ+gRsbIfe
746OyhAAj8dRMqUGnuvUI7iudTUDf1u/BEYvb1Y+9zUEiJNtNsulRslqAWQNugMy
QjUe1z7VcdTiPgn7ppp8i5gNE2ef19kNCfECbOTlEzdY93+agN5R/YgbdKaGow9c
vN1rhiWXbkDc4ZjmnOXqEiuExOgcW8PKSR+/CX72TGYsdmvjdLA5naQDOXCWJ1ED
h+HNr4/qPLtNLW2mcx5Dh/I7zarf2QEJDsg/PssjmYYRQhm1H7L5Hm3ZaEHyrExM
+TLKW3+RHZBp4xK7ZiBwJ11zBOyEXw1G4Z0pzLPVsG5wuAACQA0ofcDk9ZGVYIhH
HVRRdjK9HypcIaT7S8Cj2hilsgl61HlCD1BuBrz8DEiA6CegXdbAMxsnW56HA6wt
xCpqEruZhBgiwOi15hNbMYr9sqS4V5H2jJ9AihsQSbPILIvfLDwzInJoNu9UF4m0
mq4mKzBDU/Y20PtcMH3ZlPLZPH3YYbi8h61QjYHDFRVBOBlaesEw4zOHr/y3q+2S
DPMge+FlK8M28vUA1U3NEa7QJwq66F19TkCt7uHLc2Slg8rgRmfotsTOSXKqo6GL
t+kwtTHD2UYCFsV4DegCn5504t6MkJIuQ/roCuBOhQAaDyDqTmnkjYbVQsFpfR27
EbJZT5lq8PzONtTiavdshqHA5aIpOV+UCIhVK7tdajnXMUE1mz8=
=Hhh5
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
