Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB158C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 16:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CF392080C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 16:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgBJQHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 11:07:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:33104 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727120AbgBJQHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 11:07:05 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 29C98ACD0;
        Mon, 10 Feb 2020 16:07:04 +0000 (UTC)
Date:   Mon, 10 Feb 2020 07:56:11 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, mcgrof@kernel.org,
        broonie@kernel.org, alex.williamson@redhat.com
Subject: Re: [PATCH -next 0/5] rbtree: optimize frequent tree walks
Message-ID: <20200210155611.lfrddnolsyzktqne@linux-p48b>
References: <20200207180305.11092-1-dave@stgolabs.net>
 <20200209174632.9c7b6ff20567853c05e5ee58@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200209174632.9c7b6ff20567853c05e5ee58@linux-foundation.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 09 Feb 2020, Andrew Morton wrote:
>Seems that all the caller sites you've converted use a fairly small
>number of rbnodes, so the additional storage shouldn't be a big
>problem.  Are there any other sites you're eyeing?  If so, do you expect
>any of those will use a significant amount of memory for the nodes?

I also thought about converting the deadline scheduler to use these,
mainly benefiting pull_dl_task() but didn't get to it and I don't expect
the extra footprint to be prohibitive.

>
>And...  are these patches really worth merging?  Complexity is added,
>but what end-user benefit can we expect?

Yes they are worth merging, imo (which of course is biased :)

I don't think there is too much added complexity overall, particularly
considering that the user conversions are rather trivial. And even for
small trees (ie 100 nodes) we still benefit in a measurable way from
these optimizations.

Thanks,
Davidlohr
