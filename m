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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A729C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 20:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD9AA2077D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 20:04:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YcWv/Ng+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728510AbgGJUEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 16:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbgGJUEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 16:04:22 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FF5C08C5DC
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 13:04:22 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id z24so7783852ljn.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 13:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=upv6HyhLP4aEGK32Lyt7RFYLTeMC908RT7hWhpDKjXI=;
        b=YcWv/Ng+Xe1od3A8ERpoizba2TI4fOXam8+d/PKzLH1WMrRay6cUfpS9+pYFQ+2onz
         GjsBKG6YoJtYoCIArRhoo0biLuR+DSvJ3g08l0kbb0z0LbcyNgS8gPxLj4XMMDdPSzee
         vClhD5FOgLSaxVRd+S4amfNeWlO+DmfGPg+D7Z0aV24kQ2WVWGLUGPbtsaiFPy/QY8yZ
         /KMN8De4AzD7YRRwndFFahHMpfLAN2NVvJPomAQ/SgVCrW1+JyVfhn9u+EY76pfDgzV3
         fSE5s2qz6EcKd86NYECjO6i6QzezcAMKW/wFCb+tyDKYoNbQ2IlKnoIuiVyX6vDPLgQy
         T4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=upv6HyhLP4aEGK32Lyt7RFYLTeMC908RT7hWhpDKjXI=;
        b=Ep44/XmZrWaNsi0FaycycPhHrfX1kZcIr4wD383/Di1/+mBrXZAfGZe09ztPOdMPZp
         eIlvqL9fGy61DWQ3p8vZiPwzBpSQfxEgfZ7w5ALU1MaIXJxvqb8UHKQ5xirSZK44J3Am
         UpcY8gweP9VMmYdbehisnXNk/v11yjnBzeCdhGE6hsKmwyNCnOxXJALR/QucSaRS5G02
         MWfVVFEJk5lSkfNv1FWjC6DFYUaZRUBdaVHh01sFiU4mrdDhHIHdV7hWl/hEsmzj0APJ
         7JHQUCZ0yAbzANBxxUhHMQ8L+8oIJcJe1gzNVVIo86PTbYVmOhp5ce9EjBgwZM3gRE+0
         i/MQ==
X-Gm-Message-State: AOAM532SJrRomSF+HHavQ4G7GMrizMRbjty5kZQN703ThAuSFveR0ojB
        tQVw+CNl1mU72o+HCHf9hv8=
X-Google-Smtp-Source: ABdhPJw8mISKfQOiTyr3De+IS4+Mzm837tlLnCygkmps6B5cLYI4ac33g/i9u8JIZ+YLi6GoLlaWHw==
X-Received: by 2002:a2e:9316:: with SMTP id e22mr38667350ljh.393.1594411461147;
        Fri, 10 Jul 2020 13:04:21 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id e16sm2236787ljn.12.2020.07.10.13.04.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 13:04:20 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Fri, 10 Jul 2020 22:04:18 +0200
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 1/1] mm/vmalloc.c: Add an error message if two areas
 overlap
Message-ID: <20200710200418.GA19627@pc636>
References: <20200710194042.2510-1-urezki@gmail.com>
 <20200710194406.GP12769@casper.infradead.org>
 <20200710200030.GB19487@pc636>
 <20200710200138.GQ12769@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710200138.GQ12769@casper.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 09:01:38PM +0100, Matthew Wilcox wrote:
> On Fri, Jul 10, 2020 at 10:00:30PM +0200, Uladzislau Rezki wrote:
> > On Fri, Jul 10, 2020 at 08:44:06PM +0100, Matthew Wilcox wrote:
> > > On Fri, Jul 10, 2020 at 09:40:42PM +0200, Uladzislau Rezki (Sony) wrote:
> > > > Before triggering a BUG() it would be useful to understand
> > > > how two areas overlap between each other. Print information
> > > > about start/end addresses of both VAs and their addresses.
> > > > 
> > > > For example if both are identical it could mean double free.
> > > > 
> > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > ---
> > > >  mm/vmalloc.c | 10 +++++++++-
> > > >  1 file changed, 9 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > > index 5a2b55c8dd9a..1679b01febcd 100644
> > > > --- a/mm/vmalloc.c
> > > > +++ b/mm/vmalloc.c
> > > > @@ -549,8 +549,13 @@ find_va_links(struct vmap_area *va,
> > > >  		else if (va->va_end > tmp_va->va_start &&
> > > >  				va->va_start >= tmp_va->va_end)
> > > >  			link = &(*link)->rb_right;
> > > > -		else
> > > > +		else {
> > > > +			pr_err("Overlaps: 0x%px(0x%lx-0x%lx), 0x%px(0x%lx-0x%lx)\n",
> > > > +				va, va->va_start, va->va_end, tmp_va,
> > > > +				tmp_va->va_start, tmp_va->va_end);
> > > 
> > > It might be helpful to have a "vmalloc:" prefix to that string to indicate
> > > where to start searching.  And I don't think we're supposed to use %px
> > > without a really good justification these days.
> > >
> > That makes sense, i will add such prefix for sure. As for %px i can just
> > use a casting to (unsigned long) and 0x%lx prefix.
> 
> That's not the point.  Linus wants us to not display actual pointers to
> the user.
> 
Ahh, Got it!

Then i will just remove information about addresses of two VAs.
Hope that will work.

--
Vlad Rezki
