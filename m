Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C7AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 21:52:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E31F20720
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 21:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VdUB92tJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgFKVwc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 17:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgFKVwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 17:52:31 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB427C03E96F
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 14:52:30 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id q8so7133191qkm.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 14:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p3wy0jN/XH2mzyQo9Wt2q7wi5RLfChelMdRigqSs1O4=;
        b=VdUB92tJodDU/F8uo3TTTlMOMyBHo/GOD79C4S8FGl3MjThPq8EjLLOEz8gLy3Y5bd
         7UKzqIJoVpuzjOZfuFizkns2AMk1h3txC1gAgd+hUNUBcAGefqBVdXrcaad7PqhGQqrM
         oiyKTHQlSkICWTR6tXzIduwZFqIaWFeslQsbUL8j+EZuhBfmEo4agUyb4avj6zszSb2S
         OLWUZQLzTKGKGrfe/h/q3wm+O7Jbhuf9Zf3Q767aKyPRvEjbSTNPyaV+Ygrc4vVVdvIF
         cU/wH3Zvspi+AkJWLpOoqKoZQHM41HfsNHNesZQWTovWqWynD4Jq0pC+o+S7RtD9vRzg
         Go/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=p3wy0jN/XH2mzyQo9Wt2q7wi5RLfChelMdRigqSs1O4=;
        b=fletEppcBa2UbDmw3u4EoSU/UPzPQQgE04A3c860omuJZXH8Lg5Y89moGTMzbuBXy1
         Q8G01FYz7tYyI+Y/1n0SVY3+KpA0jFduw1NNRDwdSisD9s2Dk2n4K3g2HXtTUd7/QwGg
         4N+p2GofjarM8dcdfnV1F8vbH+6tYuMGreVeojYYQ7ilM3RrHjkDtsz0bWfJ3oiFWwIm
         rY0or9Gq6pcf1YkTVD3BvSYYPpMGp40Uw6N31E4KUHKFWgoL23xTY6qHGFcStzjBH2nD
         3u/a66rHsI3XCyFARD7Uv46lOje/WdXfFaTdVfuGydn1Y9lZ+OQobKxZ5UgfrwY//uUm
         ynpQ==
X-Gm-Message-State: AOAM532wY8LcFPGKXLvoADT8G1KpPhmu3dCvHTaiE6xe9RcI+LLv1IPQ
        0UhZfpP50T3GoMGNw8IOqtxwjsmD
X-Google-Smtp-Source: ABdhPJxLZDcE4PlcusTMx4eCpUBTeoq3rkqyvSlc87RdI2R4A4dBhq5mG8K11OHyHK3+biaLsUTYKQ==
X-Received: by 2002:a37:7c6:: with SMTP id 189mr91374qkh.24.1591912349838;
        Thu, 11 Jun 2020 14:52:29 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id n2sm3092439qtp.45.2020.06.11.14.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 14:52:29 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 11 Jun 2020 17:52:27 -0400
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Fangrui Song <maskray@google.com>,
        Rong Chen <rong.a.chen@intel.com>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Makefile: Improve compressed debug info support detection
Message-ID: <20200611215227.GB3924125@rani.riverdale.lan>
References: <20200610063715.v2qrqvwtegdxdwzl@google.com>
 <20200610191106.2662548-1-nivedita@alum.mit.edu>
 <CAKwvOdnF9xhrs+FP4QXo6uXxgHMfHO8NvPYs1=KDE2ZyhCw2QQ@mail.gmail.com>
 <20200610233046.GA2941409@rani.riverdale.lan>
 <CAKwvOdnddAjiXDKA8fp3n2NN+R=Syp2N5DHbp1j=VRzM1dNnRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKwvOdnddAjiXDKA8fp3n2NN+R=Syp2N5DHbp1j=VRzM1dNnRw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 02:09:21PM -0700, Nick Desaulniers wrote:
> On Wed, Jun 10, 2020 at 4:30 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > Yes, the gcc driver reports an error when deciding what to pass to the
> > assembler for -gz=zlib, if it was configured with a linker that does not
> > support the flag. It's even more weird actually -- if it was configured
> > with a linker that supports the flag but an assembler that doesn't, it
> > will silently eat the flag when calling the assembler. At least that
> > won't break anything, though none of the .o files will be compressed.
> 
> Not sure whether we'd like to prevent the option from being selectable
> in that case, or just to silently not compress the debug info.  Given
> that the compression is an optimization, it doesn't hurt to silently
> not do it, but it would be nice to notify the user their toolchain may
> have been misconfigured.  Though another part of me feels "garbage in,
> garbage out."
> 

I don't think it's worth trying to detect it -- I can see it in the
source code, but it should be highly unlikely for a gcc to be configured
this way. Btw, it looks like if you configure gcc with LLD, it will
enable this option only because it thinks that "LLD 11.0.0 (compatible
with GNU linkers)" is GNU LD version 11, which is bigger than 2. Is that
intentional :)

> > No, as-option does invoke the assembler. The problem here is that with
> > -Wa, the option is only seen by the assembler, not the gcc driver. So it
> > will succeed because the assembler supports it, but it will not test
> > whether the gcc driver also supports it.
> 
> ^ Those 2 last sentences should go in the commit message, as the
> current form doesn't allude to that.

Ok.

> 
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> 
