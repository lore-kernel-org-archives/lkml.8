Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E771C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 12:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E76942072D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 12:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="rBNMv/m7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729613AbgGMMMs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 08:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgGMMMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 08:12:48 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E483AC061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 05:12:47 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id i3so9646504qtq.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 05:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RpYSNQC2exuWKUTSRfbzznKwmjgAwfUEWqW8RzotbS4=;
        b=rBNMv/m7LaTM5arw6QzFTxkwPH7OghzX2+1T4d0DECfS6DFMcAv1644Lu5aG+V9mCd
         PMKwN8m//5IvkMkE7befYGE5dNlHQGJ1XgOmVUFV5n1VP1FlkC+JoX7DQVbBuwjIflg0
         Xiha5OPk6LbG69HWASAzNTROcVKp7AAUVGBPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RpYSNQC2exuWKUTSRfbzznKwmjgAwfUEWqW8RzotbS4=;
        b=OGp+xJWJFiX+SYosr8B0nmmFk5XwOR6a4fAt6ksdlU5/w4gpzW38HdemImIeqWczQb
         UfrTG8hFmmA097rTtaW6E/2o3UhD/eW5R0fnkj8RQR6X8DDB3e6B4pwSxTbn7LPZUYQr
         IqpBVr2MJgQydp1BuB+zzb28f4WTeX19aAFQ55/ierT+DjjxTd57gv8rhX4Se6DGZ0HO
         DyUlMaF5X2+C4Cgv6GkefprctNYiI4CvoK879pfQqKoFwoWyc8gv8U8cwYYUhEDxVLTW
         TwSRRG8z4DL6vEXDAX0TawVYpymR18qXPim+6gdU2mi8t8cE8EmeeeZC/vnJUD6gF4AQ
         Oxgw==
X-Gm-Message-State: AOAM533oDggZNSes+wNatHHCxRR8n2EEVtpNUpgHXs0TNMHdhZk6lSGW
        lsDAcs6vA6Z3C4tORv6nNn8b+8KxYms=
X-Google-Smtp-Source: ABdhPJwx4Win/yPZB7k/hma4rHDpqXlvpi9H6cFu4C0fIA3YbzEIBjZE/+zuFQEGlEfG1eUL1EaC+w==
X-Received: by 2002:ac8:1a12:: with SMTP id v18mr85096949qtj.347.1594642366926;
        Mon, 13 Jul 2020 05:12:46 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id b8sm19823302qtg.45.2020.07.13.05.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 05:12:46 -0700 (PDT)
Date:   Mon, 13 Jul 2020 08:12:45 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        linux- stable <stable@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        lkft-triage@lists.linaro.org, Chris Down <chris@chrisdown.name>,
        Michel Lespinasse <walken@google.com>,
        Fan Yang <Fan_Yang@sjtu.edu.cn>,
        Brian Geffon <bgeffon@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>, pugaowei@gmail.com,
        Jerome Glisse <jglisse@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Hugh Dickins <hughd@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Tejun Heo <tj@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: WARNING: at mm/mremap.c:211 move_page_tables in i386
Message-ID: <20200713121245.GA3926869@google.com>
References: <CA+G9fYt+6OeibZMD0fP=O3nqFbcN3O4xcLkjq0mpQbZJ2uxB9w@mail.gmail.com>
 <CAHk-=wgRcFSnQt=T95S+1dPkyvCuVAVGQ37JDvRg41h8hRqO3Q@mail.gmail.com>
 <CA+G9fYuL=xJPLbQJVzDfXB8uNiCWdXpL=joDsnATEFCzyFh_1g@mail.gmail.com>
 <CAHk-=wgB6Ds6yqbZZmscKNuAiNR2J0Pf3a8UrbdfewYxHE7SbA@mail.gmail.com>
 <20200712215041.GA3644504@google.com>
 <CAHk-=whxP0Gj70pJN5R7Qec4qjrGr+G9Ex7FJi7=_fPcdQ2ocQ@mail.gmail.com>
 <20200713025354.GB3644504@google.com>
 <CAHk-=whmbpZN6-Q=8cDM42UmHmqzgNDucLLP4BvR1jQ73+KSgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whmbpZN6-Q=8cDM42UmHmqzgNDucLLP4BvR1jQ73+KSgw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 12, 2020 at 08:51:26PM -0700, Linus Torvalds wrote:
> > > Maybe saying "doing the pmd copies for the initial stack isn't
> > > important, so let's just note this as a special case and get rid of
> > > the WARN_ON()" might be an alternative solution.
> >
> > Personally, I feel it is better to keep the warning just so in the future we
> > can detect any bugs.
> 
> I don't disagree, the warning didn't happen to find a bug now, but it
> did fine a case we might be able to do better.
> 
> So now that I feel we understand the issue, and it's not a horrible
> problem, just a (very hard to trigger) warning, I don't think there's
> any huge hurry.
> 
> I think think I will - for now - change the WARN_ON() to
> WARN_ON_ONCE() (so that it doesn't floow the logs if somebody triggers
> this odd special case  this malisiously), and add a note about how
> this happens to the code for posterito.
> 
> And if/when you figure out a better way to fix it, we can update the note.
> 
> Ok?

Yes, that sounds great to me.

thanks,

 - Joel

