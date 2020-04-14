Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05FA5C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97C4F2074D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+ReKYew"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504611AbgDNTCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 15:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2504595AbgDNTC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 15:02:28 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8135EC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 12:02:28 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id u15so1025117ljd.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 12:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HK82X0VEp89OA9Y+MX3MtVkgahLviMMIweBp5dX6xeo=;
        b=e+ReKYewQus+4U70NmQegviOuZR87lmwMKXd6/CR6t0HAhXmRyUnKW+ntRBb2UxHEx
         uGin2hJ6oiKXaIThPGuP0GR4/9sAK6AH2z3IO8iAyII2KHOgCsbCGomUa320IMVATSRl
         tuOeYOnU9MXql33AUIEGYaW33NlXBYjLl4zPGdj1NdD05sK4BJBMOFMLwjQnOgXmeLfC
         rfe7QFO9jxxZntT2fL5soGssamSceeKhwEbggDkJTNDy9Z6KsNr1W2msensPFYQ5pKqM
         eoRShAqPh5SbSehjD4TuqPAzukow2QGtqYVkaRlubaz5A26HKraomVMhXRirci/ZAeCY
         kDrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HK82X0VEp89OA9Y+MX3MtVkgahLviMMIweBp5dX6xeo=;
        b=ZSPuvQyrLdj9XVFhx6T/sa9x2PTYW28qZau9wWf5hHkolpAol9anXjz3RQ4ovum18Y
         q5ja+P/3mBwivQR24KtMBxhH0yPrtE21x9nxinfgv0JP2grvQ01TQNfyHZ3e8nd0gLLg
         EohmdQukhwL4j10goJgnJmgrG2t7+iqx9xNi3YSZPi2YYeFwrYTTGamUpvq0LpOTH+Vy
         VcwuurDYkMIp4w5FWLOzsC9vJRHmvBXPnB5OgC/zuUs1rtPEcwAHULa82iKnuGiRRJza
         iAGhGOXa7baMBwJMzazmZZxuHvfc3L4O24GfIHQWaxx7ofUl6PzAjx9DmzC/unPDPbd7
         vWpQ==
X-Gm-Message-State: AGi0PuaQgzxYa/h3XVxXZiMYdjwk8SPWmfU86BFfrZpe6d+954yxQVFV
        cXBwhQmJ2bB5ORGBAr1wa8c=
X-Google-Smtp-Source: APiQypKkCytYOVS2+WizB3cBtHU3jsyUjkVqeOkXZKDTeOm9NvxG0mKvR4Ly7Nrs/F+godiFvbC6XA==
X-Received: by 2002:a2e:9a87:: with SMTP id p7mr930038lji.61.1586890946998;
        Tue, 14 Apr 2020 12:02:26 -0700 (PDT)
Received: from pc636 (h5ef52e31.seluork.dyn.perspektivbredband.net. [94.245.46.49])
        by smtp.gmail.com with ESMTPSA id j15sm5887lja.71.2020.04.14.12.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 12:02:25 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Tue, 14 Apr 2020 21:02:15 +0200
To:     Dave Hansen <dave.hansen@intel.com>, Liu Song <fishland@aliyun.com>
Cc:     Liu Song <fishland@aliyun.com>, gregkh@linuxfoundation.org,
        jroedel@suse.de, dave.hansen@linux.intel.com, tglx@linutronix.de,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "liu.song11@zte.com.cnhange-folder>?" <toggle-mailboxes@pc636>
Subject: Re: [RFC PATCH] mm/vmalloc: make sure to traverse from the beginning
 when overflow occur
Message-ID: <20200414190215.GA1531@pc636>
References: <20200412143803.43931-1-fishland@aliyun.com>
 <b295ec51-56fd-a377-95c9-a88cf5b151bc@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b295ec51-56fd-a377-95c9-a88cf5b151bc@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 08:02:49AM -0700, Dave Hansen wrote:
> On 4/12/20 7:38 AM, Liu Song wrote:
> > If overflow, should ensure that "free_vmap_cache" is set to NULL,
> > so as to ensure that it can be traversed from the beginning.
> 
> This changelog is a bit sparse.
> 
> Does this fix a demonstrated problem?  Or was it just discovered via
> code review and assumed to help a theoretical problem?
> 
> Which tree is it against?  'free_vmap_cache' doesn't show up in Linus's
> tree.
> > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > index d8e877365f9f..2638a20d36ce 100644
> > --- a/mm/vmalloc.c
> > +++ b/mm/vmalloc.c
> > @@ -441,7 +441,7 @@ static struct vmap_area *alloc_vmap_area(unsigned long size,
> >  	if (!free_vmap_cache ||
> >  			size < cached_hole_size ||
> >  			vstart < cached_vstart ||
> > -			align < cached_align) {
> > +			align < cached_align || purged) {
> >  nocache:
> >  		cached_hole_size = 0;
> >  		free_vmap_cache = NULL;
> >
We do not have such code since 5.2 kernel or so, nor things like
cached_hole_size, free_vmap_cache and so on. It was totally reworked.

--
Vlad Rezki
