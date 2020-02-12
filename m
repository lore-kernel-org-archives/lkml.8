Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E140C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 23:55:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B18E206E5
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 23:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729334AbgBLXza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 18:55:30 -0500
Received: from outbound-smtp31.blacknight.com ([81.17.249.62]:52678 "EHLO
        outbound-smtp31.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727117AbgBLXza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 18:55:30 -0500
Received: from mail.blacknight.com (unknown [81.17.254.11])
        by outbound-smtp31.blacknight.com (Postfix) with ESMTPS id 15C8ED0217
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 23:55:28 +0000 (GMT)
Received: (qmail 2395 invoked from network); 12 Feb 2020 23:55:27 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 12 Feb 2020 23:55:27 -0000
Date:   Wed, 12 Feb 2020 23:55:25 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Ivan Babrou <ivan@cloudflare.com>
Cc:     linux-mm@kvack.org, linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: Reclaim regression after 1c30844d2dfe
Message-ID: <20200212235525.GU3466@techsingularity.net>
References: <CABWYdi1eOUD1DHORJxTsWPMT3BcZhz++xP1pXhT=x4SgxtgQZA@mail.gmail.com>
 <20200211101627.GJ3466@techsingularity.net>
 <CABWYdi36O_Gd6=CVZkxY6RR8r4EKzEngScngT5VZc9-x4TB=3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CABWYdi36O_Gd6=CVZkxY6RR8r4EKzEngScngT5VZc9-x4TB=3w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 02:45:39PM -0800, Ivan Babrou wrote:
> Here's a typical graph: https://imgur.com/a/n03x5yH
> 
> * Green (numa0) and blue (numa1) for 4.19
> * Yellow (numa0) and orange (numa1) for 5.4
> 
> These downward slopes on numa0 on 5.4 are somewhat typical to the
> worst case scenario.
> 
> If I try to clean up data a bit from a bunch of machines, this is how
> numa0 compares to numa1 with 1h average values of free memory above
> 5GiB:
> 
> * https://imgur.com/a/6T4rRzi
> 
> I think it's safe to say that numa0 is much much worse, but I cannot
> be 100% sure that numa1 is free from adverse effects, they may be just
> hiding in the noise caused by rolling reboots.
> 

Ok, while I expected node 0 to be worse in general, a runaway boost due
to constant fragmentation would be a problem in general. In either case,
the patch should reduce the damage. Is there any chance that the patch
can be tested or would it be disruptive for you?

-- 
Mel Gorman
SUSE Labs
