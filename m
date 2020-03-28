Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B752C2D0E5
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB9062073E
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 16:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hurranet.com header.i=aiman.najjar@hurranet.com header.b="n6o0kRo3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbgC1Qbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 12:31:36 -0400
Received: from sender4-op-o14.zoho.com ([136.143.188.14]:17492 "EHLO
        sender4-op-o14.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgC1Qbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 12:31:36 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1585413076; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=cnx8OaaGkzeShYQvr1Bfy0emo7T0vMmwOpk6diPQlSRpKrA6jiWyHBG+l/jVElYTa68cCAvgoQcV61bLMbJkShMm2Nz0w7Ys0MGPjFRP9uz4wFvbMrxkD468jUdjT9ZYrmQh4A/WLoNZcFZAJYXgoUe//+rM7P3xyz3yc54AIXw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1585413076; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=azjRAZNzzcNH5uYyNo5qC/RyD+3T2/aoWeeGRaG+3os=; 
        b=S7J8hnMQXFIO/FD0MmYKcbXtYf06SemL2tEDTKlpLkpef12gdEo5NZ3Xjq7F8OpTi/dXwGhCJYCRYIGdx22gvpGbvYvMUHQ8SrS2jZ42fxXD5jjaTlG1Nv8wvH4C7Agn5nRjpcumykE7ML4wYL8CMRuUC80AatTsXtEwyX3l5iM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=hurranet.com;
        spf=pass  smtp.mailfrom=aiman.najjar@hurranet.com;
        dmarc=pass header.from=<aiman.najjar@hurranet.com> header.from=<aiman.najjar@hurranet.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1585413076;
        s=zoho; d=hurranet.com; i=aiman.najjar@hurranet.com;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
        bh=azjRAZNzzcNH5uYyNo5qC/RyD+3T2/aoWeeGRaG+3os=;
        b=n6o0kRo3/5p73NnQRexeL8m4BnyGwEN04SrX5mGZCc6j0zEC5WxrV4rcLgUzui6x
        iOOcq9p1i2paRHGRbhUqTBeaTf2PKuznwxGWpQ91yMI3GZHys8YltXt+rzTw8FAg5Jg
        lBxeGqDlGsNCFQ/D2jlmidqJwSCexMKwqiycV+l0=
Received: from kernel-dev (097-100-022-132.res.spectrum.com [97.100.22.132]) by mx.zohomail.com
        with SMTPS id 1585413074138661.8008301567895; Sat, 28 Mar 2020 09:31:14 -0700 (PDT)
From:   aimannajjar <aiman.najjar@hurranet.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     aimannajjar <aiman.najjar@hurranet.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Message-ID: <beb6c8c826cdda751f29f985f2b5dedfd2f87914.1585353747.git.aiman.najjar@hurranet.com>
Subject: [PATCH v2 4/5] staging: rtl8712: fix multiline derefernce warning
Date:   Fri, 27 Mar 2020 20:08:10 -0400
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1585353747.git.aiman.najjar@hurranet.com>
References: <20200327080429.GB1627562@kroah.com> <cover.1585353747.git.aiman.najjar@hurranet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following checkpatch warning in
rtl8712x_xmit.c:

WARNING: Avoid multiple line dereference - prefer 'psta->sta_xmitpriv.txseq=
_tid[pattrib->priority]'
544: FILE: drivers/staging//rtl8712/rtl871x_xmit.c:544:
+=09=09=09=09pattrib->seqnum =3D psta->sta_xmitpriv.
+=09=09=09=09=09=09 txseq_tid[pattrib->priority];

Signed-off-by: aimannajjar <aiman.najjar@hurranet.com>
---
 drivers/staging/rtl8712/rtl871x_xmit.c | 50 +++++++++++++-------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_xmit.c b/drivers/staging/rtl87=
12/rtl871x_xmit.c
index 0f789c821552..04da7b318340 100644
--- a/drivers/staging/rtl8712/rtl871x_xmit.c
+++ b/drivers/staging/rtl8712/rtl871x_xmit.c
@@ -469,7 +469,7 @@ static sint xmitframe_swencrypt(struct _adapter *padapt=
er,
 }
=20
 static int make_wlanhdr(struct _adapter *padapter, u8 *hdr,
-=09=09=09struct pkt_attrib *pattrib)
+=09=09=09struct pkt_attrib *pattr)
 {
 =09u16 *qc;
=20
@@ -479,70 +479,70 @@ static int make_wlanhdr(struct _adapter *padapter, u8=
 *hdr,
 =09__le16 *fctrl =3D &pwlanhdr->frame_ctl;
=20
 =09memset(hdr, 0, WLANHDR_OFFSET);
-=09SetFrameSubType(fctrl, pattrib->subtype);
-=09if (pattrib->subtype & WIFI_DATA_TYPE) {
+=09SetFrameSubType(fctrl, pattr->subtype);
+=09if (pattr->subtype & WIFI_DATA_TYPE) {
 =09=09if (check_fwstate(pmlmepriv,  WIFI_STATION_STATE)) {
 =09=09=09/* to_ds =3D 1, fr_ds =3D 0; */
 =09=09=09SetToDs(fctrl);
 =09=09=09memcpy(pwlanhdr->addr1, get_bssid(pmlmepriv),
 =09=09=09=09ETH_ALEN);
-=09=09=09memcpy(pwlanhdr->addr2, pattrib->src, ETH_ALEN);
-=09=09=09memcpy(pwlanhdr->addr3, pattrib->dst, ETH_ALEN);
+=09=09=09memcpy(pwlanhdr->addr2, pattr->src, ETH_ALEN);
+=09=09=09memcpy(pwlanhdr->addr3, pattr->dst, ETH_ALEN);
 =09=09} else if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
 =09=09=09/* to_ds =3D 0, fr_ds =3D 1; */
 =09=09=09SetFrDs(fctrl);
-=09=09=09memcpy(pwlanhdr->addr1, pattrib->dst, ETH_ALEN);
+=09=09=09memcpy(pwlanhdr->addr1, pattr->dst, ETH_ALEN);
 =09=09=09memcpy(pwlanhdr->addr2, get_bssid(pmlmepriv),
 =09=09=09=09ETH_ALEN);
-=09=09=09memcpy(pwlanhdr->addr3, pattrib->src, ETH_ALEN);
+=09=09=09memcpy(pwlanhdr->addr3, pattr->src, ETH_ALEN);
 =09=09} else if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) ||
 =09=09=09   check_fwstate(pmlmepriv,
 =09=09=09=09=09 WIFI_ADHOC_MASTER_STATE)) {
-=09=09=09memcpy(pwlanhdr->addr1, pattrib->dst, ETH_ALEN);
-=09=09=09memcpy(pwlanhdr->addr2, pattrib->src, ETH_ALEN);
+=09=09=09memcpy(pwlanhdr->addr1, pattr->dst, ETH_ALEN);
+=09=09=09memcpy(pwlanhdr->addr2, pattr->src, ETH_ALEN);
 =09=09=09memcpy(pwlanhdr->addr3, get_bssid(pmlmepriv),
 =09=09=09=09ETH_ALEN);
 =09=09} else if (check_fwstate(pmlmepriv, WIFI_MP_STATE)) {
-=09=09=09memcpy(pwlanhdr->addr1, pattrib->dst, ETH_ALEN);
-=09=09=09memcpy(pwlanhdr->addr2, pattrib->src, ETH_ALEN);
+=09=09=09memcpy(pwlanhdr->addr1, pattr->dst, ETH_ALEN);
+=09=09=09memcpy(pwlanhdr->addr2, pattr->src, ETH_ALEN);
 =09=09=09memcpy(pwlanhdr->addr3, get_bssid(pmlmepriv),
 =09=09=09=09ETH_ALEN);
 =09=09} else {
 =09=09=09return -EINVAL;
 =09=09}
=20
-=09=09if (pattrib->encrypt)
+=09=09if (pattr->encrypt)
 =09=09=09SetPrivacy(fctrl);
 =09=09if (pqospriv->qos_option) {
-=09=09=09qc =3D (unsigned short *)(hdr + pattrib->hdrlen - 2);
-=09=09=09if (pattrib->priority)
-=09=09=09=09SetPriority(qc, pattrib->priority);
-=09=09=09SetAckpolicy(qc, pattrib->ack_policy);
+=09=09=09qc =3D (unsigned short *)(hdr + pattr->hdrlen - 2);
+=09=09=09if (pattr->priority)
+=09=09=09=09SetPriority(qc, pattr->priority);
+=09=09=09SetAckpolicy(qc, pattr->ack_policy);
 =09=09}
 =09=09/* TODO: fill HT Control Field */
 =09=09/* Update Seq Num will be handled by f/w */
 =09=09{
 =09=09=09struct sta_info *psta;
-=09=09=09bool bmcst =3D is_multicast_ether_addr(pattrib->ra);
+=09=09=09bool bmcst =3D is_multicast_ether_addr(pattr->ra);
=20
-=09=09=09if (pattrib->psta) {
-=09=09=09=09psta =3D pattrib->psta;
+=09=09=09if (pattr->psta) {
+=09=09=09=09psta =3D pattr->psta;
 =09=09=09} else {
 =09=09=09=09if (bmcst)
 =09=09=09=09=09psta =3D r8712_get_bcmc_stainfo(padapter);
 =09=09=09=09else
 =09=09=09=09=09psta =3D
 =09=09=09=09=09 r8712_get_stainfo(&padapter->stapriv,
-=09=09=09=09=09 pattrib->ra);
+=09=09=09=09=09 pattr->ra);
 =09=09=09}
 =09=09=09if (psta) {
 =09=09=09=09psta->sta_xmitpriv.txseq_tid
-=09=09=09=09=09=09  [pattrib->priority]++;
-=09=09=09=09psta->sta_xmitpriv.txseq_tid[pattrib->priority]
+=09=09=09=09=09=09  [pattr->priority]++;
+=09=09=09=09psta->sta_xmitpriv.txseq_tid[pattr->priority]
 =09=09=09=09=09=09   &=3D 0xFFF;
-=09=09=09=09pattrib->seqnum =3D psta->sta_xmitpriv.
-=09=09=09=09=09=09  txseq_tid[pattrib->priority];
-=09=09=09=09SetSeqNum(hdr, pattrib->seqnum);
+=09=09=09=09pattr->seqnum =3D
+=09=09=09=09  psta->sta_xmitpriv.txseq_tid[pattr->priority];
+=09=09=09=09SetSeqNum(hdr, pattr->seqnum);
 =09=09=09}
 =09=09}
 =09}
--=20
2.20.1


