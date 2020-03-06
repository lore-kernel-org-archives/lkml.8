Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E94C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 16:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52A402072A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 16:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gssi.it header.i=@gssi.it header.b="BJDdwnnY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbgCFQpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 11:45:31 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52962 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgCFQpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 11:45:30 -0500
Received: by mail-wm1-f67.google.com with SMTP id p9so3201162wmc.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 08:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gssi.it; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=f1jAW4H0IkyKSlaWbqUdo9Y0iTzcaoXCOSrb76HWcpQ=;
        b=BJDdwnnYch4uEI3annx6gE5gXjIKB2h3hwun3QMq+KmyoRKQnNVr4g17Tm1+EVYLWq
         LqCbzsyBcfGUAVFns1KZYBUituYiC7liaV56CvjkmkNvnqM9Hk/Y0bZKzyS2ab0zDHOf
         QuipMUnVO9T2ih77VBp9jgZFzhkraGo1fIq9Exx9CEA7qkNaUbLE6YPDz7UFD5fo+5Gk
         s80+5yIpfR6kjoZVYP0w1VhKMgG/Mx+JOZanzOqVQRrNmkCkdis5oPBU6BxBCBoOY8hG
         1z60Ycdr+hutG/1PoLWTg1HTPNLBO2P/E5lTuKh4o+9nbwwsS+kYCZa0py5xLYhJtvUr
         K6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=f1jAW4H0IkyKSlaWbqUdo9Y0iTzcaoXCOSrb76HWcpQ=;
        b=nHwvy2DvS77hXmoZYGpRzEhC8YcVgWG8rBbzzZj0zfcZhz0yp0q/y8o5lHOCydAcj8
         fhYbXWdyGU6yK9Qe8bfLcBHLkfLhEkyQZ01z1gUuAozHqDmzWA6j9NujKXv0LpVXNGtH
         rZ6JRqb1XuhI5Uduh0nJoIhM4eEMFWpeuxSFgD0RpF1M3FseaymFMEhgLmQ5RIDVwYyK
         3tgD4T51CO1RRi7lCT2FlDV3ABU6Dg9gf/3Lq9G2A6mHt6MGjUov7iUtpfg75b/+O8q/
         L55pQd6XCq7PMOfQHPJMZ+8VJlxsNFETesYzo125LrKl8gjrmFPEVRSSVF2RHlqf2Rrj
         dqUg==
X-Gm-Message-State: ANhLgQ1uvZ4te1FxwFlkCo0hV0zFUn1/Tz/BdYrFhqQI8jXPt4X6/4TA
        q/wZR/S6tvFs3epKX0gtZffFoA==
X-Google-Smtp-Source: ADFU+vvwgXTS/gGW17pEFyLijL3F59giKG9Rig9EHIsVd2K3b7BxzgGLv34Rt3qkFPlCnjz43GNffQ==
X-Received: by 2002:a1c:9d43:: with SMTP id g64mr4727921wme.62.1583513128994;
        Fri, 06 Mar 2020 08:45:28 -0800 (PST)
Received: from [192.168.1.125] (dynamic-adsl-78-14-145-244.clienti.tiscali.it. [78.14.145.244])
        by smtp.gmail.com with ESMTPSA id t18sm41756wml.17.2020.03.06.08.45.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Mar 2020 08:45:28 -0800 (PST)
Subject: Re: [net-next 1/2] Perform IPv4 FIB lookup in a predefined FIB table
To:     David Ahern <dsahern@gmail.com>,
        Carmine Scarpitta <carmine.scarpitta@uniroma2.it>
Cc:     davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, dav.lebrun@gmail.com,
        andrea.mayer@uniroma2.it, paolo.lungaroni@cnit.it,
        hiroki.shirokura@linecorp.com
References: <20200213010932.11817-1-carmine.scarpitta@uniroma2.it>
 <20200213010932.11817-2-carmine.scarpitta@uniroma2.it>
 <7302c1f7-b6d1-90b7-5df1-3e5e0ba98f53@gmail.com>
 <20200219005007.23d724b7f717ef89ad3d75e5@uniroma2.it>
 <cd18410f-7065-ebea-74c5-4c016a3f1436@gmail.com>
 <20200219034924.272d991505ee68d95566ff8d@uniroma2.it>
 <a39867b0-c40f-e588-6cf9-1524581bb145@gmail.com>
