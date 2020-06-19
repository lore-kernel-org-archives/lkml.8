Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1903C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ABE92100A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 19:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GKytp6cb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732890AbgFSTI6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 15:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728665AbgFSTI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 15:08:57 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A1FCC06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 12:08:57 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id dr13so11276126ejc.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 12:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JlIKW7ZiZpRvoLiHLYzC+51bF9QJTWcSdc0O5TaA0nQ=;
        b=GKytp6cbb10mdcTacfYVW00r/dMIDdanv+7I6Rf+lN5IXC9ZowUywqKQTkeSX2yChI
         SlO1CjfLlVRhAn1giSRKWYt9o+THUQHA6pxb1yw7csckMG3+cynFWo+0IsTbAhO2MiJr
         LD+P1WYvzGzPNI0FZrLpJoP6CQIh0g2mV2nh2TGDsfx4m6pDexe1zJghrUwBmalvQkv5
         TbExIPdF3wiUvow1EmTlGBNDD4yShu2uREIJBO+KrPTGW218QHfylvR7fMjH/XUHzCvN
         iSfesOG+XoJwJB3WffGne2vzqi7xfxH9H07h8oVrLXLB4+6OXyHzzE+OrlBaH8WDrplf
         gl5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JlIKW7ZiZpRvoLiHLYzC+51bF9QJTWcSdc0O5TaA0nQ=;
        b=O7WQMIIHgHaYYPkAz5kP2EMz185cHRIwmbWqIGssm6E0YbBURal/spOm7MvpaMpM0J
         WU4ToAt1UDGdQsPuUANQXig4FW349Pz97sCBi3vplZqd3njcxC8VoO/KSXA6/Wt9qi39
         DUs/ENpMbbYkbxxXAeLj/Ba93nXtuleXODaZnwsoy12q36d3u7iHrvak81lXr2b2psbm
         2u423qAd3WiC3rlKRA06XzZjKqGbQnRJfGalKqLx3zHqBE9UarKKiE7XdYNIhzmAMPw9
         X7vxDp5yKAmWr9OzG2HJrlCho+vO/nNjc0lxEAgptzMrpMpYM6IlcrRLUbh3mupyeSol
         WdiQ==
X-Gm-Message-State: AOAM530kcH/DPaHzsAVHK/xUz26qKeGCHhm6WcYwmPyiBaFSZxXtlmCt
        95TcvwUZGzGOCCUXMnhfUtI=
X-Google-Smtp-Source: ABdhPJwR6TAA0426NIFUK2deCbiT2GrebjlngFGmj0ju+RVRL6+t6gt/JKC7Axsl2Vx1PH3kh4b8XA==
X-Received: by 2002:a17:906:7acf:: with SMTP id k15mr5197608ejo.410.1592593735812;
        Fri, 19 Jun 2020 12:08:55 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:b7f9:7600:8cd0:5f2e:6739:a8da])
        by smtp.gmail.com with ESMTPSA id bd19sm5259071edb.2.2020.06.19.12.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 12:08:55 -0700 (PDT)
Date:   Fri, 19 Jun 2020 21:08:54 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marco Elver <elver@google.com>, Borislav Petkov <bp@suse.de>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] sparse: use the _Generic() version of
 __unqual_scalar_typeof()
Message-ID: <20200619190854.zyxcafhxsrst2imw@ltop.local>
References: <20200618222620.5069-1-luc.vanoostenryck@gmail.com>
 <CAHk-=wg04jR4PdocoLaYE-tL1-=pAdxwaPp1n0iKhcORqYY8Dg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg04jR4PdocoLaYE-tL1-=pAdxwaPp1n0iKhcORqYY8Dg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 11:26:59AM -0700, Linus Torvalds wrote:
> On Thu, Jun 18, 2020 at 3:26 PM Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > Note: a recent version of sparse will be needed (minimum v0.6.2-rc2
> >        or later than 2020-05-28).
> 
> Ok, it sounds like this turns out to be even more recent than that,
> with the fixes for _Generic.
> 
> So i think I'll delay this until 5.9. Mind reminding me?

Sure. No problem.

-- Luc
