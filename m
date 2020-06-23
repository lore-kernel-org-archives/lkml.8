Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18EBC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 22:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8900320724
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 22:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389036AbgFWWJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 18:09:16 -0400
Received: from smtprelay0042.hostedemail.com ([216.40.44.42]:59076 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388033AbgFWWJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 18:09:14 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 7D0FA837F24F;
        Tue, 23 Jun 2020 22:09:12 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: queen47_191478726e3f
X-Filterd-Recvd-Size: 4112
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Tue, 23 Jun 2020 22:09:11 +0000 (UTC)
Message-ID: <b3c1299c40cfb76ef46d4967763afed2f7ad2d3d.camel@perches.com>
Subject: Re: [PATCH 4.19 049/206] staging: rtl8712: fix multiline derefernce
 warnings
From:   Joe Perches <joe@perches.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, Aiman Najjar <aiman.najjar@hurranet.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Date:   Tue, 23 Jun 2020 15:09:10 -0700
In-Reply-To: <20200623195319.392375544@linuxfoundation.org>
References: <20200623195316.864547658@linuxfoundation.org>
         <20200623195319.392375544@linuxfoundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-06-23 at 21:56 +0200, Greg Kroah-Hartman wrote:
> From: Aiman Najjar <aiman.najjar@hurranet.com>
> 
> [ Upstream commit 269da10b1477c31c660288633c8d613e421b131f ]
> 
> This patch fixes remaining checkpatch warnings
> in rtl871x_xmit.c:

IMO: unless necessary for another patch, these types
of whitespace or renaming only conversions patches
should not be applied to stable.

> WARNING: Avoid multiple line dereference - prefer 'psecuritypriv->PrivacyKeyIndex'
> 636: FILE: drivers/staging//rtl8712/rtl871x_xmit.c:636:
> +					      (u8)psecuritypriv->
> +					      PrivacyKeyIndex);
> 
> WARNING: Avoid multiple line dereference - prefer 'psecuritypriv->XGrpKeyid'
> 643: FILE: drivers/staging//rtl8712/rtl871x_xmit.c:643:
> +						   (u8)psecuritypriv->
> +						   XGrpKeyid);
> 
> WARNING: Avoid multiple line dereference - prefer 'psecuritypriv->XGrpKeyid'
> 652: FILE: drivers/staging//rtl8712/rtl871x_xmit.c:652:
> +						   (u8)psecuritypriv->
> +						   XGrpKeyid);
> 
> Signed-off-by: Aiman Najjar <aiman.najjar@hurranet.com>
> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
> Link: https://lore.kernel.org/r/98805a72b92e9bbf933e05b827d27944663b7bc1.1585508171.git.aiman.najjar@hurranet.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/staging/rtl8712/rtl871x_xmit.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/rtl8712/rtl871x_xmit.c b/drivers/staging/rtl8712/rtl871x_xmit.c
> index a8ae14ce66139..95d5c050a8947 100644
> --- a/drivers/staging/rtl8712/rtl871x_xmit.c
> +++ b/drivers/staging/rtl8712/rtl871x_xmit.c
> @@ -601,7 +601,7 @@ sint r8712_xmitframe_coalesce(struct _adapter *padapter, _pkt *pkt,
>  	addr_t addr;
>  	u8 *pframe, *mem_start, *ptxdesc;
>  	struct sta_info		*psta;
> -	struct security_priv	*psecuritypriv = &padapter->securitypriv;
> +	struct security_priv	*psecpriv = &padapter->securitypriv;
>  	struct mlme_priv	*pmlmepriv = &padapter->mlmepriv;
>  	struct xmit_priv	*pxmitpriv = &padapter->xmitpriv;
>  	struct pkt_attrib	*pattrib = &pxmitframe->attrib;
> @@ -644,15 +644,13 @@ sint r8712_xmitframe_coalesce(struct _adapter *padapter, _pkt *pkt,
>  				case _WEP40_:
>  				case _WEP104_:
>  					WEP_IV(pattrib->iv, psta->txpn,
> -					       (u8)psecuritypriv->
> -					       PrivacyKeyIndex);
> +					       (u8)psecpriv->PrivacyKeyIndex);
>  					break;
>  				case _TKIP_:
>  					if (bmcst)
>  						TKIP_IV(pattrib->iv,
>  						    psta->txpn,
> -						    (u8)psecuritypriv->
> -						    XGrpKeyid);
> +						    (u8)psecpriv->XGrpKeyid);
>  					else
>  						TKIP_IV(pattrib->iv, psta->txpn,
>  							0);
> @@ -660,8 +658,7 @@ sint r8712_xmitframe_coalesce(struct _adapter *padapter, _pkt *pkt,
>  				case _AES_:
>  					if (bmcst)
>  						AES_IV(pattrib->iv, psta->txpn,
> -						    (u8)psecuritypriv->
> -						    XGrpKeyid);
> +						    (u8)psecpriv->XGrpKeyid);
>  					else
>  						AES_IV(pattrib->iv, psta->txpn,
>  						       0);

