Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E26C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 21:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEFDE20663
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 21:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XzswtoS3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbgCOV1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 17:27:42 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44776 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729181AbgCOV1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 17:27:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584307660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UrI29gnK2Fgk/ugrno8dGJOP/2UGa5/L2T729KrGlw4=;
        b=XzswtoS3NQxAvt0jmvHq9vmA1Bff0Pyi2OozmSyD/7a0U7HeAPPLvRYF3ICOg2yNKiqS/L
        9NGqiaUCcOzQQFXae1DbHoucjjXBPDRljxs21oSvjRfrNpUYP+yFNQT9yTEOwFeWrY/Jt1
        lHanMXeV2QXyvjhkr7zj6SKFeh4y2vc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-236-_5NmTzabMsewadlTWehCAA-1; Sun, 15 Mar 2020 17:27:39 -0400
X-MC-Unique: _5NmTzabMsewadlTWehCAA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A9221107ACC4;
        Sun, 15 Mar 2020 21:27:37 +0000 (UTC)
Received: from elisabeth (ovpn-200-18.brq.redhat.com [10.40.200.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 81D8810027A7;
        Sun, 15 Mar 2020 21:27:32 +0000 (UTC)
Date:   Sun, 15 Mar 2020 22:27:23 +0100
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Shreeya Patel <shreeya.patel23498@gmail.com>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com,
        daniel.baluta@gmail.com, nramas@linux.microsoft.com,
        hverkuil@xs4all.nl, Larry.Finger@lwfinger.net
Subject: Re: [Outreachy kernel] [PATCH v2] Staging: rtl8723bs: rtw_mlme:
 Remove unnecessary conditions
Message-ID: <20200315222723.666470f7@elisabeth>
In-Reply-To: <20200313102912.17218-1-shreeya.patel23498@gmail.com>
References: <20200313102912.17218-1-shreeya.patel23498@gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Mar 2020 15:59:12 +0530
Shreeya Patel <shreeya.patel23498@gmail.com> wrote:

> Remove unnecessary if and else conditions since both are leading to the
> initialization of "phtpriv->ampdu_enable" with the same value.
> Also, remove the unnecessary else-if condition since it does nothing.
> 
> Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
> ---
> 
> Changes in v2
>   - Remove unnecessary comments
>   - Remove unnecessary else-if condition which does nothing.
> 
>  drivers/staging/rtl8723bs/core/rtw_mlme.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> index 71fcb466019a..d7a58af76ea0 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
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

I suspect this is actually a bug, that is:

os_dep/os_intfs.c:74:static int rtw_ampdu_enable = 1;/* for enable tx_ampdu ,0: disable, 0x1:enable (but wifi_spec should be 0), 0x2: force enable (don't care wifi_spec) */

and that seems to actually map to the ampdu_enable field in
pregistrypriv.

However, I wouldn't change this without testing it on the actual
hardware, change looks good to me and doesn't affect functionality,

Reviewed-by: Stefano Brivio <sbrivio@redhat.com>

-- 
Stefano

