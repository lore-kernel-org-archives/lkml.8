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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503EFC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 19:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DAD22078D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 19:46:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gzf2CJUi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgGJTqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 15:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgGJTqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 15:46:00 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9E9C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 12:45:59 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id q7so7787643ljm.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 12:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YsEdL4Wd97W3DlnP1Te2AUyy9smqbbkh6KPYk2RXB3c=;
        b=Gzf2CJUim5sG7TrQY85OnHYWWs6amw4TNWPXbUbP0IrPdpmJQ/aqlclLyKqPvsP2mc
         plnD10WrvlJEBsh0J8PFRAtiSUW949sWLEMyMbHq4DvM9mV2StAMKBWM/KzMUy+VGpYH
         IN/lbJ2B9HZ+dNUS/qgSLnmYXC1C9+G99bGvqfnFyGBP3A+HTRo7j1xmbJIfbcJEKvTb
         suz+ZESyv5MNiuiAzJYqFbHfSBPReQXftZoMidbrhHFzqJmKyUVVJKzVNbyyVjr0Vo1Q
         lgHOSpbkij9T+464Cfle3ClqzYUmij30IY5XRjXwQL32+T/8TgEtOBPC2fLiZejWVVel
         pCcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YsEdL4Wd97W3DlnP1Te2AUyy9smqbbkh6KPYk2RXB3c=;
        b=FJseyWjBQ88BRBf3U8g/EzRjYD291AbZMAtc6cUaQ7mEPbGj1K6/TcBh2g0eNoFGr6
         pqJcKJ6wbGUMRf9QKw0Cp/bqT9GfoqRYjZ63JxfeWZ6nOg4AqAuA3VJkldWnDMtXBDFv
         12mkQtCA/VP6Z6tFzRQWomCqy9ebdnUOJjPaLoQb+IyFHE9Xf+K18/Gmgxhn03BzQLLk
         ZtPAvLvDI+BXyqFnB8T9mGzHwQTaPfeVa2s2Kx172YHQcDT0oLYB8UskfIQ5G7y60DzN
         gnLDooZei5Pr6yPMDL2eIkGf7/t+e2BrpFCIm2ME03bWDtQ200gGM4gja1/+48FcqvEp
         /RNA==
X-Gm-Message-State: AOAM530AFtS3Gc0+L9fKHaZAJt2yILLAhvF6Yo4xyx8eo/5l3b7HdT+Z
        hS2whf6e/mfblow1BWSpUz0=
X-Google-Smtp-Source: ABdhPJyT1p7T8M2Y/pSLh9354KzgmUTn3XrOx7NSbqfWHs0mRgfdJcZdj8CQzpEpTUcNufU0UuoNxQ==
X-Received: by 2002:a2e:780e:: with SMTP id t14mr38311610ljc.444.1594410358462;
        Fri, 10 Jul 2020 12:45:58 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id j2sm2212234lji.115.2020.07.10.12.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 12:45:57 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Fri, 10 Jul 2020 21:45:55 +0200
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
Message-ID: <20200710194555.GA19487@pc636>
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
> Can we do without the BUG()?  Maybe just break out and decline to insert
> the conflicting range?
> 
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
Matthew, you are super fast!!! :)

--
Vlad Rezki
