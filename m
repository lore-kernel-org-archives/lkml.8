Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5A1C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 22:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED661207CB
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 22:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388061AbgEWWdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 18:33:49 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:2282 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728414AbgEWWds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 18:33:48 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ec9a4c00000>; Sat, 23 May 2020 15:33:36 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sat, 23 May 2020 15:33:48 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sat, 23 May 2020 15:33:48 -0700
Received: from [10.2.58.199] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 23 May
 2020 22:33:48 +0000
Subject: Re: [PATCH v2 0/4] mm/gup, drm/i915: refactor gup_fast, convert to
 pin_user_pages()
To:     Chris Wilson <chris@chris-wilson.co.uk>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Souptick Joarder <jrdr.linux@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        <intel-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20200522051931.54191-1-jhubbard@nvidia.com>
 <159022688563.11139.3402294435382936623@build.alporthouse.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <d87cdee8-aa0f-91ca-ea86-e89c4536458f@nvidia.com>
Date:   Sat, 23 May 2020 15:33:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <159022688563.11139.3402294435382936623@build.alporthouse.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-23 02:41, Chris Wilson wrote:
> Quoting John Hubbard (2020-05-22 06:19:27)
>> The purpose of posting this series is to launch a test in the
>> intel-gfx-ci tree. (The patches have already been merged into Andrew's
>> linux-mm tree.)
>>
>> This applies to today's linux.git (note the base-commit tag at the
>> bottom).
>>
>> Changes since V1:
>>
>> * Fixed a bug in the refactoring patch: added FOLL_FAST_ONLY to the
>>    list of gup_flags *not* to WARN() on. This lead to a failure in the
>>    first intel-gfx-ci test run [1].
>>
>> [1] https://lore.kernel.org/r/159008745422.32320.5724805750977048669@build.alporthouse.com
> 
> Ran this through our CI, warn and subsequent lockup were gone. That
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
	t=1590273216; bh=oK85oUq4LCrgTs8kxvJryKE7a7GUQfAveFtGpNOU2dQ=;
	h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
	 Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
	 X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
	 Content-Transfer-Encoding;
	b=QoI4eJbYYVxcoARKgFJdRrxzB/GBPqy5yKIF46/pjR75LEiZvvAX947VBwywSMYhx
	 It8aQpMm6kMaF/rxiv0IPBf3tNGxNziWBAAhDXCyNqmvAS5s1HfdQh5ZoYbyDynKbJ
	 uF+u9JjBOYo5uTnn3IUaGPRgl/p9k6OhwRhbJ9nYreDwIF1/1pPeo97jwP2jW7AtDf
	 xDO5iJhGmwLYHPzRLilgiDdLbNhIGAP1XJ/4t/DByshidOUalduU7HxVQ9IOnysnCw
	 QcqSlpyPgx5LkJOvs63gO8n28hHJnoJ4FggNXC3D311lBWRuD7iekdP5WuvmrxUb8N
	 rZKwTpl0vJl9w==


Yea! Thanks again for these test runs. I really don't like posting
patches that I can't run-time test, but this CI system mitigates
that pretty well.


> lockup is worrying me now, but that doesn't seem to be an issue from
> this series.


I do think it's worth following up on. And it seems like it would be
very easy to repro: just hack in a forced failure at the call site of
pin_user_pages_fast_only(), and follow the breadcrumbs.


> 
> The i915 changes were simple enough, I would have computed the pin flags
> just once (since the readonly bit is static, that would be interesting
> if that was allowed to change mid gup :)
> Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
> -Chris
> 

Thanks for the review! And if lifting that check up higher in the call
stack is desired, I'm all in favor of that being done...in a separate
patch. :)

I'm trying to keep a very light touch when converting these call sites.

thanks,
-- 
John Hubbard
NVIDIA
