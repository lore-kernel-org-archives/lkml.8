Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B4F4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 14:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 547732076E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 14:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="OW4kOZ2C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbgHSOXq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 10:23:46 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:1500 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgHSOXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 10:23:45 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f3d357e0000>; Wed, 19 Aug 2020 07:21:50 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 19 Aug 2020 07:23:43 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 19 Aug 2020 07:23:43 -0700
Received: from [10.21.180.149] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 19 Aug
 2020 14:23:31 +0000
Subject: Re: [PATCH net-next RFC v2 01/13] devlink: Add reload action option
 to devlink reload command
To:     Jiri Pirko <jiri@resnulli.us>
CC:     Jakub Kicinski <kuba@kernel.org>,
        Moshe Shemesh <moshe@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jiri Pirko <jiri@mellanox.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1597657072-3130-1-git-send-email-moshe@mellanox.com>
 <1597657072-3130-2-git-send-email-moshe@mellanox.com>
 <20200817163612.GA2627@nanopsycho>
 <3ed1115e-8b44-b398-55f2-cee94ef426fd@nvidia.com>
 <20200818171010.11e4b615@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <cd0e3d7e-4746-d26d-dd0c-eb36c9c8a10f@nvidia.com>
 <20200819124616.GA2314@nanopsycho.orion>
From:   Moshe Shemesh <moshe@nvidia.com>
Message-ID: <fc0d7c2f-afb5-c2e7-e44b-2ab5d21d8465@nvidia.com>
Date:   Wed, 19 Aug 2020 17:23:25 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200819124616.GA2314@nanopsycho.orion>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1597846910; bh=Qxip6IT3STJSq18HFrrNhwWzo+CK4/CnLK+xpBZUlsY=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:Content-Type:
         Content-Transfer-Encoding:Content-Language:X-Originating-IP:
         X-ClientProxiedBy;
        b=OW4kOZ2CANioSggdqHSSYoaHXOSeLPTyoPOFf5PTx1Nb/XTTnvu1n/5XfLfPIaEAe
         Zg9tYzmZ/WNMUHauEpRKpyFL7er6a1Z4E8XNOeF7GGkvrHNUXUpftJ9LRCReAGbrvB
         g/NTYR+1ApCr8yvINOfr1PBGyhAAIrsWhwbKgQEzdRvAvVZKhA9eKgsnIMI+0Ht7ug
         k+EYQAiFV6q6aGYxQeICtz7RfCm892pYzZYdD4n7QjEeRHm5DIVLpvu9T16m62VH5i
         f9cbwipvzfqdYxDYZ1UehK640ZYdtF7QK7LNI0usJCh+eHOhcPo7zwE8jc1Ng4GAQd
         S+g1CHCEFBmOA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/19/2020 3:46 PM, Jiri Pirko wrote:
> Wed, Aug 19, 2020 at 02:18:22PM CEST, moshe@nvidia.com wrote:
>> On 8/19/2020 3:10 AM, Jakub Kicinski wrote:
>>> On Tue, 18 Aug 2020 12:10:36 +0300 Moshe Shemesh wrote:
>>>> On 8/17/2020 7:36 PM, Jiri Pirko wrote:
>>>>> Mon, Aug 17, 2020 at 11:37:40AM CEST, moshe@mellanox.com wrote:
>>>>>> Add devlink reload action to allow the user to request a specific reload
>>>>>> action. The action parameter is optional, if not specified then devlink
>>>>>> driver re-init action is used (backward compatible).
>>>>>> Note that when required to do firmware activation some drivers may need
>>>>>> to reload the driver. On the other hand some drivers may need to reset
>>>>> Sounds reasonable. I think it would be good to indicate that though. Not
>>>>> sure how...
>>>> Maybe counters on the actions done ? Actually such counters can be
>>>> useful on debug, knowing what reloads we had since driver was up.
>>> Wouldn't we need to know all types of reset of drivers may do?
>>
>> Right, we can't tell all reset types driver may have, but we can tell which
>> reload actions were done.
>>
>>> I think documenting this clearly should be sufficient.
>>>
>>> A reset counter for the _requested_ reset type (fully maintained by
>>> core), however - that may be useful. The question "why did this NIC
>>> reset itself / why did the link just flap" comes up repeatedly.
>>
>> I will add counters on which reload were done. reload_down()/up() can return
>> which actions were actually done and devlink will show counters.
> Why a counter? Just return what was done over netlink reply.


Such counters can be useful for debugging, telling which reload actions 
were done on this dev from the point it was up.

