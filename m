Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDCFC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 10:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95B1C20787
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 10:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="TdT/jOYp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389778AbgEYK0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 06:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389373AbgEYK0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 06:26:49 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE38C05BD43
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 03:26:49 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id v19so9042198wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 03:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nMuvRSUb4ALiiBXH2s5u47j7uY/+82nlefji0PdsqHk=;
        b=TdT/jOYp5cN158dXnRfMmu0WeMjAVZzB0VoCOeLtiiOKgMwNFvOyrj3bPucpXG9i98
         DcQSmeXYpvdIUQ76QpOXEwjDIwVeBS2G5+anjM5hPsmCuDZia2pPpFQGsSLLTL/YzInG
         Umt6R9YimmRT5xGGQR6fRUGYY91nr/bSkGomQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nMuvRSUb4ALiiBXH2s5u47j7uY/+82nlefji0PdsqHk=;
        b=Nmc/ORddNYkz2meecHimI6VzkbNTti+RszNvqo8at89tmiFA1Q9jReAej4GpVPegMx
         FfUbOjYflOvrpxvgjlJOLLAvNHZ3sl8N0aZHeTE0UbxqTNfUJj8bIs/WO3VOZ6YgNOay
         7WUFoR11IbFPqhY3peOhIzDgprIoC1F5ONSrGZfdzmwuyvvuucI56MSzw4YBI47I2AjK
         ZWkODnTO5DBTNAGY6S8twp3jWZ/cK8D1gjGlW7TQgcMMIojHgIkd0yzcCJec+wo6FljW
         a17WOiWaIONFoukDfxKE8A3EcQNsRBzTq0nbWwGeSAwAVCb5aWOcUPaVYep0jx/1q7n2
         vhKA==
X-Gm-Message-State: AOAM533DwNxaqOzev166SiBDEfrEbSjfnzPBBkzrkcF2EmnQs/81FIA7
        3BruzAzdqLPdPaVl2Cd1kx+ZWPSRwLCQfg==
X-Google-Smtp-Source: ABdhPJxXgGSlKW88yPOhBKqcx/KenoNx/MiflMYVJdNcY2yiQq7fFumKEeTy32ISIjvc3rahbZnVuw==
X-Received: by 2002:a7b:c253:: with SMTP id b19mr25701091wmj.110.1590402407376;
        Mon, 25 May 2020 03:26:47 -0700 (PDT)
Received: from [192.168.0.109] (84-238-136-197.ip.btc-net.bg. [84.238.136.197])
        by smtp.gmail.com with ESMTPSA id 40sm17155504wrc.15.2020.05.25.03.26.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2020 03:26:46 -0700 (PDT)
Subject: Re: MRP netlink interface
To:     Michal Kubecek <mkubecek@suse.cz>, netdev@vger.kernel.org
Cc:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        roopa@cumulusnetworks.com, davem@davemloft.net, kuba@kernel.org,
        andrew@lunn.ch, UNGLinuxDriver@microchip.com,
        bridge@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20200525112827.t4nf4lamz6g4g2c5@soft-dev3.localdomain>
 <20200525100322.sjlfxhz2ztrfjia7@lion.mk-sys.cz>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <88bc4a98-c0c8-32df-142e-d4738fe0065a@cumulusnetworks.com>
Date:   Mon, 25 May 2020 13:26:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200525100322.sjlfxhz2ztrfjia7@lion.mk-sys.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/05/2020 13:03, Michal Kubecek wrote:
> On Mon, May 25, 2020 at 11:28:27AM +0000, Horatiu Vultur wrote:
> [...]
>> My first approach was to extend the 'struct br_mrp_instance' with a field that
>> contains the priority of the node. But this breaks the backwards compatibility,
>> and then every time when I need to change something, I will break the backwards
>> compatibility. Is this a way to go forward?
> 
> No, I would rather say it's an example showing why passing data
> structures as binary data via netlink is a bad idea. I definitely
> wouldn't advice this approach for any new interface. One of the
> strengths of netlink is the ability to use structured and extensible
> messages.
> 
>> Another approach is to restructure MRP netlink interface. What I was thinking to
>> keep the current attributes (IFLA_BRIDGE_MRP_INSTANCE,
>> IFLA_BRIDGE_MRP_PORT_STATE,...) but they will be nested attributes and each of
>> this attribute to contain the fields of the structures they represents.
>> For example:
>> [IFLA_AF_SPEC] = {
>>     [IFLA_BRIDGE_FLAGS]
>>     [IFLA_BRIDGE_MRP]
>>         [IFLA_BRIDGE_MRP_INSTANCE]
>>             [IFLA_BRIDGE_MRP_INSTANCE_RING_ID]
>>             [IFLA_BRIDGE_MRP_INSTANCE_P_IFINDEX]
>>             [IFLA_BRIDGE_MRP_INSTANCE_S_IFINDEX]
>>         [IFLA_BRIDGE_MRP_RING_ROLE]
>>             [IFLA_BRIDGE_MRP_RING_ROLE_RING_ID]
>>             [IFLA_BRIDGE_MRP_RING_ROLE_ROLE]
>>         ...
>> }
>> And then I can parse each field separately and then fill up the structure
>> (br_mrp_instance, br_mrp_port_role, ...) which will be used forward.
>> Then when this needs to be extended with the priority it would have the
>> following format:
>> [IFLA_AF_SPEC] = {
>>     [IFLA_BRIDGE_FLAGS]
>>     [IFLA_BRIDGE_MRP]
>>         [IFLA_BRIDGE_MRP_INSTANCE]
>>             [IFLA_BRIDGE_MRP_INSTANCE_RING_ID]
>>             [IFLA_BRIDGE_MRP_INSTANCE_P_IFINDEX]
>>             [IFLA_BRIDGE_MRP_INSTANCE_S_IFINDEX]
>>             [IFLA_BRIDGE_MRP_INSTANCE_PRIO]
>>         [IFLA_BRIDGE_MRP_RING_ROLE]
>>             [IFLA_BRIDGE_MRP_RING_ROLE_RING_ID]
>>             [IFLA_BRIDGE_MRP_RING_ROLE_ROLE]
>>         ...
>> }
>> And also the br_mrp_instance will have a field called prio.
>> So now, if the userspace is not updated to have support for setting the prio
>> then the kernel will use a default value. Then if the userspace contains a field
>> that the kernel doesn't know about, then it would just ignore it.
>> So in this way every time when the netlink interface will be extended it would
>> be backwards compatible.
> 
> Silently ignoring unrecognized attributes in userspace requests is what
> most kernel netlink based interfaces have been doing traditionally but
> it's not really a good idea. Essentially it ties your hands so that you
> can only add new attributes which can be silently ignored without doing
> any harm, otherwise you risk that kernel will do something different
> than userspace asked and userspace does not even have a way to find out
> if the feature is supported or not. (IIRC there are even some places
> where ignoring an attribute changes the nature of the request but it is
> still ignored by older kernels.)
> 
> That's why there have been an effort, mostly by Johannes Berg, to
> introduce and promote strict checking for new netlink interfaces and new
> attributes in existing netlink attributes. If you don't have strict
> checking for unknown attributes enabled yet, there isn't much that can
> be done for already released kernels but I would suggest to enable it as
> soon as possible.
> 
> Michal
> 

+1, we don't have strict checking for the bridge main af spec attributes, but
you could add that for new nested interfaces that need to be parsed like the
above







