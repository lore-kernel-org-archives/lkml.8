Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB51C11D04
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 10:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C83A52071E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 10:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="CHhJlEw/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbgBTKtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 05:49:05 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35824 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbgBTKtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 05:49:05 -0500
Received: by mail-lf1-f68.google.com with SMTP id l16so2716745lfg.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 02:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=elqBx5qccKeWXFeijHzzj4zGRQz8csEMjCt6nrBw4jQ=;
        b=CHhJlEw/vJPZsldcecLhsNr9vJBUsjd+yCmC4+PBQIAB615g+m/bmsbCm+smfp7kha
         ZzzR7qBrZKmM+Uz5iGeodwjQdkX/Ut3SXtKiQIT1eQIfRDIbtwyYtGiPfj2fDoVYOtSP
         OtZmYLVoQokm4mW7qjklFDKYsSoncHr88Q9Qo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=elqBx5qccKeWXFeijHzzj4zGRQz8csEMjCt6nrBw4jQ=;
        b=QCzGAva+w2bYlwU7ICp2hi7Is7wvMn9NcSxbyNZm/bqCd3Oai6J7ALtJ+xhCRpRzCQ
         C2tjFutTvIu5ItAAfeiS4xxYU+/BoXkVAnaEocIK5fqHyqSFMhhdPGJ6ZVyPgT4ZTJCF
         JNRM5EzTHQKT3s6o7iwVA5C4/RlSshbjOMFv9oAp//VtpVQOKgRHoUO6wWuUnLtLPD/c
         SGSXEWtDgKLqZmHFE331exB8zMABixqZgAzjKUaLvo7m4A57towhpf9QTJuz6OcHRX2R
         1t9lauqDNnVto1kphOEwkN6pRa4dnxs513KfnOWEEUxcjFhqopaQ8QkLVNGm7CNSKJJX
         8gUw==
X-Gm-Message-State: APjAAAXTaTpiQZv35anbIWoMgCafcMJPRxEYgCYIsZ0ZJXj8+ClLxzMj
        gIDt0PmKcuFi5H+OeA2/W/NVbw==
X-Google-Smtp-Source: APXvYqzwTiE0c0qFnS0kqXN9/jTJ63pSwZ0ewsJGx6WkU0dJzhGtkP8ca1/5onXvO0CBGVp2kmGjiQ==
X-Received: by 2002:a19:48c5:: with SMTP id v188mr16578879lfa.100.1582195741352;
        Thu, 20 Feb 2020 02:49:01 -0800 (PST)
Received: from [192.168.0.109] (84-238-136-197.ip.btc-net.bg. [84.238.136.197])
        by smtp.gmail.com with ESMTPSA id m16sm1559879ljb.47.2020.02.20.02.48.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2020 02:49:00 -0800 (PST)
Subject: Re: [RFC net-next v3 00/10] net: bridge: mrp: Add support for Media
 Redundancy Protocol (MRP)
To:     "Allan W. Nielsen" <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bridge@lists.linux-foundation.org, jiri@resnulli.us,
        ivecera@redhat.com, davem@davemloft.net, roopa@cumulusnetworks.com,
        anirudh.venkataramanan@intel.com, olteanv@gmail.com,
        andrew@lunn.ch, jeffrey.t.kirsher@intel.com,
        UNGLinuxDriver@microchip.com
References: <20200124161828.12206-1-horatiu.vultur@microchip.com>
 <20200218121811.xo3o6zzrhl5p3j2s@lx-anielsen.microsemi.net>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <3afba55f-f953-7aaa-8425-14777db1b27d@cumulusnetworks.com>
