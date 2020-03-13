Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1570AC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 21:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3A2F2074F
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 21:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbgCMVXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 17:23:44 -0400
Received: from smtprelay0073.hostedemail.com ([216.40.44.73]:47840 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726534AbgCMVXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 17:23:43 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 42BE018017528;
        Fri, 13 Mar 2020 21:23:42 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: magic84_5a52c2e86bc2d
X-Filterd-Recvd-Size: 2535
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Fri, 13 Mar 2020 21:23:40 +0000 (UTC)
Message-ID: <25a1aca2c993ecb70ba7cd9c9e38bce9170a98b0.camel@perches.com>
Subject: Re: [Outreachy kernel] [PATCH v2] Staging: rtl8723bs: rtw_mlme:
 Remove unnecessary conditions
From:   Joe Perches <joe@perches.com>
To:     Shreeya Patel <shreeya.patel23498@gmail.com>,
        gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com,
        sbrivio@redhat.com, daniel.baluta@gmail.com,
        nramas@linux.microsoft.com, hverkuil@xs4all.nl,
        Larry.Finger@lwfinger.net
Date:   Fri, 13 Mar 2020 14:21:57 -0700
In-Reply-To: <20200313102912.17218-1-shreeya.patel23498@gmail.com>
References: <20200313102912.17218-1-shreeya.patel23498@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-03-13 at 15:59 +0530, Shreeya Patel wrote:
> Remove unnecessary if and else conditions since both are leading to the
> initialization of "phtpriv->ampdu_enable" with the same value.
> Also, remove the unnecessary else-if condition since it does nothing.
[]
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
[]
> @@ -2772,16 +2772,7 @@ void rtw_update_ht_cap(struct adapter *padapter, u8 *pie, uint ie_len, u8 channe
>  
>  	/* maybe needs check if ap supports rx ampdu. */
>  	if (!(phtpriv->ampdu_enable) && pregistrypriv->ampdu_enable == 1) {
> -		if (pregistrypriv->wifi_spec == 1) {
> -			/* remove this part because testbed AP should disable RX AMPDU */
> -			/* phtpriv->ampdu_enable = false; */
> -			phtpriv->ampdu_enable = true;
> -		} else {
> -			phtpriv->ampdu_enable = true;
> -		}
> -	} else if (pregistrypriv->ampdu_enable == 2) {
> -		/* remove this part because testbed AP should disable RX AMPDU */
> -		/* phtpriv->ampdu_enable = true; */
> +		phtpriv->ampdu_enable = true;

This isn't the same test.

This could be:
 	if ((!(phtpriv->ampdu_enable) && pregistrypriv->ampdu_enable == 1)) ||
	    pregistrypriv->ampdu_enable == 2)
		phtpriv->ampdu_enable = true;

Though it is probably more sensible to just set
phtpriv->ampdu_enable without testing whether or
not it's already set:

	if (pregistrypriv->ampdu_enable == 1 ||
	    pregistrypriv->ampdu_enable == 2)
		phtpriv->ampdu_enable = true;


