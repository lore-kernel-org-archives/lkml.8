Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA49C10F26
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 08:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E9712078E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 08:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="Zi3HkAfo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387725AbgDBI3P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 04:29:15 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:33714 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728612AbgDBI3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 04:29:15 -0400
Received: from mxbackcorp1g.mail.yandex.net (mxbackcorp1g.mail.yandex.net [IPv6:2a02:6b8:0:1402::301])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id ADDEB2E1692;
        Thu,  2 Apr 2020 11:29:11 +0300 (MSK)
Received: from myt5-70c90f7d6d7d.qloud-c.yandex.net (myt5-70c90f7d6d7d.qloud-c.yandex.net [2a02:6b8:c12:3e2c:0:640:70c9:f7d])
        by mxbackcorp1g.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id tw43FK2i9g-TANSDuS2;
        Thu, 02 Apr 2020 11:29:11 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1585816151; bh=QTITW8f5XYW6rIQ9ZSQ98EK+jrBunn2smnxn8GyI6RY=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=Zi3HkAfodPmAC9xNqgsMPIYvqqjFRefkeswjrvTsr3xjttQLTO4wm58368idRJIRV
         9sGMKTkEsET6noWlntGL4hgIFJYOTNu1CdfeBL5pj4wPjbvcjNKXivHNMegXKV60TW
         vuBhPxM7Lj/i40ouNoMZnQFORXChuUXiFiZkD9fo=
Authentication-Results: mxbackcorp1g.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from unknown (unknown [2a02:6b8:b080:6404::1:b])
        by myt5-70c90f7d6d7d.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id 83JJbdCInE-T9WKljbT;
        Thu, 02 Apr 2020 11:29:10 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [PATCH -V2] /proc/PID/smaps: Add PMD migration entry parsing
To:     Michal Hocko <mhocko@kernel.org>,
        "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        =?UTF-8?B?Su+/vXLvv71tZSBHbGlzc2U=?= <jglisse@redhat.com>,
        Yang Shi <yang.shi@linux.alibaba.com>
References: <20200402020031.1611223-1-ying.huang@intel.com>
 <20200402064437.GC22681@dhcp22.suse.cz> <87zhbufjyc.fsf@yhuang-dev.intel.com>
 <20200402074411.GH22681@dhcp22.suse.cz> <87v9mifgui.fsf@yhuang-dev.intel.com>
 <20200402082142.GL22681@dhcp22.suse.cz>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <a8b089b7-75a8-327c-0418-a5209af0571b@yandex-team.ru>
Date:   Thu, 2 Apr 2020 11:29:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200402082142.GL22681@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/04/2020 11.21, Michal Hocko wrote:
> On Thu 02-04-20 16:10:29, Huang, Ying wrote:
>> Michal Hocko <mhocko@kernel.org> writes:
>>
>>> On Thu 02-04-20 15:03:23, Huang, Ying wrote:
> [...]
>>>>> Could you explain why do we need this WARN_ON? I haven't really checked
>>>>> the swap support for THP but cannot we have normal swap pmd entries?
>>>>
>>>> I have some patches to add the swap pmd entry support, but they haven't
>>>> been merged yet.
>>>>
>>>> Similar checks are for all THP migration code paths, so I follow the
>>>> same style.
>>>
>>> I haven't checked other migration code paths but what is the reason to
>>> add the warning here? Even if this shouldn't happen, smaps is perfectly
>>> fine to ignore that situation, no?
>>
>> Yes. smaps itself is perfectly fine to ignore it.  I think this is used
>> to find bugs in other code paths such as THP migration related.
> 
> Please do not add new warnings without a good an strong reasons. As a
> matter of fact there are people running with panic_on_warn and each
> warning is fatal for them. Please also note that this is a user trigable
> path and that requires even more care.
> 

But this should not happen and if it does we'll never know without debug.
VM_WARN_ON checks something only if build with CONFIG_DEBUG_VM=y.

Anybody who runs debug kernels with panic_on_warn shouldn't expect much stability =)
