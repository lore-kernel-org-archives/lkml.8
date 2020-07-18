Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E08C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 09:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF7C72073E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 09:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pesu-pes-edu.20150623.gappssmtp.com header.i=@pesu-pes-edu.20150623.gappssmtp.com header.b="n3d+sUFa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgGRJQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 05:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbgGRJQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 05:16:32 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FCBC0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 02:16:32 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id m9so6576889pfh.0
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 02:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pesu-pes-edu.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=C24ti86kE7NMM1lv4kv8FNrXBsCWS2j7pMpanwJHY1U=;
        b=n3d+sUFa71nV7qDubwtx493drXVvVG0FqzGDuXSWGPr9ZkiuMhohiaZ0c8CP4ZqBPN
         /wVWuzRkJi3pEaTslE6Pdef3NWOnjl2KCVet9On0hGRJlhlGAy5uqHjOaBsjEKvlJGjh
         PRNQaq6Vd6NzoDczBgd1fv8UN7fk2JD4Nxo//2nE5J6vB6oTrVHels0I2z2kcBS0e6po
         OoIr3nl9ZvtP479PsnKnvP5Zfs2xFlUp4Har+Q9d43Ok2IzQ9g9Z5IAcKyzkHkM/9dCL
         hx4aA1Dkuc4WI9dxeM/98+d8zZNI0u5lYpjjW7zFoOzp49ohlV0XCUHYhMJBbn6jJ//f
         TH5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=C24ti86kE7NMM1lv4kv8FNrXBsCWS2j7pMpanwJHY1U=;
        b=RJkee5dt0AYbKElIx77Dyynm5lAyBX9365cedmhQdw91GduaGC5XGy7lN4r5A2LG9d
         MIElN41ffaBKPS+E6RJ6wzCdgHEUU0Q+ZtMCitLKANEWgxwVCPemJwYq/TyKdLbBWcgw
         Odo3NBVKW+cW5pYZPXQarlACkB1LAvzzcN6W8hSfBU6+cMD4/PqMMFHXuW9/T872vYf3
         K0RydmtxaCp8lqolJvNp7h/gBTOMqHbvW5JqBeY8u2BxZcKz/IBTs7vCIUublD8t7amM
         md0KFp5S9MZNWLEut12zQ/i/yIY1dWefiC3DHCbhbivYIigO7Il6wRQQcVGjrJzkhbp6
         VnPw==
X-Gm-Message-State: AOAM531lMSO7ouGPPnS/yTqGkd15SJmAxyMhFLE+MMgUQeZeLirvX92g
        zXEtaVAWBmwPLq+udV3XW9yJkw==
X-Google-Smtp-Source: ABdhPJxZsd8+37SUXd40L8uH5JQT4ipksIBm/OjaVFSnEDjV63RCt491SafxvEHFwH77tZt/vKfWlQ==
X-Received: by 2002:a65:63c8:: with SMTP id n8mr11804090pgv.232.1595063791931;
        Sat, 18 Jul 2020 02:16:31 -0700 (PDT)
Received: from localhost ([2406:7400:73:207:8b43:3062:877d:c647])
        by smtp.gmail.com with ESMTPSA id o14sm4930415pjw.3.2020.07.18.02.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jul 2020 02:16:30 -0700 (PDT)
From:   B K Karthik <bkkarthik@pesu.pes.edu>
X-Google-Original-From: B K Karthik <karthik.bk2000@live.com>
Date:   Sat, 18 Jul 2020 05:16:26 -0400
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] staging: rtl8188eu: include: fixed multiple parentheses
 coding style issues
Message-ID: <20200718091626.uflhdcgkmhqij5b7@pesu-pes-edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p6ckdqruwalwg3a2"
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--p6ckdqruwalwg3a2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

fixed multiple parentheses coding style issues reported by checkpatch.

Signed-off-by: B K Karthik <karthik.bk2000@live.com>
---
 drivers/staging/rtl8188eu/include/ieee80211.h |  4 +--
 .../staging/rtl8188eu/include/osdep_service.h |  4 +--
 drivers/staging/rtl8188eu/include/wifi.h      | 34 +++++++++----------
 3 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/rtl8188eu/include/ieee80211.h b/drivers/stagin=
