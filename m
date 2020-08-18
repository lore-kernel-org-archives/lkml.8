Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34EB2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 09:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13A6F206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 09:06:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="YxtEA4x1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgHRJG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 05:06:28 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:13380 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgHRJG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 05:06:26 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f3b99d80000>; Tue, 18 Aug 2020 02:05:28 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 18 Aug 2020 02:06:26 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 18 Aug 2020 02:06:26 -0700
Received: from [10.21.180.203] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Aug
 2020 09:06:16 +0000
Subject: Re: [PATCH net-next RFC v2 01/13] devlink: Add reload action option
 to devlink reload command
To:     Jakub Kicinski <kuba@kernel.org>,
        Moshe Shemesh <moshe@mellanox.com>
CC:     "David S. Miller" <davem@davemloft.net>,
        Jiri Pirko <jiri@mellanox.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1597657072-3130-1-git-send-email-moshe@mellanox.com>
 <1597657072-3130-2-git-send-email-moshe@mellanox.com>
 <20200817091615.37e76ca3@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Moshe Shemesh <moshe@nvidia.com>
Message-ID: <9fbad1d6-7052-225a-7d62-9d29548d6342@nvidia.com>
Date:   Tue, 18 Aug 2020 12:06:13 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200817091615.37e76ca3@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1597741528; bh=HttBBno2RrdfqVBFotFLEqVwUaVEe8oX4DoTjrSxv9w=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:Content-Type:
         Content-Transfer-Encoding:Content-Language:X-Originating-IP:
         X-ClientProxiedBy;
        b=YxtEA4x1mszR7M0/a+ZkzDE7cg06avnU3+2OWGw8K0hTsFeWpyAfcWoht6or+7zPs
         zm+DtdSn0Plr8R6NJe2J6+z1vUaPPnocX4Dd06PmMtj+WYZMjM7lcdMv8dNDEyscd2
         37GTGNZBw0Mb5KUWVt3Y46SNAEOvz7Cg2219UP4Uglycq8pASc7wY0WDIbCxguECcj
         Dzf9/pXUIHGsx2lRez/E9DJ+Mia0njUQ/SiZ0jxrlxdW0fPhtXA/KdJQauV6/6CCYz
         nU+o5vOlYTBWV9WnYYLQGV4Fimwv6mWCeIht5bQYKDVpZIFLm7PZHI2/HNUwLpisEE
         W0VuLCW3qRlIw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/17/2020 7:16 PM, Jakub Kicinski wrote:
>
> On Mon, 17 Aug 2020 12:37:40 +0300 Moshe Shemesh wrote:
>> Add devlink reload action to allow the user to request a specific reload
>> action. The action parameter is optional, if not specified then devlink
>> driver re-init action is used (backward compatible).
>> Note that when required to do firmware activation some drivers may need
>> to reload the driver. On the other hand some drivers may need to reset
>> the firmware to reinitialize the driver entities.
> See, this is why I wanted to keep --live as a separate option.
> Normally the driver is okay to satisfy more actions than requested,
> e.g. activate FW even if only driver_reinit was requested.
>
> fw_live_patch does not have this semantics, it explicitly requires
> driver to not impact connectivity much. No "can do more resets than
> requested" here. Hence the --live part would be better off as a
> separate argument (at least in uAPI, the in-kernel interface we can
> change later if needed).


Yes, it does have a different semantics, kind of no reset allowed.

On the other hand, it is not related to driver_reinit, only fw_activate.

So the uAPI should be:

 =C2=A0=C2=A0=C2=A0 devlink dev reload DEV [ netns { PID | NAME | ID } ] [ =
action {=20
driver_reinit | fw_activate [--live] } ]

Or maybe better than "live" say explicitly "no reset":

 =C2=A0=C2=A0=C2=A0 devlink dev reload DEV [ netns { PID | NAME | ID } ] [ =
action {=20
driver_reinit | fw_activate [--no_reset] } ]


>> Reload actions supported are:
>> driver_reinit: driver entities re-initialization, applying devlink-param
>>                 and devlink-resource values.
>> fw_activate: firmware activate.
>> fw_live_patch: firmware live patching.
