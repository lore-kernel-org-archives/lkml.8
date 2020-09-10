Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2F9EC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 20:09:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B57F3221E3
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 20:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgIJUJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 16:09:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:56946 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726535AbgIJUHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 16:07:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 48C0DAC26;
        Thu, 10 Sep 2020 20:08:05 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 10 Sep 2020 22:07:48 +0200
From:   osalvador@suse.de
To:     akpm@linux-foundation.org
Cc:     naoya.horiguchi@nec.com, mhocko@kernel.org, tony.luck@intel.com,
        cai@lca.pw, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 0/5] HWpoison: further fixes and cleanups
In-Reply-To: <20200908075626.11976-1-osalvador@suse.de>
References: <20200908075626.11976-1-osalvador@suse.de>
User-Agent: Roundcube Webmail
Message-ID: <861ca491140488d42d85ec7cef76ca0a@suse.de>
X-Sender: osalvador@suse.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-08 09:56, Oscar Salvador wrote:
> The important bit of this patchset is patch#1, which is a fix to take 
> off
> HWPoison pages off a buddy freelist since it can lead us to having 
> HWPoison
> pages back in the game without no one noticing it.
> So fix it (we did that already for soft_offline_page [1]).
> 
> The other patches are clean-ups and not that important, so if anything,
> consider patch#1 for inclusion.
> 
> [1] https://patchwork.kernel.org/cover/11704083/
> 
> Thanks
> 
> Oscar Salvador (5):
>   mm,hwpoison: Take free pages off the buddy freelists
>   mm,hwpoison: Refactor madvise_inject_error
>   mm,hwpoison: Drain pcplists before bailing out for non-buddy
>     zero-refcount page
>   mm,hwpoison: Drop unneeded pcplist draining
>   mm,hwpoison: Remove stale code

Naoya, any insight?

Thanks