From:   Ahmed Abdelsalam <ahmed.abdelsalam@gssi.it>
Message-ID: <4ed5aff3-43e8-0138-1848-22a3a1176e46@gssi.it>
Date:   Fri, 6 Mar 2020 17:45:26 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <a39867b0-c40f-e588-6cf9-1524581bb145@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

Thanks for the pointers for the VRF with MPLS.

We have been looking at this for the last weeks also watched your videos 
on the VRF and l3mdev implementation at the different netdev conferences.

However, in the SRv6 we don’t really need a VRF device. The SRv6 
functions (the already supported ones as well as the End.DT4 submitted 
here) resides in the IPv6 FIB table.

The way it works is as follows:
1) create a table for the tenant
$ echo 100 tenant1 >> /etc/iproute2/rt_tables

You instantiate an SRv6 End.DT4 function at the Egress PE to decapsulate 
the SRv6 encapsulation and lookup the inner packet in the tenant1 table. 
The example iproute2 command to do so is as below.

$ ip -6 route add A::B encap seg6local action End.DT4 table tenant1 dev 
enp0s8

This installs an IPv6 FIB entry as shown below.
$ ip -6 r
a::b  encap seg6local action End.DT4 table 100 dev enp0s8 metric 1024 
pref medium

Then the BGP routing daemon at the Egress PE is used to advertise this 
VPN service. The BGP sub-TLV to support SRv6 IPv4 L3VPN is defined in [2].

The SRv6 BGP extensions to support IPv4/IPv6 L3VPN are now merged in in 
FRRouting/frr [3][4][5][6].

There is also a pull request for the CLI to configure SRv6-locator on 
zebra [7].

The BGP daemon at the Ingress PE receives the BGP update and installs an 
a FIB entry that this bound to SRv6 encapsulation.

$ ip r
30.0.0.0/24  encap seg6 mode encap segs 1 [ a::b ] dev enp0s9

Traffic destined to that tenant will get encapsulated at the ingress 
node and forwarded to the egress node on the IPv6 fabric.

The encapsulation is in the form of outer IPv6 header that has the 
destination address equal to the VPN service A::B instantiated at the 
Egress PE.

When the packet arrives at the Egress PE, the destination address 
matches the FIB entry associated with the End.DT4 function which does 
the decapsulation and the lookup inside the tenant table associated with 
it (tenant1).

Everything I explained is in the Linux kernel since a while. End.DT4 was 
missing and this the reason we submitted this patch.

In this multi-tenant DC fabric we leverage the IPv6 forwarding. No need 
for MPLS dataplane in the fabric.

We can submit a v2 of patch addressing your comments on the "tbl_known" 
flag.

Thanks,
Ahmed

[1] https://segment-routing.org/index.php/Implementation/AdvancedConf
[2] https://tools.ietf.org/html/draft-ietf-bess-srv6-services-02
[3] 
https://github.com/FRRouting/frr/commit/7f1ace03c78ca57c7f8b5df5796c66fddb47e5fe
[4] 
https://github.com/FRRouting/frr/commit/e496b4203055c50806dc7193b9762304261c4bbd
[5] 
https://github.com/FRRouting/frr/commit/63d02478b557011b8606668f1e3c2edbf263794d
[6] 
https://github.com/FRRouting/frr/commit/c6ca155d73585b1ca383facd74e9973c281f1f93
[7] https://github.com/FRRouting/frr/pull/5865


On 19/02/2020 05:29, David Ahern wrote:
> On 2/18/20 7:49 PM, Carmine Scarpitta wrote:
>> Hi David,
>> Thanks for the reply.
>>
>> The problem is not related to the table lookup. Calling fib_table_lookup and then rt_dst_alloc from seg6_local.c is good.
>>
> 
> you did not answer my question. Why do all of the existing policy
> options (mark, L3 domains, uid) to direct the lookup to the table of
> interest not work for this use case?
> 
> What you want is not unique. There are many ways to make it happen.
> Bleeding policy details to route.c and adding a flag that is always
> present and checked even when not needed (e.g.,
> CONFIG_IP_MULTIPLE_TABLES is disabled) is not the right way to do it.
> 
