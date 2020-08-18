Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F4AC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 09:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15521206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 09:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="jMyex0Y7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgHRJKw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 05:10:52 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:13968 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgHRJKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 05:10:51 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f3b9ae10000>; Tue, 18 Aug 2020 02:09:53 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 18 Aug 2020 02:10:51 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 18 Aug 2020 02:10:51 -0700
Received: from [10.21.180.203] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 18 Aug
 2020 09:10:40 +0000
Subject: Re: [PATCH net-next RFC v2 01/13] devlink: Add reload action option
 to devlink reload command
To:     Jiri Pirko <jiri@resnulli.us>, Moshe Shemesh <moshe@mellanox.com>
CC:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jiri Pirko <jiri@mellanox.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1597657072-3130-1-git-send-email-moshe@mellanox.com>
 <1597657072-3130-2-git-send-email-moshe@mellanox.com>
 <20200817163612.GA2627@nanopsycho>
From:   Moshe Shemesh <moshe@nvidia.com>
Message-ID: <3ed1115e-8b44-b398-55f2-cee94ef426fd@nvidia.com>
Date:   Tue, 18 Aug 2020 12:10:36 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200817163612.GA2627@nanopsycho>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1597741793; bh=KpcCA1ZEvoZ2dw2EhhZA8Hor+WKkCjTOyzDjT4/nqFc=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:Content-Type:
         Content-Transfer-Encoding:Content-Language:X-Originating-IP:
         X-ClientProxiedBy;
        b=jMyex0Y7h+2Z0BjdTUxln7lQiokb2clNBETbcQHDNQINBfOG1IJRYjM7wz70ElRIn
         l0niJUKaAXZtR//1HkbZGgdOh4ehKogiqrCKrTE2zOjInz65nN65pBXem4iYwh6HsR
         YfHCxYAa6HVL+Vmz4e/MOtN1hknnaq0ys7W7QQ9XBWQIV+p8VFb7y7An5tCr4NLkKi
         2+wMslO+8EHKfAv0a2z7YP1H/UxobmmXd9Df8P1NhYeqC0gUKRgdp9TbLA7Bf7XYG2
         M4FX3yxxsH1dP6tjrYIjtPrhCI/Lmib/lInCnjAx4bF+c6vGsybQH86A3Iz3SXQNqW
         kbmBhyRNQWtOA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/17/2020 7:36 PM, Jiri Pirko wrote:
> Mon, Aug 17, 2020 at 11:37:40AM CEST, moshe@mellanox.com wrote:
>> Add devlink reload action to allow the user to request a specific reload
>> action. The action parameter is optional, if not specified then devlink
>> driver re-init action is used (backward compatible).
>> Note that when required to do firmware activation some drivers may need
>> to reload the driver. On the other hand some drivers may need to reset
> Sounds reasonable. I think it would be good to indicate that though. Not
> sure how...


Maybe counters on the actions done ? Actually such counters can be 
useful on debug, knowing what reloads we had since driver was up.

>
>> the firmware to reinitialize the driver entities.
>> Reload actions supported are:
>> driver_reinit: driver entities re-initialization, applying devlink-param
>>                and devlink-resource values.
>> fw_activate: firmware activate.
>> fw_live_patch: firmware live patching.
>>
