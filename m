Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 706E7C2D0E5
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 20:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 390512070A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 20:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=hurranet.com header.i=aiman.najjar@hurranet.com header.b="gkYU8iLG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbgCZUDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 16:03:31 -0400
Received: from sender4-op-o14.zoho.com ([136.143.188.14]:17470 "EHLO
        sender4-op-o14.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgCZUDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 16:03:30 -0400
X-Greylist: delayed 902 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Mar 2020 16:03:28 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1585252098; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=NuRt0E9jx0APEgz5tWIGAXmm75oYiNvYYnAlh0AUs5r/5DWMQ56WnC0EbBb69YGWQ1QhoRY7FHoCNMk0enYXelkBWqJqL9gvmVRWQI9C4VP5aTbmA5kPwj2SEW7frXEKSTY3/WOzPwaLBtSWdaz8h6m4fD5ac2HDuYU1kPaGhWY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1585252098; h=Content-Type:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=vAIX+3WhXmJIPfSg+hpUeAYTAcBVVuTLMUuwR1a6dqw=; 
        b=BSgEa4DDYdhXwVt76bf0Qy+gPwMywML2eSI5eu6FWAYqdG4lBlbKpwSZajpGJOc2U/AGggbm58UGt284Ggl1vuKljM7aX2bGm9neeuGFAxHbE3ccO60osxXHqFFhnuHg4zOo2v/X2jIGujQcWQQ7LV4u/VB5OAVjXOmqild5+ds=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=hurranet.com;
        spf=pass  smtp.mailfrom=aiman.najjar@hurranet.com;
        dmarc=pass header.from=<aiman.najjar@hurranet.com> header.from=<aiman.najjar@hurranet.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1585252098;
        s=zoho; d=hurranet.com; i=aiman.najjar@hurranet.com;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        bh=vAIX+3WhXmJIPfSg+hpUeAYTAcBVVuTLMUuwR1a6dqw=;
        b=gkYU8iLGg7bwFO0KLd0Ft2jG4gO2ruwldVOewpAmMXtgp3PDfMpI8iLm5TUSEB4R
        sjF9JcHelL4pZKL8gTn6PvKaszVo4D2X8Ahm5r58cQmMzFS5wtgmdgb0UMWcPs1DhNg
        4qo00eckSB+KTVlLyc+HcL/dcWZMPla6V0jnE5AA=
Received: from kernel-dev (097-100-022-132.res.spectrum.com [97.100.22.132]) by mx.zohomail.com
        with SMTPS id 158525209733942.26383857202677; Thu, 26 Mar 2020 12:48:17 -0700 (PDT)
Date:   Thu, 26 Mar 2020 01:56:16 -0400
From:   Aiman Najjar <aiman.najjar@hurranet.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8712: fix checkpatch warnings
Message-ID: <20200326055616.GA3718@kernel-dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes remaining warnings in rtl871x_xmit.c of
rtl8712 staging driver

The following warnings are resolved:

WARNING: line over 80 characters
\#74: FILE: drivers/staging//rtl8712/rtl871x_xmit.c:74:
+	* Please allocate memory with the sz = (struct xmit_frame) * NR_XMITFRAME,

WARNING: line over 80 characters
\#79: FILE: drivers/staging//rtl8712/rtl871x_xmit.c:79:
+		kmalloc(NR_XMITFRAME * sizeof(struct xmit_frame) + 4, GFP_ATOMIC);

WARNING: line over 80 characters
\#129: FILE: drivers/staging//rtl8712/rtl871x_xmit.c:129:
+		pxmitbuf->pallocated_buf = kmalloc(MAX_XMITBUF_SZ + XMITBUF_ALIGN_SZ,

WARNING: Avoid multiple line dereference - prefer 'psecuritypriv->XGrptxmickey'
\#378: FILE: drivers/staging//rtl8712/rtl871x_xmit.c:378:
+					psecuritypriv->
+					XGrptxmickey[psecuritypriv->

WARNING: Avoid multiple line dereference - prefer 'psecuritypriv->XGrpKeyid'
\#379: FILE: drivers/staging//rtl8712/rtl871x_xmit.c:379:
+					XGrptxmickey[psecuritypriv->
+					XGrpKeyid].skey);

WARNING: Avoid multiple line dereference - prefer 'psta->sta_xmitpriv.txseq_tid[pattrib->priority]'
\#544: FILE: drivers/staging//rtl8712/rtl871x_xmit.c:544:
+				pattrib->seqnum = psta->sta_xmitpriv.
+						 txseq_tid[pattrib->priority];

WARNING: Avoid multiple line dereference - prefer 'psecuritypriv->PrivacyKeyIndex'
\#636: FILE: drivers/staging//rtl8712/rtl871x_xmit.c:636:
+					      (u8)psecuritypriv->
+					      PrivacyKeyIndex);

WARNING: Avoid multiple line dereference - prefer 'psecuritypriv->XGrpKeyid'
\#643: FILE: drivers/staging//rtl8712/rtl871x_xmit.c:643:
+						   (u8)psecuritypriv->
+						   XGrpKeyid);

