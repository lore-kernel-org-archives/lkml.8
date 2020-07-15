Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D24C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 07:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83FF1206F4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 07:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NdZh9VsO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729446AbgGOHnE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 03:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729375AbgGOHnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 03:43:04 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8153C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 00:43:03 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f139so4558974wmf.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 00:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=26li/AIJxcCZ4n6pM/+6TmGvQhnQI2gensE7JIjJDAc=;
        b=NdZh9VsOlkJAPSQxVmZ23VbCikT7wyVDUcjTkK9O6kXdepSpcwJVt4MvmBm0kTQc1W
         a9WmL72Va6z/FCymS8H5MO/fbNf2WV3XFGzpCqHIXbydYjnJWoXKqw2UbELmya31Jr8M
         w0raL2rh0ZvMSlMkvSCSW2c0R8Qtob8e+JCDAl1WHSqGJxL3nBZK2ZYAWbBECrd22EUD
         2Hb9BxEDjveBmIyMYElvkOmAQhwPpzZsRlA6p3RaJxF0dPyYXkDxYyD3RYKiuXpkx2lj
         XY5MvIkZn0PCAqc+vPr/FEL/fQ20syR1eJQ3v9wDHS/2JfDXlqtjBD9tOR4Wsw9rZ2Um
         zEcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=26li/AIJxcCZ4n6pM/+6TmGvQhnQI2gensE7JIjJDAc=;
        b=TPXE8P1+NDD81EifVxTmtJaGoMg63DOH9dxFbM/flCVP1dKgj/iHyCYCvykQRCS3Kh
         pFcsBV6aatEupagD4UeDhqEL1fHwECxWfhNOvqSnxrDNzkujHYJq9ACtMNaD9VXcBMEQ
         wb344asmIcBVB27TpbuJ/UD0bBFevbOqCc3ymxJyuKQPpldykKNYKg7gNRJ9tcA/4F1V
         uAuzgEt72lDVN4rS+d7quPkmdjUw3MJvgbAaCQhWuoPguxUGrJ+WW7PddxGnqq0/973n
         tGEJqeivStO5JbWKS44B1GukzTrP97jmzyPyoBY6msy0sAr0fCzafUT+9rsQ9iaSl6Vg
         hMPQ==
X-Gm-Message-State: AOAM531Z8djmHapwhmgPpNUxJkR47vQaWxKj+nZlz5Vl07dN6hnXYtDC
        HvIhjC6zq48ja4xX1DUUfv07nial2sQ=
X-Google-Smtp-Source: ABdhPJzY1MGFaIei7X/rpybaV5i9FrbgJZWkdMp9ql9dHDnDA3wzUwFO88SB9J9tnw9f5JHcOEGA4A==
X-Received: by 2002:a1c:e285:: with SMTP id z127mr7356248wmg.162.1594798982037;
        Wed, 15 Jul 2020 00:43:02 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:814b:c0b2:8c76:b6a9? ([2a01:e34:ed2f:f020:814b:c0b2:8c76:b6a9])
        by smtp.googlemail.com with ESMTPSA id b23sm2316165wmd.37.2020.07.15.00.43.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jul 2020 00:43:01 -0700 (PDT)
Subject: Re: [PATCH] net: genetlink: Move initialization to core_initcall
To:     davem@davemloft.net
Cc:     Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@mellanox.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Michal Kubecek <mkubecek@suse.cz>,
        "open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200715074120.8768-1-daniel.lezcano@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <3ab741d2-2d44-fbcb-709d-c89d2b0c3649@linaro.org>
Date:   Wed, 15 Jul 2020 09:43:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200715074120.8768-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Dave,

if you agree with this change, is it possible I merge it through the
thermal tree in order to fix the issue ?

Thanks

  -- Daniel


On 15/07/2020 09:41, Daniel Lezcano wrote:
> The generic netlink is initialized far after the netlink protocol
> itself at subsys_initcall. The devlink is initialized at the same
> level, but after, as shown by a disassembly of the vmlinux:
> 
> [ ... ]
> 374 ffff8000115f22c0 <__initcall_devlink_init4>:
> 375 ffff8000115f22c4 <__initcall_genl_init4>:
> [ ... ]
> 
> The function devlink_init() calls genl_register_family() before the
> generic netlink subsystem is initialized.
> 
> As the generic netlink initcall level is set since 2005, it seems that
> was not a problem, but now we have the thermal framework initialized
> at the core_initcall level which creates the generic netlink family
> and sends a notification which leads to a subtle memory corruption
> only detectable when the CONFIG_INIT_ON_ALLOC_DEFAULT_ON option is set
> with the earlycon at init time.
> 
> The thermal framework needs to be initialized early in order to begin
> the mitigation as soon as possible. Moving it to postcore_initcall is
> acceptable.
> 
> This patch changes the initialization level for the generic netlink
> family to the core_initcall and comes after the netlink protocol
> initialization.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  net/netlink/genetlink.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
> index 55ee680e9db1..36b8a1909826 100644
> --- a/net/netlink/genetlink.c
> +++ b/net/netlink/genetlink.c
> @@ -1263,7 +1263,7 @@ static int __init genl_init(void)
>  	panic("GENL: Cannot register controller: %d\n", err);
>  }
>  
> -subsys_initcall(genl_init);
> +core_initcall(genl_init);
>  
>  static int genlmsg_mcast(struct sk_buff *skb, u32 portid, unsigned long group,
>  			 gfp_t flags)
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
