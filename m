Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE81C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 16:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76C3F21741
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 16:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eMD3+YRT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgGSQKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 12:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgGSQKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 12:10:49 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F271C0619D2;
        Sun, 19 Jul 2020 09:10:49 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 207so7850053pfu.3;
        Sun, 19 Jul 2020 09:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IQJ2lp1aWlzAuTQVmicrunbxGhlr+LmtlAWLDGnu94E=;
        b=eMD3+YRT3HEcXSwAjmG2pBhJcK64phOCRXKocUN8jVCyY+Yl1RjQMqnCflBxdDtKwr
         dnWvYBsdatEp6N4hdYsf6qokYLN9Fp6v1khuhSxNwL6OdmNQlYHPV7ieARzag6Zwhnpe
         kAIgC2ex6QsD6tCu5hy/FIBmJdxAj9U7ZgL/Ic4CLmkLwx/Nahi2ZVj5P1jTfUMSqY8k
         VhNVmbFfNZ6F0bo+aDpKDEghH1oKtg2xCsbybYnyXBC46r6bFzhC4di7fQzq+ptT0TLJ
         4kjqQYs98hZswbszwaDWWQqDhoFarnib00F7Zkycvz9u740o/RmtyUmwy1JPNvdnNBzt
         tUeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IQJ2lp1aWlzAuTQVmicrunbxGhlr+LmtlAWLDGnu94E=;
        b=gsxoAhA/RFHO/K/86p28OokFhwAR+WltEywuh8AB6+t4xcMxsKTsZk0GjHovUjYj61
         52IhQDl72+38UaApPOuShk5Ru4hJU6KJkH6hy9GJJFa02D/waRcEalEj1ZvZqSIPAQhV
         EQYefYrmz0uaY+cz6qEx5/mkMnUPpu4A0cKJzCiDmG2rWRUsLxmd56lDcVHWVjW21Uqt
         iaD+dUYQSeg72CUCCCP4H5XVCSCZUyC+TWqU1x0vtNE8i1yJdvjvAB49Nin/4pIG56Cu
         1vvxSwWAACU3fWI3tx1qIQLv0+oFVLhfEch5NtzZ7D1wJiA17SW1PdRFqX843kHTIw9a
         079w==
X-Gm-Message-State: AOAM532mLYCb0LRJkyXKj02frvjV9a+SNjXKmptjZBm9jXqC/UnaGXRK
        Wgt1YW1B7FeDoO1DU3hLHTHj+Ks3
X-Google-Smtp-Source: ABdhPJyjAV599gzgfuPVyU0Ji+Oy1DYIgS60m4PG6yOhRzZxuUTjR7zNL/0Ve8HdlduPhQ8roQ2Dhw==
X-Received: by 2002:aa7:860f:: with SMTP id p15mr16116841pfn.59.1595175048522;
        Sun, 19 Jul 2020 09:10:48 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id y27sm13494240pgc.56.2020.07.19.09.10.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jul 2020 09:10:47 -0700 (PDT)
Subject: Re: [PATCH net-next 2/4] net: dsa: Add wrappers for overloaded
 ndo_ops
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     netdev@vger.kernel.org, Vivien Didelot <vivien.didelot@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jiri Pirko <jiri@mellanox.com>,
        Eric Dumazet <edumazet@google.com>,
        Taehee Yoo <ap420073@gmail.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Maxim Mikityanskiy <maximmi@mellanox.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Michal Kubecek <mkubecek@suse.cz>,
        open list <linux-kernel@vger.kernel.org>
References: <20200718030533.171556-1-f.fainelli@gmail.com>
 <20200718030533.171556-3-f.fainelli@gmail.com>
 <20200719154014.GJ1383417@lunn.ch>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <90674456-cacf-09a7-9e0f-fe292e039811@gmail.com>
Date:   Sun, 19 Jul 2020 09:10:41 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200719154014.GJ1383417@lunn.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/19/2020 8:40 AM, Andrew Lunn wrote:
>> +#if IS_ENABLED(CONFIG_NET_DSA)
>> +#define dsa_build_ndo_op(name, arg1_type, arg1_name, arg2_type, arg2_name) \
>> +static int inline dsa_##name(struct net_device *dev, arg1_type arg1_name, \
>> +			     arg2_type arg2_name)	\
>> +{							\
>> +	const struct dsa_netdevice_ops *ops;		\
>> +	int err = -EOPNOTSUPP;				\
>> +							\
>> +	if (!dev->dsa_ptr)				\
>> +		return err;				\
>> +							\
>> +	ops = dev->dsa_ptr->netdev_ops;			\
>> +	if (!ops || !ops->name)				\
>> +		return err;				\
>> +							\
>> +	return ops->name(dev, arg1_name, arg2_name);	\
>> +}
>> +#else
>> +#define dsa_build_ndo_op(name, ...)			\
>> +static inline int dsa_##name(struct net_device *dev, ...) \
>> +{							\
>> +	return -EOPNOTSUPP;				\
>> +}
>> +#endif
>> +
>> +dsa_build_ndo_op(ndo_do_ioctl, struct ifreq *, ifr, int, cmd);
>> +dsa_build_ndo_op(ndo_get_phys_port_name, char *, name, size_t, len);
> 
> Hi Florian
> 
> I tend to avoid this sort of macro magic. Tools like
> https://elixir.bootlin.com/ and other cross references have trouble
> following it. The current macros only handle calls with two
> parameters. And i doubt it is actually saving many lines of code, if
> there are only two invocations.

It saves about 20 lines of code for each new function that is added.
Since the boilerplate logic is always the same, if you prefer I could
provide it as a separate helper function and avoid the macro to generate
the function body, yes let's do that.
-- 
Florian
