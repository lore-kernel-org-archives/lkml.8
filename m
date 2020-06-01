Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B989C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 11:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08AB420772
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 11:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="FJP0Tzjy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbgFALSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 07:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbgFALS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 07:18:27 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2976AC03E96F
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 04:18:26 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id c71so10283438wmd.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 04:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=g0VCdWKmiQwqzeZ1145Q+jD/a6zqNIWdbNoYho8IUD0=;
        b=FJP0TzjycG35j8tltdqEefozgArLWxJRNm/8pejgk3vi+YrzWYohveIo+Wv32u9RyO
         ZM81uVxshoCGVU+k2TohNajLp6bVNA2XU23gRT9SZOTgTTbAt2+A+iMYZcjvWWJ8mzlQ
         zfNvKWd2clOWM8C3xpLHdyLROXd0Q8POb8TqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g0VCdWKmiQwqzeZ1145Q+jD/a6zqNIWdbNoYho8IUD0=;
        b=kM5Jr/JHcUGAJw2FtvJskhXzYnGq8f4b7W37hsOkR1nEDsNcYpySZHgPzHDdMmdNwt
         e5zx3Bv9rp0cZ0ZRIywRRWwKGA52v50fGqOWRP1TIqY9nL50zqN0HOxzs4UyucUnAGKC
         6xE47evxgcrfrsbC1pOv8xKMLLVmmvJbeLB07rYPCi4YbmMltE0lWtq8GcmkF6CBhT/n
         mRr82fWMVQI55JSds/QhzsOLVxUfbz2ANwVvC3Hz7H8GiCLT9gI9QHzH5nslI701XMCi
         LWW3eYVBHjnzMyWBCUAC591IIunqZ45DEnNMjMHI8lz5MwwjCRzUR1pHSssOF2Q2ciE5
         LF/g==
X-Gm-Message-State: AOAM5318aC5CaWisUoNo5Ei5Ato8tEv33xHvdJpdSst5Ef4n9arhawB4
        n4ss7qUOo3G4MFYzbVLbHs4nPGTsz+I=
X-Google-Smtp-Source: ABdhPJwdYJu0zMaWhn84ZbnLMJkV5ivwehiW6NRByLBq2FJYb+LNL4BsdrTKY6NK2+rut3Dk64b2Qg==
X-Received: by 2002:a1c:6244:: with SMTP id w65mr19535960wmb.82.1591010304464;
        Mon, 01 Jun 2020 04:18:24 -0700 (PDT)
Received: from [192.168.0.109] (84-238-136-197.ip.btc-net.bg. [84.238.136.197])
        by smtp.gmail.com with ESMTPSA id a1sm13861812wmd.28.2020.06.01.04.18.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2020 04:18:23 -0700 (PDT)
Subject: Re: [PATCH] ipv4: nexthop: Fix deadcode issue by performing a proper
 NULL check
To:     patrickeigensatz@gmail.com, David Ahern <dsahern@kernel.org>
Cc:     Coverity <scan-admin@coverity.com>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200601111201.64124-1-patrick.eigensatz@gmail.com>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <a4fc3fdc-48c2-3af9-95fc-342c1e87ed62@cumulusnetworks.com>
Date:   Mon, 1 Jun 2020 14:18:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200601111201.64124-1-patrick.eigensatz@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2020 14:12, patrickeigensatz@gmail.com wrote:
> From: Patrick Eigensatz <patrickeigensatz@gmail.com>
> 
> After allocating the spare nexthop group it should be tested for kzalloc()
> returning NULL, instead the already used nexthop group (which cannot be
> NULL at this point) had been tested so far.
> 
> Additionally, if kzalloc() fails, return ERR_PTR(-ENOMEM) instead of NULL.
> 
> Coverity-id: 1463885
> Reported-by: Coverity <scan-admin@coverity.com>
> Signed-off-by: Patrick Eigensatz <patrickeigensatz@gmail.com>
> ---
>  net/ipv4/nexthop.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
> index 563f71bcb2d7..cb9412cd5e4b 100644
> --- a/net/ipv4/nexthop.c
> +++ b/net/ipv4/nexthop.c
> @@ -1118,10 +1118,10 @@ static struct nexthop *nexthop_create_group(struct net *net,
>  
>  	/* spare group used for removals */
>  	nhg->spare = nexthop_grp_alloc(num_nh);
> -	if (!nhg) {
> +	if (!nhg->spare) {
>  		kfree(nhg);
>  		kfree(nh);
> -		return NULL;
> +		return ERR_PTR(-ENOMEM);
>  	}
>  	nhg->spare->spare = nhg;
>  
> 

As Colin's similar patch[1] was rejected recently, this one also fixes the issue.
This is targeted at -net.

Fixes: 90f33bffa382 ("nexthops: don't modify published nexthop groups")
Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

Thanks!

[1] https://lkml.org/lkml/2020/5/28/909
