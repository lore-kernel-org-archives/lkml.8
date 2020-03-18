Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB26BC5ACD7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 09:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1A4220767
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 09:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584525435;
	bh=PxOugapyiLyGM41ij3qU4It93Jbk5/RLhf0dug/PLy8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qvqjpQ7chAtvevrEHyMSMqgu5bF4aaeNayBrqVwmAUeinsva947SdYGtwpOp45HBq
	 jDpU2GP7ei7InKMT05jgV0zSqXxY/CLthyIvMHZhVEHY04TyhNg6lvqYBELlThxYpQ
	 FFYIAB2h3FXIabvlSXDSnABQDRtRzxEvLtU2C4xo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbgCRJ5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 05:57:14 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:37715 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbgCRJ5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 05:57:14 -0400
Received: by mail-wr1-f48.google.com with SMTP id w10so631428wrm.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 02:57:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GOcmbfCGsBYkxr9ElKbbF2lKiCO06vnAuf1KQJx6gnM=;
        b=X+judH+b0yjx8AzNhOcwU3Zp/ihld72xOPu9nScQ8noVWGjjMWGAqd6Wvpx7drlYic
         TZFZwzle7z0FZRrYAjf2aeSkltepaiC1BMl1fmvRBDF83q9ARiyvAceqcRKEUxuMXNdX
         G41Fj6TPgwnMtvXxIqTG8VH4HMBfHN1lHhK0rXL/qFZh4XV6wlFo8pcUZdQbPJEPN5n7
         QwGWBL8V78L+/pwoCvv75k/DgQw8HF5TkQ3EdTGdq7xOwGCgVvpgmTfXwn2LqekDCOus
         gdAKwyRMRA+xbf7AjxWpFP0bKvWcH5YOn01UG+kVR+xYJExJh2KRWWb3H4oeQYhuErUH
         /Eig==
X-Gm-Message-State: ANhLgQ2pnZxCkSsPmyoe/0GvJ85cFDvnGkjKrinlvaFmMFPxP2whB3+q
        CA8vkkn9fcDDYOmVjDh3ZcE=
X-Google-Smtp-Source: ADFU+vvBHA61twBo/iJCkAyPfb8alCOE0RxXYb3BGFv8E2BcCaIptytGe1N2yy2yIUN1EMDdUQzxpQ==
X-Received: by 2002:adf:ea42:: with SMTP id j2mr4642015wrn.3.1584525432444;
        Wed, 18 Mar 2020 02:57:12 -0700 (PDT)
Received: from localhost (ip-37-188-180-89.eurotel.cz. [37.188.180.89])
        by smtp.gmail.com with ESMTPSA id s7sm8708665wro.10.2020.03.18.02.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 02:57:11 -0700 (PDT)
Date:   Wed, 18 Mar 2020 10:57:10 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Ami Fischman <fischman@google.com>
Cc:     Robert Kolchmeyer <rkolchmeyer@google.com>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [patch] mm, oom: make a last minute check to prevent unnecessary
 memcg oom kills
Message-ID: <20200318095710.GG21362@dhcp22.suse.cz>
References: <alpine.DEB.2.21.2003101454580.142656@chino.kir.corp.google.com>
 <20200310221938.GF8447@dhcp22.suse.cz>
 <alpine.DEB.2.21.2003101547090.177273@chino.kir.corp.google.com>
 <CAJc0_fwDAKUTcYd_rga+jjDEE2BT7Tp=ViWdtiUeswVLUqC9CQ@mail.gmail.com>
 <CAHuR8a-PbmthrKYpY5-SM-MH39O39W2J1mXA48oy9nASmys0mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHuR8a-PbmthrKYpY5-SM-MH39O39W2J1mXA48oy9nASmys0mg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 17-03-20 12:00:45, Ami Fischman wrote:
> On Tue, Mar 17, 2020 at 11:26 AM Robert Kolchmeyer
> <rkolchmeyer@google.com> wrote:
> >
> > On Tue, Mar 10, 2020 at 3:54 PM David Rientjes <rientjes@google.com> wrote:
> > >
> > > Robert, could you elaborate on the user-visible effects of this issue that
> > > caused it to initially get reported?
> >
> > Ami (now cc'ed) knows more, but here is my understanding.
> 
> Robert's description of the mechanics we observed is accurate.
> 
> We discovered this regression in the oom-killer's behavior when
> attempting to upgrade our system. The fraction of the system that
> went unhealthy due to this issue was approximately equal to the
> _sum_ of all other causes of unhealth, which are many and varied,
> but each of which contribute only a small amount of
> unhealth. This issue forced a rollback to the previous kernel
> where we ~never see this behavior, returning our unhealth levels
> to the previous background levels.

Could you be more specific on the good vs. bad kernel versions? Because
I do not remember any oom changes that would affect the
time-to-check-time-to-kill race. The timing might be slightly different
in each kernel version of course.

-- 
Michal Hocko
SUSE Labs
