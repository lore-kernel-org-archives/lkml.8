Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4E4C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 13:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A809F20829
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 13:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgGRNRQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 09:17:16 -0400
Received: from smtprelay0030.hostedemail.com ([216.40.44.30]:36496 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726566AbgGRNRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 09:17:15 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 84C0D181D207A;
        Sat, 18 Jul 2020 13:17:14 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: crib79_62139b626f13
X-Filterd-Recvd-Size: 3809
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Sat, 18 Jul 2020 13:17:13 +0000 (UTC)
Message-ID: <560eeb7388164e58ac0e47277fe2aec798c45a5c.camel@perches.com>
Subject: Re: [PATCH 4/4] staging: rtl8188eu: include: placed constant on the
 right side of the test in comparisons
From:   Joe Perches <joe@perches.com>
To:     B K Karthik <bkkarthik@pesu.pes.edu>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Sat, 18 Jul 2020 06:17:12 -0700
In-Reply-To: <20200718091857.quzs5sqvkjzngd6k@pesu-pes-edu>
References: <20200718091857.quzs5sqvkjzngd6k@pesu-pes-edu>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-07-18 at 05:18 -0400, B K Karthik wrote:
> placed constant on the right side of the test
> to fix warnings issued by checkpatch
[]
> diff --git a/drivers/staging/rtl8188eu/include/wifi.h b/drivers/staging/rtl8188eu/include/wifi.h
[]
> @@ -326,7 +326,7 @@ static inline unsigned char *get_hdr_bssid(unsigned char *pframe)
>  
>  static inline int IsFrameTypeCtrl(unsigned char *pframe)
>  {
> -	if (WIFI_CTRL_TYPE == GetFrameType(pframe))
> +	if (GetFrameType(pframe) == WIFI_CTRL_TYPE)
>  		return true;
>  	else
>  		return false;

Always try to improve code instead of merely shutting
up checkpatch warnings.

This function should likely be written:

static inline bool IsFrameTypeCtrl(unsigned char *pframe)
{
	return GetFrameType(pframe) == WIFI_CTRL_TYPE;
}

and given it's used only once, it might be expanded
in that place and removed altogether.

Something like:

(and the memcmp below could be ether_addr_equal instead
 but I'm too lazy to find out if the addresses are both
 guaranteed to be __aligned(2) which is likely)

---
 drivers/staging/rtl8188eu/hal/rtl8188e_rxdesc.c | 8 +++++---
 drivers/staging/rtl8188eu/include/wifi.h        | 7 -------
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/rtl8188e_rxdesc.c b/drivers/staging/rtl8188eu/hal/rtl8188e_rxdesc.c
index 7d0135fde795..a2994f9ecbde 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188e_rxdesc.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188e_rxdesc.c
@@ -144,10 +144,12 @@ void update_recvframe_phyinfo_88e(struct recv_frame *precvframe,
 
 	wlanhdr = precvframe->pkt->data;
 
-	pkt_info.bPacketMatchBSSID = ((!IsFrameTypeCtrl(wlanhdr)) &&
-		!pattrib->icv_err && !pattrib->crc_err &&
+	pkt_info.bPacketMatchBSSID =
+		GetFrameType(wlanhdr) != WIFI_CTRL_TYPE &&
+		!pattrib->icv_err &&
+		!pattrib->crc_err &&
 		!memcmp(get_hdr_bssid(wlanhdr),
-		 get_bssid(&padapter->mlmepriv), ETH_ALEN));
+			get_bssid(&padapter->mlmepriv), ETH_ALEN);
 
 	pkt_info.bPacketToSelf = pkt_info.bPacketMatchBSSID &&
 				 (!memcmp(get_da(wlanhdr),
diff --git a/drivers/staging/rtl8188eu/include/wifi.h b/drivers/staging/rtl8188eu/include/wifi.h
index 791f287a546d..3998d5633860 100644
--- a/drivers/staging/rtl8188eu/include/wifi.h
+++ b/drivers/staging/rtl8188eu/include/wifi.h
@@ -324,13 +324,6 @@ static inline unsigned char *get_hdr_bssid(unsigned char *pframe)
 	return sa;
 }
 
-static inline int IsFrameTypeCtrl(unsigned char *pframe)
-{
-	if (WIFI_CTRL_TYPE == GetFrameType(pframe))
-		return true;
-	else
-		return false;
-}
 /*-----------------------------------------------------------------------------
 			Below is for the security related definition
 ------------------------------------------------------------------------------*/




