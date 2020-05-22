Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFA3C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 22:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8780920823
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 22:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="SvLtugFE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731176AbgEVWWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 18:22:13 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:14856 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731111AbgEVWWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 18:22:10 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ec850860001>; Fri, 22 May 2020 15:21:58 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 22 May 2020 15:22:10 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 22 May 2020 15:22:10 -0700
Received: from [10.2.52.1] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 22 May
 2020 22:22:10 +0000
Subject: Re: [PATCH 0/4] mm/gup, drm/i915: refactor gup_fast, convert to
 pin_user_pages()
To:     Souptick Joarder <jrdr.linux@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Matthew Auld <matthew.auld@intel.com>,
        <intel-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20200519002124.2025955-1-jhubbard@nvidia.com>
 <CAFqt6zZTZrB=LiGQpcOtZfnr7-CL4tkLHz8eXFvxwCTcfKy4sQ@mail.gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <6391e8c2-0b3e-80c3-b59f-63d0fb96bdb4@nvidia.com>
Date:   Fri, 22 May 2020 15:22:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAFqt6zZTZrB=LiGQpcOtZfnr7-CL4tkLHz8eXFvxwCTcfKy4sQ@mail.gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1590186118; bh=O9O6+RtPM2flqTtnO+2Mzi65L6kjI2yOB1OXyUMSITs=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=SvLtugFEJ9WaldeXt+dm3SwBqigdt2J9ZvySOYhS49EDlHvnhYaJAgLAoVXqC5YKb
         bUBa8YhbnaSkbR5Y4l4bOQ3nnu1dIp0mpBdCkP/SzdXR1qYCf3zzNXYsSC2gVYVYDG
         iYC2SSqhenJXAc8846FwAX7sZx8XoXs9r31gd3LHb2erXn5A01u+azAs82iWTVnXrJ
         aA/TNc7Yd2u3tjbcIsjmovd+ui8GZ1E2HEfpl6ScuUnoZAzwX6Kn6nHc2pRl0wrCHZ
         8zYdxnJ3xNNE3XrP82KJ2NOPFJYpmUoSviJP6YoyL/Jk7iQ7wUTdXmvdiHGEE2IS+z
         lQb8mQnBoAvlA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-22 04:40, Souptick Joarder wrote:
...
>> 3) Make it easy for an upcoming patch from Souptick, which aims to
>>     convert __get_user_pages_fast() to use a gup_flags argument, instead
>>     of a bool writeable arg.  Also, if this series looks good, we can
>>     ask Souptick to change the name as well, to whatever the consensus
>>     is. My initial recommendation is: get_user_pages_fast_only(), to
>>     match the new pin_user_pages_only().
> 
> Shall I hold my changes till 5.8-rc1 , when this series will appear upstream ?

I don't really see any problem with your posting something that is based on
the latest linux-next (which has my changes now). Should be fine. And in
fact it would be nice to get that done in this round, so that the pin* and
get* APIs look the same.


thanks,
-- 
John Hubbard
NVIDIA
