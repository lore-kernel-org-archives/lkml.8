Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AD7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 03:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 584952177B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 03:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tk+pY8fM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgHFDB6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 23:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbgHFDB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 23:01:56 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CA8C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 20:01:55 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id a24so21069964oia.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 20:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=9YbI/rdSFwpyEfSjSs1g6aqjJ6+zv9mzjZy2JFwQXTs=;
        b=tk+pY8fM91KUHu+8g+Rir5doYGblFRTWiY+fTa2RPFNWRiN8HK2SDWdHhsWg15FizX
         dNr6y7YajdIzGLKYggI3WnpvUV8j1gehn7aRqLU33w3aOymDRZBxdJbbhmPF4xSb84eU
         kH2VQ9UjRSvuBSMxhN277d1OSucC1F5y+xn7Pb6Owr6ohInKu+STbnQ90BFSZdHnckcP
         qAhtfvc2xvvs99U2BTmcdf0pIOLdNSjkyMt8RJuEtEfHva9V6Ky4xrFEoUVnY9DobWm1
         hH1f7hU5K0w1+sgcBbGFmy1pkF2Q3TjUT51tQpFIRav3bOtDJS3c0RhK5enVngSdczAr
         ml8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=9YbI/rdSFwpyEfSjSs1g6aqjJ6+zv9mzjZy2JFwQXTs=;
        b=DjZel6Zn4S2/AS+CgDQu5DqTQGUCDpCNznrAY4UNt3uzl9xOzpSJy4qNNwaIrF8dhX
         a5Dx/HN/WzygIAUoa1aMV5s3n7slnM1kw1BfEvpJJ1jGDWLgM2X0+jStQszQRH74tH3I
         8LDZGseW4s/a6CEM4Dw6Ikr43lrrSY3V/8eTo0cET/85aUSQgFMSy6nGv8UtC85ug2Uo
         Ke12fXSgYQYsDk6640ht04Dur4rL7W1cg500dzfTa9ccakWXTWyKeLlKpM4EVBY07YPW
         BSir/PpFSW4lamvBCZvE7YZi7vpYNpTsX+DPjztqklBHWn+30NfWHIn6znqnY0jcJ8OX
         Myxg==
X-Gm-Message-State: AOAM532l6YxyNMAf3T2WJ3SsIPNttmp95TyCO9XpB99HgoYPstU3kDoZ
        UW8ZjqmQ1fsEFjfUd66tlrUjjg==
X-Google-Smtp-Source: ABdhPJz5TpXwVAxYMkzas2SpFHo+j7W1c9DisqbZqdMLkRErbRcGDj6Szcb2d0fXp8AP+PatH8i2oQ==
X-Received: by 2002:aca:fd88:: with SMTP id b130mr5487086oii.40.1596682911567;
        Wed, 05 Aug 2020 20:01:51 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 102sm785844oth.3.2020.08.05.20.01.48
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 05 Aug 2020 20:01:49 -0700 (PDT)
Date:   Wed, 5 Aug 2020 20:01:33 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Roman Gushchin <guro@fb.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: vmstat: fix /proc/sys/vm/stat_refresh generating
 false warnings
In-Reply-To: <20200804004012.GA1049259@carbon.dhcp.thefacebook.com>
Message-ID: <alpine.LSU.2.11.2008051913580.8184@eggly.anvils>
References: <20200714173920.3319063-1-guro@fb.com> <alpine.LSU.2.11.2007291902340.6363@eggly.anvils> <20200730162348.GA679955@carbon.dhcp.thefacebook.com> <alpine.LSU.2.11.2007302018350.2410@eggly.anvils> <20200801011821.GA859734@carbon.dhcp.thefacebook.com>
 <alpine.LSU.2.11.2007311915130.9716@eggly.anvils> <20200804004012.GA1049259@carbon.dhcp.thefacebook.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Aug 2020, Roman Gushchin wrote:
