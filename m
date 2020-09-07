Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E74EC43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 20:47:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29915215A4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 20:47:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Hq7iVc8V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbgIGUrD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 16:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbgIGUq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 16:46:56 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC38C061755
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 13:46:55 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id e23so19656501eja.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 13:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=prYc+7ttMHQt/W7TskfM9n0oRkdYfOwCwchTSFOez28=;
        b=Hq7iVc8VDPbHRQuQogFSWAqW4zTvRdDrU5cuWL2eabnKRjgwT1xZZX8+XM0Ri2l/Ay
         zQTKoRpecyuLtZX7LXUqYnHPOXkPiDDEfrmCJXl9aS4AmzUe1rlWe8vTd9vLQO6eBWmm
         Gx6M33b9N/48GaEoB9qUBBPJGlOH6c8fmDXa0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=prYc+7ttMHQt/W7TskfM9n0oRkdYfOwCwchTSFOez28=;
        b=k7np5vULd2860bmkqD/w75FsmjmGyn2TrvVZkiIqfgr3iFmWDQWfwKhzipEKFAJrHS
         zZjv9BofwDR/3n4dYqJaHGDW+gjEHqcsovL0OFf6sQFJna++wXZfWJ/VfAkSNMGMVaNP
         1w41rJIPjr06O7N7wkiOqVRvTK/KvDQq6q1yjt8bY1E5TJCzq+zIDXIjvdf4jCgqItY4
         cf+yJEuspHHiUlP8oYTR5Y93e5negaymvSTK3I2zN4PPUK02/1srVhHZX0lOaSTdP6UF
         yimO6oxFp1USAjjq+tBtF+JpXLBzA2mVhEDMZCqTTBDkcU6jjjxrXRuXo1CEZOTF77mm
         iI5Q==
X-Gm-Message-State: AOAM531Fqx0Rb0C595MTu0oMVXGh3PvmX0RsqfZ6JFjXkCT3uoc3q9mE
        /aeyFkM1YDgjbn4XaLLwZEV1/gW4DThFrXZOoLdEQs/Dt6M/H2zXb9d3zQEdDRp9XgE5oL4svH+
        1/yBufGIrYW3XeqLpE3LhSamjcvo4UaIkRgCpy3c1rqj1PQyE35t3L48pAv91vA/gUla3VLyb3w
        +bI0eCDWHH/m5jPfOm
X-Google-Smtp-Source: ABdhPJy6KkwYdGkaIy0ygpf+Q8ZtAaKvRmZ1OUNiM6+KyWHS7X/d8AFgynvdsorNA3B+8t5dITTzYQ==
X-Received: by 2002:a17:906:c0d9:: with SMTP id bn25mr15530389ejb.246.1599511613863;
        Mon, 07 Sep 2020 13:46:53 -0700 (PDT)
Received: from [192.168.178.129] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id bm2sm13722046edb.30.2020.09.07.13.46.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2020 13:46:53 -0700 (PDT)
Subject: Re: [PATCH] brcmsmac: fix potential memory leak in
 wlc_phy_attach_lcnphy
To:     Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
Cc:     takafumi@sslab.ics.keio.ac.jp,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        "open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER" 
        <linux-wireless@vger.kernel.org>,
        "open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER" 
        <brcm80211-dev-list.pdl@broadcom.com>,
        "open list:BROADCOM BRCM80211 IEEE802.11n WIRELESS DRIVER" 
        <brcm80211-dev-list@cypress.com>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200907162245.17997-1-keitasuzuki.park@sslab.ics.keio.ac.jp>
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
Message-ID: <bad4e33a-af2f-b44f-63e5-56386c312a91@broadcom.com>
Date:   Mon, 7 Sep 2020 22:46:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200907162245.17997-1-keitasuzuki.park@sslab.ics.keio.ac.jp>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/7/2020 6:22 PM, Keita Suzuki wrote:
> When wlc_phy_txpwr_srom_read_lcnphy fails in wlc_phy_attach_lcnphy,
> the allocated pi->u.pi_lcnphy is leaked, since struct brcms_phy will be
> freed in the caller function.
> 
> Fix this by calling wlc_phy_detach_lcnphy in the error handler of
> wlc_phy_txpwr_srom_read_lcnphy before returning.
> 
> Signed-off-by: Keita Suzuki <keitasuzuki.park@sslab.ics.keio.ac.jp>
> ---
>   .../net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c    | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c
> index 7ef36234a25d..6d70f51b2ddf 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/phy/phy_lcn.c
> @@ -5065,8 +5065,10 @@ bool wlc_phy_attach_lcnphy(struct brcms_phy *pi)
>   	pi->pi_fptr.radioloftget = wlc_lcnphy_get_radio_loft;
>   	pi->pi_fptr.detach = wlc_phy_detach_lcnphy;
>   
> -	if (!wlc_phy_txpwr_srom_read_lcnphy(pi))
> +	if (!wlc_phy_txpwr_srom_read_lcnphy(pi)) {
> +		wlc_phy_detach_lcnphy(pi);

Essentially the same but I prefer to simply do the kfree() call directly 
here as we also allocate in this function.

Thanks,
Arend
