Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87077C2D0E5
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 18:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FD2420732
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 18:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hurranet.com header.i=aiman.najjar@hurranet.com header.b="UfZUyxH+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbgC2S73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 14:59:29 -0400
Received: from sender4-op-o14.zoho.com ([136.143.188.14]:17457 "EHLO
        sender4-op-o14.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgC2S72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 14:59:28 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1585508340; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=eqhdibtFvn3qt2Eb++DEvnmy4c+vluwIlqMi35NdykSlyl0Nz5F6R5xyXdXR4yq6Q1gAIfoDjPmQXWe1epHrYDTKBDtXb1c52sUwCOIFSYGJgFTqnAA+qbvo41CwS0oLtbvc2BV3DzkGdrRGj1hZx3ch02ovD5fDdRFHeNZnHiw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1585508340; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=MuiLiAsrA5upVzkJTPsQoyFumgH4t0lXkV3qC5Ts/8I=; 
        b=cfL2dzhj2NhoGonxnCyLviBuweGcZMLoikEauRsx5K6zZ5lbiG7t4weEAmZta1HCyh3CPbjbbRKe3ctZyyDIS6b/YYMs35phkrMpbcUHT1qzTmA/XRBFx7A1cjM+J6XniPzVN5OjdN/C4rsxvD7ZtF6x5msKvmwrz2G/uIkVRJo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=hurranet.com;
        spf=pass  smtp.mailfrom=aiman.najjar@hurranet.com;
        dmarc=pass header.from=<aiman.najjar@hurranet.com> header.from=<aiman.najjar@hurranet.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1585508340;
        s=zoho; d=hurranet.com; i=aiman.najjar@hurranet.com;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=MuiLiAsrA5upVzkJTPsQoyFumgH4t0lXkV3qC5Ts/8I=;
        b=UfZUyxH+UiH9C/xRm5HdM4ypKq8swoO16sHdFuLkg07DYRG5t/Ir6bGeuC5TCj03
        TJnCheWa+yfQ4v5m4O6H3effAqKpWbxOA2de3h4VV4fSr5hAeZfLoB/rc78uBg8NFoV
        ODOuty420Mnd8zUkj5S/VBUx4ufMIuPlz4caPJK8=
Received: from kernel-dev (097-100-022-132.res.spectrum.com [97.100.22.132]) by mx.zohomail.com
        with SMTPS id 1585508338369107.26816775653185; Sun, 29 Mar 2020 11:58:58 -0700 (PDT)
From:   Aiman Najjar <aiman.najjar@hurranet.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Aiman Najjar <aiman.najjar@hurranet.com>,
        Joe Perches <joe@perches.com>
Message-ID: <275773a0379e4a03839cd832d2ed952fd7bfee48.1585508171.git.aiman.najjar@hurranet.com>
Subject: [PATCH v3 4/5] staging:rtl8712: code improvements to make_wlanhdr
Date:   Sun, 29 Mar 2020 14:57:46 -0400
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1585508171.git.aiman.najjar@hurranet.com>
References: <cover.1585508171.git.aiman.najjar@hurranet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. Refactor make_wlanhdr to improve code style.
2. Use ether_addr_copy instead of memcpy to copy addresses.

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Aiman Najjar <aiman.najjar@hurranet.com>
---
 drivers/staging/rtl8712/rtl871x_xmit.c | 123 ++++++++++++-------------
 drivers/staging/rtl8712/rtl871x_xmit.h |   2 +-
 2 files changed, 61 insertions(+), 64 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_xmit.c b/drivers/staging/rtl87=
12/rtl871x_xmit.c
index 0f789c821552..21026297413c 100644
--- a/drivers/staging/rtl8712/rtl871x_xmit.c
+++ b/drivers/staging/rtl8712/rtl871x_xmit.c
@@ -477,75 +477,72 @@ static int make_wlanhdr(struct _adapter *padapter, u8=
 *hdr,
 =09struct mlme_priv *pmlmepriv =3D &padapter->mlmepriv;
 =09struct qos_priv *pqospriv =3D &pmlmepriv->qospriv;
 =09__le16 *fctrl =3D &pwlanhdr->frame_ctl;
+=09u8 *bssid;
=20
 =09memset(hdr, 0, WLANHDR_OFFSET);
 =09SetFrameSubType(fctrl, pattrib->subtype);
-=09if (pattrib->subtype & WIFI_DATA_TYPE) {
-=09=09if (check_fwstate(pmlmepriv,  WIFI_STATION_STATE)) {
-=09=09=09/* to_ds =3D 1, fr_ds =3D 0; */
-=09=09=09SetToDs(fctrl);
-=09=09=09memcpy(pwlanhdr->addr1, get_bssid(pmlmepriv),
-=09=09=09=09ETH_ALEN);
-=09=09=09memcpy(pwlanhdr->addr2, pattrib->src, ETH_ALEN);
-=09=09=09memcpy(pwlanhdr->addr3, pattrib->dst, ETH_ALEN);
-=09=09} else if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
-=09=09=09/* to_ds =3D 0, fr_ds =3D 1; */
-=09=09=09SetFrDs(fctrl);
-=09=09=09memcpy(pwlanhdr->addr1, pattrib->dst, ETH_ALEN);
-=09=09=09memcpy(pwlanhdr->addr2, get_bssid(pmlmepriv),
-=09=09=09=09ETH_ALEN);
-=09=09=09memcpy(pwlanhdr->addr3, pattrib->src, ETH_ALEN);
-=09=09} else if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) ||
-=09=09=09   check_fwstate(pmlmepriv,
-=09=09=09=09=09 WIFI_ADHOC_MASTER_STATE)) {
-=09=09=09memcpy(pwlanhdr->addr1, pattrib->dst, ETH_ALEN);
-=09=09=09memcpy(pwlanhdr->addr2, pattrib->src, ETH_ALEN);
-=09=09=09memcpy(pwlanhdr->addr3, get_bssid(pmlmepriv),
-=09=09=09=09ETH_ALEN);
-=09=09} else if (check_fwstate(pmlmepriv, WIFI_MP_STATE)) {
-=09=09=09memcpy(pwlanhdr->addr1, pattrib->dst, ETH_ALEN);
-=09=09=09memcpy(pwlanhdr->addr2, pattrib->src, ETH_ALEN);
-=09=09=09memcpy(pwlanhdr->addr3, get_bssid(pmlmepriv),
-=09=09=09=09ETH_ALEN);
-=09=09} else {
-=09=09=09return -EINVAL;
-=09=09}
+=09if (!(pattrib->subtype & WIFI_DATA_TYPE))
+=09=09return 0;
=20
-=09=09if (pattrib->encrypt)
-=09=09=09SetPrivacy(fctrl);
-=09=09if (pqospriv->qos_option) {
-=09=09=09qc =3D (unsigned short *)(hdr + pattrib->hdrlen - 2);
-=09=09=09if (pattrib->priority)
-=09=09=09=09SetPriority(qc, pattrib->priority);
-=09=09=09SetAckpolicy(qc, pattrib->ack_policy);
-=09=09}
-=09=09/* TODO: fill HT Control Field */
-=09=09/* Update Seq Num will be handled by f/w */
-=09=09{
-=09=09=09struct sta_info *psta;
-=09=09=09bool bmcst =3D is_multicast_ether_addr(pattrib->ra);
-
-=09=09=09if (pattrib->psta) {
-=09=09=09=09psta =3D pattrib->psta;
-=09=09=09} else {
-=09=09=09=09if (bmcst)
-=09=09=09=09=09psta =3D r8712_get_bcmc_stainfo(padapter);
-=09=09=09=09else
-=09=09=09=09=09psta =3D
-=09=09=09=09=09 r8712_get_stainfo(&padapter->stapriv,
-=09=09=09=09=09 pattrib->ra);
-=09=09=09}
-=09=09=09if (psta) {
-=09=09=09=09psta->sta_xmitpriv.txseq_tid
-=09=09=09=09=09=09  [pattrib->priority]++;
-=09=09=09=09psta->sta_xmitpriv.txseq_tid[pattrib->priority]
-=09=09=09=09=09=09   &=3D 0xFFF;
-=09=09=09=09pattrib->seqnum =3D psta->sta_xmitpriv.
-=09=09=09=09=09=09  txseq_tid[pattrib->priority];
-=09=09=09=09SetSeqNum(hdr, pattrib->seqnum);
-=09=09=09}
+=09bssid =3D get_bssid(pmlmepriv);
+
+=09if (check_fwstate(pmlmepriv,  WIFI_STATION_STATE)) {
+=09=09/* to_ds =3D 1, fr_ds =3D 0; */
+=09=09SetToDs(fctrl);
+=09=09ether_addr_copy(pwlanhdr->addr1, bssid);
+=09=09ether_addr_copy(pwlanhdr->addr2, pattrib->src);
+=09=09ether_addr_copy(pwlanhdr->addr3, pattrib->dst);
+=09} else if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
+=09=09/* to_ds =3D 0, fr_ds =3D 1; */
+=09=09SetFrDs(fctrl);
+=09=09ether_addr_copy(pwlanhdr->addr1, pattrib->dst);
+=09=09ether_addr_copy(pwlanhdr->addr2, bssid);
+=09=09ether_addr_copy(pwlanhdr->addr3, pattrib->src);
+=09} else if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) ||
+=09=09   check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) {
+=09=09ether_addr_copy(pwlanhdr->addr1, pattrib->dst);
+=09=09ether_addr_copy(pwlanhdr->addr2, pattrib->src);
+=09=09ether_addr_copy(pwlanhdr->addr3, bssid);
+=09} else if (check_fwstate(pmlmepriv, WIFI_MP_STATE)) {
+=09=09ether_addr_copy(pwlanhdr->addr1, pattrib->dst);
+=09=09ether_addr_copy(pwlanhdr->addr2, pattrib->src);
+=09=09ether_addr_copy(pwlanhdr->addr3, bssid);
+=09} else {
+=09=09return -EINVAL;
+=09}
+
+=09if (pattrib->encrypt)
+=09=09SetPrivacy(fctrl);
+=09if (pqospriv->qos_option) {
+=09=09qc =3D (unsigned short *)(hdr + pattrib->hdrlen - 2);
+=09=09if (pattrib->priority)
+=09=09=09SetPriority(qc, pattrib->priority);
+=09=09SetAckpolicy(qc, pattrib->ack_policy);
+=09}
+=09/* TODO: fill HT Control Field */
+=09/* Update Seq Num will be handled by f/w */
+=09{
+=09=09struct sta_info *psta;
+=09=09bool bmcst =3D is_multicast_ether_addr(pattrib->ra);
+
+=09=09if (pattrib->psta)
+=09=09=09psta =3D pattrib->psta;
+=09=09else if (bmcst)
+=09=09=09psta =3D r8712_get_bcmc_stainfo(padapter);
+=09=09else
+=09=09=09psta =3D r8712_get_stainfo(&padapter->stapriv,
+=09=09=09=09=09=09 pattrib->ra);
+
+=09=09if (psta) {
+=09=09=09u16 *txtid =3D psta->sta_xmitpriv.txseq_tid;
+
+=09=09=09txtid[pattrib->priority]++;
+=09=09=09txtid[pattrib->priority] &=3D 0xFFF;
+=09=09=09pattrib->seqnum =3D txtid[pattrib->priority];
+=09=09=09SetSeqNum(hdr, pattrib->seqnum);
 =09=09}
 =09}
+
 =09return 0;
 }
=20
diff --git a/drivers/staging/rtl8712/rtl871x_xmit.h b/drivers/staging/rtl87=
12/rtl871x_xmit.h
index f227828094bf..c0c0c781fe17 100644
--- a/drivers/staging/rtl8712/rtl871x_xmit.h
+++ b/drivers/staging/rtl8712/rtl871x_xmit.h
@@ -115,7 +115,7 @@ struct pkt_attrib {
 =09u8=09icv_len;
 =09unsigned char iv[8];
 =09unsigned char icv[8];
-=09u8=09dst[ETH_ALEN];
+=09u8=09dst[ETH_ALEN] __aligned(2);=09/* for ether_addr_copy */
 =09u8=09src[ETH_ALEN];
 =09u8=09ta[ETH_ALEN];
 =09u8=09ra[ETH_ALEN];
--=20
2.20.1


