Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C60C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 12:02:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B051420733
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 12:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="C5SDUba+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbgC2MCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 08:02:20 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:47067 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727965AbgC2MCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 08:02:20 -0400
Received: by mail-lj1-f196.google.com with SMTP id r7so7179015ljg.13
        for <linux-kernel@vger.kernel.org>; Sun, 29 Mar 2020 05:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Cq8VIxSwvwCSuQt3WNmGkXzcdrs0outzKbdn+QVFL8s=;
        b=C5SDUba+Fkoy2P8Hc0dS+/pcVzsmUR1V/3qsUjGDQcKAG56T6DUtDJZu9YY9ZF0ezZ
         jwyEZ/VxLc7emmpUOm9NmpFXL1VUTcgnX2CFb5pdV/GhJ6XlGtOMa+NsBF5KLRkbu/NQ
         X5O9GNW0nyM/erPBbBpkQYzj11e9iTQZG83xs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Cq8VIxSwvwCSuQt3WNmGkXzcdrs0outzKbdn+QVFL8s=;
        b=hXh88xjcEtkAvLSe67K3JgnNsbDyVJK4WNBvSgSO7t9d9lOyBuxBlbY78Eu8TBuoRU
         198W49CWbyln1i5IDYxpLOMfT38Stcyim4LdVtwWE7WNH5nEmqfqLlPEki08vfXKQ/5m
         Og+bfuM3zCJlB5/nTXyYp6xXPK8y5xjkZ3cWwRZopzhHK0wkqj94xZKMA4RyEeOt/QAD
         dAJQJpEZ/EKvtRKfIz1jtKxw4FE79HTLTV2ewuVWPys8jtf/9fJ6ND2H9D82OCFDX9Kq
         O8RFGZ8BXTeZG+wINLQvyaLPZMGLTclFb6jA66Qtp5EGG714rECXjXy1srb8KbmyuB5x
         jhbA==
X-Gm-Message-State: AGi0PubpSeVbKal7L4/eKsPdoDtka//fvT+hlh+MWgiHp6fw29dJ5yJC
        mn+Jwq0Isrm4EhNQnexEfjZF8g==
X-Google-Smtp-Source: APiQypI89yqc93TSmOnJWJRnO43OWKFd7LoI5Egh4hYQIX5SifepNeFGxejqT6E5UbsuaJHsMVdoRA==
X-Received: by 2002:a2e:9586:: with SMTP id w6mr4514883ljh.133.1585483337920;
        Sun, 29 Mar 2020 05:02:17 -0700 (PDT)
Received: from [192.168.0.109] (84-238-136-197.ip.btc-net.bg. [84.238.136.197])
        by smtp.gmail.com with ESMTPSA id c13sm5328557ljj.37.2020.03.29.05.02.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Mar 2020 05:02:17 -0700 (PDT)
Subject: Re: [PATCH net-next 6/6] net: dsa: sja1105: add broadcast and
 per-traffic class policers
To:     Vladimir Oltean <olteanv@gmail.com>,
        Ido Schimmel <idosch@idosch.org>
Cc:     Roopa Prabhu <roopa@cumulusnetworks.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jiri Pirko <jiri@resnulli.us>,
        Jakub Kicinski <kuba@kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Allan W. Nielsen" <allan.nielsen@microchip.com>,
        Joergen Andreasen <joergen.andreasen@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        "Y.b. Lu" <yangbo.lu@nxp.com>,
        Alexandru Marginean <alexandru.marginean@nxp.com>,
        Po Liu <po.liu@nxp.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Li Yang <leoyang.li@nxp.com>
References: <20200329005202.17926-1-olteanv@gmail.com>
 <20200329005202.17926-7-olteanv@gmail.com>
 <20200329095712.GA2188467@splinter>
 <CA+h21hoybhxhR3KgfRkAaKyPPJPesbGLWDaDp5O_2yTz05y5jQ@mail.gmail.com>
 <CA+h21hoBp6=Zyc3mX3BVguVs0f8Un6-A3pk9YaZKPgs0efTi3g@mail.gmail.com>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <cd6f4e55-ff5b-5f64-8211-61b4d87b1f0f@cumulusnetworks.com>
Date:   Sun, 29 Mar 2020 15:02:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CA+h21hoBp6=Zyc3mX3BVguVs0f8Un6-A3pk9YaZKPgs0efTi3g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/03/2020 14:46, Vladimir Oltean wrote:
> On Sun, 29 Mar 2020 at 14:37, Vladimir Oltean <olteanv@gmail.com> wrote:
>>
>> On Sun, 29 Mar 2020 at 12:57, Ido Schimmel <idosch@idosch.org> wrote:
>>>
>>> + Nik, Roopa
>>>
>>> On Sun, Mar 29, 2020 at 02:52:02AM +0200, Vladimir Oltean wrote:
>>>> From: Vladimir Oltean <vladimir.oltean@nxp.com>
[snip]
>>> In the past I was thinking about ways to implement this in Linux. The
>>> only place in the pipeline where packets are actually classified to
>>> broadcast / unknown unicast / multicast is at bridge ingress. Therefore,
>>
>> Actually I think only 'unknown unicast' is tricky here, and indeed the
>> bridge driver is the only place in the software datapath that would
>> know that.

Yep, unknown unicast is hard to pass outside of the bridge, especially at ingress
where the bridge hasn't been hit yet. One possible solution is to expose a function
from the bridge which can make such a decision at the cost of 1 more fdb hash lookup,
but if the packet is going to hit the bridge anyway that cost won't be that high
since it will have to do the same. We already have some internal bridge functionality
exposed for netfilter, tc and some drivers so it would be in line with that.
I haven't looked into how feasible the above is, so I'm open to other ideas (the
bridge_slave functions for example, we've discussed such extensions before in other
contexts). But I think this can be much simpler if we just expose the unknown unicast
information, the mcast/bcast can be decided by the classifier already or with very
little change. I think such exposed function can be useful to netfilter as well.

>> I know very little about frame classification in the Linux network
>> stack, but would it be possible to introduce a match key in tc-flower
>> for whether packets have a known destination or not?
>>
>>> my thinking was to implement these storm control policers as a
>>> "bridge_slave" operation. It can then be offloaded to capable drivers
>>> via the switchdev framework.
>>>
>>
>> I think it would be a bit odd to duplicate tc functionality in the
>> bridge sysfs. I don't have a better suggestion though.
>>
> 
> Not to mention that for hardware like this, to have the same level of
> flexibility via a switchdev control would mean to duplicate quite a
> lot of tc functionality. On this 5-port switch I can put a shared
> broadcast policer on 2 ports (via the ingress_block functionality),
> and individual policers on the other 3, and the bandwidth budgeting is
> separate. I can only assume that there are more switches out there
> that allow this.
> 
>>> I think that if we have this implemented in the Linux bridge, then your
>>> patch can be used to support the policing of broadcast packets while
>>> returning an error if user tries to police unknown unicast or multicast
>>> packets.
>>
>> So even if the Linux bridge gains these knobs for flood policers,
>> still have the dst_mac ff:ff:ff:ff:ff:ff as a valid way to configure
>> one of those knobs?
>>
>>> Or maybe the hardware you are working with supports these types
>>> as well?
>>
>> Nope, on this hardware it's just broadcast, I just checked that. Which
>> simplifies things quite a bit.
>>
>>>
>>> WDYT?
>>>
>>
>> I don't know.
>>
>> Thanks,
>> -Vladimir
> 
> -Vladimir
> 

