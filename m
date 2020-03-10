Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122CBC3F2D0
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 22:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF5CD222D9
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 22:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583878485;
	bh=HloSqHaVdLpu24DbJWrvzi8gYutv5amVll4sXduTcok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WoPcHIrUV2fH0+RYfKNhEJYZbCS/XHXrcFz9QGe9btgc2hrfBP0ox0mYpNGsu9KET
	 wt3Tn1nEiWFGitEkAyKICGnJts0wQozTCwdQdErNMP+Nw8+h+WnyAxSVDkFsD2RFkF
	 ezY0YUhozqb+NhM/3NxVzRoDDQ57+0em41ww+v8A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbgCJWOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 18:14:44 -0400
Received: from mail-pj1-f49.google.com ([209.85.216.49]:54891 "EHLO
        mail-pj1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgCJWOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 18:14:44 -0400
Received: by mail-pj1-f49.google.com with SMTP id np16so1012791pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 15:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qC8GAUuR4P3Ihh/wBkWywJtv6lirNyfGJk8EnvJshE8=;
        b=jZvVnCBeMjLVo4/ypI5WH9f5cD9fa7eRyo8ChnGZP7Dy3c4fuAfswYtWukOMt2pPlG
         nkm6sguxpkwMfvNGcU1Qy4zQqYY5SfWaD4wNcelQ1Bp9Zk5CEf4AU6vGZtS8u84BUrNR
         8cxGzN4+e3V618fVyF8mri1OxOKhkWOdPNJll5Yt+fCR/e/HX833UB1L7nbfvO1RoO5O
         +9ggd/8ngqGTlbUrgQdPpGf0Lu5XxEhbLcSX9D34glSy2kywmCkAHkrzlu8QxzUharIN
         EeyUkwy1W7f0siKUmpsWZaQ1kuJGS2qHbGNcTsqBcGsg8ndO5DyTSC2qM1DWfTlrh2lT
         Qwkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=qC8GAUuR4P3Ihh/wBkWywJtv6lirNyfGJk8EnvJshE8=;
        b=nsy80g51nHLiY94+DyIVZJgb4tGAy1YYMJlALG7GIb2FzumdV/1P0SM6mv7aSo3CAf
         88QRrCIkYIq0thU8PtQeosFkib895iRaEoKoFJ1fdsO9pksZ6TMnUNQwR0963Ycd103Q
         a3XaS3e53/k79dbgd+TVKOYy+e5coeYkeWadGZ+TmLymlLJfXt1uZkqU17Owwu/PH14t
         nqe//CBllAY7+n8Eciozzrv4dAxUuWUxMJZibbQfKqCr1OVnePMnBuDLe+AJjdGxsJQh
         LSR8lj0swECPDCQT9nbCS307aig5V8Xo7d3Y4NkfbmkJtEw0rkmXMqC6JBEo+U8ETvOi
         HpzA==
X-Gm-Message-State: ANhLgQ1mYCwlnv18JGmzFHb6ullkG/YtnhUZqm21vwHcULXdLJ6zT7C9
        0L75pCF7wVUXIAAPB14CjHE=
X-Google-Smtp-Source: ADFU+vsFhYKBd/NsJnYeB5XON8zxOKT2DjZ1OPEyMz++H2Emj/2WjXteH/gy00smlkpGZjZg2BpfGQ==
X-Received: by 2002:a17:902:db83:: with SMTP id m3mr117436pld.166.1583878483130;
        Tue, 10 Mar 2020 15:14:43 -0700 (PDT)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id o2sm42464515pfh.26.2020.03.10.15.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 15:14:41 -0700 (PDT)
Date:   Tue, 10 Mar 2020 15:14:40 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Jann Horn <jannh@google.com>
Cc:     Michal Hocko <mhocko@suse.com>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Daniel Colascione <dancol@google.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: Re: interaction of MADV_PAGEOUT with CoW anonymous mappings?
Message-ID: <20200310221440.GA72963@google.com>
References: <CAG48ez0G3JkMq61gUmyQAaCq=_TwHbi1XKzWRooxZkv08PQKuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez0G3JkMq61gUmyQAaCq=_TwHbi1XKzWRooxZkv08PQKuw@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jann,

On Tue, Mar 10, 2020 at 07:08:28PM +0100, Jann Horn wrote:
> Hi!
> 
> From looking at the source code, it looks to me as if using
> MADV_PAGEOUT on a CoW anonymous mapping will page out the page if
> possible, even if other processes still have the same page mapped. Is
> that correct?
> 
> If so, that's probably bad in environments where many processes (with
> different privileges) are forked from a single zygote process (like
> Android and Chrome), I think? If you accidentally call it on a CoW
> anonymous mapping with shared pages, you'll degrade the performance of
> other processes. And if an attacker does it intentionally, they could
> use that to aid with exploiting race conditions or weird
> microarchitectural stuff (e.g. the new https://lviattack.eu/lvi.pdf
> talks about "the assumption that attackers can provoke page faults or
> microcode assists for (arbitrary) load operations in the victim
> domain").
> 
> Should madvise_cold_or_pageout_pte_range() maybe refuse to operate on
> pages with mapcount>1, or something like that? Or does it already do
> that, and I just missed the check?

Originally, patchset had the mapcount check to filer out shared page
due to performance concern, not security stuff. However, the code
was removed because reviewer asked me "let the shared pages rely on
general LRU" because shared pages would have higher chance to be
touched compared to private pages so naturally, they will keep in
the memory. It did make sense for me.

I am not familiar with the security stuff but if it's really vulnerable
and everyone agree on that, it's easy to add mapcount check there.

Thanks.
