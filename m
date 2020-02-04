Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21A5C2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 13:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C336A2084E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 13:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580822369;
	bh=+ABH2fTzqOSZtR7TG5JxxiRQ05wfUh8P5KjHvYUIJpg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0WDIh1dbJQ6R/kL1+rr6j+02JL3TKdJyxiBtDbab8B2pq7aGxeO8azNBWmYWPDEez
	 vY+d+foQFBmmhkXnDWKE+dYRmT1dNXpGYCXgwCeE/h02aZJGcjPiJ6Rje3BT1iSPdu
	 vX09woHOyPke0HZgT+ngIW+OCo7NQm0k7eJ7T7To=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbgBDNT3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 08:19:29 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35788 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbgBDNT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 08:19:28 -0500
Received: by mail-lj1-f193.google.com with SMTP id q8so18583862ljb.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 05:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xR1pHXUbH21ovtfJqMza53BSt5qO6F06flkKMlxHpMw=;
        b=Tm8K2YpzToZinVn0HXYou3oVuziz9AfRjbMisfOvksoOhr0RuXwB9inffmPj1BdpMo
         7tot/nvS8z2akGnwX0LSxtjiQX/v92otkl4VrgWDfqhDiIZyXrjuyXnr3S3rwglIrH7B
         5KqXAeLADnQrNl9cCr8jsv5Q4RYE0mn6rvRWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xR1pHXUbH21ovtfJqMza53BSt5qO6F06flkKMlxHpMw=;
        b=kb9bwL92iGfLGCweWCQxU5OjUNstv+YT1D7zkLyyP0ySvgLSWzBUVaF8v/lE+ICHMB
         lfqPzBTo+Qx78GpdT+9doRVA6IHOuPX0g7W4w25rfSDGZuqk1qCGY3vZKha4cp4Hqs2P
         XDlsudUVWXXwzV3CSE6/YbeOgvbgXfV0GQD6F+8i3s8ZFj6PRAontPqsR79lI10PM98/
         x9o3kX2Am4YxczklTkL/JEWfbQhxAJMklU3qbydGNl+zd0B8zUIcvPF008iJzsf18CDi
         LgDA1PmaNuUj3OcTiJn/YpHK4lX8qwwF0AzW05ewu3sYOI/bNEzJtguMV77OdZLfEo11
         5JRA==
X-Gm-Message-State: APjAAAXueLA5J26/wp2xtUUmykUygoeLaZzekwX+RlSjiygIZdvcOtz5
        t4igotLB6+fevHoyiCwYhQj9XzhY9IdWKA==
X-Google-Smtp-Source: APXvYqwkf342/zUp8rQYRS8hUs86i670LR4zprGRvcEXGB3kQONvohKPRtFOEynnvNTwvs2/zsORqw==
X-Received: by 2002:a2e:3e10:: with SMTP id l16mr17008184lja.286.1580822363943;
        Tue, 04 Feb 2020 05:19:23 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id a9sm10671820lfk.23.2020.02.04.05.19.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2020 05:19:23 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id 9so12136746lfq.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 05:19:22 -0800 (PST)
X-Received: by 2002:ac2:43a7:: with SMTP id t7mr15077047lfl.125.1580822362223;
 Tue, 04 Feb 2020 05:19:22 -0800 (PST)
MIME-Version: 1.0
References: <20200204053155.127c3f1e@oasis.local.home> <CAHk-=wjfjO+h6bQzrTf=YCZA53Y3EDyAs3Z4gEsT7icA3u_Psw@mail.gmail.com>
 <20200204072856.0da60613@oasis.local.home>
In-Reply-To: <20200204072856.0da60613@oasis.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 4 Feb 2020 13:19:06 +0000
X-Gmail-Original-Message-ID: <CAHk-=wg2Wk9ZgVBDCBHa3-b0fSfByiRJnGA_F8snMy=3HHg_gw@mail.gmail.com>
Message-ID: <CAHk-=wg2Wk9ZgVBDCBHa3-b0fSfByiRJnGA_F8snMy=3HHg_gw@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Changes for 5.6
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 4, 2020 at 12:29 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Would this work?

Yeah, looks workable. At least this wary if you screw up your
bootconfig file somehow (or you have a kernel bug that interacts badly
with a good bootconfig file), you don't need to worry about rewriting
the initrd.

The reason _I_ care is that the initrd creation scripts tend to come
mostly pre-packaged from a distro, and editing the initrd is a big
step.

The one reaction I have is that I wonder if we should just do this the
other way around instead: instead of disabling bootconfig, have a
"enable bootconfig" model instead.

Because it strikes me that the bootconfig should be the special case
(ie "bootconfig does setup for boot-time tracing"), and that you
should explicitly say "I want you to read the extended config" on the
regular kernel command line.

So from looking at this, I do have to say that I'd have a slight
preference for simply making this be an option like
"config=bootconfig" that says "extend cmdline with the data from the
'bootconfig' file".

Would that be horribly painful for your uses?

               Linus
