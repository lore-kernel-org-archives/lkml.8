Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD77C1975A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 20:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B341520722
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 20:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgCVUcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 16:32:54 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:55122
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726623AbgCVUcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 16:32:54 -0400
X-IronPort-AV: E=Sophos;i="5.72,293,1580770800"; 
   d="scan'208";a="343214285"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 22 Mar 2020 21:32:31 +0100
Date:   Sun, 22 Mar 2020 21:32:31 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Simran Singhal <singhalsimran0@gmail.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [PATCH] staging: rtl8723bs: Remove comparisons
 to NULL in conditionals
In-Reply-To: <20200322202214.GA9750@simran-Inspiron-5558>
Message-ID: <alpine.DEB.2.21.2003222128580.2325@hadrien>
References: <20200322202214.GA9750@simran-Inspiron-5558>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 23 Mar 2020, Simran Singhal wrote:

> Remove comparisons to NULL in conditionals in
> drivers/staging/rtl8723bs/core/rtw_ap.c
> Issues reported by checkpatch.pl as:
> CHECK: Comparison to NULL could be written

The patch also drops some parentheses that are completely unrelated to the
change described here.  These changes should not be done in this patch.

There is no need to give the name of the file in the log message.  One can
see that directly in the patch.  Likewise, it is not necessary to give the
complete message from checkpatch.  Saying that checkpatch identified the
problem is good enough.

A good commit log message should say what you have done and why.  The
message above is missing the "why" part.  Why is it a good idea to remove
the NULL comparisons, beyond that checkpatch said that it was something to
check?

julia

>
> Signed-off-by: Simran Singhal <singhalsimran0@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_ap.c | 30 ++++++++++++-------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
> index a76e81330756..82b977c07205 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_ap.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
> @@ -79,7 +79,7 @@ static void update_BCNTIM(struct adapter *padapter)
>  			&tim_ielen,
>  			pnetwork_mlmeext->IELength - _FIXED_IE_LENGTH_
>  		);
> -		if (p != NULL && tim_ielen > 0) {
> +		if (p && tim_ielen > 0) {
>  			tim_ielen += 2;
>
>  			premainder_ie = p + tim_ielen;
> @@ -103,7 +103,7 @@ static void update_BCNTIM(struct adapter *padapter)
>  				&tmp_len,
>  				(pnetwork_mlmeext->IELength - _BEACON_IE_OFFSET_)
>  			);
> -			if (p != NULL)
> +			if (p)
>  				offset += tmp_len + 2;
>
>  			/*  get supported rates len */
> @@ -112,7 +112,7 @@ static void update_BCNTIM(struct adapter *padapter)
>  				_SUPPORTEDRATES_IE_, &tmp_len,
>  				(pnetwork_mlmeext->IELength - _BEACON_IE_OFFSET_)
>  			);
> -			if (p !=  NULL)
> +			if (p)
>  				offset += tmp_len + 2;
>
>  			/* DS Parameter Set IE, len =3 */
> @@ -1036,7 +1036,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
>  		&ie_len,
>  		(pbss_network->IELength - _BEACON_IE_OFFSET_)
>  	);
> -	if (p !=  NULL) {
> +	if (p) {
>  		memcpy(supportRate, p + 2, ie_len);
>  		supportRateNum = ie_len;
>  	}
> @@ -1048,7 +1048,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
>  		&ie_len,
>  		pbss_network->IELength - _BEACON_IE_OFFSET_
>  	);
> -	if (p !=  NULL) {
> +	if (p) {
>  		memcpy(supportRate + supportRateNum, p + 2, ie_len);
>  		supportRateNum += ie_len;
>  	}
> @@ -1136,8 +1136,8 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
>  			break;
>  		}
>
> -		if ((p == NULL) || (ie_len == 0))
> -				break;
> +		if (!p || ie_len == 0)
> +			break;
>  	}
>
>  	/* wmm */
> @@ -1165,7 +1165,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
>  				break;
>  			}
>
> -			if ((p == NULL) || (ie_len == 0))
> +			if (!p || ie_len == 0)
>  				break;
>  		}
>  	}
> @@ -1296,7 +1296,7 @@ int rtw_check_beacon_data(struct adapter *padapter, u8 *pbuf,  int len)
>  	psta = rtw_get_stainfo(&padapter->stapriv, pbss_network->MacAddress);
>  	if (!psta) {
>  		psta = rtw_alloc_stainfo(&padapter->stapriv, pbss_network->MacAddress);
> -		if (psta == NULL)
> +		if (!psta)
>  			return _FAIL;
>  	}
>
> @@ -1453,7 +1453,7 @@ u8 rtw_ap_set_pairwise_key(struct adapter *padapter, struct sta_info *psta)
>  	}
>
>  	psetstakey_para = rtw_zmalloc(sizeof(struct set_stakey_parm));
> -	if (psetstakey_para == NULL) {
> +	if (!psetstakey_para) {
>  		kfree(ph2c);
>  		res = _FAIL;
>  		goto exit;
> @@ -1491,12 +1491,12 @@ static int rtw_ap_set_key(
>  	/* DBG_871X("%s\n", __func__); */
>
>  	pcmd = rtw_zmalloc(sizeof(struct cmd_obj));
> -	if (pcmd == NULL) {
> +	if (!pcmd) {
>  		res = _FAIL;
>  		goto exit;
>  	}
>  	psetkeyparm = rtw_zmalloc(sizeof(struct setkey_parm));
> -	if (psetkeyparm == NULL) {
> +	if (!psetkeyparm) {
>  		kfree(pcmd);
>  		res = _FAIL;
>  		goto exit;
> @@ -1668,11 +1668,11 @@ static void update_bcn_wps_ie(struct adapter *padapter)
>  		&wps_ielen
>  	);
>
> -	if (pwps_ie == NULL || wps_ielen == 0)
> +	if (!pwps_ie || wps_ielen == 0)
>  		return;
>
>  	pwps_ie_src = pmlmepriv->wps_beacon_ie;
> -	if (pwps_ie_src == NULL)
> +	if (!pwps_ie_src)
>  		return;
>
>  	wps_offset = (uint)(pwps_ie - ie);
> @@ -2322,7 +2322,7 @@ void rtw_ap_restore_network(struct adapter *padapter)
>  	for (i = 0; i < chk_alive_num; i++) {
>  		psta = rtw_get_stainfo_by_offset(pstapriv, chk_alive_list[i]);
>
> -		if (psta == NULL) {
> +		if (!psta) {
>  			DBG_871X(FUNC_ADPT_FMT" sta_info is null\n", FUNC_ADPT_ARG(padapter));
>  		} else if (psta->state & _FW_LINKED) {
>  			rtw_sta_media_status_rpt(padapter, psta, 1);
> --
> 2.17.1
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20200322202214.GA9750%40simran-Inspiron-5558.
>
