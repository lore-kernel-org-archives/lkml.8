Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB1AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 19:17:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 562C52077D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 19:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593026265;
	bh=vdx1BidY1dD3vPoX2CtkizwrX4XdX2UNUOVuHeSPf+c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=y+XahPvqS2OPHZPNdlWfPIwEvOKEeiJ7bvusRJh+migDlfaz62INL98YPUfOAEvGx
	 l2vlujqjLMAjnOCahEDpQy38YnVmvC65sYHltfa4yxtljvsgetcxH1gfDAd4Wuixy9
	 uESuF5r3XsTIePXDxFuWlcrvr/1GHbK0lkxG22Gw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406009AbgFXTRo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 15:17:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:59374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404563AbgFXTRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 15:17:43 -0400
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1877B20702;
        Wed, 24 Jun 2020 19:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593026263;
        bh=vdx1BidY1dD3vPoX2CtkizwrX4XdX2UNUOVuHeSPf+c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uegryQSVLpTE+yWXqjp8I3Fw36AoHqwHvv6FtfmOMozFhePJY1tHBR1SaOQvRKhcL
         0yRjO+iDhRBRBYBncBvxQpyZFZX6+Xwg1biL7IqobBygQYEg5iHTZ15VAMhGeTenrZ
         F7Dog63Ek+kySLBULBo9SmHD3lJkfNqotql16CtI=
Date:   Wed, 24 Jun 2020 12:17:42 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     nao.horiguchi@gmail.com
Cc:     linux-mm@kvack.org, mhocko@kernel.org, mike.kravetz@oracle.com,
        osalvador@suse.de, tony.luck@intel.com, david@redhat.com,
        aneesh.kumar@linux.vnet.ibm.com, zeil@yandex-team.ru,
        naoya.horiguchi@nec.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/15] HWPOISON: soft offline rework
Message-Id: <20200624121742.711331a2a65633a0e16fd9e6@linux-foundation.org>
In-Reply-To: <20200624150137.7052-1-nao.horiguchi@gmail.com>
References: <20200624150137.7052-1-nao.horiguchi@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jun 2020 15:01:22 +0000 nao.horiguchi@gmail.com wrote:

> I rebased soft-offline rework patchset [1][2] onto the latest mmotm.  The
> rebasing required some non-trivial changes to adjust, but mainly that was
> straightforward.  I confirmed that the reported problem doesn't reproduce on
> compaction after soft offline.  For more precise description of the problem
> and the motivation of this patchset, please see [2].
> 
> I think that the following two patches in v2 are better to be done with
> separate work of hard-offline rework, so it's not included in this series.
> 
>   - mm,hwpoison: Take pages off the buddy when hard-offlining
>   - mm/hwpoison-inject: Rip off duplicated checks
> 
> These two are not directly related to the reported problem, so they seems
> not urgent.  And the first one breaks num_poisoned_pages counting in some
> testcases, and The second patch needs more consideration about commented point.
> 

It would be nice to have some sort of overview of the patch series in
this [0/n] email.

> [1] v1: https://lore.kernel.org/linux-mm/1541746035-13408-1-git-send-email-n-horiguchi@ah.jp.nec.com/
> [2] v2: https://lore.kernel.org/linux-mm/20191017142123.24245-1-osalvador@suse.de/

The above have such, but are they up to date?