g/rtl8188eu/include/ieee80211.h
index 83218e7ec0a9..a872a86f89ab 100644
--- a/drivers/staging/rtl8188eu/include/ieee80211.h
+++ b/drivers/staging/rtl8188eu/include/ieee80211.h
@@ -646,8 +646,8 @@ struct rtw_ieee80211_channel {
 	"flags:0x%08x" \
=20
 #define CHAN_ARG(channel) \
-	(channel)->hw_value \
-	, (channel)->flags \
+	((channel)->hw_value \
+	, (channel)->flags)
=20
 /* Parsed Information Elements */
 struct rtw_ieee802_11_elems {
diff --git a/drivers/staging/rtl8188eu/include/osdep_service.h b/drivers/st=
aging/rtl8188eu/include/osdep_service.h
index 31d897f1d21f..2245cc430981 100644
--- a/drivers/staging/rtl8188eu/include/osdep_service.h
+++ b/drivers/staging/rtl8188eu/include/osdep_service.h
@@ -76,9 +76,9 @@ struct net_device *rtw_alloc_etherdev_with_old_priv(void =
*old_priv);
 void rtw_free_netdev(struct net_device *netdev);
=20
 #define FUNC_NDEV_FMT "%s(%s)"
-#define FUNC_NDEV_ARG(ndev) __func__, ndev->name
+#define FUNC_NDEV_ARG(ndev) (__func__, (ndev)->name)
 #define FUNC_ADPT_FMT "%s(%s)"
-#define FUNC_ADPT_ARG(adapter) __func__, adapter->pnetdev->name
+#define FUNC_ADPT_ARG(adapter) (__func__, (adapter)->pnetdev->name)
=20
 /* Macros for handling unaligned memory accesses */
=20
diff --git a/drivers/staging/rtl8188eu/include/wifi.h b/drivers/staging/rtl=
8188eu/include/wifi.h
index 791f287a546d..677827900607 100644
--- a/drivers/staging/rtl8188eu/include/wifi.h
+++ b/drivers/staging/rtl8188eu/include/wifi.h
@@ -143,57 +143,57 @@ enum WIFI_REG_DOMAIN {
 #define _ORDER_		BIT(15)
=20
 #define SetToDs(pbuf)	\
-	*(__le16 *)(pbuf) |=3D cpu_to_le16(_TO_DS_)
+	(*(__le16 *)(pbuf) |=3D cpu_to_le16(_TO_DS_))
=20
 #define GetToDs(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_TO_DS_)) !=3D 0)
=20
 #define ClearToDs(pbuf)	\
-	*(__le16 *)(pbuf) &=3D (~cpu_to_le16(_TO_DS_))
+	(*(__le16 *)(pbuf) &=3D (~cpu_to_le16(_TO_DS_)))
=20
 #define SetFrDs(pbuf)	\
-	*(__le16 *)(pbuf) |=3D cpu_to_le16(_FROM_DS_)
+	(*(__le16 *)(pbuf) |=3D cpu_to_le16(_FROM_DS_))
=20
 #define GetFrDs(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_FROM_DS_)) !=3D=
 0)
=20
 #define ClearFrDs(pbuf)	\
-	*(__le16 *)(pbuf) &=3D (~cpu_to_le16(_FROM_DS_))
+	(*(__le16 *)(pbuf) &=3D (~cpu_to_le16(_FROM_DS_)))
=20
 #define get_tofr_ds(pframe)	((GetToDs(pframe) << 1) | GetFrDs(pframe))
=20
 #define SetMFrag(pbuf)	\
-	*(__le16 *)(pbuf) |=3D cpu_to_le16(_MORE_FRAG_)
+	(*(__le16 *)(pbuf) |=3D cpu_to_le16(_MORE_FRAG_))
=20
 #define GetMFrag(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_MORE_FRAG_)) !=
=3D 0)
=20
 #define ClearMFrag(pbuf)	\
-	*(__le16 *)(pbuf) &=3D (~cpu_to_le16(_MORE_FRAG_))
+	(*(__le16 *)(pbuf) &=3D (~cpu_to_le16(_MORE_FRAG_)))
=20
 #define SetRetry(pbuf)	\
-	*(__le16 *)(pbuf) |=3D cpu_to_le16(_RETRY_)
+	(*(__le16 *)(pbuf) |=3D cpu_to_le16(_RETRY_))
=20
 #define GetRetry(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_RETRY_)) !=3D =
0)
=20
 #define ClearRetry(pbuf)	\
-	*(__le16 *)(pbuf) &=3D (~cpu_to_le16(_RETRY_))
+	(*(__le16 *)(pbuf) &=3D (~cpu_to_le16(_RETRY_)))
=20
 #define SetPwrMgt(pbuf)	\
-	*(__le16 *)(pbuf) |=3D cpu_to_le16(_PWRMGT_)
+	(*(__le16 *)(pbuf) |=3D cpu_to_le16(_PWRMGT_))
=20
 #define GetPwrMgt(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_PWRMGT_)) !=
