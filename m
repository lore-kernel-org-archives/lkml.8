Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD79C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 16:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE386207F7
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 16:58:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="CQ7SXN1P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729899AbgEUQ6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 12:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728565AbgEUQ6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 12:58:10 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3262CC061A0F
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 09:58:09 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id s8so7335404wrt.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 09:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5Y9QXn5/MtNpd1gpuH+YQVxBDqCPuf0vIRP+fPeT388=;
        b=CQ7SXN1PdVyxzxTn48IBDk1HDqJrKf6aZ67r0kdzGCIMp82jRV5cP4cXU2qsgf8AMR
         f0AYNpGAUQai+4PcqZ5mqW77BBJDzPWRJnwb8ORAmgyJ5eeg8et4blG30bbGrcpoxGMM
         rYvRWqpfyEztOdLirxGPacBA6cO421LA1RVow=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5Y9QXn5/MtNpd1gpuH+YQVxBDqCPuf0vIRP+fPeT388=;
        b=kc1rPBSsElb3dY0NDDS1LQ3I0umuARRjorKywF4Chf69YCTGk4TNCtwksYXkXiQrAn
         IsC6hg15CJMJY4KFPxbTUFov2JXjHR6sf0MGejfg7ZMbA9d/g76VE6miYO2G56uuAQK8
         ijqysb4Gkd1PTUsGfir4qyE4HfbRhd5kUnSOH7UQQ2xx3f5omxvvzh17envFgfckGRWB
         o3/Va48VS7yZJeUU/ja44Rrdvo9RXGwtUeoxHONjpyuiai+/1q9zXO/FP1BNAVBkeT5b
         RGHqPj3y8AgrLO/64FzyvN6RTlvAl+Gq525a/x5d9N8ILs25wnLzPXH/MEqwi7XWSWB6
         +RvA==
X-Gm-Message-State: AOAM533tPP/EpbQPZj8UTvjmYu4GlCYOQve3PbtmWo7JLtrMFbRCLRgt
        jXfsNwoj+pjVEIZxpjQ9pZX5NQ==
X-Google-Smtp-Source: ABdhPJwtTFeFA0RzSf70parteHd+eKsBzJ7WMtkTQlSR9kL4jx9EHI7evkipwvopFBuSAuWcIlqymA==
X-Received: by 2002:a5d:5389:: with SMTP id d9mr6717311wrv.77.1590080287860;
        Thu, 21 May 2020 09:58:07 -0700 (PDT)
Received: from [192.168.0.109] (84-238-136-197.ip.btc-net.bg. [84.238.136.197])
        by smtp.gmail.com with ESMTPSA id q15sm6224927wrf.87.2020.05.21.09.58.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 09:58:07 -0700 (PDT)
Subject: Re: [PATCH 1/3] bridge: mrp: Add br_mrp_unique_ifindex function
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     jiri@resnulli.us, ivecera@redhat.com, davem@davemloft.net,
        kuba@kernel.org, roopa@cumulusnetworks.com, andrew@lunn.ch,
        UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org
References: <20200520130923.3196432-1-horatiu.vultur@microchip.com>
 <20200520130923.3196432-2-horatiu.vultur@microchip.com>
 <cecbdbf0-bb49-1e3c-c163-8e7412c6fcec@cumulusnetworks.com>
 <20200521181337.ory6lxyswatqhoej@soft-dev3.localdomain>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <39ba5110-2c2a-6fd9-a3e3-000b52a366dc@cumulusnetworks.com>
Date:   Thu, 21 May 2020 19:58:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200521181337.ory6lxyswatqhoej@soft-dev3.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/05/2020 21:49, Horatiu Vultur wrote:
> The 05/21/2020 11:16, Nikolay Aleksandrov wrote:
>> On 20/05/2020 16:09, Horatiu Vultur wrote:
>>> It is not allow to have the same net bridge port part of multiple MRP
>>> rings. Therefore add a check if the port is used already in a different
>>> MRP. In that case return failure.
>>>
>>> Fixes: 9a9f26e8f7ea ("bridge: mrp: Connect MRP API with the switchdev API")
>>> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
>>> ---
>>>  net/bridge/br_mrp.c | 31 +++++++++++++++++++++++++++++++
>>>  1 file changed, 31 insertions(+)
>>>
>>> diff --git a/net/bridge/br_mrp.c b/net/bridge/br_mrp.c
>>> index d7bc09de4c139..a5a3fa59c078a 100644
>>> --- a/net/bridge/br_mrp.c
>>> +++ b/net/bridge/br_mrp.c
>>> @@ -37,6 +37,32 @@ static struct br_mrp *br_mrp_find_id(struct net_bridge *br, u32 ring_id)
>>>       return res;
>>>  }
>>>
>>> +static bool br_mrp_unique_ifindex(struct net_bridge *br, u32 ifindex)
>>> +{
>>> +     struct br_mrp *mrp;
>>> +     bool res = true;
>>> +
>>> +     rcu_read_lock();
>>
>> Why do you need the rcu_read_lock() here when lockdep_rtnl_is_held() is used?
>> You should be able to just do rtnl_dereference() below as this is used only
>> under rtnl.
> 
> Hi Nik,
> 
> Also initially I thought that is not needed, but when I enabled all the
> RCU debug configs to see if I use correctly the RCU, I got a warning
> regarding suspicious RCU usage.
> And that is the reason why I have put it.
> 

Did you try using rtnl_dereference() instead of rcu_dereference() ?

>>
>>> +     list_for_each_entry_rcu(mrp, &br->mrp_list, list,
>>> +                             lockdep_rtnl_is_held()) {
>>> +             struct net_bridge_port *p;
>>> +
>>> +             p = rcu_dereference(mrp->p_port);
>>> +             if (p && p->dev->ifindex == ifindex) {
>>> +                     res = false;
>>> +                     break;
>>> +             }
>>> +
>>> +             p = rcu_dereference(mrp->s_port);
>>> +             if (p && p->dev->ifindex == ifindex) {
>>> +                     res = false;
>>> +                     break;
>>> +             }
>>> +     }
>>> +     rcu_read_unlock();
>>> +     return res;
>>> +}
>>> +
>>>  static struct br_mrp *br_mrp_find_port(struct net_bridge *br,
>>>                                      struct net_bridge_port *p)
>>>  {
>>> @@ -255,6 +281,11 @@ int br_mrp_add(struct net_bridge *br, struct br_mrp_instance *instance)
>>>           !br_mrp_get_port(br, instance->s_ifindex))
>>>               return -EINVAL;
>>>
>>> +     /* It is not possible to have the same port part of multiple rings */
>>> +     if (!br_mrp_unique_ifindex(br, instance->p_ifindex) ||
>>> +         !br_mrp_unique_ifindex(br, instance->s_ifindex))
>>> +             return -EINVAL;
>>> +
>>>       mrp = kzalloc(sizeof(*mrp), GFP_KERNEL);
>>>       if (!mrp)
>>>               return -ENOMEM;
>>>
>>
> 

