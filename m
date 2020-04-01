Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35EDEC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 15:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0540E2137B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 15:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585755507;
	bh=JY2tia3QTbcpPhzJVXSZeQLMXu9NqEKkkJz+HlA2Qeg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=ZpGUMz1AhEunOHpi8Li9Nc2lZftZZL6MgP7PBj3Efvz6hhPjwwuv8jBooRzzCYgkp
	 7BrxLT5nF+hlqi6Y8whfYkQjH5VRFQOpNyh5jTVEZhvfD+Q8Mwq36t5rSiJ9DxVXGm
	 OySNFBqwDf+CcW+jb613qYoBmnNQkt6UzhDfXVEM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733005AbgDAPi0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 11:38:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:58986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732789AbgDAPiZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 11:38:25 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D47AA20CC7;
        Wed,  1 Apr 2020 15:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585755504;
        bh=JY2tia3QTbcpPhzJVXSZeQLMXu9NqEKkkJz+HlA2Qeg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=etY4MTJchQkys0FTpGM43fY7tc5bu8tvTwdDl5PLjFd400uw69SG+aBNAABBGVNjA
         5GcekwAa0sHV5AUTdOXMq1+qcXGZ11v7vP+NbeCP6WRdaDd/7ql+F3vx1DSvhCu0cQ
         eJjghtByaGBJIX+1oFic1eiavQ1fKiQoip3RGHY4=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A550835227CD; Wed,  1 Apr 2020 08:38:24 -0700 (PDT)
Date:   Wed, 1 Apr 2020 08:38:24 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, dvyukov@google.com,
        glider@google.com, andreyknvl@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        apw@canonical.com, Will Deacon <will@kernel.org>
Subject: Re: [PATCH] checkpatch: Warn about data_race() without comment
Message-ID: <20200401153824.GX19865@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200401101714.44781-1-elver@google.com>
 <9de4fb8fa1223fc61d6d8d8c41066eea3963c12e.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9de4fb8fa1223fc61d6d8d8c41066eea3963c12e.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 01, 2020 at 08:17:52AM -0700, Joe Perches wrote:
> On Wed, 2020-04-01 at 12:17 +0200, Marco Elver wrote:
> > Warn about applications of data_race() without a comment, to encourage
> > documenting the reasoning behind why it was deemed safe.
> []
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > @@ -5833,6 +5833,14 @@ sub process {
> >  			}
> >  		}
> >  
> > +# check for data_race without a comment.
> > +		if ($line =~ /\bdata_race\s*\(/) {
> > +			if (!ctx_has_comment($first_line, $linenr)) {
> > +				WARN("DATA_RACE",
> > +				     "data_race without comment\n" . $herecurr);
> > +			}
> > +		}
> > +
> >  # check for smp_read_barrier_depends and read_barrier_depends
> >  		if (!$file && $line =~ /\b(smp_|)read_barrier_depends\s*\(/) {
> >  			WARN("READ_BARRIER_DEPENDS",
> 
> Sensible enough but it looks like ctx_has_comment should
> be updated to allow c99 comments too, but that should be
> a separate change from this patch.
> 
> Otherwise, this style emits a message:
> 
> WARNING: data_race without comment
> #135: FILE: kernel/rcu/tasks.h:135:
> +	int i = data_race(rtp->gp_state); // Let KCSAN detect update races
> 

Yes, please!

							Thanx, Paul