WARNING: Avoid multiple line dereference - prefer 'psecuritypriv->XGrpKeyid'
\#652: FILE: drivers/staging//rtl8712/rtl871x_xmit.c:652:
+						   (u8)psecuritypriv->
+						   XGrpKeyid);

Signed-off-by: aimannajjar <aiman.najjar@hurranet.com>
---
 drivers/staging/rtl8712/rtl871x_xmit.c | 85 +++++++++++++-------------
 1 file changed, 41 insertions(+), 44 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_xmit.c b/drivers/staging/rtl8712/rtl871x_xmit.c
index f0b85338b567..82df5e26f8c8 100644
--- a/drivers/staging/rtl8712/rtl871x_xmit.c
+++ b/drivers/staging/rtl8712/rtl871x_xmit.c
@@ -71,12 +71,13 @@ int _r8712_init_xmit_priv(struct xmit_priv *pxmitpriv,
 	_init_queue(&pxmitpriv->apsd_queue);
 	_init_queue(&pxmitpriv->free_xmit_queue);
 	/*
-	 * Please allocate memory with the sz = (struct xmit_frame) * NR_XMITFRAME,
+	 * Please allocate memory with sz = (struct xmit_frame) * NR_XMITFRAME,
 	 * and initialize free_xmit_frame below.
 	 * Please also apply  free_txobj to link_up all the xmit_frames...
 	 */
 	pxmitpriv->pallocated_frame_buf =
-		kmalloc(NR_XMITFRAME * sizeof(struct xmit_frame) + 4, GFP_ATOMIC);
+		kmalloc(NR_XMITFRAME * sizeof(struct xmit_frame) + 4,
+			GFP_ATOMIC);
 	if (!pxmitpriv->pallocated_frame_buf) {
 		pxmitpriv->pxmit_frame_buf = NULL;
 		return -ENOMEM;
@@ -126,8 +127,8 @@ int _r8712_init_xmit_priv(struct xmit_priv *pxmitpriv,
 	pxmitbuf = (struct xmit_buf *)pxmitpriv->pxmitbuf;
 	for (i = 0; i < NR_XMITBUFF; i++) {
 		INIT_LIST_HEAD(&pxmitbuf->list);
-		pxmitbuf->pallocated_buf = kmalloc(MAX_XMITBUF_SZ + XMITBUF_ALIGN_SZ,
-						   GFP_ATOMIC);
+		pxmitbuf->pallocated_buf =
+			kmalloc(MAX_XMITBUF_SZ + XMITBUF_ALIGN_SZ, GFP_ATOMIC);
 		if (!pxmitbuf->pallocated_buf)
 			return -ENOMEM;
 		pxmitbuf->pbuf = pxmitbuf->pallocated_buf + XMITBUF_ALIGN_SZ -
@@ -350,7 +351,7 @@ static int xmitframe_addmic(struct _adapter *padapter,
 	struct	sta_info *stainfo;
 	struct	qos_priv *pqospriv = &(padapter->mlmepriv.qospriv);
 	struct	pkt_attrib  *pattrib = &pxmitframe->attrib;
-	struct	security_priv *psecuritypriv = &padapter->securitypriv;
+	struct	security_priv *psecpriv = &padapter->securitypriv;
 	struct	xmit_priv *pxmitpriv = &padapter->xmitpriv;
 	u8 priority[4] = {0x0, 0x0, 0x0, 0x0};
 	bool bmcst = is_multicast_ether_addr(pattrib->ra);
@@ -368,15 +369,14 @@ static int xmitframe_addmic(struct _adapter *padapter,
 					   0x0, 0x0};
 			pframe = pxmitframe->buf_addr + TXDESC_OFFSET;
 			if (bmcst) {
-				if (!memcmp(psecuritypriv->XGrptxmickey
-				   [psecuritypriv->XGrpKeyid].skey,
+				if (!memcmp(psecpriv->XGrptxmickey
+				   [psecpriv->XGrpKeyid].skey,
 				   null_key, 16))
 					return -ENOMEM;
 				/*start to calculate the mic code*/
 				r8712_secmicsetkey(&micdata,
-					 psecuritypriv->
-					 XGrptxmickey[psecuritypriv->
-					XGrpKeyid].skey);
+					psecpriv->XGrptxmickey
+					[psecpriv->XGrpKeyid].skey);
 			} else {
 				if (!memcmp(&stainfo->tkiptxmickey.skey[0],
 					    null_key, 16))
@@ -416,7 +416,7 @@ static int xmitframe_addmic(struct _adapter *padapter,
 					length = pattrib->last_txcmdsz -
 						  pattrib->hdrlen -
 						  pattrib->iv_len -
-						  ((psecuritypriv->sw_encrypt)
+						  ((psecpriv->sw_encrypt)
 						  ? pattrib->icv_len : 0);
 					r8712_secmicappend(&micdata, payload,
 							   length);
@@ -424,7 +424,7 @@ static int xmitframe_addmic(struct _adapter *padapter,
 				} else {
 					length = pxmitpriv->frag_len -
 					    pattrib->hdrlen - pattrib->iv_len -
-					    ((psecuritypriv->sw_encrypt) ?
+					    ((psecpriv->sw_encrypt) ?
 					    pattrib->icv_len : 0);
 					r8712_secmicappend(&micdata, payload,
 							   length);
@@ -469,7 +469,7 @@ static sint xmitframe_swencrypt(struct _adapter *padapter,
 }
 
 static int make_wlanhdr(struct _adapter *padapter, u8 *hdr,
-			struct pkt_attrib *pattrib)
+			struct pkt_attrib *pattr)
 {
 	u16 *qc;
 
@@ -479,70 +479,70 @@ static int make_wlanhdr(struct _adapter *padapter, u8 *hdr,
 	__le16 *fctrl = &pwlanhdr->frame_ctl;
 
 	memset(hdr, 0, WLANHDR_OFFSET);
-	SetFrameSubType(fctrl, pattrib->subtype);
-	if (pattrib->subtype & WIFI_DATA_TYPE) {
+	SetFrameSubType(fctrl, pattr->subtype);
+	if (pattr->subtype & WIFI_DATA_TYPE) {
 		if (check_fwstate(pmlmepriv,  WIFI_STATION_STATE)) {
 			/* to_ds = 1, fr_ds = 0; */
 			SetToDs(fctrl);
 			memcpy(pwlanhdr->addr1, get_bssid(pmlmepriv),
 				ETH_ALEN);
-			memcpy(pwlanhdr->addr2, pattrib->src, ETH_ALEN);
-			memcpy(pwlanhdr->addr3, pattrib->dst, ETH_ALEN);
+			memcpy(pwlanhdr->addr2, pattr->src, ETH_ALEN);
+			memcpy(pwlanhdr->addr3, pattr->dst, ETH_ALEN);
 		} else if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
 			/* to_ds = 0, fr_ds = 1; */
 			SetFrDs(fctrl);
-			memcpy(pwlanhdr->addr1, pattrib->dst, ETH_ALEN);
+			memcpy(pwlanhdr->addr1, pattr->dst, ETH_ALEN);
 			memcpy(pwlanhdr->addr2, get_bssid(pmlmepriv),
 				ETH_ALEN);
-			memcpy(pwlanhdr->addr3, pattrib->src, ETH_ALEN);
+			memcpy(pwlanhdr->addr3, pattr->src, ETH_ALEN);
 		} else if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) ||
 			   check_fwstate(pmlmepriv,
 					 WIFI_ADHOC_MASTER_STATE)) {
-			memcpy(pwlanhdr->addr1, pattrib->dst, ETH_ALEN);
-			memcpy(pwlanhdr->addr2, pattrib->src, ETH_ALEN);
+			memcpy(pwlanhdr->addr1, pattr->dst, ETH_ALEN);
+			memcpy(pwlanhdr->addr2, pattr->src, ETH_ALEN);
 			memcpy(pwlanhdr->addr3, get_bssid(pmlmepriv),
 				ETH_ALEN);
 		} else if (check_fwstate(pmlmepriv, WIFI_MP_STATE)) {
-			memcpy(pwlanhdr->addr1, pattrib->dst, ETH_ALEN);
-			memcpy(pwlanhdr->addr2, pattrib->src, ETH_ALEN);
+			memcpy(pwlanhdr->addr1, pattr->dst, ETH_ALEN);
+			memcpy(pwlanhdr->addr2, pattr->src, ETH_ALEN);
 			memcpy(pwlanhdr->addr3, get_bssid(pmlmepriv),
 				ETH_ALEN);
 		} else {
 			return -EINVAL;
 		}
 
-		if (pattrib->encrypt)
+		if (pattr->encrypt)
 			SetPrivacy(fctrl);
 		if (pqospriv->qos_option) {
-			qc = (unsigned short *)(hdr + pattrib->hdrlen - 2);
-			if (pattrib->priority)
-				SetPriority(qc, pattrib->priority);
-			SetAckpolicy(qc, pattrib->ack_policy);
+			qc = (unsigned short *)(hdr + pattr->hdrlen - 2);
+			if (pattr->priority)
+				SetPriority(qc, pattr->priority);
+			SetAckpolicy(qc, pattr->ack_policy);
 		}
 		/* TODO: fill HT Control Field */
 		/* Update Seq Num will be handled by f/w */
 		{
 			struct sta_info *psta;
-			bool bmcst = is_multicast_ether_addr(pattrib->ra);
+			bool bmcst = is_multicast_ether_addr(pattr->ra);
 
-			if (pattrib->psta) {
-				psta = pattrib->psta;
+			if (pattr->psta) {
+				psta = pattr->psta;
 			} else {
 				if (bmcst)
 					psta = r8712_get_bcmc_stainfo(padapter);
 				else
 					psta =
 					 r8712_get_stainfo(&padapter->stapriv,
-					 pattrib->ra);
+					 pattr->ra);
 			}
 			if (psta) {
 				psta->sta_xmitpriv.txseq_tid
-						  [pattrib->priority]++;
-				psta->sta_xmitpriv.txseq_tid[pattrib->priority]
+						  [pattr->priority]++;
+				psta->sta_xmitpriv.txseq_tid[pattr->priority]
 						   &= 0xFFF;
-				pattrib->seqnum = psta->sta_xmitpriv.
-						  txseq_tid[pattrib->priority];
-				SetSeqNum(hdr, pattrib->seqnum);
+				pattr->seqnum =
+				  psta->sta_xmitpriv.txseq_tid[pattr->priority];
+				SetSeqNum(hdr, pattr->seqnum);
 			}
 		}
 	}
@@ -589,7 +589,7 @@ sint r8712_xmitframe_coalesce(struct _adapter *padapter, _pkt *pkt,
 	addr_t addr;
 	u8 *pframe, *mem_start, *ptxdesc;
 	struct sta_info		*psta;
-	struct security_priv	*psecuritypriv = &padapter->securitypriv;
+	struct security_priv	*psecpriv = &padapter->securitypriv;
 	struct mlme_priv	*pmlmepriv = &padapter->mlmepriv;
 	struct xmit_priv	*pxmitpriv = &padapter->xmitpriv;
 	struct pkt_attrib	*pattrib = &pxmitframe->attrib;
@@ -632,15 +632,13 @@ sint r8712_xmitframe_coalesce(struct _adapter *padapter, _pkt *pkt,
 				case _WEP40_:
 				case _WEP104_:
 					WEP_IV(pattrib->iv, psta->txpn,
-					       (u8)psecuritypriv->
-					       PrivacyKeyIndex);
+					       (u8)psecpriv->PrivacyKeyIndex);
 					break;
 				case _TKIP_:
 					if (bmcst)
 						TKIP_IV(pattrib->iv,
 						    psta->txpn,
-						    (u8)psecuritypriv->
-						    XGrpKeyid);
+						    (u8)psecpriv->XGrpKeyid);
 					else
 						TKIP_IV(pattrib->iv, psta->txpn,
 							0);
@@ -648,8 +646,7 @@ sint r8712_xmitframe_coalesce(struct _adapter *padapter, _pkt *pkt,
 				case _AES_:
 					if (bmcst)
 						AES_IV(pattrib->iv, psta->txpn,
-						    (u8)psecuritypriv->
-						    XGrpKeyid);
+						    (u8)psecpriv->XGrpKeyid);
 					else
 						AES_IV(pattrib->iv, psta->txpn,
 						       0);
-- 
2.20.1

