Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E83BEC35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 23:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAEFD20838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 23:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Bn2ol/VU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbgBFXee (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 18:34:34 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:19144 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgBFXed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 18:34:33 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e3ca2700000>; Thu, 06 Feb 2020 15:34:08 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Thu, 06 Feb 2020 15:34:33 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Thu, 06 Feb 2020 15:34:33 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 6 Feb
 2020 23:34:32 +0000
Subject: Re: [PATCH] mm: fix a data race in put_page()
To:     Qian Cai <cai@lca.pw>, Jan Kara <jack@suse.cz>
CC:     David Hildenbrand <david@redhat.com>, <akpm@linux-foundation.org>,
        <ira.weiny@intel.com>, <dan.j.williams@intel.com>,
        <elver@google.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20200206145501.GD26114@quack2.suse.cz>
 <D022CBB0-C8EC-4F5A-A0B0-893AA7A014AA@lca.pw>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <079c4429-8a11-154d-cf5c-473d2698d18d@nvidia.com>
Date:   Thu, 6 Feb 2020 15:34:32 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <D022CBB0-C8EC-4F5A-A0B0-893AA7A014AA@lca.pw>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1581032048; bh=NbgCRtQwz/ScWw7YmhxlSz2dIjnhpyzO4fLkgwkbp8Y=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Bn2ol/VUcsiqpFfCO9n7dT/7s3gzXDQIIm2hCC+iXL3/blWk/EbG7fElAM7PFI8Vk
         xEtBbe5EIsh3A7lnBWku9wGJXlqCEZfE8sRwOYW1gJ6Fk2i8A0pwczgX5U+9mJtsnG
         ewSCLQKl5el1Pi+780JoNPBihzPL21JP5m+wWD/6XySCIdSCM8riyLk29ivsOOp0Cl
         /JVCU0VfQhUesumQZu+n9zvKyYkrKANbJQskmO+5iZ+21SrNLS8o8pWkSqpZzeIjM8
         rfM8IOEIU7mE7iOrC+kpjQfIl8Iehr038pfh07tRHoMR6rnsHYilep6IweN+KtEJZ2
         LbJD3xb9+I0Kg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/6/20 7:23 AM, Qian Cai wrote:
> 
> 
>> On Feb 6, 2020, at 9:55 AM, Jan Kara <jack@suse.cz> wrote:
>>
>> I don't think the problem is real. The question is how to make KCSAN happy
>> in a way that doesn't silence other possibly useful things it can find and
>> also which makes it most obvious to the reader what's going on... IMHO
>> using READ_ONCE() fulfills these targets nicely - it is free
>> performance-wise in this case, it silences the checker without impacting
>> other races on page->flags, its kind of obvious we don't want the load torn
>> in this case so it makes sense to the reader (although a comment may be
>> nice).
> 
> Actually, use the data_race() macro there fulfilling the same purpose too, i.e, silence the splat here but still keep searching for other races.
> 

Yes, but both READ_ONCE() and data_race() would be saying untrue things about this code,
and that somewhat offends my sense of perfection... :)

* READ_ONCE(): this field need not be restricted to being read only once, so the
  name is immediately wrong. We're using side effects of READ_ONCE().

* data_race(): there is no race on the N bits worth of page zone number data. There
  is only a perceived race, due to tools that look at word-level granularity.

I'd propose one or both of the following:

a) Hope that Marcus has an idea to enhance KCSAN so as to support this model of
   access, and/or

b) Add a new, better-named macro to indicate what's going on. Initial bikeshed-able
   candidates:

	READ_RO_BITS()
	READ_IMMUTABLE_BITS()
	...etc...

thanks,
-- 
John Hubbard
NVIDIA
