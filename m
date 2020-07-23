Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5DEC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 08:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA3D820658
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 08:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595491440;
	bh=E8WPFKZTovr88QBvMljesDVRiCaLPjeIwdZaDfbfcx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BCPg9TPvMvSFH1G8FkHeV5Q2mO3U3S4eD7Fa0QMXtP1dPDwCrvgpcgrxFFrDjXhrc
	 rGdxFel8lekk4LzIP7epjT3f3qSc5440D+PSRz3vOxNPJHzQnZpRo7QTl3HZYj6b7C
	 Cnpn46hCHXiijTaPXJOVRi3Qs0Nc8a4ezIRj/LV4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgGWID7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 04:03:59 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:36022 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgGWID6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 04:03:58 -0400
Received: by mail-ej1-f68.google.com with SMTP id n22so5393522ejy.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 01:03:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bCs96AWK1IeU0Pi3Hq8GZsVghkdCcCGSOQ2rhkm1nLw=;
        b=Zd3S9stGPv98alFSxwWaDX2afqxn4cc36JJhoQl7V9am/mcdUrdGFkIctUnCzxFktr
         XgJxrT4lK26OMG7L+IuUw34aYDSMdlL8q7QJPv1cosXECSx7kaiOvQEJC1tUN3b+VJHV
         0ITI0NHmtnvQ8xpZTglF7nNo/+LYTgrkugvcoVhggd/lAv83iod9C09PkfvbiijtmzVs
         GYH6SPuQue2lSShRilm/AyoEcZCCFBq+VooARVbcwd6LqJPPwTUYDS6tTksSU7NJbKcg
         xwzGFhEh3PvZlYGHcZcXy3Cv4dYDNVrMXc/mwn5/N92L7Twt8tVyHQN2coXZYfSyXTCl
         03VA==
X-Gm-Message-State: AOAM530nQeE7x/W8toNHhJn6kwaEMybj76LzT5vl40ngonwvssmoZlfI
        YEq+9G991ml127f09fJVV1OBEICL
X-Google-Smtp-Source: ABdhPJww8PpEwt4eaNKqvIT/UpfaPHSYqjku44Ho1ALUwDJfuJ4+Nj7wApmHlOWdFK8LDxXeNY9MYg==
X-Received: by 2002:a17:906:23e9:: with SMTP id j9mr3149698ejg.107.1595491436925;
        Thu, 23 Jul 2020 01:03:56 -0700 (PDT)
Received: from localhost (ip-37-188-169-187.eurotel.cz. [37.188.169.187])
        by smtp.gmail.com with ESMTPSA id c10sm1614880edt.22.2020.07.23.01.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 01:03:56 -0700 (PDT)
Date:   Thu, 23 Jul 2020 10:03:49 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>
Subject: Re: [RFC PATCH] mm: silence soft lockups from unlock_page
Message-ID: <20200723080349.GY4061@dhcp22.suse.cz>
References: <20200721063258.17140-1-mhocko@kernel.org>
 <CAHk-=whewL14RgwLZTXcNAnrDPt0H+sRJS6iDq0oGb6zwaBMxg@mail.gmail.com>
 <CAHk-=whb0=rjc1WR+F_r_syw5Ld4=ebuNJmmpaPEzfjZRD5Y-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whb0=rjc1WR+F_r_syw5Ld4=ebuNJmmpaPEzfjZRD5Y-w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 22-07-20 11:29:20, Linus Torvalds wrote:
> On Tue, Jul 21, 2020 at 8:33 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > More likely, it's actually *caused* by that commit 11a19c7b099f, and
> > what might be happening is that other CPU's are just adding new
> > waiters to the list *while* we're waking things up, because somebody
> > else already got the page lock again.
> >
> > Humor me.. Does something like this work instead?
> 
> I went back and looked at this, because it bothered me.

Thanks for pursuing this. I have learned that the affected system is in
fact a production machine which doesn't seem to have any downtime window
planned soon. Moreover the issue is not always reproducible. So I cannot
guarantee I can have this or other patches tested soon which is really
unfortunate.

> And I'm no longer convinced it can possibly make a difference.
> 
> Why?
> 
> Because __wake_up_locked_key_bookmark() just calls __wake_up_common(),
> and that one checks the return value of the wakeup function:
> 
>                 ret = curr->func(curr, mode, wake_flags, key);
>                 if (ret < 0)
>                         break;
> 
> and will not add the bookmark back to the list if this triggers.
> 
> And the wakeup function does that same "stop walking" thing:
> 
>         if (test_bit(key->bit_nr, &key->page->flags))
>                 return -1;
> 
> So if somebody else took the page lock, I think we should already have
> stopped walking the list.

Right! I didn't bother to look at the wakeup callback so have missed
this. For completeness this behavior is there since 3510ca20ece01 which
we have in our 4.12 based kernel as well.
-- 
Michal Hocko
SUSE Labs
