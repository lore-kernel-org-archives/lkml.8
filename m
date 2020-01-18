Return-Path: <SRS0=3sb/=3H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B91C33CB1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 08:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AB4520730
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jan 2020 08:04:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="xhJ7gcm/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgARIE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jan 2020 03:04:26 -0500
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:43046 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726416AbgARIE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jan 2020 03:04:26 -0500
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 9A2472E148F;
        Sat, 18 Jan 2020 11:04:22 +0300 (MSK)
Received: from vla1-5a8b76e65344.qloud-c.yandex.net (vla1-5a8b76e65344.qloud-c.yandex.net [2a02:6b8:c0d:3183:0:640:5a8b:76e6])
        by mxbackcorp2j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id muAey6KGiP-4LvGNOBc;
        Sat, 18 Jan 2020 11:04:22 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1579334662; bh=mzWO7FgHoEWNjnX84D+nJnPHJUiMjBrNmWaYiTUOznQ=;
        h=In-Reply-To:Message-ID:From:Date:References:To:Subject:Cc;
        b=xhJ7gcm/zTBF4pqWS7rYnpQ9OsFdcJLAvjSeA8/y0X82qjgtgAcm2x5NzojkeOncz
         iQIlnHOrqX7YiTvmP5dgwq+PPDIat9Zkbay5QToMIziLIlm4DhEEpeIAepwy5JTBl3
         HBDb81nhL8Ctltx3If2S0cpUP3dXoujMzPd9+zqY=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from unknown (unknown [2a02:6b8:b080:8305::1:9])
        by vla1-5a8b76e65344.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id BhMT5Z59Wh-4LWipmcK;
        Sat, 18 Jan 2020 11:04:21 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: [PATCH v2 1/2] mm/rmap: fix and simplify reusing mergeable
 anon_vma as parent when fork
To:     Wei Yang <richardw.yang@linux.intel.com>,
        Li Xinhai <lixinhai.lxh@gmail.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        akpm <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rik van Riel <riel@redhat.com>,
        "kirill.shutemov" <kirill.shutemov@linux.intel.com>
References: <b8269278-85b5-9fd2-9bce-6defffcad6e8@yandex-team.ru>
 <20200110023029.GB16823@richard> <20200110112357351531132@gmail.com>
 <20200110053442.GA27846@richard>
 <d89587b7-f59f-3897-968b-969b946a9e8a@yandex-team.ru>
 <20200111223820.GA15506@richard>
 <a6a7bb3b-434e-277c-694f-d5a18e629d2c@yandex-team.ru>
 <20200113003343.GA27210@richard>
 <1cf002fa-a3cb-bcef-57dc-ac9c09dcf2eb@yandex-team.ru>
 <2020011422424965556826@gmail.com> <20200115012055.GC4916@richard>
From:   Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Message-ID: <8f335403-4a14-bd17-39da-6299dd962fc6@yandex-team.ru>
Date:   Sat, 18 Jan 2020 11:04:21 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200115012055.GC4916@richard>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/01/2020 04.20, Wei Yang wrote:
> On Tue, Jan 14, 2020 at 10:42:52PM +0800, Li Xinhai wrote:
>> On 2020-01-13 at 19:07 Konstantin Khlebnikov wrote:
>>
>>>
>>> Because I want to keep both heuristics.
>>> This seems most sane way of interaction between them.
>>>
>>> Unfortunately even this patch is slightly broken.
>>> Condition prev->anon_vma->parent == pvma->anon_vma doesn't guarantee that
>>> prev vma has the same set of anon-vmas like current vma.
>>> I.e. anon_vma_clone(vma, prev) might be not enough for keeping connectivity.
>>
>> New patch is required?
> 
> My suggestion is separate the fix and new approach instead of mess them into
> one patch.

Yep, it's messy. Maybe it's could be better to revert recent change,
apply second patch from this set and write something new after that.

> 
>> It is necessary to call anon_vma_clone(vma, pvma) to link all anon_vma which
>> currently linked by pvma, then link the prev->anon_vma to vma. By this way,
>> connectivity of vma should be maintained, right?
>>
>>> Building such case isn't trivial job but I see nothing that could prevent it.
>>>
>>
> 
