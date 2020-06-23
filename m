Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9DEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 12:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F4032072E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 12:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20150623.gappssmtp.com header.i=@mojatatu-com.20150623.gappssmtp.com header.b="I1Gjq66+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732629AbgFWMRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 08:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732614AbgFWMRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 08:17:53 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD97C061755
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 05:17:52 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id j10so6548943qtq.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 05:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rnJX8R4/u0bul7jK+J0G603qpNM/gE9eTBblQOsKzWY=;
        b=I1Gjq66+zBAiX58YdWGXeVVqtkndN9vNMW3N/NugBnOkOFotrNHfQAvhHSSgF8aNr4
         uvRJ+7V4SPcgZd6i+fY+Sr4rLWpA/TPwYf7zzUAmJHaGuZOhBsbjU2MkY8t9AhvzGTJ3
         V2DJwWjYWL814+jeqAAqkG9HqBIAg4NXguiVswxQprtG6pdV4DubpiXaAYuEyTFgZ+vw
         lm2OPmXw8dwvZ0BVwZ/75brpcb4NhczvJyaPbxwFR/ro2wt7mX7AmEW3nShYi3giToiH
         Y7TXQ2uBDq9+rWkZyNeSzvG+iOUQswSnehzycdXUKJ2k9ltq6qQVhYKAK6DHDDMJIz6h
         akSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rnJX8R4/u0bul7jK+J0G603qpNM/gE9eTBblQOsKzWY=;
        b=PzboWxX6gn1k2p+JWPeuvNL5PH6lXH97HZad8p1crJjioe6V+ZyMUKmLF8K66ZY17x
         +t/0IYsNW/QBocNSfDTZZDYeHLl4aCqt1zRULBo6K0yHI7lp0Buo6/Y4TsTzaHJ57q4+
         bdVorzLb1EHGBBz2EdYB+1t03Ybkm7lKBvol5Eh0eHU6gT+Jk72pHrMUc5zzOr5vAVzG
         7oW8OUpN460HiPMFs6i4BoE9K5hvLAUuV79r/I7bBfR/s2JSnP7qyEFDwoniyLsKwjEU
         HWBGj6og0dgjJDBCqaFfSLpHSC+RYS+e6Sp+gUw/Kz0VgqEC/qU94gOVfX2GHT3MkPLe
         dDfw==
X-Gm-Message-State: AOAM530JSThK2xlsNQEGpL0GGH2zw4/zv+E6DakCBhEYEel5+n4gxitG
        e8ix9c6JRLxBHR5G9DntbMRKHg==
X-Google-Smtp-Source: ABdhPJw/o04cwm75ceLorlpG3HUxbpqG1Y1BDalbZRqu2xwFfhg/LL70R/ci3xqMynyzdv/RM08grw==
X-Received: by 2002:ac8:3129:: with SMTP id g38mr13445444qtb.92.1592914671416;
        Tue, 23 Jun 2020 05:17:51 -0700 (PDT)
Received: from [192.168.1.117] (23-233-27-60.cpe.pppoe.ca. [23.233.27.60])
        by smtp.googlemail.com with ESMTPSA id l3sm398979qtn.69.2020.06.23.05.17.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jun 2020 05:17:50 -0700 (PDT)
Subject: Re: [v1,net-next 3/4] net: qos: police action add index for tc flower
 offloading
To:     Po Liu <po.liu@nxp.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "idosch@idosch.org" <idosch@idosch.org>
Cc:     "jiri@resnulli.us" <jiri@resnulli.us>,
        "vinicius.gomes@intel.com" <vinicius.gomes@intel.com>,
        "vlad@buslov.dev" <vlad@buslov.dev>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Alexandru Marginean <alexandru.marginean@nxp.com>,
        "michael.chan@broadcom.com" <michael.chan@broadcom.com>,
        "vishal@chelsio.com" <vishal@chelsio.com>,
        "saeedm@mellanox.com" <saeedm@mellanox.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "jiri@mellanox.com" <jiri@mellanox.com>,
        "idosch@mellanox.com" <idosch@mellanox.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "UNGLinuxDriver@microchip.com" <UNGLinuxDriver@microchip.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>,
        "simon.horman@netronome.com" <simon.horman@netronome.com>,
        "pablo@netfilter.org" <pablo@netfilter.org>,
        "moshe@mellanox.com" <moshe@mellanox.com>,
        "m-karicheri2@ti.com" <m-karicheri2@ti.com>,
        "andre.guedes@linux.intel.com" <andre.guedes@linux.intel.com>,
        "stephen@networkplumber.org" <stephen@networkplumber.org>,
        Edward Cree <ecree@solarflare.com>
References: <VE1PR04MB64965F4F28439370BC53539A92940@VE1PR04MB6496.eurprd04.prod.outlook.com>
From:   Jamal Hadi Salim <jhs@mojatatu.com>
Message-ID: <a8afb955-b3c3-eabb-7f48-319220e85240@mojatatu.com>
Date:   Tue, 23 Jun 2020 08:17:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <VE1PR04MB64965F4F28439370BC53539A92940@VE1PR04MB6496.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-23 7:55 a.m., Po Liu wrote:


[..]
>> My question: Is this any different from how stats are structured?
> 
> I don't know I fully catch the question. Are you trying to get how many frames for each filter chain passing one index policing action?
> If one index police action bind to multiple tc filter(they should have differnt chain index ). All those filter should get same index police action stats value since they are sharing the same hardware entry. But I don't think this is the problem.
>

This is a good thing. What is nice is i can use the same index for
s/w and h/w (and no need for a translation/remapping).

> With index provide to device driver(map the s/w action index to a h/w table index ), user could list the police actions list by command:
> # tc actions show action police
> Shows the police action table by index.

This is also nice.

My question: Why cant you apply the same semantics for the counters?
Does your hardware have an indexed counter/stats table? If yes
then you should be able to do similar thing for counters
as you do for policer (i.e use an index and share counters across
actions). So when i say:
tc action drop index 5
and
tc action ok index 5
infact they use the same counter.


cheers,
jamal

