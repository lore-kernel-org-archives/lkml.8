Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290FFC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 769F120786
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tessares-net.20150623.gappssmtp.com header.i=@tessares-net.20150623.gappssmtp.com header.b="y5QJ1RTO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730007AbgHFRFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729537AbgHFREq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:04:46 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70175C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 03:47:12 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id bo3so27146426ejb.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 03:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YG1Q9ynyALFe9AR4AZSnu22cCvufmDI+jK/ShRTakaM=;
        b=y5QJ1RTOml2RSAjIvBYsdVJ2k8poyIbAEqK9gbXMvf/anLbi20BZWlKrIHnB30nI0o
         LMcfKgqvmQhpTkNTN/uVT2Oppdah2LqBb4AFhcL2ZU0O84VOqggfijA3nXRfjnyWxMqg
         8LYg/feEy49SaB/FTnYHvZpsjBaae2IF4aai6ydPwwXY271DMkUG+tnTFfLuA481asuY
         ncqAKCMbDfhJbvRlEToPaTm8qaLiG/vCaXTCTxqMtZ5LfCGpeORnYTysGbGUccu8RqHP
         Y/FNI3Z4fHBttNubfHeMVQnHSB3brn45wUMNRL8WM0cu9ZHtIdjUGC5q5rs1uDKQzlIZ
         fFlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YG1Q9ynyALFe9AR4AZSnu22cCvufmDI+jK/ShRTakaM=;
        b=lKLv7CBK5Mm5WqitZfoYjNi39Kv6IdHwycIyScfnJbzXGbDAznb/NHHKlt9AadhSGa
         La2rxWazx6g401+tDzBO1kRNMbFnHhMhHTwkk2FFsi9FSp10wBy5FL5jPCwMrAbFmQDW
         MjdHubCUC1WD0p+KmoeU2Yqsde+No2kC0b2K3JaR8q7oUKDYKgvA+Z469Swadb6c1AJ8
         803sMMR1Cz2qLUXfz7SvdHaEXXrVqVnBrATdOWR+3LJELlXfnC4mH4DRHGMAhXe+7Zgv
         Xc3Fa6TIP55I0X7+z6t6yLOyw1BWDXnXTTDsmAMIKeFc2gpxM1grMUyQXsn4cqer5dg/
         I0BA==
X-Gm-Message-State: AOAM530JUfbyX9c/JkZYDdKqL9hiI1nge0k4VHL5CWf3HQWnjE+Y5eRF
        NHTSVJ8YUUrorh6hbYb0wfqouK32cJg=
X-Google-Smtp-Source: ABdhPJySSAYHHGXG7ZhusGtY3TlrMlJ2Bid0HtSCCmNCIXaptwIq+EGfkdHrYLhPWUyULEZJsrYJKQ==
X-Received: by 2002:a17:906:1986:: with SMTP id g6mr3896501ejd.404.1596710830139;
        Thu, 06 Aug 2020 03:47:10 -0700 (PDT)
Received: from tsr-lap-08.nix.tessares.net ([79.132.248.22])
        by smtp.gmail.com with ESMTPSA id e14sm3227107edl.86.2020.08.06.03.47.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2020 03:47:09 -0700 (PDT)
Subject: Re: [PATCH net 1/2] net: refactor bind_bucket fastreuse into helper
To:     Tim Froidcoeur <tim.froidcoeur@tessares.net>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Patrick McHardy <kaber@trash.net>,
        KOVACS Krisztian <hidden@balabit.hu>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200806064109.183059-1-tim.froidcoeur@tessares.net>
 <20200806064109.183059-2-tim.froidcoeur@tessares.net>
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Message-ID: <a4143368-bfe8-a3f1-c6e0-753359388191@tessares.net>
Date:   Thu, 6 Aug 2020 12:47:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200806064109.183059-2-tim.froidcoeur@tessares.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tim,

Thank you for having sent the patch!

On 06/08/2020 08:41, Tim Froidcoeur wrote:
> Refactor the fastreuse update code in inet_csk_get_port into a small
> helper function that can be called from other places.

(...)

> diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
> index afaf582a5aa9..3b46b1f6086e 100644
> --- a/net/ipv4/inet_connection_sock.c
> +++ b/net/ipv4/inet_connection_sock.c
> @@ -266,7 +266,7 @@ inet_csk_find_open_port(struct sock *sk, struct inet_bind_bucket **tb_ret, int *
>   static inline int sk_reuseport_match(struct inet_bind_bucket *tb,
>   				     struct sock *sk)
>   {
> -	kuid_t uid = sock_i_uid(sk);
> +	kuid_t uid = sock_i_uid((struct sock *)sk);

It seems there is a left over from a previous version. This modification 
is no longer needed.

>   
>   	if (tb->fastreuseport <= 0)
>   		return 0;
> @@ -296,6 +296,57 @@ static inline int sk_reuseport_match(struct inet_bind_bucket *tb,
>   				    ipv6_only_sock(sk), true, false);
>   }
>   
> +void inet_csk_update_fastreuse(struct inet_bind_bucket *tb,
> +			       struct sock *sk)
> +{
> +	kuid_t uid = sock_i_uid((struct sock *)sk);

Same here.

May you send a v2 without these two casts please?

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
