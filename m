Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1526C55185
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 11:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73FA5206EC
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 11:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l1kxZJcg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgDYLct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 07:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgDYLct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 07:32:49 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07277C09B04B;
        Sat, 25 Apr 2020 04:32:48 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t16so4770900plo.7;
        Sat, 25 Apr 2020 04:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=B+W3fSIG0b01sQcBXySLrSav3xx3u2le0H6T3QghDFc=;
        b=l1kxZJcgEZpWRkALjXbUTcNA5ovU6ZVUM+f+oU9UoRc+U1gx3uJm5xfdBxRAeD3n9L
         fAxDfIkwcceZZTkgaSS+yT5IlMil3cCWU5rC9wqyyBCdHXPyGxUK6rdJZ8qksFjCuBCM
         2DKZIV0J76PsZg54a3BKJXw1xYIEPIGnSoGiBwJ0gfSfa/TB7jGYVauH5vnRc6P7yrE/
         Y/9Fju11gHyDpSu08+dF2JTT6HapwaAQki4WkCEklQIBCjdwNZ5UI2fBq+58XW5dsqnU
         Tw8mVkhLsHcg7ivEeskt28Dr747PxVDb6MBAGDRp1Qv7LoefGNIg8BXuha0/u/3fooN4
         qWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=B+W3fSIG0b01sQcBXySLrSav3xx3u2le0H6T3QghDFc=;
        b=AShy5wI0Uv4qz2zwOH6z4HyNlBPC8OkHdmqTERkKdRl9GWWsFC2ehtDlzbv1ogOaBn
         R8oPZwYjWXYX0sDx0MyQId8FurP7tId96nredlk/JjaMv/8aof733tQ3yT0x2Qib8ReD
         jXOciUcxm8xfSos2dwSGK49n8aHn8F1t1TzyzLbSdGilBBw9aHWyMDKSemse0n+07alb
         jJwbhXrcDvluvwANFpxB3UcMJoLCjWV+Z01CiYF6qRPPKdJv2L+zWuGs6CvwqJyU3x/h
         jTYKg75iBtQmn9aY02ZpMbxxqLg3aFKcBQIrdRvZT47giw+I69EhYZqAAfIwpVzrsP1n
         9Hmg==
X-Gm-Message-State: AGi0PubL6tmOBH9gNtn/RDhPoeYg0rvl3aqMHN4L9/CzIHrkHNq28hiB
        +eip3FZNTF+56wGmjJlYAcQ=
X-Google-Smtp-Source: APiQypIK/Xv6UYq8rj92xpSeAb1sCBvmF7UA2YD7f5RGsSJKV20elDO5tweYidskW68GMpg/4xDJOA==
X-Received: by 2002:a17:90a:db91:: with SMTP id h17mr12504358pjv.10.1587814368263;
        Sat, 25 Apr 2020 04:32:48 -0700 (PDT)
Received: from blackclown ([171.60.181.170])
        by smtp.gmail.com with ESMTPSA id f13sm1612636pgr.14.2020.04.25.04.32.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 25 Apr 2020 04:32:47 -0700 (PDT)
Date:   Sat, 25 Apr 2020 17:02:34 +0530
From:   Suraj Upadhyay <usuraj35@gmail.com>
To:     jerome.pouiller@silabs.com, gregkh@linuxfoundation.org
Cc:     kernel-janitors@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] staging: wfx: cleanup long lines in data_tx.c
Message-ID: <20200425113234.GA14492@blackclown>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Break lines with length over 80 characters to
conform to the linux coding style and refactor
wherever necessary.

Signed-off-by: Suraj Upadhyay <usuraj35@gmail.com>
---

Changes in v4:
	- Added a space after declaration in wfx_get_hw_rate().
	- A checkpatch warning for this commit is retained at line 75,
	  to maintain uniformity in function declarations. (Reviewer
	  jerome suggested).

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
index 9c1a91207dd8..2f8a254fa453 100644
--- a/drivers/staging/wfx/data_tx.c
+++ b/drivers/staging/wfx/data_tx.c
@@ -20,6 +20,8 @@
 static int wfx_get_hw_rate(struct wfx_dev *wdev,
 			   const struct ieee80211_tx_rate *rate)
 {
+	struct ieee80211_supported_band *band;
+
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


--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE7AbCa0kOsMJ4cx0j+gRsbIfe744FAl6kH8gACgkQ+gRsbIfe
744T+A/7BbxW6wKy7I5b3vvOMx57gWO8LdDZiVaSNVoKicPelvxaWMDcL7uRNrRA
s8x7UyIzmqh3bEXKJX1fhTP5SlNURo6XNbtKvU4yKD5r8wG1uCpWfXy4BcIEhVSu
+0PrGLKiw7Oj+TirnRZ4rns7n26bbHUcoi9e8lfqCmIzv7KDDW/J8MlSYloef2mm
L/rNGA6MoJ2P1I5yS8esP4tCWtXpSWHSRg71vrNgioYHeJhCCfhHrlQyxUf+x/m3
YZxXoSBi21aGrmUIp+PkHH9eLmc/Z/1d0rK9IUqqFeDXBVK5ZYR5Tmax4E3Lmbmn
RscbUS3mOQhJ0dSB51yeI+U8CAlScEjF9Tdp4SKyXik6m2RM1bGr9YAAvkDgl3Cd
AMi7FOzDmHg4CFGI1eHzKIKSZ5IAUEhE2vxGnDOxvNDStoXmd9UBnP2Bi/wO2oNi
dvch8Vf4S+RjhExNxugJVvJ8U4b7pL8mhLO+dotIDC729A8uisZ9QHU5WctTZUdA
lYfUX6CqZh4m4BO810Ni7JnGjb2GNW8nMF2v0z8PMK4KmBSxxgPUx1x08/GJdZan
tCk6i5QkneGDYnRax8RbDkFYAzefSt05Cis+bE1zVbJDhZJzvH+UtJv/F8ot9tLZ
Z/YeBXs6pxRrXcy5YSp2xXJ3snhcN/K+EZtEHyVfqIQqij5PRfQ=
=UVQ5
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
