Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2202EC3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 19:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3BB22073B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 19:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETOMulbX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730719AbgCCTTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 14:19:41 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35878 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730164AbgCCTTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 14:19:41 -0500
Received: by mail-qk1-f193.google.com with SMTP id u25so38857qkk.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 11:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C5WUDNOXTdr51aZe4hgZXE+927OHlJgZEm9hjZobCGc=;
        b=ETOMulbXsOUfiOcXvDlcB5pI+If1PdQdvDcpU7KVUxzHghpVh6AlCT2EBKBOvAjSrV
         Cz6EYjc26BDQSB1frN5G3my8aoRmg/o5lPTX9/HtkT9Nw8Nefmq2kfhUYgIWRYwBw1Wo
         wO2yJYZLj8OVh+WNAJ57j5vsIAm4vi2UfkV17/Li0W14UGs9mUwZg/H/C56MuIyeerIV
         4R0I77/hH9RDvzsQLw7HMDwkLetkEK2H8+q+yyPlsOlIX72xi0lFKQNHoMZNLaWbMxgH
         TZrbg9LYFzw9n87492VOrY9UHMvOcNlQWa7SFkt394t3+SoRaweYLJmeHld9KviDK1X0
         u5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C5WUDNOXTdr51aZe4hgZXE+927OHlJgZEm9hjZobCGc=;
        b=BeSNRb+9PFFC5//Uds2kKUOypRI0STkG8R0+YD2aQdwh3QlGsZwoYwymMou+Zu+iMk
         MW5lqiqUYGcgryC0thqOH/ysa8T3x4sgIPN5IQeRiD1jiSPIIn94hVus8Mt7wTVT3f4n
         22OfV+rgbR7Ej91NepPyOcEHhcmkJNuBEngLsRLQqPvuVYcFRjHErVRWx1mrP3VFmHaz
         T8PkuFme3qk6s4gD0vARZq+jhCP71NgTXFOxa9Ru5nOKEOVjKrEjF7eLsPviwhZT/YiT
         0N08NXfVHzj0vrD6OLXnp03HWi/vMrrET6ibUsUrWMagNx2eDDyXfR3wJoFJSxLJ2DyK
         Txfw==
X-Gm-Message-State: ANhLgQ1Ajx2/9l+L+bGBYOel/4Br3SJ34uFkQTaIjQw4y+jcb+AkAgdj
        5+xGX0u89v2sNx9dxXGakIg=
X-Google-Smtp-Source: ADFU+vsLHohgDzG8cdYdUQ7UpYQsd9FYrRdSlztysierpzOYKCtD2SFD3MyAt1oUDEdsWCzC/G8Y5g==
X-Received: by 2002:a37:a28f:: with SMTP id l137mr5487584qke.196.1583263180256;
        Tue, 03 Mar 2020 11:19:40 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id x93sm4772046qte.60.2020.03.03.11.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 11:19:39 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 4F0B6403AD; Tue,  3 Mar 2020 16:19:37 -0300 (-03)
Date:   Tue, 3 Mar 2020 16:19:37 -0300
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] perf bench: Share 'start', 'end', 'runtime' global
 vars
Message-ID: <20200303191937.GA5550@kernel.org>
References: <20200303155811.GD13702@kernel.org>
 <87eeu92syj.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eeu92syj.fsf@nanos.tec.linutronix.de>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 03, 2020 at 07:28:52PM +0100, Thomas Gleixner escreveu:
> Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com> writes:
> >> > Don't we have header files for that?
> >  
> >> Sure, that was the laziest/quickest way to "fix" that, the other was to
> >> stick a 'static' in front of it.
> >  
> >> I'll go see if pushing them to a header file will not clash with other
> >> stuff.
> >
> > Better now? Had to prefix those, not to clash with local variables when
> > adding it to bench/bench.h.
> 
> Yes.
> 
> > Looking at the patch more can be done to share those benchmark
> > arguments, but this is the second minimal patch to get tools/perf to
> > build with the latest gcc (the one in Fedora rawhide and some other
> > distros).
> 
> Right, but yes there is definitely quite some overlap there.
> 
> Acked-by: Thomas Gleixner <tglx@linutronix.de>

Thanks, adding it to the cset,

- Arnaldo