=3D 0)
=20
 #define ClearPwrMgt(pbuf)	\
-	*(__le16 *)(pbuf) &=3D (~cpu_to_le16(_PWRMGT_))
+	(*(__le16 *)(pbuf) &=3D (~cpu_to_le16(_PWRMGT_)))
=20
 #define SetMData(pbuf)	\
-	*(__le16 *)(pbuf) |=3D cpu_to_le16(_MORE_DATA_)
+	(*(__le16 *)(pbuf) |=3D cpu_to_le16(_MORE_DATA_))
=20
 #define GetMData(pbuf)	(((*(__le16 *)(pbuf)) & cpu_to_le16(_MORE_DATA_)) !=
=3D 0)
=20
 #define ClearMData(pbuf)	\
-	*(__le16 *)(pbuf) &=3D (~cpu_to_le16(_MORE_DATA_))
+	(*(__le16 *)(pbuf) &=3D (~cpu_to_le16(_MORE_DATA_)))
=20
 #define SetPrivacy(pbuf)	\
-	*(__le16 *)(pbuf) |=3D cpu_to_le16(_PRIVACY_)
+	(*(__le16 *)(pbuf) |=3D cpu_to_le16(_PRIVACY_))
=20
 #define GetPrivacy(pbuf)					\
 	(((*(__le16 *)(pbuf)) & cpu_to_le16(_PRIVACY_)) !=3D 0)
@@ -228,18 +228,18 @@ enum WIFI_REG_DOMAIN {
 	} while (0)
=20
 #define SetDuration(pbuf, dur) \
-	*(__le16 *)((size_t)(pbuf) + 2) =3D cpu_to_le16(0xffff & (dur))
+	(*(__le16 *)((size_t)(pbuf) + 2) =3D cpu_to_le16(0xffff & (dur)))
=20
 #define SetPriority(pbuf, tid)	\
-	*(__le16 *)(pbuf) |=3D cpu_to_le16(tid & 0xf)
+	(*(__le16 *)(pbuf) |=3D cpu_to_le16(tid & 0xf))
=20
 #define GetPriority(pbuf)	((le16_to_cpu(*(__le16 *)(pbuf))) & 0xf)
=20
 #define SetEOSP(pbuf, eosp)	\
-		*(__le16 *)(pbuf) |=3D cpu_to_le16((eosp & 1) << 4)
+		(*(__le16 *)(pbuf) |=3D cpu_to_le16((eosp & 1) << 4))
=20
 #define SetAckpolicy(pbuf, ack)	\
-	*(__le16 *)(pbuf) |=3D cpu_to_le16((ack & 3) << 5)
+	(*(__le16 *)(pbuf) |=3D cpu_to_le16((ack & 3) << 5))
=20
 #define GetAckpolicy(pbuf) (((le16_to_cpu(*(__le16 *)pbuf)) >> 5) & 0x3)
=20
--=20
2.20.1


--p6ckdqruwalwg3a2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAEBCgAdFiEEpIrzAt4LvWLJmKjp471Q5AHeZ2oFAl8SvekACgkQ471Q5AHe
Z2q17Qv9EYWSTewAxPY7AdbcAU7qwWLaHeW7SlMcp+fQZoI8DqZCPkqGEso0IgN/
q1yIwanySsm4KVYZ13yg2uWV/V0qrSjeUr16ieWxjuftSM61JfEm471JyjDv9g1M
738qtqHPyJi47LdWUjau4frgcGbnirqUI4RpCxYiOjfYHdDBw7sYKTShx1694/UE
CBW7NU0p1zRezoL7CYf2jADMHPqU79a2M+dSvEKdqkZz/6Bvv38vzBu59baZzEFS
mbV5Kvlkct0eXmAeguUjzbVqTSLmkvUYf4OdiBlWj7Gl6Wr/XGOXELjWyGIl2Ol+
F/rZVx2PqQpY9SVWWWZPJKuaxbSgzihkAK0aGoFKZOb9lmIs7kkHrM70RtDcylon
3N3MyH99h75yPYEz5l4CGfEBzg+nHdbpylYH+0ChOIdJb2zdmjytTrpn10b08TEj
ZwoHFS2qdEkhEOiaIIaVRmCn0YnM5J69qe44V8l4Db3Tm5+aS8KeY294jxIJSjoO
7ayi9O3R
=ULwM
-----END PGP SIGNATURE-----

--p6ckdqruwalwg3a2--
