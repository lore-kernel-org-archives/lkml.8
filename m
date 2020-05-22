Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0257CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 02:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D170F207E8
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 02:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="TJWMmnVX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgEVC4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 22:56:17 -0400
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:8294 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727770AbgEVC4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 22:56:16 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ec73f000000>; Thu, 21 May 2020 19:54:56 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 21 May 2020 19:56:16 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 21 May 2020 19:56:16 -0700
Received: from [10.2.48.182] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 22 May
 2020 02:56:15 +0000
Subject: Re: [PATCH] mm/gup: fixup gup.c for "mm/gup: refactor and
 de-duplicate gup_fast() code"
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
References: <20200521233841.1279742-1-jhubbard@nvidia.com>
 <159011561851.32320.15372940900085926477@build.alporthouse.com>
X-Nvconfidentiality: public
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <19baba24-1f05-9497-2d23-36c2af09d080@nvidia.com>
Date:   Thu, 21 May 2020 19:56:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <159011561851.32320.15372940900085926477@build.alporthouse.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590116096; bh=ZAaG0RT29C3mMCelcOYrNPFdgL+X0u5fdvmv/XTgbkc=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=TJWMmnVXno2KwLrQrVCBptO62ixYJXrnhmGBvfspnNjIVECJQuuUtf1JeHSN6fv7P
         XwX/TlqcFZ6qoSxl/wadKFem1hPdciMiZTSzHaO8MPq6/UTnri7pGV+AQForDp/6Gp
         Xql98VL2kl7HJMdj/zhWZ4H18Mb+pTQZ3KM57Zh7dgSJVV5g0qswajsa4oLSTqUAmv
         zc/evDP3vS7BHBsJrkNzolR2q/x3MiEtqy3esU26QF5FXHmR/qj1bCBtKO+sfUtfJz
         eDnXjhUNbzvLztmlFWeBo5JQrKOUPA+JDHBf59Vnrrdx3AcmX+yFVQjh7k0UJlcipA
         8OOcXDtb3wVVQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-21 19:46, Chris Wilson wrote:
> Quoting John Hubbard (2020-05-22 00:38:41)
>> Include FOLL_FAST_ONLY in the list of flags to *not* WARN()
>> on, in internal_get_user_pages_fast().
>>
>> Cc: Chris Wilson <chris@chris-wilson.co.uk>
>> Cc: Daniel Vetter <daniel@ffwll.ch>
>> Cc: David Airlie <airlied@linux.ie>
>> Cc: Jani Nikula <jani.nikula@linux.intel.com>
>> Cc: "Joonas Lahtinen" <joonas.lahtinen@linux.intel.com>
>> Cc: Matthew Auld <matthew.auld@intel.com>
>> Cc: Matthew Wilcox <willy@infradead.org>
>> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
>> Cc: Souptick Joarder <jrdr.linux@gmail.com>
>> Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
>> ---
>>
>> Hi Andrew, Chris,
>>
>> Andrew: This is a fixup that applies to today's (20200521) linux-next.
>> In that tree, this fixes up:
>>
>> commit dfb8dfe80808 ("mm/gup: refactor and de-duplicate gup_fast() code")
>>
>> Chris: I'd like to request another CI run for the drm/i915 changes, so
>> for that, would you prefer that I post a v2 of the series [1], or
>> is it easier for you to just apply this patch here, on top of [2]?
> 
> If you post your series again with this patch included to intel-gfx, CI
> will pick it up. Or I'll do that in the morning.
> -Chris
> 

OK, perfect. I'll post a version for linux.git in a moment here.


thanks,
-- 
John Hubbard
NVIDIA
