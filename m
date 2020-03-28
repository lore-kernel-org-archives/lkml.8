Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755B9C43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 19:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46E05206E6
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 19:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbgC1TTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 15:19:15 -0400
Received: from smtprelay0238.hostedemail.com ([216.40.44.238]:44710 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725807AbgC1TTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 15:19:14 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 6E1DC100E8420;
        Sat, 28 Mar 2020 19:19:12 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: egg02_1607af1e1a855
X-Filterd-Recvd-Size: 8678
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Sat, 28 Mar 2020 19:19:11 +0000 (UTC)
Message-ID: <197b261122fc6a751a163545044195f2d98d79dc.camel@perches.com>
Subject: Re: [PATCH v2 4/5] staging: rtl8712: fix multiline derefernce
 warning
From:   Joe Perches <joe@perches.com>
To:     aimannajjar <aiman.najjar@hurranet.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Sat, 28 Mar 2020 12:17:19 -0700
In-Reply-To: <beb6c8c826cdda751f29f985f2b5dedfd2f87914.1585353747.git.aiman.najjar@hurranet.com>
References: <20200327080429.GB1627562@kroah.com>
         <cover.1585353747.git.aiman.najjar@hurranet.com>
         <beb6c8c826cdda751f29f985f2b5dedfd2f87914.1585353747.git.aiman.najjar@hurranet.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-03-27 at 20:08 -0400, aimannajjar wrote:
> This patch fixes the following checkpatch warning in
> rtl8712x_xmit.c:
> 
> WARNING: Avoid multiple line dereference - prefer 'psta->sta_xmitpriv.txseq_tid[pattrib->priority]'
> 544: FILE: drivers/staging//rtl8712/rtl871x_xmit.c:544:
> +				pattrib->seqnum = psta->sta_xmitpriv.
> +						 txseq_tid[pattrib->priority];

It's always better to try to make the code clearer than
merely shut up checkpatch bleats.

> diff --git a/drivers/staging/rtl8712/rtl871x_xmit.c b/drivers/staging/rtl8712/rtl871x_xmit.c
[]
> @@ -479,70 +479,70 @@ static int make_wlanhdr(struct _adapter *padapter, u8 *hdr,
>  	__le16 *fctrl = &pwlanhdr->frame_ctl;
>  
>  	memset(hdr, 0, WLANHDR_OFFSET);
> -	SetFrameSubType(fctrl, pattrib->subtype);
> -	if (pattrib->subtype & WIFI_DATA_TYPE) {
> +	SetFrameSubType(fctrl, pattr->subtype);
> +	if (pattr->subtype & WIFI_DATA_TYPE) {
> 

The whole following block could be outdented one level
by changing this test to

	if (!(pattr->subtype & WIFI_DATA_TYPE))
		return 0;

>  		if (check_fwstate(pmlmepriv,  WIFI_STATION_STATE)) {
>  			/* to_ds = 1, fr_ds = 0; */
>  			SetToDs(fctrl);
>  			memcpy(pwlanhdr->addr1, get_bssid(pmlmepriv),
>  				ETH_ALEN);
The repetitive call to get_bssid(pmlmepriv) could be saved
by performing it outside this test

	u8 bssid = get_bssid(pmlmepriv);

and then using bssid in each memcpy/ether_addr_copy

> -			memcpy(pwlanhdr->addr2, pattrib->src, ETH_ALEN);
> -			memcpy(pwlanhdr->addr3, pattrib->dst, ETH_ALEN);
> +			memcpy(pwlanhdr->addr2, pattr->src, ETH_ALEN);
> +			memcpy(pwlanhdr->addr3, pattr->dst, ETH_ALEN);

All of these memcpy could probably use ether_addr_copy if

	struct pkt_attrib {
		...
		u8      dst[ETH_ALEN];
		...
	};

was changed to 

		u8	dst[ETH_ALEN] __aligned(2);
		

so these would be

			ether_addr_copy(pwlanhdr->addr2, pattr->src);

and pwlanhdr isn't a particularly valuable name
for an automatic either.  It's hungarian like.

So I would suggest something like the below that
avoids any long lines instead and also removes
unnecessary multi-line statements without renaming.

---
 drivers/staging/rtl8712/rtl871x_xmit.c | 123 ++++++++++++++++-----------------
 drivers/staging/rtl8712/rtl871x_xmit.h |   2 +-
 2 files changed, 61 insertions(+), 64 deletions(-)

diff --git a/drivers/staging/rtl8712/rtl871x_xmit.c b/drivers/staging/rtl8712/rtl871x_xmit.c
index f0b853..3961dae 100644
--- a/drivers/staging/rtl8712/rtl871x_xmit.c
+++ b/drivers/staging/rtl8712/rtl871x_xmit.c
@@ -477,75 +477,72 @@ static int make_wlanhdr(struct _adapter *padapter, u8 *hdr,
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
 	struct qos_priv *pqospriv = &pmlmepriv->qospriv;
 	__le16 *fctrl = &pwlanhdr->frame_ctl;
+	u8 *bssid;
 
 	memset(hdr, 0, WLANHDR_OFFSET);
 	SetFrameSubType(fctrl, pattrib->subtype);
-	if (pattrib->subtype & WIFI_DATA_TYPE) {
-		if (check_fwstate(pmlmepriv,  WIFI_STATION_STATE)) {
-			/* to_ds = 1, fr_ds = 0; */
-			SetToDs(fctrl);
-			memcpy(pwlanhdr->addr1, get_bssid(pmlmepriv),
-				ETH_ALEN);
-			memcpy(pwlanhdr->addr2, pattrib->src, ETH_ALEN);
-			memcpy(pwlanhdr->addr3, pattrib->dst, ETH_ALEN);
-		} else if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
-			/* to_ds = 0, fr_ds = 1; */
-			SetFrDs(fctrl);
-			memcpy(pwlanhdr->addr1, pattrib->dst, ETH_ALEN);
-			memcpy(pwlanhdr->addr2, get_bssid(pmlmepriv),
-				ETH_ALEN);
-			memcpy(pwlanhdr->addr3, pattrib->src, ETH_ALEN);
-		} else if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) ||
-			   check_fwstate(pmlmepriv,
-					 WIFI_ADHOC_MASTER_STATE)) {
-			memcpy(pwlanhdr->addr1, pattrib->dst, ETH_ALEN);
-			memcpy(pwlanhdr->addr2, pattrib->src, ETH_ALEN);
-			memcpy(pwlanhdr->addr3, get_bssid(pmlmepriv),
-				ETH_ALEN);
-		} else if (check_fwstate(pmlmepriv, WIFI_MP_STATE)) {
-			memcpy(pwlanhdr->addr1, pattrib->dst, ETH_ALEN);
-			memcpy(pwlanhdr->addr2, pattrib->src, ETH_ALEN);
-			memcpy(pwlanhdr->addr3, get_bssid(pmlmepriv),
-				ETH_ALEN);
-		} else {
-			return -EINVAL;
-		}
+	if (!(pattrib->subtype & WIFI_DATA_TYPE))
+		return 0;
 
-		if (pattrib->encrypt)
-			SetPrivacy(fctrl);
-		if (pqospriv->qos_option) {
-			qc = (unsigned short *)(hdr + pattrib->hdrlen - 2);
-			if (pattrib->priority)
-				SetPriority(qc, pattrib->priority);
-			SetAckpolicy(qc, pattrib->ack_policy);
-		}
-		/* TODO: fill HT Control Field */
-		/* Update Seq Num will be handled by f/w */
-		{
-			struct sta_info *psta;
-			bool bmcst = is_multicast_ether_addr(pattrib->ra);
-
-			if (pattrib->psta) {
-				psta = pattrib->psta;
-			} else {
-				if (bmcst)
-					psta = r8712_get_bcmc_stainfo(padapter);
-				else
-					psta =
-					 r8712_get_stainfo(&padapter->stapriv,
-					 pattrib->ra);
-			}
-			if (psta) {
-				psta->sta_xmitpriv.txseq_tid
-						  [pattrib->priority]++;
-				psta->sta_xmitpriv.txseq_tid[pattrib->priority]
-						   &= 0xFFF;
-				pattrib->seqnum = psta->sta_xmitpriv.
-						  txseq_tid[pattrib->priority];
-				SetSeqNum(hdr, pattrib->seqnum);
-			}
+	bssid = get_bssid(pmlmepriv);
+
+	if (check_fwstate(pmlmepriv,  WIFI_STATION_STATE)) {
+		/* to_ds = 1, fr_ds = 0; */
+		SetToDs(fctrl);
+		ether_addr_copy(pwlanhdr->addr1, bssid);
+		ether_addr_copy(pwlanhdr->addr2, pattrib->src);
+		ether_addr_copy(pwlanhdr->addr3, pattrib->dst);
+	} else if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
+		/* to_ds = 0, fr_ds = 1; */
+		SetFrDs(fctrl);
+		ether_addr_copy(pwlanhdr->addr1, pattrib->dst);
+		ether_addr_copy(pwlanhdr->addr2, bssid);
+		ether_addr_copy(pwlanhdr->addr3, pattrib->src);
+	} else if (check_fwstate(pmlmepriv, WIFI_ADHOC_STATE) ||
+		   check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) {
+		ether_addr_copy(pwlanhdr->addr1, pattrib->dst);
+		ether_addr_copy(pwlanhdr->addr2, pattrib->src);
+		ether_addr_copy(pwlanhdr->addr3, bssid);
+	} else if (check_fwstate(pmlmepriv, WIFI_MP_STATE)) {
+		ether_addr_copy(pwlanhdr->addr1, pattrib->dst);
+		ether_addr_copy(pwlanhdr->addr2, pattrib->src);
+		ether_addr_copy(pwlanhdr->addr3, bssid);
+	} else {
+		return -EINVAL;
+	}
+
+	if (pattrib->encrypt)
+		SetPrivacy(fctrl);
+	if (pqospriv->qos_option) {
+		qc = (unsigned short *)(hdr + pattrib->hdrlen - 2);
+		if (pattrib->priority)
+			SetPriority(qc, pattrib->priority);
+		SetAckpolicy(qc, pattrib->ack_policy);
+	}
+	/* TODO: fill HT Control Field */
+	/* Update Seq Num will be handled by f/w */
+	{
+		struct sta_info *psta;
+		bool bmcst = is_multicast_ether_addr(pattrib->ra);
+
+		if (pattrib->psta)
+			psta = pattrib->psta;
+		else if (bmcst)
+			psta = r8712_get_bcmc_stainfo(padapter);
+		else
+			psta = r8712_get_stainfo(&padapter->stapriv,
+						 pattrib->ra);
+
+		if (psta) {
+			u16 *txtid = psta->sta_xmitpriv.txseq_tid;
+
+			txtid[pattrib->priority]++;
+			txtid[pattrib->priority] &= 0xFFF;
+			pattrib->seqnum = txtid[pattrib->priority];
+			SetSeqNum(hdr, pattrib->seqnum);
 		}
 	}
+
 	return 0;
 }
 
diff --git a/drivers/staging/rtl8712/rtl871x_xmit.h b/drivers/staging/rtl8712/rtl871x_xmit.h
index f227828..c0c0c7 100644
--- a/drivers/staging/rtl8712/rtl871x_xmit.h
+++ b/drivers/staging/rtl8712/rtl871x_xmit.h
@@ -115,7 +115,7 @@ struct pkt_attrib {
 	u8	icv_len;
 	unsigned char iv[8];
 	unsigned char icv[8];
-	u8	dst[ETH_ALEN];
+	u8	dst[ETH_ALEN] __aligned(2);	/* for ether_addr_copy */
 	u8	src[ETH_ALEN];
 	u8	ta[ETH_ALEN];
 	u8	ra[ETH_ALEN];


