Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F3EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EAE9215A4
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590567293;
	bh=IZTSfgXKAp7khJeVaJeeGoeqOh2uLETlRAh3tUunzl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=z4QMn0BbxD13/Dkw4+UqnFEtc39iKm2F9oO0OrwIhdEx8jCJfcCJVGXNwOgjw9j8z
	 lppyvOZMlaXd3ZEjAjMvVoTEdY+3Cee8mlK8EadFBjnuLdIesA0SnN+G67OyNiGbIf
	 WHEVPngfa53ZvSkSLQ8sGRAAlWuvI1/v9TXz16Fo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387767AbgE0IOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 04:14:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:33624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387552AbgE0IOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 04:14:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 591AC21531;
        Wed, 27 May 2020 08:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590567290;
        bh=IZTSfgXKAp7khJeVaJeeGoeqOh2uLETlRAh3tUunzl0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gxchxf+ou0aFzf7A6ZG7nrSKxgQEQMjbd0GqgggAAS/uwPdZ0L4zI8zi0WEf1O6KG
         1FN69AU8a7q7clS0UE5pm/ifmld7+2cM9mnbRttH9tN5ia71y0PGmF9GLkqy15bjju
         g3F1etKwBRKna3EsiqZECEM95wMU/8ky0iumDwQ8=
Date:   Wed, 27 May 2020 10:14:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Pascal Terjan <pterjan@google.com>
Cc:     "Taihsiang Ho (tai271828)" <tai271828@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8712: Fix IEEE80211_ADDBA_PARAM_BUF_SIZE_MASK
Message-ID: <20200527081448.GA122537@kroah.com>
References: <20200523211247.23262-1-pterjan@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200523211247.23262-1-pterjan@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 23, 2020 at 10:12:47PM +0100, Pascal Terjan wrote:
> The value in shared headers was fixed 9 years ago in commit 8d661f1e462d
> ("ieee80211: correct IEEE80211_ADDBA_PARAM_BUF_SIZE_MASK macro") and
> while looking at using shared headers for other duplicated constants
> I noticed this driver uses the old value.
> 
> The macros are also defined twice in this file so I am deleting the
> second definition.
> 
> Signed-off-by: Pascal Terjan <pterjan@google.com>
> Cc: stable <stable@vger.kernel.org>
> ---
>  drivers/staging/rtl8712/wifi.h | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/rtl8712/wifi.h b/drivers/staging/rtl8712/wifi.h
> index be731f1a2209..91b65731fcaa 100644
> --- a/drivers/staging/rtl8712/wifi.h
> +++ b/drivers/staging/rtl8712/wifi.h
> @@ -440,7 +440,7 @@ static inline unsigned char *get_hdr_bssid(unsigned char *pframe)
>  /* block-ack parameters */
>  #define IEEE80211_ADDBA_PARAM_POLICY_MASK 0x0002
>  #define IEEE80211_ADDBA_PARAM_TID_MASK 0x003C
> -#define IEEE80211_ADDBA_PARAM_BUF_SIZE_MASK 0xFFA0
> +#define IEEE80211_ADDBA_PARAM_BUF_SIZE_MASK 0xFFC0
>  #define IEEE80211_DELBA_PARAM_TID_MASK 0xF000
>  #define IEEE80211_DELBA_PARAM_INITIATOR_MASK 0x0800

I'll take this patch, but why can't this code be all deleted such that
the real in-kernel defines are used instead of these duplicated ones?

thanks,

greg k-h
