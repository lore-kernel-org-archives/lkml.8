Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFBC8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 21:14:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9199B20823
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 21:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TlYSTVO/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730604AbgEUVOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 17:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgEUVOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 17:14:35 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D542C05BD43
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 14:14:35 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id d69so2641745ybc.22
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 14:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=semgcmJd0ZZ9q+OBcE/cjzRQcM4RABCN/d9XODlBjRA=;
        b=TlYSTVO/Y8u4XRBQIPQXsEu5jGML3Ds00FRBHt//Mxa9a2AaScCsqVRxFRWHdU2drB
         Oc3DmuiIsF0NWvZfGexbksIlGcw3bTNLnB7Dm2vDAvLHR0EzpVD44ZglXDaidxyyv29c
         imLD0eJU1+IZelhBUQDzp6FhQKefWoXPsjeRjoVeWZMYpuTceYBZXqwe1usyba7Mo5fd
         lxPYQMiD5umdUV8hOrVNEke3LLE++/LulrbW2iidAoyzCqUm37kUbnc4WgFvpmV98zoy
         lJZHfQ5EpPOmS9n4KMjq3spWJA07pHcS/UJ6p83Krdx6oi+LWBGpfxXoxwUURqVeV0T5
         SBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=semgcmJd0ZZ9q+OBcE/cjzRQcM4RABCN/d9XODlBjRA=;
        b=Du3WQmXTzCaRJBRsECN+wvcP1vUAAoAYmIU7RpQetLUSxDEvcG9oMauOVZnruRkXF5
         msWwxirbePCQfwFYCTKOVDSCbMbZs3VGz8UauV2BkGtiykeRnWtuQvk78Vj/N5adNmBr
         O+s+yIrtyI5VoNP7YXVUMLG5aTWevWxVDmZFkgIO/S/hD6Wn6u0QPdJEq78S6FPBdLbD
         f2DB8i/Akbxxo5MHKCtvjwM7pceXeydhHNI7VrBeeUHOBZ54AzG9JdE2i8oXsJoTG+o2
         wag1p8wBAlQhOSHGrLh611/N1pUvCVANIfNRK3BsN66kj3uKR4rqQPPJcTp/4642vOZ1
         qVmA==
X-Gm-Message-State: AOAM531vGP7JPAt0oorqUUwQtBWYjhgSFaJsGSyux5GjP4kalKvDscor
        riJJhNsMqoHle+qKAjQH3CDgMyU=
X-Google-Smtp-Source: ABdhPJw5CN2ei/ClgLNdsSzrKVS4Hgzwn2pYl2BgA0+O1BHrOE25xjmCCA7f/kCtzSd2kWGb8repg8I=
X-Received: by 2002:a25:cbc9:: with SMTP id b192mr18457440ybg.132.1590095674239;
 Thu, 21 May 2020 14:14:34 -0700 (PDT)
Date:   Thu, 21 May 2020 14:14:32 -0700
In-Reply-To: <20200521125247.30178-1-fejes@inf.elte.hu>
Message-Id: <20200521211432.GC49942@google.com>
Mime-Version: 1.0
References: <20200521125247.30178-1-fejes@inf.elte.hu>
Subject: Re: [PATCH net-next] Extending bpf_setsockopt with SO_BINDTODEVICE sockopt
From:   sdf@google.com
To:     Ferenc Fejes <fejes@inf.elte.hu>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Lawrence Brakmo <brakmo@fb.com>,
        "David S . Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/21, Ferenc Fejes wrote:
> This option makes possible to programatically bind sockets to netdevices.
> With the help of this option sockets of VRF unaware applications
> could be distributed between multiple VRFs with eBPF sock_ops program.
> This let the applications benefit from the multiple possible routes.

> Signed-off-by: Ferenc Fejes <fejes@inf.elte.hu>
> ---
>   net/core/filter.c | 39 ++++++++++++++++++++++++++++++++++++++-
>   1 file changed, 38 insertions(+), 1 deletion(-)

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 822d662f97ef..25dac75bfc5d 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -4248,6 +4248,9 @@ static const struct bpf_func_proto  
> bpf_get_socket_uid_proto = {
>   static int _bpf_setsockopt(struct sock *sk, int level, int optname,
>   			   char *optval, int optlen, u32 flags)
>   {
> +	char devname[IFNAMSIZ];
> +	struct net *net;
> +	int ifindex;
>   	int ret = 0;
>   	int val;

> @@ -4257,7 +4260,7 @@ static int _bpf_setsockopt(struct sock *sk, int  
> level, int optname,
>   	sock_owned_by_me(sk);

>   	if (level == SOL_SOCKET) {
> -		if (optlen != sizeof(int))
> +		if (optlen != sizeof(int) && optname != SO_BINDTODEVICE)
>   			return -EINVAL;
>   		val = *((int *)optval);

> @@ -4298,6 +4301,40 @@ static int _bpf_setsockopt(struct sock *sk, int  
> level, int optname,
>   				sk_dst_reset(sk);
>   			}
>   			break;
> +		case SO_BINDTODEVICE:
> +			ret = -ENOPROTOOPT;
> +#ifdef CONFIG_NETDEVICES
Any specific reason you're not reusing sock_setbindtodevice or at least
sock_setbindtodevice_locked here? I think, historically, we've
reimplemented some of the sockopts because they were 'easy' (i.e.
were just setting a flag in the socket), this one looks more involved.

I'd suggest, add an optional 'lock_sk' argument to sock_setbindtodevice,
call it with 'true' from real setsockopt, and call it with 'false'
here.

And, as Andrii pointed out, it would be nice to have a selftest
that exercises this new option.
