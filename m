Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E94B5C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 09:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB768207FF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 09:53:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbgAOJxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 04:53:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:34894 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729504AbgAOJxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 04:53:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C9B23AC2C;
        Wed, 15 Jan 2020 09:52:54 +0000 (UTC)
Date:   Wed, 15 Jan 2020 10:52:53 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Qian Cai <cai@lca.pw>
Cc:     Michal Hocko <mhocko@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        akpm@linux-foundation.org, sergey.senozhatsky.work@gmail.com,
        rostedt@goodmis.org, peterz@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm/hotplug: silence a lockdep splat with printk()
Message-ID: <20200115095253.36e5iqn77n4exj3s@pathway.suse.cz>
References: <20200114210215.GQ19428@dhcp22.suse.cz>
 <D5CC7C52-1F08-401E-BDCA-DF617909BB9D@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D5CC7C52-1F08-401E-BDCA-DF617909BB9D@lca.pw>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-01-14 16:40:49, Qian Cai wrote:
> 
> 
> > On Jan 14, 2020, at 4:02 PM, Michal Hocko <mhocko@kernel.org> wrote:
> > 
> > Yeah, that was a long discussion with a lot of lockdep false positives.
> > I believe I have made it clear that the console code shouldn't depend on
> > memory allocation because that is just too fragile. If that is not
> > possible for some reason then it has to be mentioned in the changelog.
> > I really do not want us to add kludges to the MM code just because of
> > printk deficiencies unless that is absolutely inevitable.
> 
> I don’t know how to convince you, but both random number generator
> and printk() maintainers agreed to get ride of printk() with
> zone->lock held as you can see in the approved commit mentioned

I neither acked nor blocked the fix in the random generator. I believe
that it was false positive. But the fix was trivial and I did not have
any better solution in the pocket.


> in this patch description because it is a whac-a-mole to fix other
> places.

This is misleading. Using printk_deferred() in
_warn_unseeded_randomness() is whack-a-mole approach as well.

The most realistic real solution is to deffer consoles into kthreads.
It is being discussed for years. There is finally an agreement
to get this upstream. But the priority is to add lockless ringbuffer
first.

I could understand that Michal is against hack in -mm code that
would just hide a false positive warning.

If you really need a solution before the console offload gets
upstream then I suggest to do something really simple. For example,
disable lockdep around the allocation in console registration code
that is proven to produce the false positive chain.

Best Regards,
Petr
