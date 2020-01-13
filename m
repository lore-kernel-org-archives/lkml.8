Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 492BCC33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 11:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F13207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 11:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728695AbgAMLQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 06:16:49 -0500
Received: from foss.arm.com ([217.140.110.172]:37900 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbgAMLQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 06:16:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2FCCB13D5;
        Mon, 13 Jan 2020 03:16:48 -0800 (PST)
Received: from [10.1.194.46] (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4755C3F6C4;
        Mon, 13 Jan 2020 03:16:47 -0800 (PST)
Subject: Re: [PATCH] cpu-topology: warn if NUMA configurations conflicts with
 lower layer
To:     "Zengtao (B)" <prime.zeng@hisilicon.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Linuxarm <linuxarm@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1577088979-8545-1-git-send-email-prime.zeng@hisilicon.com>
 <20191231164051.GA4864@bogus>
 <678F3D1BB717D949B966B68EAEB446ED340AE1D3@dggemm526-mbx.china.huawei.com>
 <20200102112955.GC4864@bogus>
 <678F3D1BB717D949B966B68EAEB446ED340AEB67@dggemm526-mbx.china.huawei.com>
 <c43342d0-7e4d-3be0-0fe1-8d802b0d7065@arm.com>
 <678F3D1BB717D949B966B68EAEB446ED340AFCA0@dggemm526-mbx.china.huawei.com>
 <20200103114011.GB19390@bogus>
 <678F3D1BB717D949B966B68EAEB446ED340B31E9@dggemm526-mbx.china.huawei.com>
 <20200109104306.GA10914@e105550-lin.cambridge.arm.com>
 <678F3D1BB717D949B966B68EAEB446ED340BEDD6@dggemm526-mbx.china.huawei.com>
 <1a8f7963-97e9-62cc-12d2-39f816dfaf67@arm.com>
 <678F3D1BB717D949B966B68EAEB446ED340E2592@DGGEMM506-MBX.china.huawei.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <15050bf2-99ec-e604-ab95-827ce86fd693@arm.com>
Date:   Mon, 13 Jan 2020 11:16:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <678F3D1BB717D949B966B68EAEB446ED340E2592@DGGEMM506-MBX.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/2020 06:51, Zengtao (B) wrote:
> I have tried both, this previous one don't work. But this one seems work
> correctly with the warning message printout as expected.
> 

Thanks for trying it out.

> This patch is based on the fact " non-NUMA spans shouldn't overlap ", I am
> not quite sure if this is always true? 
> 

I think this is required for get_group() to work properly. Otherwise,
successive get_group() calls may override (and break) the sd->groups
linking as you initially reported.

In your example, for MC level we have

  tl->mask(3) == 3-7
  tl->mask(4) == 4-7

Which partially overlaps, causing the relinking of '7->3' to '7->4'. Valid
configurations would be

  wholly disjoint:
  tl->mask(3) == 0-3
  tl->maks(4) == 4-7

  equal:
  tl->mask(3) == 3-7
  tl->mask(4) == 3-7

> Anyway, Could you help to raise the new patch?
> 

Ideally I'd like to be able to reproduce this locally first (TBH I'd like
to get my first suggestion to work since it's less intrusive). Could you
share how you were able to trigger this? Dietmar's been trying to reproduce
this with qemu but I don't think he's there just yet.

> Thanks
> Zengtao
> 
>>
>>> Thanks
>>> Zengtao
>>>
>>>>
>>>> Morten
