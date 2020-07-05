Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D568C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 18:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D65220739
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 18:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="CdFIz0ff"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgGESdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 14:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbgGESdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 14:33:17 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E259BC08C5DE
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 11:33:16 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id e15so32716405edr.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jul 2020 11:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H0dBiMlIz57i5a6OQd6NNT0qs7e4FvnqEbY3KZH5hD8=;
        b=CdFIz0ffcFB5FT8t5IaEhDZyUUp01nVtQqvO1mpda5BxsFn2930XF2Z2oE2exxz4wn
         l7XKnvQC3uMablm/vg23TOUkkdnchyDUsIDZcmMkE88p5vjGI/eQhYjCk2qARTMEzSB7
         TGa0jTtLBjq/jNgaLRuSK9wALpCB3Y9hy0Dds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H0dBiMlIz57i5a6OQd6NNT0qs7e4FvnqEbY3KZH5hD8=;
        b=DKodUxGix8evBPLd+jMAgCpzPDBAYon9N+BP9I0wiWk5uzgliXLLLWeNzf6q6RKuqB
         9Q0FMe9F+7aHWOId3WV55waH84VbOJQIC38B5CWapp8LHwSsdvGGNwGWqn3+RwPymX0C
         nr0YC60Bt/nROZrTBa3VzDCQ1znQgorIn6gE1cFJObtvGHz4AkWrtzRPDOyC2WWS5nwx
         tMOtLTeNuwIZZmGmfCKWfkwfvHGK2YtC5Yo7ybK3ARYiEp5PpWvFvWqkItomxW6+FueH
         /J6g4hPaH/wCxyIQrx+8M1Y4mnxaohlO4W7uIXmwf7BbVCjmifLY47V1s68ILxhlx9+X
         gdtQ==
X-Gm-Message-State: AOAM531vy2Brt4oSRIUvOkG9VgiruRT5QfDpR27mRCUuaCOtBRgTz92t
        aTNUdunwEAJdmdjjkYo7UbjcwGiRlr36Xw==
X-Google-Smtp-Source: ABdhPJw1YolUJEgQOjHxaMMgrtEFfdKzMndj+fP4DQxRb8lTkT+E4qELkvffnnn/b1BV5qIxiEI5+g==
X-Received: by 2002:a50:fc88:: with SMTP id f8mr20587991edq.314.1593973995305;
        Sun, 05 Jul 2020 11:33:15 -0700 (PDT)
Received: from [192.168.0.109] (84-238-136-197.ip.btc-net.bg. [84.238.136.197])
        by smtp.gmail.com with ESMTPSA id u17sm14476477eje.74.2020.07.05.11.33.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Jul 2020 11:33:14 -0700 (PDT)
Subject: Re: [PATCH net] bridge: mcast: Fix MLD2 Report IPv6 payload length
 check
To:     =?UTF-8?Q?Linus_L=c3=bcssing?= <linus.luessing@c0d3.blue>,
        netdev@vger.kernel.org
Cc:     Roopa Prabhu <roopa@cumulusnetworks.com>,
        Martin Weinelt <martin@linuxlounge.net>,
        "David S . Miller" <davem@davemloft.net>,
        bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20200705182234.10257-1-linus.luessing@c0d3.blue>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <093beb97-87e8-e112-78ad-b3e4fe230cdb@cumulusnetworks.com>
Date:   Sun, 5 Jul 2020 21:33:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200705182234.10257-1-linus.luessing@c0d3.blue>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2020 21:22, Linus Lüssing wrote:
> Commit e57f61858b7c ("net: bridge: mcast: fix stale nsrcs pointer in
> igmp3/mld2 report handling") introduced a small bug which would potentially
> lead to accepting an MLD2 Report with a broken IPv6 header payload length
> field.
> 
> The check needs to take into account the 2 bytes for the "Number of
> Sources" field in the "Multicast Address Record" before reading it.
> And not the size of a pointer to this field.
> 
> Fixes: e57f61858b7c ("net: bridge: mcast: fix stale nsrcs pointer in igmp3/mld2 report handling")
> Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
> ---
>  net/bridge/br_multicast.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

I'd rather be more concerned with it rejecting a valid report due to wrong size. The ptr
size would always be bigger. :)

Thanks!
Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>

> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
> index 83490bf73a13..4c4a93abde68 100644
> --- a/net/bridge/br_multicast.c
> +++ b/net/bridge/br_multicast.c
> @@ -1000,21 +1000,21 @@ static int br_ip6_multicast_mld2_report(struct net_bridge *br,
>  	num = ntohs(icmp6h->icmp6_dataun.un_data16[1]);
>  	len = skb_transport_offset(skb) + sizeof(*icmp6h);
>  
>  	for (i = 0; i < num; i++) {
>  		__be16 *_nsrcs, __nsrcs;
>  		u16 nsrcs;
>  
>  		nsrcs_offset = len + offsetof(struct mld2_grec, grec_nsrcs);
>  
>  		if (skb_transport_offset(skb) + ipv6_transport_len(skb) <
> -		    nsrcs_offset + sizeof(_nsrcs))
> +		    nsrcs_offset + sizeof(__nsrcs))
>  			return -EINVAL;
>  
>  		_nsrcs = skb_header_pointer(skb, nsrcs_offset,
>  					    sizeof(__nsrcs), &__nsrcs);
>  		if (!_nsrcs)
>  			return -EINVAL;
>  
>  		nsrcs = ntohs(*_nsrcs);
>  		grec_len = struct_size(grec, grec_src, nsrcs);
>  
> 

