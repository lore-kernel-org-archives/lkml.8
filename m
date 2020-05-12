Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CCFC54E8B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 07:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D07DC206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 07:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589268762;
	bh=cRquIjFAbxbjjoOK5t/QWyXeCHOgCICCWAxA3sA3yM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dDTKVLpmCp99wphahYVjMUW4ks17MkBvo29K0v1kO/NtPbHtJdFaMwtumqFi+vmkt
	 cCETN439KIIG3P8A55pyocmYbnqXnRr4Nne9MjXfhjdLKmwiXaQsPe3vLM4DYaOGCw
	 LMjRvZh7TQ9E3sXrvXmf+5GCvKo2W6tac0k/5KsU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgELHcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 03:32:41 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45887 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbgELHcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 03:32:41 -0400
Received: by mail-wr1-f66.google.com with SMTP id v12so13988648wrp.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 00:32:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rjR0xAaaRoHPNCmqXbAIef0LNkXJSTuZB54tpgVRD5I=;
        b=Isq5NxLkAHEMxxMlF/7pkzCC0Cr/my3Sq7cZk2QF8LQBl6tsFY1eXWS+c1b9mmd7J+
         bOihxLh1KDVMNydbcGc/sEUR9GwLEUZK713BYBUsw4SobbfBXxox+8UUljwTLhfA6fta
         7Bn7TVA4et+StpZFQF7lbJypcZs2p3lDrdIMu971GbjzTZv3J5+DeAg2ElXgdqEcwHYs
         GfBAZkFfXcs4+lt8mEjJFd5C30fvli0pIMQdde3lOzxirtROOPOwALexUQaS18S4ICsb
         GI/W4KrgMidf+7xheAtDz9+h0b92qMmMsQ+OJGMtha5TFmhrUvZvh+ERJcvvJ2Ob415l
         Blsw==
X-Gm-Message-State: AGi0Pub3gX2afYrHs4SfSuYXH0n1IAZXeRyvJAgS/HalXL+rRNgvwO66
        KiK6ArnUCEGwwhPLlbs5YrQ=
X-Google-Smtp-Source: APiQypLQZqtnJSFzH38WJbvuO0r2ggsc2I3KPEMHsxbCyIRP9qoAd4tmtHbEOkaztWDe6d+0TdgOvg==
X-Received: by 2002:adf:a74b:: with SMTP id e11mr21891062wrd.99.1589268758442;
        Tue, 12 May 2020 00:32:38 -0700 (PDT)
Received: from localhost (ip-37-188-140-86.eurotel.cz. [37.188.140.86])
        by smtp.gmail.com with ESMTPSA id m3sm5751648wrn.96.2020.05.12.00.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 00:32:37 -0700 (PDT)
Date:   Tue, 12 May 2020 09:32:36 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Minchan Kim <minchan@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] mm, swap: Use prandom_u32_max()
Message-ID: <20200512073236.GQ29153@dhcp22.suse.cz>
References: <20200512064147.514493-1-ying.huang@intel.com>
 <20200512065049.GN29153@dhcp22.suse.cz>
 <875zd1pqu1.fsf@yhuang-dev.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875zd1pqu1.fsf@yhuang-dev.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 12-05-20 15:14:46, Huang, Ying wrote:
> Michal Hocko <mhocko@kernel.org> writes:
> 
> > On Tue 12-05-20 14:41:46, Huang Ying wrote:
> >> To improve the code readability and get random number with higher
> >> quality.
> >
> > I understand the readability argument but why should prandom_u32_max
> > (which I was not aware of) provide a higher quality randomness?
> 
> I am not expert on random number generator.  I have heard about that the
> randomness of the low order bits of some random number generator isn't
> good enough.  Anyway, by using the common implementation, the real
> random number generator expert can fix the possible issue once for all
> users.

Please drop the quality argument if you cannot really justify it. This
will likely just confuse future readers the same way it confused me
here. Because prandom_u32_max uses the same source of randomness the
only difference is the way how modulo vs. u64 overflow arithmetic is
used for distributing values. I am not aware the later would be
a way to achieve a higher quality randomness. If the interval
distribution is better with the later then it would be great to have it
documented.

> >> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> >> Cc: Michal Hocko <mhocko@suse.com>
> >> Cc: Minchan Kim <minchan@kernel.org>
> >> Cc: Tim Chen <tim.c.chen@linux.intel.com>
> >> Cc: Hugh Dickins <hughd@google.com>
> >
> > To the change itself
> > Acked-by: Michal Hocko <mhocko@suse.com>
> 
> Thanks!
> 
> Best Regards,
> Huang, Ying
> 
> >> ---
> >>  mm/swapfile.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >> 
> >> diff --git a/mm/swapfile.c b/mm/swapfile.c
> >> index a0a123e59ce6..2ec8b21201d6 100644
> >> --- a/mm/swapfile.c
> >> +++ b/mm/swapfile.c
> >> @@ -3220,7 +3220,7 @@ SYSCALL_DEFINE2(swapon, const char __user *, specialfile, int, swap_flags)
> >>  		 * select a random position to start with to help wear leveling
> >>  		 * SSD
> >>  		 */
> >> -		p->cluster_next = 1 + (prandom_u32() % p->highest_bit);
> >> +		p->cluster_next = 1 + prandom_u32_max(p->highest_bit);
> >>  		nr_cluster = DIV_ROUND_UP(maxpages, SWAPFILE_CLUSTER);
> >>  
> >>  		cluster_info = kvcalloc(nr_cluster, sizeof(*cluster_info),
> >> -- 
> >> 2.26.2

-- 
Michal Hocko
SUSE Labs
