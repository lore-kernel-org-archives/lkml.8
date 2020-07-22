Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04068C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 21:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D493A22B42
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 21:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pensando.io header.i=@pensando.io header.b="SHf1JmGT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732701AbgGVVSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 17:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgGVVSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 17:18:52 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F13CC0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 14:18:52 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id 8so2159243pjj.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 14:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=/NCA8bXI3zfZYAohLjznoM/f/0f70sPbB/+ypwTdYwc=;
        b=SHf1JmGTnB3dAO02ZCUI+6CakGm0Ef6Boq9u7eNpki+17Ha09xS2ZLBYWpY3VMzFT3
         u+7lxgl5oNVZvC0wFhSwysOqeqyKoI7jJIip6qgnkiWglcOa6GlBXxdWE+BMgA/PMGTq
         wx4TzANPIFUFMO5iOGVq9/MJNTNzyYw/GTftAaKhd0iydIvRpoEwwhWXlf8cLPHp30TB
         sbaXemgDpu1SkwiwBU1Hl2v003Sf6nVysUcoJnIFqYlKFi8qkRvHDdhsNFJMAW93yETa
         5yNBOnrao3i9q6rZ63DqUtfWqx/DFAtRhx0/1ifYorhLdjAcBsfiLIraRTpmbF2fQj8y
         1kQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=/NCA8bXI3zfZYAohLjznoM/f/0f70sPbB/+ypwTdYwc=;
        b=h9jjRClKvkPAdHmloiyQ8o6hjtI42nsX38W6wzttOoW6PaniXalnaWDuNh4FN2hx7q
         U8Eox/korlwL5URIAz4H/dkPAmtLQtZvLoQSVNnLAoKZycw2sgUMDW1EIDphlGLFo+e2
         NR1OREMLSHoAZ249e1UGsWbgze5OI7ppd1w/ITbajXG81rGuEJ2eVFM1EUzphuotjG5r
         f57mcDR+a0TYelAclGjd8NcPrnAj7rN4ZMJrQjzX9VDALQoSu8nC4v/jYShZIF+E86CQ
         fpIRIoQJwB2y74xpBsKdiWjyCSo1Z68J5vn3K3J2oc2u0LK1BozK7Yt551E8uRb/RjaU
         Gu3g==
X-Gm-Message-State: AOAM531AvsTAhepebUdgPb8w1skD/CCVu9fXZgbvTviMIWikn2TrniHk
        weVwYsL2iYe3gbb/8tVoQHwhQ+KIgWc=
X-Google-Smtp-Source: ABdhPJzosbYETKUk0ThWbWyDitsjMwfz7haDDCSEljXg5g94MYNfHgTQ89Bodw/QHDKiLlW78A78Gw==
X-Received: by 2002:a17:90a:c592:: with SMTP id l18mr1236663pjt.119.1595452728690;
        Wed, 22 Jul 2020 14:18:48 -0700 (PDT)
Received: from Shannons-MacBook-Pro.local (static-50-53-47-17.bvtn.or.frontiernet.net. [50.53.47.17])
        by smtp.gmail.com with ESMTPSA id 207sm566591pfa.100.2020.07.22.14.18.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2020 14:18:47 -0700 (PDT)
Subject: Re: [PATCH][next] ionic: fix memory leak of object 'lid'
To:     Colin King <colin.king@canonical.com>,
        Pensando Drivers <drivers@pensando.io>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200722174003.962374-1-colin.king@canonical.com>
From:   Shannon Nelson <snelson@pensando.io>
Message-ID: <e0e428cf-3bef-9b57-2a7f-5a2381587085@pensando.io>
Date:   Wed, 22 Jul 2020 14:18:46 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722174003.962374-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/22/20 10:40 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> Currently when netdev fails to allocate the error return path
> fails to free the allocated object 'lid'.  Fix this by setting
> err to the return error code and jumping to a new label that
> performs the kfree of lid before returning.
>
> Addresses-Coverity: ("Resource leak")
> Fixes: 4b03b27349c0 ("ionic: get MTU from lif identity")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   drivers/net/ethernet/pensando/ionic/ionic_lif.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> index 7ad338a4653c..728dd6429d80 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> @@ -2034,7 +2034,8 @@ static struct ionic_lif *ionic_lif_alloc(struct ionic *ionic, unsigned int index
>   				    ionic->ntxqs_per_lif, ionic->ntxqs_per_lif);
>   	if (!netdev) {
>   		dev_err(dev, "Cannot allocate netdev, aborting\n");
> -		return ERR_PTR(-ENOMEM);
> +		err = -ENOMEM;
> +		goto err_out_free_lid;
>   	}
>   
>   	SET_NETDEV_DEV(netdev, dev);
> @@ -2120,6 +2121,7 @@ static struct ionic_lif *ionic_lif_alloc(struct ionic *ionic, unsigned int index
>   err_out_free_netdev:
>   	free_netdev(lif->netdev);
>   	lif = NULL;
> +err_out_free_lid:
>   	kfree(lid);
>   
>   	return ERR_PTR(err);

Thanks!

Acked-by: Shannon Nelson <snelson@pensando.io>


