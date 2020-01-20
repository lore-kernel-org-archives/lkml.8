Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAB6C33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 07:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 937BC20684
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 07:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579504980;
	bh=sE0YgHR3/69NR2b6qoAvqiX5z6zce0Lt3KatTtwtWW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KmQ1utsTTSOueHPsyDAhBkOiRpWcEH38eAUGIkW3Mg78H1fryDTAGxdeHl5kRWBDj
	 ynLsXtGJeUwe1t59BceSgr8gJU4eRJYH4SWwgm2UjmGsynzAinZuqzhXq0RmYbDFdb
	 pwLOsU04lxARz4qsanR/ABysgY/eMNT9PdkND99c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgATHW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 02:22:59 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42914 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbgATHW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 02:22:59 -0500
Received: by mail-wr1-f66.google.com with SMTP id q6so28224180wro.9
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jan 2020 23:22:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XoV6O0m1pCknJULeMQsOZ3LratNUtl8Q4pIJIVCq2CQ=;
        b=DvTdshZAJbi/lGBOdwq1woVHsmt2NbhSFnb9V8oCDeIxvqDfzSpjak4KXsST02bY9u
         DxLGrGD7hPOS4YUVebApmIJr+sw0xXfUZC86BZbwBg/KDqjrV7E7tnb5C8F8VeGqmqSI
         csXh40so+jZxcEMCqnJEzu/ZDZjvM9tFfVFsMSc+Cn6iZCW44wMcjd+wOH4DaF3TuUGH
         ujA7bPaS4+Ie2t++Kcb9itrpDnefVVbI8x15Dug1o1/l4eqNl1g4ZwFBXk84eLUGjQfN
         7QEaJTm+tK4NlrX8lfdTa5wzW04C5cjj2/tK3sQJdOW+b58JR2RasX9OLinNLycQ036r
         lqaw==
X-Gm-Message-State: APjAAAW/FY7fxxgDu8/YUrNemz26vDS9FcMwUteZ72hzJ1gxszWrctk0
        G/Fxo6JF+Cg6GaNaYxnDTg9+XAc1
X-Google-Smtp-Source: APXvYqzywx/yRIN+ucM+OPGKSntfCeJSJma/U31vPXTCEzmOaR/EBCEa8L89Pjw6tvf1P8OKlGk/mw==
X-Received: by 2002:adf:fd87:: with SMTP id d7mr17305260wrr.226.1579504977148;
        Sun, 19 Jan 2020 23:22:57 -0800 (PST)
Received: from localhost (ip-37-188-138-155.eurotel.cz. [37.188.138.155])
        by smtp.gmail.com with ESMTPSA id g25sm1849534wmh.3.2020.01.19.23.22.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2020 23:22:56 -0800 (PST)
Date:   Mon, 20 Jan 2020 08:22:55 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        sergey.senozhatsky.work@gmail.com, pmladek@suse.com,
        rostedt@goodmis.org, peterz@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v5] mm/hotplug: silence a lockdep splat with
 printk()
Message-ID: <20200120072255.GB18451@dhcp22.suse.cz>
References: <5abf5440-7c1c-b9e9-9770-b89759771a44@redhat.com>
 <587CD165-FAA4-4369-9F30-CB8F9C03F062@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <587CD165-FAA4-4369-9F30-CB8F9C03F062@lca.pw>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 17-01-20 11:35:08, Qian Cai wrote:
> 
> 
> > On Jan 17, 2020, at 11:27 AM, David Hildenbrand <david@redhat.com> wrote:
> > 
> > the "int" should go onto the next line as well
> > [...]
> 
> Yes.
> 
> > apart from that looks good to me. I hope we won't have a whac-a-mole
> > with printk() (including WARN_ON() etc?) under the zone lock. This all
> > screams for a better fix.
> 
> WARN_ON() is normally not a concern. Once it happens here, we will
> figure out the reason why it happens in the first place and shut it
> off there instead.

It is very much the same concern as any other printk which might
deadlock. It is true this is WARN_ONCE so the likelyhood is much
smaller. But you know, probability is not going to help you if you are
unlucky ;)

-- 
Michal Hocko
SUSE Labs
