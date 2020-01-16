Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5E2C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:39:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE05620730
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 13:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="DV2mwNPn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbgAPNi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 08:38:59 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42348 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgAPNi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 08:38:59 -0500
Received: by mail-wr1-f67.google.com with SMTP id q6so19106735wro.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 05:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google;
        h=reply-to:subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N3obRAIyIl+6u7JuAN54pttOMvMsTv5wq2/SDqyRJ7k=;
        b=DV2mwNPnM1+gJ94/Hm+iBvvKHf2qavNI2HhzAlr2bd7Y8UnnZAcjXmPkOD/YOOaz0h
         uTz0cZWWeoMey1khdcAwZxfK78AAXAxtsUMqU1lvjSduhQrp298vB/K/trZeNfh2rQ1h
         dmvWs7Kyc6jPlPhu4VRTOmkOWagyYRJ0rgwnAWFnKH5JoTO4W6zuyVFicf5gcB6jr+RI
         LQRbjgUa10OelFpnCN42GOVGohMd7mLlc1yjM4NlpfnCWDf5i1b1CB5k7TKepXrvNLZy
         aXrhv+wFM9BqSTaKHOP5qGWZamAuvrXkGpVI9brhqexuvYFjqyO18qx1jIkrEwiYuriu
         +hsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=N3obRAIyIl+6u7JuAN54pttOMvMsTv5wq2/SDqyRJ7k=;
        b=BdSiRafbj33LS1qKW2URFk6mHw2nRoeZQ/8O+9vlT9ys/bmjzJa8/WUVGtmPG6guat
         OsfdeUmpFFcbdbQ7Kd8NRlJbFHEYCD4dbkS7AR65sxwg6TcZIDkOemogSmI60TdEvUdU
         qCOA95yOhKYJ277HFipAskjWjZCnMy8YZXdGLeweVmjj4qdHpSe4eLxCHeSp8hdrOP9p
         VfZd5BNecbs9yx8J71ApHgBXrKVTBhGY78pkIFNHex/WoTQEbuPqYDqrgeDIDXjfeOzL
         pPvFZznDer5PJ6GHVXK+vJCRJRqyA3Rok8yF3aRui1ZxjlWusNzzh/4p7+rlgaXIg840
         57zQ==
X-Gm-Message-State: APjAAAVjCjLNKqVa0K2IQ40YsOi00ULjRC8B/byCe1TChpPR5URgYG+9
        TtjVqp1VuATJe1X0b9QiRz7dxg==
X-Google-Smtp-Source: APXvYqzV0HizurXQKRKc7aBZQVV35L2R0WGtTw9cQxi+Vx96irLv2rVZGepNKR1qVGGkwEpMIzj8sw==
X-Received: by 2002:a05:6000:1288:: with SMTP id f8mr3433770wrx.66.1579181937431;
        Thu, 16 Jan 2020 05:38:57 -0800 (PST)
Received: from ?IPv6:2a01:e0a:410:bb00:ed9f:e0c6:a41a:de2f? ([2a01:e0a:410:bb00:ed9f:e0c6:a41a:de2f])
        by smtp.gmail.com with ESMTPSA id u18sm28899430wrt.26.2020.01.16.05.38.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2020 05:38:56 -0800 (PST)
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next v3] openvswitch: add TTL decrement action
To:     Pravin Shelar <pshelar@ovn.org>, Matteo Croce <mcroce@redhat.com>
Cc:     Linux Kernel Network Developers <netdev@vger.kernel.org>,
        ovs dev <dev@openvswitch.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Bindiya Kurle <bindiyakurle@gmail.com>,
        Simon Horman <simon.horman@netronome.com>,
        Ben Pfaff <blp@ovn.org>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
References: <20200115164030.56045-1-mcroce@redhat.com>
 <CAOrHB_D_zM+rceB9U3O_0GbGQW3KUouE-==haQf7MZUJm5p4wg@mail.gmail.com>
From:   Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
Message-ID: <c7f288b2-dd07-f43a-48c9-ce6086137322@6wind.com>
Date:   Thu, 16 Jan 2020 14:38:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAOrHB_D_zM+rceB9U3O_0GbGQW3KUouE-==haQf7MZUJm5p4wg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 16/01/2020 à 08:21, Pravin Shelar a écrit :
> On Wed, Jan 15, 2020 at 8:40 AM Matteo Croce <mcroce@redhat.com> wrote:
[snip]
>> @@ -1050,4 +1051,5 @@ struct ovs_zone_limit {
>>         __u32 count;
>>  };
>>
>> +#define OVS_DEC_TTL_ATTR_EXEC      0
> 
> I am not sure if we need this, But if you want the nested attribute
> then lets define enum with this single attribute and have actions as
> part of its data. This would be optional argument, so userspace can
> skip it, and in that case datapath can drop the packet.
And note that 0 is a reserved value and should not be used. Look at other
attributes.

Regards,
Nicolas
