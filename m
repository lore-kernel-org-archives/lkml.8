Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62DE5C35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 23:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35DD520730
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 23:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="mtUcIQa5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726838AbgBFXgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 18:36:39 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:19247 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgBFXgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 18:36:39 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e3ca2ed0001>; Thu, 06 Feb 2020 15:36:13 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 06 Feb 2020 15:36:38 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 06 Feb 2020 15:36:38 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 6 Feb
 2020 23:36:38 +0000
Subject: Re: [PATCH] mm: fix a data race in put_page()
From:   John Hubbard <jhubbard@nvidia.com>
To:     Qian Cai <cai@lca.pw>, Jan Kara <jack@suse.cz>
CC:     David Hildenbrand <david@redhat.com>, <akpm@linux-foundation.org>,
        <ira.weiny@intel.com>, <dan.j.williams@intel.com>,
        <elver@google.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Marco Elver <elver@google.com>
References: <20200206145501.GD26114@quack2.suse.cz>
 <D022CBB0-C8EC-4F5A-A0B0-893AA7A014AA@lca.pw>
 <079c4429-8a11-154d-cf5c-473d2698d18d@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <1978a849-1db9-2d8a-d494-978eadc7d999@nvidia.com>
Date:   Thu, 6 Feb 2020 15:36:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <079c4429-8a11-154d-cf5c-473d2698d18d@nvidia.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1581032173; bh=QfvWhgIyJ16nW5czUmXs6GNFz2v/B+IzL+b/xu15Az4=;
        h=X-PGP-Universal:Subject:From:To:CC:References:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=mtUcIQa5HqcEJuyfO/kq4QLOD2SkmY/1PmuqRULzeQlJCYFWLYDlVR6YRVI/MXgGU
         ffhlajXj1n3CU25R7p7eeCF6gyGCKOU5C76gaUuf6Y0SUjL7R0pUdY4t+zkjq+kSL/
         9pVi+V2kQwNChMx26YAkGddURZb5qdySj7ChUkJTX5pRN5kW9wWniCAediOEWk/TAc
         dO1I9s4+Yr6HaxD8A/gzSt1mgM0C2qrJEH79WzTZilqEalUhvLHXpuJi+qLUKmlWjU
         VMeDH13tL9c23FVB9tptlIf1clceOaHmr8H9TpSRRZlmeUl1L36yZCbSgNmtiBmNrZ
         6hJg8aJl7zupg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/6/20 3:34 PM, John Hubbard wrote:
> On 2/6/20 7:23 AM, Qian Cai wrote:
>>
>>
>>> On Feb 6, 2020, at 9:55 AM, Jan Kara <jack@suse.cz> wrote:
>>>
>>> I don't think the problem is real. The question is how to make KCSAN happy
>>> in a way that doesn't silence other possibly useful things it can find and
>>> also which makes it most obvious to the reader what's going on... IMHO
>>> using READ_ONCE() fulfills these targets nicely - it is free
>>> performance-wise in this case, it silences the checker without impacting
>>> other races on page->flags, its kind of obvious we don't want the load torn
>>> in this case so it makes sense to the reader (although a comment may be
>>> nice).
>>
>> Actually, use the data_race() macro there fulfilling the same purpose too, i.e, silence the splat here but still keep searching for other races.
>>
> 
> Yes, but both READ_ONCE() and data_race() would be saying untrue things about this code,
> and that somewhat offends my sense of perfection... :)
> 
> * READ_ONCE(): this field need not be restricted to being read only once, so the
>   name is immediately wrong. We're using side effects of READ_ONCE().
> 
> * data_race(): there is no race on the N bits worth of page zone number data. There
>   is only a perceived race, due to tools that look at word-level granularity.
> 
> I'd propose one or both of the following:
> 
> a) Hope that Marcus has an idea to enhance KCSAN so as to support this model of
>    access, and/or
> 


arggh, make that "Marco Elver"! Really sorry for the typo on your name. 


thanks,
-- 
John Hubbard
NVIDIA

> b) Add a new, better-named macro to indicate what's going on. Initial bikeshed-able
>    candidates:
> 
> 	READ_RO_BITS()
> 	READ_IMMUTABLE_BITS()
> 	...etc...
> 
> thanks,
> 
