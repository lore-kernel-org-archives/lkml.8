Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679D7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 09:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4084720787
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 09:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="Avf++p7G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389365AbgEYJd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 05:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389251AbgEYJdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 05:33:24 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E890C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 02:33:24 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id x14so11094703wrp.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 02:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=e8LU087JhCQmZTPzcRDUvpkp9wx3VT7SLtgrgSxNirE=;
        b=Avf++p7GjzWXbsom5IIKMsjrIT2NWfxRUCcz0t9E2X+owIr7NhKcDhNjZwLY2Xsai4
         i2zGx5T94A7jZNeFpHF7QY/2CWDO/3ZBoU6IX3soy51XaYqMBSSnqucZE+KFXygzKDsA
         feluyyuU7afsDf1A7N0VkWxm9CxktoAwWswDw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=e8LU087JhCQmZTPzcRDUvpkp9wx3VT7SLtgrgSxNirE=;
        b=LoUlOJk2TEq8wx7SuGjRJzDczXC9a87a1z7u/jr5cE984kuwj/vh75/N3vTn1h85+j
         8RKdHD7S5i+DKo/UM/2QRvzry7pNgTbF3foAoM21Xuigs93x8aNQ9DQTGVa1U0Iimf/d
         rE67FMZsCzd90k4ag6nZ0p7G0LvaI78dJpXai5Om74rjfqsLfF0910y0XtKONK/PhPRx
         NtqSK7HME9ptDOjpsdlcYW1SLhJsqKNnab9WQIi1FV00h0zkLlzsrDRer5hihDH5Coew
         77ZLNoKv49FhMtnlywYr5eaAavuhJt4TBt7qdxPwul+MVhkkPTlJSEAsEuPhkI2rjaFb
         6LvQ==
X-Gm-Message-State: AOAM531Vs2Vhvq3mTBIBVFhyg07Ov6K428bEYrok1QlWF9IQMDes6rlY
        1pBVhRUT0z4zAjo1ryX7pViEmG19lHq4dA==
X-Google-Smtp-Source: ABdhPJyhXfTUVDMmF9+pUbBzM3VN1sv2lr3v3pq3bi5JJOeNg/uXQIF0NWiFionp9ryN3K84i24i/g==
X-Received: by 2002:a5d:56c7:: with SMTP id m7mr14169824wrw.256.1590399201557;
        Mon, 25 May 2020 02:33:21 -0700 (PDT)
Received: from [192.168.0.109] (84-238-136-197.ip.btc-net.bg. [84.238.136.197])
        by smtp.gmail.com with ESMTPSA id p3sm12447448wru.95.2020.05.25.02.33.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2020 02:33:20 -0700 (PDT)
Subject: Re: MRP netlink interface
To:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        roopa@cumulusnetworks.com, davem@davemloft.net, kuba@kernel.org,
        andrew@lunn.ch, UNGLinuxDriver@microchip.com,
        bridge@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200525112827.t4nf4lamz6g4g2c5@soft-dev3.localdomain>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <2176b58f-35f3-36c1-8ba7-d18649eb29f7@cumulusnetworks.com>
Date:   Mon, 25 May 2020 12:33:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200525112827.t4nf4lamz6g4g2c5@soft-dev3.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/05/2020 14:28, Horatiu Vultur wrote:
> Hi,
> 
> While I was working on adding support for MRA role to MRP, I noticed that I
> might have some issues with the netlink interface, so it would be great if you
> can give me an advice on how to continue.
> 
> First a node with MRA role can behave as a MRM(Manager) or as a
> MRC(Client). The behaviour is decided by the priority of each node. So
> to have this functionality I have to extend the MRP netlink interface
> and this brings me to my issues.
> 
> My first approach was to extend the 'struct br_mrp_instance' with a field that
> contains the priority of the node. But this breaks the backwards compatibility,
> and then every time when I need to change something, I will break the backwards
> compatibility. Is this a way to go forward?
> 
> Another approach is to restructure MRP netlink interface. What I was thinking to
> keep the current attributes (IFLA_BRIDGE_MRP_INSTANCE,
> IFLA_BRIDGE_MRP_PORT_STATE,...) but they will be nested attributes and each of
> this attribute to contain the fields of the structures they represents.
> For example:
> [IFLA_AF_SPEC] = {
>     [IFLA_BRIDGE_FLAGS]
>     [IFLA_BRIDGE_MRP]
>         [IFLA_BRIDGE_MRP_INSTANCE]
>             [IFLA_BRIDGE_MRP_INSTANCE_RING_ID]
>             [IFLA_BRIDGE_MRP_INSTANCE_P_IFINDEX]
>             [IFLA_BRIDGE_MRP_INSTANCE_S_IFINDEX]
>         [IFLA_BRIDGE_MRP_RING_ROLE]
>             [IFLA_BRIDGE_MRP_RING_ROLE_RING_ID]
>             [IFLA_BRIDGE_MRP_RING_ROLE_ROLE]
>         ...
> }
> And then I can parse each field separately and then fill up the structure
> (br_mrp_instance, br_mrp_port_role, ...) which will be used forward.
> Then when this needs to be extended with the priority it would have the
> following format:
> [IFLA_AF_SPEC] = {
>     [IFLA_BRIDGE_FLAGS]
>     [IFLA_BRIDGE_MRP]
>         [IFLA_BRIDGE_MRP_INSTANCE]
>             [IFLA_BRIDGE_MRP_INSTANCE_RING_ID]
>             [IFLA_BRIDGE_MRP_INSTANCE_P_IFINDEX]
>             [IFLA_BRIDGE_MRP_INSTANCE_S_IFINDEX]
>             [IFLA_BRIDGE_MRP_INSTANCE_PRIO]
>         [IFLA_BRIDGE_MRP_RING_ROLE]
>             [IFLA_BRIDGE_MRP_RING_ROLE_RING_ID]
>             [IFLA_BRIDGE_MRP_RING_ROLE_ROLE]
>         ...
> }
> And also the br_mrp_instance will have a field called prio.
> So now, if the userspace is not updated to have support for setting the prio
> then the kernel will use a default value. Then if the userspace contains a field
> that the kernel doesn't know about, then it would just ignore it.
> So in this way every time when the netlink interface will be extended it would
> be backwards compatible.
> 
> If it is not possible to break the compatibility then the safest way is to
> just add more attributes under IFLA_BRIDGE_MRP but this would just complicate
> the kernel and the userspace and it would make it much harder to be extended in
> the future.
> 
> My personal choice would be the second approach, even if it breaks the backwards
> compatibility. Because it is the easier to go forward and there are only 3
> people who cloned the userspace application
> (https://github.com/microchip-ung/mrp/graphs/traffic). And two of
> these unique cloners is me and Allan.
> 
> So if you have any advice on how to go forward it would be great.
> 

IIRC this is still in net-next only, right? If so - now would be the time to change it.
Once it goes into a release, we'll be stuck with workarounds. So I'd go for solution 2).

I haven't cloned it, but I do sync your user-space mrp repo to check against the patches. :)