> On Fri, Jul 31, 2020 at 07:17:05PM -0700, Hugh Dickins wrote:
> > On Fri, 31 Jul 2020, Roman Gushchin wrote:
> > > On Thu, Jul 30, 2020 at 09:06:55PM -0700, Hugh Dickins wrote:
> > > > 
> > > > Though another alternative did occur to me overnight: we could
> > > > scrap the logged warning, and show "nr_whatever -53" as output
> > > > from /proc/sys/vm/stat_refresh: that too would be acceptable
> > > > to me, and you redirect to /dev/null.
> > > 
> > > It sounds like a good idea to me. Do you want me to prepare a patch?
> > 
> > Yes, if you like that one best, please do prepare a patch - thanks!
> 
> Hi Hugh,
> 
> I mastered a patch (attached below), but honestly I can't say I like it.
> The resulting interface is confusing: we don't generally use sysctls to
> print debug data and/or warnings.

Since you confessed to not liking it yourself, I paid it very little
attention.  Yes, when I made that suggestion, I wasn't really thinking
of how stat_refresh is a /proc/sys/vm sysctl thing; and I'm not at all
sure how issuing output from a /proc file intended for input works out
(perhaps there are plenty of good examples, and you followed one, but
it smells fishy to me now).

> 
> I thought about treating a write to this sysctls as setting the threshold,
> so that "echo 0 > /proc/sys/vm/stat_refresh" would warn on all negative
> entries, and "cat /proc/sys/vm/stat_refresh" would use the default threshold
> as in my patch. But this breaks  to some extent the current ABI, as passing
> an incorrect value will result in -EINVAL instead of passing (as now).

I expect we could handle that well enough, by more lenient validation
of the input; though my comment above on output versus input sheds doubt.

> 
> Overall I still think we shouldn't warn on any values inside the possible
> range, as it's not an indication of any kind of error. The only reason
> why we see some values going negative and some not, is that some of them
> are updated more frequently than others, and some are bouncing around
> zero, while other can't reach zero too easily (like the number of free pages).

We continue to disagree on that (and it amuses me that you who are so
sure they can be ignored, cannot ignore them; whereas I who am so curious
to investigate them, have not actually found the time to do so in years).
It was looking as if nothing could satisfy us both, but...

> 
> Actually, if someone wants to ensure that numbers are accurate,
> we have to temporarily set the threshold to 0, then flush the percpu data
> and only then check atomics. In the current design flushing percpu data
> matters for only slowly updated counters, as all others will run away while
> we're waiting for the flush. So if we're targeting some slowly updating
> counters, maybe we should warn only on them being negative, Idk.

I was going to look into that angle, though it would probably add a little
unjustifiable overhead to fast paths, and be rejected on that basis.

But in going to do so, came up against an earlier comment of yours, of
which I had misunderstood the significance. I had said and you replied:

> > nr_zone_write_pending: yes, I've looked at our machines, and see that
> > showing up for us too (-49 was the worst I saw).  Not at all common,
> > but seen.  And not followed by increasingly worse numbers, so a state
> > that corrects itself.  nr_dirty too (fewer instances, bigger numbers);
> > but never nr_writeback, which you'd expect to go along with those.
> 
> NR_DIRTY and NR_WRITEBACK are node counters, so we don't check them?

Wow. Now I see what you were pointing out: when v4.8's 75ef71840539
("mm, vmstat: add infrastructure for per-node vmstats") went in, it
missed updating vmstat_refresh() to check all the NR_VM_NODE_STAT items.

And I've never noticed, and have interpreted its silence on those items
as meaning they're all good (and the nr_dirty ones I mentioned above,
must have been from residual old kernels, hence the fewer instances).
I see the particularly tricky NR_ISOLATED ones are in that category.
Maybe they are all good, but I have been mistaken.

I shall certainly want to reintroduce those stats to checking for
negatives, even if it's in a patch that never earns your approval,
and just ends up kept internal for debugging.  But equally certainly,
I must not suddenly reintroduce that checking without gaining some
experience of it (and perhaps getting as irritated as you by more
transient negatives).

I said earlier that I'd prefer you to rip out all that checking for
negatives, rather than retaining it with the uselessly over-generous
125 * nr_cpus leeway.  Please, Roman, would you send Andrew a patch
doing that, to replace the patch in this thread?  Or if you prefer,
I can do so.

Thanks,
Hugh