Date:   Thu, 20 Feb 2020 12:48:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200218121811.xo3o6zzrhl5p3j2s@lx-anielsen.microsemi.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/02/2020 14:18, Allan W. Nielsen wrote:
> 
> Hi All,
> 
> Its been a while since posting this serie. We got some good and very
> specific comments, but there has not been much discussion on the overall
> architecture.
> 
> Here is the list of items we have noted to be fixed in the next version:
> - The headless chicken (it keeps sending test frames if user-space
>   daemon dies)
> - Avoid loops when bringing up the network - meaning we need to let MRP
>   do its work before the br0 device is set to up, and we need to
>   preserve that state.
> - Unnessecary ifdef on the include.
> - Extend the existing mac-table flush instead of adding
>   BR_MRP_GENL_FLUSH
> - Further optimize the changes in br_handle_frame
> 
> In v1 & v2 we had the entire protocol implemented in kernel-space.
> Everybody told us this is a bad idea, and in v3 we have moved as much as
> possible to user-space, and only kept the HW offload facilites in
> kernel-space. The protocol is then implemented in user-space.
> 
> This is nice because it simplifies the code in the kernel and moves it
> to user-space where such complexity is easier to handle. The downside of
> this is that it makes the netlink interface more specific to our HW.
> 
> The way v3 is implemented, the netlink API returns an error if a given
> operation cannot be HW offloaded. If the netlink calls return Ok,
> user-space will trust that HW do the offloading as requested, if the
> netlink calls return an error, it will implement all the functionallity
> in user-space.
> 
> This works at-least in 2 scenarios: The HW we have with full MRP offload
> capabilities, and a pure SW bridge.
> 
> But we should try make sure this also works in a backwards compatible
> way with future MRP aware HW, and with existing (and future) SwitchDev
> offloaded HW. At the very least we want to make this run on Ocelot, HW
> offload the MRC role, but do the MRM in SW (as the HW is not capable of
> this).
> 
> If we use the kernel to abstract the MRP forwarding (not the entire
> protocol like we did in v1/v2, not just the HW like we did in v3) then
> we will have more flxibility to support other HW with a different set of
> offload facilities, we can most likely achieve better performance, and
> it would be a cleaner design.
> 
> This will mean, that if user-space ask for MRP frame to be generated,
> the kernel should make sure it will happen. The kernel can try to
> offload this via the switchdev API, or it can do it in kernel-space.
> 
> Again, it will mean putting back some code into kernel space, but I
> think it is worth it.
> 
> What do you think, what is the right design.
> 
> /Allan
> 
> 

In light of all the discussions and details that were explained, and as you've
noted above, I think more code should be put in kernel space at the very least
the performance/latency critical parts would benefit from being executed in the
kernel (kind of control/data-plane separation). It seems from the switchdev calls there's
a minimal state working set which define the behaviour and can be used to make
decisions (similar to STP) in the kernel, but the complex logic how to set them can be
executed in user-space meaning that maybe these hw-offload calls can have a simple SW
fallback logic based on their current values. I think it is worth considering if this can
be achieved before going to full in-kernel implementation of the state machine.
Since you intend to hw-offload it then putting in some SW fallback logic would be good
when the HW can't offload everything, what you suggest above also sounds good to me and
I think you'll have to extend mdb and the multicast code to do it, but IIRC you already
have code to do that based on previous discussions.

As was already suggested you can put the MRP options in the bridge's options and
process them from the bridge netlink code, that should simplify your code. You could
also make the port's "mrp_aware" bool into an internal port flag (use net_bridge_port's
flags field) so it can be quickly tested and in a hot cache line.

