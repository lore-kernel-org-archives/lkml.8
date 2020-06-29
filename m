Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7FEC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B641F206F1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:21:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732037AbgF2TVX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:21:23 -0400
Received: from outbound-smtp04.blacknight.com ([81.17.249.35]:53108 "EHLO
        outbound-smtp04.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729572AbgF2TUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:20:54 -0400
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp04.blacknight.com (Postfix) with ESMTPS id 5562EBEB4F
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 15:32:19 +0100 (IST)
Received: (qmail 4532 invoked from network); 29 Jun 2020 14:32:19 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.18.5])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 29 Jun 2020 14:32:19 -0000
Date:   Mon, 29 Jun 2020 15:32:17 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Maxim Levitsky <mlevitsk@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Commit 'fs: Do not check if there is a fsnotify watcher on
 pseudo inodes' breaks chromium here
Message-ID: <20200629143217.GZ3183@techsingularity.net>
References: <7b4aa1e985007c6d582fffe5e8435f8153e28e0f.camel@redhat.com>
 <CAOQ4uxg8E-im=B6L0PQNaTTKdtxVAO=MSJki7kxq875ME4hOLw@mail.gmail.com>
 <20200629130915.GF26507@quack2.suse.cz>
 <CAOQ4uxhdOMbn9vL_PAGKLtriVzkjwBkuEgbdB5+uH2ZM6uA97w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAOQ4uxhdOMbn9vL_PAGKLtriVzkjwBkuEgbdB5+uH2ZM6uA97w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 05:05:38PM +0300, Amir Goldstein wrote:
> > > The motivation for the patch "fs: Do not check if there is a fsnotify
> > > watcher on pseudo inodes"
> > > was performance, but actually, FS_CLOSE and FS_OPEN events probably do
> > > not impact performance as FS_MODIFY and FS_ACCESS.
> >
> > Correct.
> >
> > > Do you agree that dropping FS_MODIFY/FS_ACCESS events for FMODE_STREAM
> > > files as a general rule should be safe?
> >
> > Hum, so your patch drops FS_MODIFY/FS_ACCESS events also for named pipes
> > compared to the original patch AFAIU and for those fsnotify works fine
> > so far. So I'm not sure we won't regress someone else with this.
> >
> > I've also tested inotify on a sample pipe like: cat /dev/stdin | tee
> > and watched /proc/<tee pid>/fd/0 and it actually generated IN_MODIFY |
> > IN_ACCESS when data arrived to a pipe and tee(1) read it and then
> > IN_CLOSE_WRITE | IN_CLOSE_NOWRITE when the pipe got closed (I thought you
> > mentioned modify and access events didn't get properly generated?).
> 
> I don't think that I did (did I?)
> 

I didn't see them properly generated for fanotify_mark but that could
have been a failure. inotify-watch is able to generate the events.

> >
> > So as much as I agree that some fsnotify events on FMODE_STREAM files are
> > dubious, they could get used (possibly accidentally) and so after this
> > Chromium experience I think we just have to revert the change and live with
> > generating notification events for pipes to avoid userspace regressions.
> >
> > Thoughts?
> 
> I am fine with that.
> 
> Before I thought of trying out FMODE_STREAM I was considering to propose
> to set the new flag FMODE_NOIONOTIFY in alloc_file_pseudo() to narrow Mel's
> patch to dropping FS_MODIFY|FS_ACCESS.
> 
> But I guess the burden of proof is back on Mel.
> And besides, quoting Mel's patch:
> "A patch is pending that reduces, but does not eliminate, the overhead of
>     fsnotify but for files that cannot be looked up via a path, even that
>     small overhead is unnecessary"
> 
> So really, we are not even sacrificing much by reverting this patch.
> We down to "nano optimizations".
> 

It's too marginal to be worth the risk. A plain revert is safest when
multiple people are hitting this.

-- 
Mel Gorman
SUSE Labs
