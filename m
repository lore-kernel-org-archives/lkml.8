Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C8FC2BA15
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 20:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DA7920678
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 20:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Smm1q5CY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390090AbgDBU1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 16:27:51 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40075 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730837AbgDBU1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 16:27:51 -0400
Received: by mail-pg1-f195.google.com with SMTP id t24so2370386pgj.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 13:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Tm9Yr3bqmuNGExiY7vVKsPwnaHo60Po4ISz6K0cbNJM=;
        b=Smm1q5CY/oX1a5RB+6/rg0OMMpkQQEyasTzFJrBTMrH/9ggcr/BfvbpYsLykFyjKyj
         2PwhzKCTjNwbauICju6+DoHPLTmOfE26sbu8gKPAF0JNysrFbBXJP1k99H1Y81ZGotjF
         HBEOphcciEgjXYH2LvUC0i9QCTEJqTA6uBORk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Tm9Yr3bqmuNGExiY7vVKsPwnaHo60Po4ISz6K0cbNJM=;
        b=b632y/MP+4nmTwFaq9gIpD//rvU45D3JhGRhMxZksiKICYQsv4I2C8WDSuQq+EW7Ae
         p9oSfowMRgwN/meTLngI6FhyMHxYYXZjYkoRwCXrBiDxNIIpRrC7ghAjgkpSfmZwwvbF
         nxeLOXKZ+vaTovkZwkIavfgluunDlO/Z6eliTQ3t7IHibxE9HzXCMiKUiy9XfTfpdMLn
         WFlfx8rgys5WQaIRLqukuuwOdhMEvxRUkR+a7K0idN02Otr5JFkfIpcCSJkR2qXp0O/Z
         edmGyHPaenWbnzwdmIjtLmNgjKArjqhb1vvr3+AO71HMqwbtsfTPwDzqDaYkrUhMY8Zq
         V+Og==
X-Gm-Message-State: AGi0PuaMkxqZnCQbCvQbWg7cTrgzfOXCkGh3sxhIZVNvrK244hNjcIYs
        G4yV7rHhHjJY0mba8+GFwRacsQ==
X-Google-Smtp-Source: APiQypJru05phqDJ49g1EwlFJFXm3/ghT/fLOJrssR3ZOL3AQdXi15r8fpVrMULS6+mqXqrkrXK0nA==
X-Received: by 2002:a63:b80a:: with SMTP id p10mr4870517pge.306.1585859268304;
        Thu, 02 Apr 2020 13:27:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i187sm4325945pfg.33.2020.04.02.13.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 13:27:47 -0700 (PDT)
Date:   Thu, 2 Apr 2020 13:27:46 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Anvin <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH RESEND 1/4] uaccess: Add user_read_access_begin/end and
 user_write_access_begin/end
Message-ID: <202004021322.5F80467@keescook>
References: <27106d62fdbd4ffb47796236050e418131cb837f.1585811416.git.christophe.leroy@c-s.fr>
 <20200402162942.GG23230@ZenIV.linux.org.uk>
 <67e21b65-0e2d-7ca5-7518-cec1b7abc46c@c-s.fr>
 <20200402175032.GH23230@ZenIV.linux.org.uk>
 <202004021132.813F8E88@keescook>
 <CAHk-=wg9cSm=AjPmkasNHBDwuW4D10jszjv6EeCKp8V9Qbx2hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg9cSm=AjPmkasNHBDwuW4D10jszjv6EeCKp8V9Qbx2hg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 12:26:52PM -0700, Linus Torvalds wrote:
> On Thu, Apr 2, 2020 at 11:36 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > Yup, I think it's a weakness of the ARM implementation and I'd like to
> > not extend it further. AFAIK we should never nest, but I would not be
> > surprised at all if we did.
> 
> Wel, at least the user_access_begin/end() sections can't nest. objtool
> verifies and warns about that on x86.

Right, yes, I mentioned that earlier in the thread. I meant I wasn't
100% sure about ARM's corner cases. I would _hope_ it doesn't.

> > If we were looking at a design goal for all architectures, I'd like
> > to be doing what the public PaX patchset
> 
> We already do better than PaX ever did. Seriously. Mainline has long
> since passed their hacky garbage.

I was just speaking to design principles in this area: if the "enable"
is called when already enabled, Something Is Wrong. :) (And one thing
still missing in this general subject is that x86 still lacks SMAP
emulation. And yes, I understand it's just not been a priority for anyone
that can work on it, but it is still a gap.)

-- 
Kees Cook
