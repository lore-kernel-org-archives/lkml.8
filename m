Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18713C433E5
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 20:00:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA7B92075D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 20:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R65UmsUf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbgGJUAj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 16:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbgGJUAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 16:00:38 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D6FC08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 13:00:36 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id g2so3869060lfb.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 13:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VGGNYIiYtfiau26k3ZU9GdTLqalXbW1YfEG5XzhHZro=;
        b=R65UmsUf6sEGi28q+oBAELsbkXGXV7TsSBUSRYm+1Fi5AuTRLgWzkg0hajhjTZwYpJ
         kbwYWolWZkH2JZ0b4Ne4dTX7ywYrpsdYY4ag4HfmAAxpPbgd6n/b3mUKo2+XciPMIxN4
         GsKqqa12+SMKjtSgDqDYHyi3A3RMe1tDJRpK5Ki0GKjipHc9YbrjbyzgaoLEHJQ0RkJi
         5WfrPH88+Z4U5FkO2t/3LYigg4IZN8rTje1Yp4pq3qSWKvFYofS3CuA+3ffOtTbXWxut
         xyJRHTiWGXlRVJuUu4f1ahqyNyDhg0xRzDX2n5afNGcvdcPWBhK3frGvzAIIcadFwbjz
         OsEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VGGNYIiYtfiau26k3ZU9GdTLqalXbW1YfEG5XzhHZro=;
        b=a8pxsegWTQLLARm6wjxAWq6UoDVYayfhEvCmzkCSPDkLTrDK7x/0SnGZRJ4Rb3pwR9
         kAmODK6iS5674fJw3Fs2XUUB204QIb1Vb7FxiqRvzkbEqURge+3n+sbanxh+zFYZZlBB
         ryqrYrZMR4EpESaAAFN2TyDDWp4fJqGDevwaG9FV2YfPJSKXrr/5ssC/0PFF5rIsXTKf
         n1EOPrOamM1d6o1a+9YIxSjJQ47lDOwd5JKt07f7G2yhKhxaV52iLnFzrcK9ahTxP9sF
         EelVmfnZBHbTznBQ9JLWS/8QpaK9R8skL2g1GLEnME0ZAQP5Umg0ylmKbaXOUf9HVx9K
         HgOA==
X-Gm-Message-State: AOAM531De2OAAxdejEbCQPqeIOuXwjfRgavTagyKJI2D4FEsRJywEzzX
        TFcPpM/Cu68bL4E5rcA5vNE=
X-Google-Smtp-Source: ABdhPJzDVAgLOZni4F+IW3+70sdYnze8gvj4viMEUGip9JI1iibh1hU/HLt771jJFm5tRv+H8zzIoA==
X-Received: by 2002:a05:6512:20f:: with SMTP id a15mr44267476lfo.118.1594411234831;
        Fri, 10 Jul 2020 13:00:34 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id g142sm2511187lfd.41.2020.07.10.13.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 13:00:32 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Fri, 10 Jul 2020 22:00:30 +0200
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 1/1] mm/vmalloc.c: Add an error message if two areas
 overlap
Message-ID: <20200710200030.GB19487@pc636>
References: <20200710194042.2510-1-urezki@gmail.com>
 <20200710194406.GP12769@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710194406.GP12769@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 08:44:06PM +0100, Matthew Wilcox wrote:
> On Fri, Jul 10, 2020 at 09:40:42PM +0200, Uladzislau Rezki (Sony) wrote:
> > Before triggering a BUG() it would be useful to understand
> > how two areas overlap between each other. Print information
> > about start/end addresses of both VAs and their addresses.
> > 
> > For example if both are identical it could mean double free.
> > 
> > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > ---
> >  mm/vmalloc.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index 5a2b55c8dd9a..1679b01febcd 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -549,8 +549,13 @@ find_va_links(struct vmap_area *va,
> >  		else if (va->va_end > tmp_va->va_start &&
> >  				va->va_start >= tmp_va->va_end)
> >  			link = &(*link)->rb_right;
> > -		else
> > +		else {
> > +			pr_err("Overlaps: 0x%px(0x%lx-0x%lx), 0x%px(0x%lx-0x%lx)\n",
> > +				va, va->va_start, va->va_end, tmp_va,
> > +				tmp_va->va_start, tmp_va->va_end);
> 
> It might be helpful to have a "vmalloc:" prefix to that string to indicate
> where to start searching.  And I don't think we're supposed to use %px
> without a really good justification these days.
>
That makes sense, i will add such prefix for sure. As for %px i can just
use a casting to (unsigned long) and 0x%lx prefix.

> 
> Can we do without the BUG()?  Maybe just break out and decline to insert
> the conflicting range?
> 
When i developed that logic, i was thinking about that but for some
reason i went with BUG_ON(), do not remember why. But i agree we shold
avoid of it. Let me think about it one more time.

> >  			BUG();
> > +		}
> >  	} while (*link);
> >  
> >  	*parent = &tmp_va->rb_node;
> > @@ -1993,6 +1998,9 @@ static void vmap_init_free_space(void)
> >  			insert_vmap_area_augment(free, NULL,
> >  				&free_vmap_area_root,
> >  					&free_vmap_area_list);
> > +			insert_vmap_area_augment(free, NULL,
> > +				&free_vmap_area_root,
> > +					&free_vmap_area_list);
> 
> This is surely testing code that you forgot to delete?
>
Yes, i forgot to remove it.

Thanks for your comments!

--
Vlad Rezki
