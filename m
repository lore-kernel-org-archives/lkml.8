Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E03AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 11:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72D0720853
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 11:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rFS2ORtv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgFJLQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 07:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728304AbgFJLQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 07:16:19 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D51C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 04:16:19 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j10so1797463wrw.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 04:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2zMZpeYnCtb3OvEhwTC1cmq94O9vgkXCVzFHFnyeATg=;
        b=rFS2ORtvsQ1X6+RDaKRXGMV1yL9XjaiWWY81ATO2FCRzjAiw3O+Ml2YfR2ncHeJneK
         1zwvIR548svKd/IkUpBiKfyzoqOibTjmf9slbPvCQkCWcUQoDvU6ZrGlGSeN348GUpeJ
         z34Tss8KgQ2cwfEMea+yF4Lx9cPZt+zQL+8YTq/Dty1ZDbn/6qaXOu8GxWnIIgRUVRfT
         4pqwHjWsAcyYgqO1ie4DoQXgHkGF7kSrSfl3cVFbM/EHAcDtDvZ5X23pbaaSJBawp67J
         3oHuAufqnadATgjOHgTdXj+cb1EkTSpilzlelaEx9oYJ0/5uEJlqeuSa26WW2E56hw7N
         0bYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2zMZpeYnCtb3OvEhwTC1cmq94O9vgkXCVzFHFnyeATg=;
        b=ZWPlmlC0LbOMbvqPXJ41Bzi/vA7TMdQbC4n6TesLeooUkSwGTM6gahZvb/TgP6IP/s
         fsvWux0Uo0Q0+M3JuRDkw2Qzmx41sreIGbvIFnvcO5LyVzwAa0hgRYECRec5oQWGf4oh
         ufBqa/nPv1NoojPgxg8J2fYs29czc1BgXFUbHvMu9XXc9WPkQ5L5YZ2ZOW4WBLvMZF/e
         ZRzhUtfz7DLyWZL6RAJq54o1FNGxodQFvuQbxhhUZmHuRDJoPxM2JGIEYDk0SGd4R5gM
         ac/Yhe4TwtkmVwYJustQFBSR7iyTUlpA2oXwOC9VnCSeHTUqXx8y9Bf46YAmZFxYhvTt
         SRxw==
X-Gm-Message-State: AOAM530lLcctMzdNk5D1Dt1184R9K0gH60cwP3KO1KZ4iJpmWvx73xhf
        K6C3ySf220nW0YtLR/7AG+8qrQ==
X-Google-Smtp-Source: ABdhPJw7AW05W+LUQZ5VIYJ8nsQULakkp0WgLU+jGtkhhN4gUvGIQJ+EFBbfxxObWsFHWqGmdtWheQ==
X-Received: by 2002:a5d:608d:: with SMTP id w13mr3105813wrt.298.1591787777793;
        Wed, 10 Jun 2020 04:16:17 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id k64sm6739643wmf.34.2020.06.10.04.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 04:16:16 -0700 (PDT)
Date:   Wed, 10 Jun 2020 12:16:15 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     jim.cromie@gmail.com
Cc:     Jason Baron <jbaron@akamai.com>,
        LKML <linux-kernel@vger.kernel.org>, akpm@linuxfoundation.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 03/16] dyndbg: refine debug verbosity; 1 is basic, 2 more
 chatty
Message-ID: <20200610111615.z6vukjsq2aprkug4@holly.lan>
References: <20200605162645.289174-1-jim.cromie@gmail.com>
 <20200605162645.289174-4-jim.cromie@gmail.com>
 <20200608112150.7ohrax6pzpi7ss2l@holly.lan>
 <CAJfuBxwHOyvOcSB8005=z1G_-Hux1UxaLOutOX1SE2wYONSsrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfuBxwHOyvOcSB8005=z1G_-Hux1UxaLOutOX1SE2wYONSsrg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 01:59:41PM -0600, jim.cromie@gmail.com wrote:
> On Mon, Jun 8, 2020 at 5:21 AM Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> >
> > On Fri, Jun 05, 2020 at 10:26:32AM -0600, Jim Cromie wrote:
> > > The verbose/debug logging done for `cat $MNT/dynamic_debug/control` is
> > > voluminous (2 per control file entry + 2 per PAGE).  Moreover, it just
> > > prints pointer and sequence, which is not useful to a dyndbg user.
> > > So just drop them.
> >
> > I'd assumed these messages where to help the dyndbg implementer rather
> > than the dyndbg user.
> 
> So I thought I was guilty of adding those noisy pr_info()s in the
> ddebug_proc_* functions,
> but I have touched them, changing them to vpr_info().
> In any case, I dont think theyre useful to the implementer either.
> 
> If the verbose messages really are useful to help
> > users who (mis)configure .../control then should the enable/disable
> > control be shadowed in debugfs to make it easy to find?
> >
> 
> I would hesitate to change the API, even if this is just an add-on,
> without changes to existing.
> OTOH, I could see it added as /proc/dynamic_debug/verbose

/proc ? 

I was assuming that if the verbose output of dynamic debug is useful to
the person trying to *use* dynamic_debug then it should be in
/sys/kernel/debug/dynamic_debug/verbose .

If they are only likely useful to the person trying to *implement*
dynamic_debug itself (or to check that the infrastructure is not broken)
then there is no reason to add them to debugfs.


> with this patch, verbose=1 is better focused on showing the parsing process,
> to give user more context as to what his query-command is doing
> verbose=2 additionally shows callsites that match the query, including
> any unchanged (iirc)

I'm still a little confused by what benefit having two levels of
verbosity really is. Why does a user need to turn on verbose mode to
figure out what is happening? Why isn't reading back
.../dynamic_debug/control (perhaps using grep and friends) sufficient?


Daniel.