> On 24.01.2020 17:18, Horatiu Vultur wrote:
>> Media Redundancy Protocol is a data network protocol standardized by
>> International Electrotechnical Commission as IEC 62439-2. It allows rings of
>> Ethernet switches to overcome any single failure with recovery time faster than
>> STP. It is primarily used in Industrial Ethernet applications.
>>
>> Based on the previous RFC[1][2], the MRP state machine and all the
>> timers were moved to userspace. A generic netlink interface is added to
>> allow configuring the HW, and logic added to to implement the MRP
>> specific forwarding rules.
>>
>> The userspace application that is using the new netlink can be found here[3].
>>
>> The current implementation both in kernel and userspace supports only 2 roles:
>>
>>  MRM - this one is responsible to send MRP_Test and MRP_Topo frames on both
>>  ring ports. It needs to process MRP_Test to know if the ring is open or
>>  closed. This operation is desired to be offloaded to the HW because it
>>  requires to generate and process up to 4000 frames per second. Whenever it
>>  detects that the ring open it sends MRP_Topo frames to notify all MRC about
>>  changes in the topology. MRM needs also to process MRP_LinkChange frames,
>>  these frames are generated by the MRC. When the ring is open the the state
>>  of both ports is to forward frames and when the ring is closed then the
>>  secondary port is blocked.
>>
>>  MRC - this one is responsible to forward MRP frames between the ring ports.
>>  In case one of the ring ports gets a link down or up, then MRC will generate
>>  a MRP_LinkChange frames. This node should also process MRP_Topo frames and to
>>  clear its FDB when it receives this frame.
>>
>> Userspace
>>               Deamon +----------+ Client
>>                +
>>                |
>> +--------------|-----------------------------------------+
>>  Kernel        |
>>                + Netlink
>>
>>                |                              + Interrupt
>>                |                              |
>> +--------------|------------------------------|----------+
>>  HW            | Switchdev                    |
>>                +                              |
>>
>> The user interacts using the client (called 'mrp'), the client talks to the
>> deamon (called 'mrp_server'), which talks with the kernel using netlink. The
>> kernel will try to offload the requests to the HW via switchdev API. For this a
>> new generic netlink interface was added to the bridge.
>>
>> If the kernel cannot offload MRP to HW (maybe it does not have a switchdev
>> driver, or it is just not supported), then all the netlink calls will return
>> -EOPNOTSUPP. In this case the user-space deamon fallback to SW only
>> implementation.
>>
>> There are required changes to the SW bridge to be able to run the MRP. First the
>> bridge needs to initialize the netlink interface. And second it needs to know if
>> a MRP frame was received on a MRP ring port. In case it was received the SW
>> bridge should not forward the frame it needs to redirected to upper layes. In
>> case it was not received on a ring port then it just forwards it as usual.
>>
>> To be able to offload this to the HW, it was required to extend the switchdev
>> API.
>>
>> If this will be accepted then in the future the netlink interface can be
>> expended with multiple attributes which are required by different roles of the
>> MRP. Like Media Redundancy Automanager(MRA), Media Interconnect Manager(MIM) and
>> Media Interconnect Client(MIC).
>>
>> [1] https://www.spinics.net/lists/netdev/msg623647.html
>> [2] https://www.spinics.net/lists/netdev/msg624378.html
>> [3] https://github.com/microchip-ung/mrp/tree/patch-v3
>>
>> Horatiu Vultur (10):
>>  net: bridge: mrp: Expose mrp attributes.
>>  net: bridge: mrp: Expose function br_mrp_port_open
>>  net: bridge: mrp: Add MRP interface used by netlink
>>  net: bridge: mrp: Add generic netlink interface to configure MRP
>>  net: bridge: mrp: Update MRP interface to add switchdev support
>>  net: bridge: mrp: switchdev: Extend switchdev API to offload MRP
>>  net: bridge: mrp: switchdev: Implement MRP API for switchdev
>>  net: bridge: mrp: Connect MRP api with the switchev API
>>  net: bridge: mrp: Integrate MRP into the bridge
>>  net: bridge: mrp: Update Kconfig and Makefile
>>
>> include/linux/mrp_bridge.h      |  25 ++
>> include/net/switchdev.h         |  51 +++
>> include/uapi/linux/if_ether.h   |   1 +
>> include/uapi/linux/mrp_bridge.h | 118 ++++++
>> net/bridge/Kconfig              |  12 +
>> net/bridge/Makefile             |   2 +
>> net/bridge/br.c                 |  11 +
>> net/bridge/br_device.c          |   3 +
>> net/bridge/br_if.c              |   6 +
>> net/bridge/br_input.c           |  14 +
>> net/bridge/br_mrp.c             | 193 ++++++++++
>> net/bridge/br_mrp_netlink.c     | 655 ++++++++++++++++++++++++++++++++
>> net/bridge/br_mrp_switchdev.c   | 147 +++++++
>> net/bridge/br_private.h         |  14 +
>> net/bridge/br_private_mrp.h     |  58 +++
>> 15 files changed, 1310 insertions(+)
>> create mode 100644 include/linux/mrp_bridge.h
>> create mode 100644 include/uapi/linux/mrp_bridge.h
>> create mode 100644 net/bridge/br_mrp.c
>> create mode 100644 net/bridge/br_mrp_netlink.c
>> create mode 100644 net/bridge/br_mrp_switchdev.c
>> create mode 100644 net/bridge/br_private_mrp.h
>>
>> -- 
>> 2.17.1
>>
> /Allan

