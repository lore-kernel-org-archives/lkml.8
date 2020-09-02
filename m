Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66DD4C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44A8220BED
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:40:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TUiuF9VC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728245AbgIBSkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 14:40:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25170 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728192AbgIBSkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 14:40:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599072015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j0uPPhC3zXrQ09ZOMV6+TGvbzv6S3EaGNYNTJu5Zubg=;
        b=TUiuF9VCljYBjTFutieG2Dcwn41oxt0iqjEmYY4TtbILyhTbf9EaY7qAtaQF7F/vifDREk
        IQsjjHMCgFH7oOjwP09NoAZN8q2IEAfkIDTln3xJbWKz5+AAPuHCLr96TPCVmexHExp9F3
        EIAlEgkWs5cCX5KE2P+D1Z6KNT9k8ys=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-1B1nMp4QNcuCUYcY_KeN8Q-1; Wed, 02 Sep 2020 14:40:13 -0400
X-MC-Unique: 1B1nMp4QNcuCUYcY_KeN8Q-1
Received: by mail-il1-f197.google.com with SMTP id 2so424578ill.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 11:40:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=j0uPPhC3zXrQ09ZOMV6+TGvbzv6S3EaGNYNTJu5Zubg=;
        b=ekkfVp1V+4iKxOxTjipATsZh5KtdGhHEegcbNZAsyBlP8N1P1jvEPx6aNOPCAXjkfa
         PXPi9+3ZmxFVmCYdF4MHeeixYmf31RhMBUi2g93Um2s28pxYR7Fz/CwQoWh0sBnFZ805
         4/r2RXipd6hJfWrRNu/pQQTrj6C/StfHFirDfklNk3qRmq4r/sLOqTv6mDU5+IsKYt4g
         gm1LVIbItQe8efcPQ2xBFIFfSj+O82RDj4pZvp2+qeD47c5eyKhZhw4QUKt5UeugXPuu
         9LgeK+hOU+KLoNyWGRO4KrBIIQIDi5GMu9xSQx4A+wnLERhdhpIShVzrMz2TmnIh0JvR
         ojEw==
X-Gm-Message-State: AOAM531+v52TCMnD00lYwVwtas3pxS5Y9Sr0tA8NvMX978mqivR+o7ri
        s4Xw/PDNmovPIGWTckPGOvYi/tciP41c+T4uUKkIuOxetvC0yBrzPK/xp1/xn5kCHzyky+ly9QR
        JfzcLB7Mol6uYsAdRz9p2jgzM
X-Received: by 2002:a6b:ec17:: with SMTP id c23mr4629243ioh.186.1599072012699;
        Wed, 02 Sep 2020 11:40:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZtLCzpJ4UK29gX+Y0AYBy64NrsA5WDVyrB09mtmKEQIp2UsYMvd2RPnoUL0lxE9o89yAuGQ==
X-Received: by 2002:a6b:ec17:: with SMTP id c23mr4629228ioh.186.1599072012548;
        Wed, 02 Sep 2020 11:40:12 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id o1sm191736ils.1.2020.09.02.11.40.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2020 11:40:12 -0700 (PDT)
Subject: Re: [PATCH v2] net: openvswitch: pass NULL for unused parameters
To:     David Miller <davem@davemloft.net>
Cc:     pshelar@ovn.org, kuba@kernel.org, natechancellor@gmail.com,
        ndesaulniers@google.com, netdev@vger.kernel.org,
        dev@openvswitch.org, linux-kernel@vger.kernel.org
References: <20200830212630.32241-1-trix@redhat.com>
 <20200901.131111.186993526997490086.davem@davemloft.net>
From:   Tom Rix <trix@redhat.com>
Message-ID: <7b82468b-bc67-df62-1816-1f510888fc39@redhat.com>
Date:   Wed, 2 Sep 2020 11:40:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200901.131111.186993526997490086.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/1/20 1:11 PM, David Miller wrote:
> From: trix@redhat.com
> Date: Sun, 30 Aug 2020 14:26:30 -0700
>
>> Passing unused parameters is a waste.
> Poorly predicted branches are an even bigger waste.
>
> I'm not a big fan of this change and others have asked for performance
> analysis to be performed.
>
> So I'm not applying this as-is, sorry.

no worries.

I think these functions need a larger working over so the stats collecting are not in the core functions.

Thanks for giving it a look,

Tom

>
> It's also not great to see that CLANG can't make use of the caller's
> __always_unused directive to guide these warnings.

