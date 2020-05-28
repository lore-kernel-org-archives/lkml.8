Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2104C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F8EB2075F
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 14:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="SbC0EQCR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403833AbgE1Ox3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 10:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391244AbgE1Ox0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 10:53:26 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DDDC08C5C7
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 07:53:26 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f5so3502909wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 07:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jYwlFXyoA5W7eOjmY64mk9fyq3/rODJ0HXkx98UI8ms=;
        b=SbC0EQCRmMAuKlDmTMhJKM9/33wrjm/5m2A2+LrYTwDPw/46j9VlKEgIUfKQCdLuAn
         fXX93FqGNDFTYN3zPxj+k59IOEd36bKDQRBOBhfWH9O7pBo+QJaZACUtjmi0qvG6k1WX
         tdRemBAXpwxvD6CCdTEFVESiud6PlgU1nXiLU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jYwlFXyoA5W7eOjmY64mk9fyq3/rODJ0HXkx98UI8ms=;
        b=QozHgNWiuASB+mbubCWZ1Qdb0aEu5JFuH5TTl1svv8Qa+pSkl/6IS6amschEJ7e+4b
         gCJoM1bnOZ52/rAvspkbTmGj7M5E4UJOoyLgxuKOTASF5nU+VbiLpydYtUx63wbNXmuw
         7ql7re7COYahcYdAZ3r89bvG9E555xwhWPpeerexmffCXO7pbrpuxJSqK6nkv0uVWCTh
         Dbwgn+P4Xbnd+jQkt02U1E3WE1CHIXB4WtS0skRqOjfwWASE/GL1QIzKJuoEmR1y0BFI
         anCLRFtStHdAaSiLy83mVqGbZmjueebuitu2pZEK2N2QU1+CvjYGcybU4PpmOwG4Uh3c
         k35w==
X-Gm-Message-State: AOAM533FQCeE3ImLE42QT4nnAk5VpBkvR+om2rFAd9ud7EIlKvm9Qj7S
        o/oiw7BwBM/uLmw9TeyWGIWI/Lv9O6qrIg==
X-Google-Smtp-Source: ABdhPJw6x83C5m+liS6sK3O+5Mi+sGqGNugMnzt/+6U4WeTLNCfN42hQ7sh+8CL5hqzz96DVlegeBA==
X-Received: by 2002:a1c:a74d:: with SMTP id q74mr3779042wme.177.1590677604252;
        Thu, 28 May 2020 07:53:24 -0700 (PDT)
Received: from [192.168.51.243] ([78.128.78.220])
        by smtp.gmail.com with ESMTPSA id h20sm6747524wma.6.2020.05.28.07.53.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 07:53:22 -0700 (PDT)
Subject: Re: [PATCH][net-next] nexthop: fix incorrect allocation failure on
 nhg->spare
To:     Colin King <colin.king@canonical.com>,
        David Ahern <dsahern@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200528145114.420100-1-colin.king@canonical.com>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <8b73e872-c05e-e93f-1d2d-3466da4ddbcc@cumulusnetworks.com>
Date:   Thu, 28 May 2020 17:53:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200528145114.420100-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/05/2020 17:51, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The allocation failure check for nhg->spare is currently checking
> the pointer nhg rather than nhg->spare which is never false. Fix
> this by checking nhg->spare instead.
> 
> Addresses-Coverity: ("Logically dead code")
> Fixes: 430a049190de ("nexthop: Add support for nexthop groups")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  net/ipv4/nexthop.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
> index ebafa5ed91ac..97423d6f2de9 100644
> --- a/net/ipv4/nexthop.c
> +++ b/net/ipv4/nexthop.c
> @@ -1185,7 +1185,7 @@ static struct nexthop *nexthop_create_group(struct net *net,
>  
>  	/* spare group used for removals */
>  	nhg->spare = nexthop_grp_alloc(num_nh);
> -	if (!nhg) {
> +	if (!nhg->spare) {
>  		kfree(nhg);
>  		kfree(nh);
>  		return NULL;
> 

Good catch, embarrassing copy paste error :-/
Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

