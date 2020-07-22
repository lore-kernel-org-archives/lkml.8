Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75ABFC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 19:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C5EB20717
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 19:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595444485;
	bh=phvxtdTXHp9Ry685fnG62H47P5SrsEFmbdTWmWp9FvI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0V3oTv+aUN8rfr297iGDH19BpInN2Gku/WtcGHyqWnF0e11GKTW5ZlTt7XqNm56u0
	 jKjWcADkPMiOAF3uCM8YWyLOhj+0F09KKkkeClei8rsjtOadcUj+7NGGPjdAK49I0K
	 ovY1KyB2ANvjbA2WTfsHuXiDYRTnth7tISRzKikc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbgGVTBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 15:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgGVTBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 15:01:23 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AEC4C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 12:01:23 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id q7so3672433ljm.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 12:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S56kKEMkL7FsZHzp242DbbqcflHJI9ZmfrGxgxQ00iw=;
        b=hp6J7kc6ujHEfqS4VcPSu6/E/CVvGuWnpeuP4cvEevgb+mml5e8qAmQ2baC+TV9hpK
         0O2LDESlpYJDcdfZhmWpZOLUurvPD1i2pP9WYcLP22qBxYONdwG0tiNODUxunmKpYuYu
         9d/AS6zUxaGLsDzBZfgf5hgVvPpiJOMIH4bCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S56kKEMkL7FsZHzp242DbbqcflHJI9ZmfrGxgxQ00iw=;
        b=pOl/Hj9Bpz3czwu2nYxK/IEWKAtZUfnmzVFoW4QGalzZZ3hfCep1D57yh2NGLtdF9Z
         UTAHFdmIjYzJOKAf7xW3u+hIBFbzdp/OpUR8xe6eZKCWi+kKPzbMw2JdlDJB6RpfKOBn
         5C30MPLhliJ6k5Ul+AIQBq217/vc/m27HId307SIvn7rmVMNmEYbt0Bxqu/ACI1IVJyb
         I37Z9tRuTv8ApOgZHkxtvajYkE0vDZ4jLIg9UvvwPQLOZedDvMn1zuHO7q+yoaXkwzzi
         sbGXqR9d6rMMn8NPMR9Fzqddut3PIFPm5TzwBK3qKbGvMa5lQpbSBOvMVfxjs5TADE3P
         bevw==
X-Gm-Message-State: AOAM532xLpSC8lyAMwi1Jr4bw1TB5Xnz67gOaNVwYPvGIqewWZ3OweMy
        X/p2zImFklAXAdD2oaPWnNFg7mZO2Do=
X-Google-Smtp-Source: ABdhPJyK+Hwu3oDb9pAcMnSaWRi2rFXtOeZPIbYgNpnANhkC2eAUPGM7XZ0krpzt0sdIHCPqOruwVA==
X-Received: by 2002:a2e:b175:: with SMTP id a21mr298184ljm.10.1595444481343;
        Wed, 22 Jul 2020 12:01:21 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id 193sm493597lfa.90.2020.07.22.12.01.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jul 2020 12:01:20 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id b30so1902062lfj.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 12:01:20 -0700 (PDT)
X-Received: by 2002:a05:6512:3b7:: with SMTP id v23mr394161lfp.10.1595444480107;
 Wed, 22 Jul 2020 12:01:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200722141151.GO15516@casper.infradead.org> <CAHk-=whC-GKFoBGRSnTnD6VxL_J+5xs4BzEhEfyhGMcT8Mga7g@mail.gmail.com>
 <20200722184636.GQ15516@casper.infradead.org>
In-Reply-To: <20200722184636.GQ15516@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Jul 2020 12:01:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=whW+M5kBwdNX2mLyGEDSGq=Bu7i=M5FUh+E1ZSTwsrEAw@mail.gmail.com>
Message-ID: <CAHk-=whW+M5kBwdNX2mLyGEDSGq=Bu7i=M5FUh+E1ZSTwsrEAw@mail.gmail.com>
Subject: Re: [GIT PULL] XArray for 5.8
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 11:46 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> But I think the real problem is that local_lock_internal.h doesn't include
> <linux/sched.h>.  Header files shouldn't depend on other headers to be
> included first.

The big hint is that name: "internal".

Also, we often violate the "shouldn't depend on other headers" rule.
Some basic headers are just that - basic. And some headers are not.

Things like the uapi headers need to be independent, but we've had
circular ordering problems with kernel headers, and sometimes it's
just better to say "you need to just get the basic header first".

            Linus
