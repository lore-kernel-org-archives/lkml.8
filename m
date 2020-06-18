Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E00C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 05:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F7412186A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 05:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="puqklF0y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgFRFCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 01:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgFRFCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 01:02:52 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E12CC06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 22:02:52 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id dr13so4983681ejc.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 22:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jjaCsrpPxOnBRDGiMS4P7h43F7hdfNpMzgEF2aqYAy4=;
        b=puqklF0y/QZHfjHhYdRpjtuu1ZzeQrxZmlXk7NgjlYWI1KaoDUPu7BAlV9yiXyGYBb
         MzqWB8JT2ziY2D8LTcHZygz1xXOh6WElDKIt5KFc56Hz14hyc/HDvu7/hBYu1UDIg+By
         Bs61xes0fdsXzbH2QLTWgF2i88Q1lj8XcAD6pfSdCp+YNMQt2EHoR9LfNlS5/e4+fh/d
         SLVevi7WMqbFdSMBcKHl7/7+c2LtbNqNALPDD9xdcrZMEJKRjqxE3w3m6NWuPsHBj4Pu
         Cebg4HthbsVrqWTKmjUwIRqZtn8zzEGkgiLiT2Mk/ivBdqIoNOjd/LbQy2lqmDKp5CVt
         9oDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jjaCsrpPxOnBRDGiMS4P7h43F7hdfNpMzgEF2aqYAy4=;
        b=nDoElTt/DbXAHNlgek3Alg47uU1lGpgIxcFQ4aRm67lyiIqi4BX6b3jU8ruZW/nEae
         NunZ2eIZ/bQ2MaVz0ceEHIwNMRmjOOFTGH8p3hf+TOOY+/8q3Dqv9JTpQJ7kUs85IP/h
         Y8P2qIDoMb+R/dcMssramJJ8feB6jYJQ8+yxCVhzXYvZSDjl8McpPrgtnmnLa3HkcOC5
         KfdEpk/hA5SPBnTSEw+bZkt0onrtp3WQNT7Bbp9Fai/MGItG09yodYp6IB8PKvi/KsrG
         3OQm9GTJLJwqK/KlcxW45feoqGCCmpKHjUnMsF3js33Pp7IlpqAUq+8U4QNUlq785G/u
         fjOw==
X-Gm-Message-State: AOAM532pJ6DJ0zQC5bC7JttaFjI8dgR+1dWiabjMdzntzhpFlbqvyUKY
        RFKQ4JRHc9F/gNrgHgaE+WI=
X-Google-Smtp-Source: ABdhPJzeGlD6qx5HQy86J6NI+GewLFqPUAFvMRnB8le49W08F8FnnABruo3wU7NEuyXTRFRVbPXG8g==
X-Received: by 2002:a17:906:7751:: with SMTP id o17mr2410122ejn.111.1592456571382;
        Wed, 17 Jun 2020 22:02:51 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:b7f9:7600:b172:c4ad:b420:2811])
        by smtp.gmail.com with ESMTPSA id dj26sm1265966edb.4.2020.06.17.22.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 22:02:50 -0700 (PDT)
Date:   Thu, 18 Jun 2020 07:02:49 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sparse: use identifiers to define address spaces
Message-ID: <20200618050249.lqwznznltm3lcykr@ltop.local>
References: <20200617220226.88948-1-luc.vanoostenryck@gmail.com>
 <CANiq72nNQ+11ch7sRjLLc33s_OkftuOqgGkCDggq88tbJtdPNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72nNQ+11ch7sRjLLc33s_OkftuOqgGkCDggq88tbJtdPNQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 03:22:15AM +0200, Miguel Ojeda wrote:
> Hi Luc,

Hi Miguel,

> On Thu, Jun 18, 2020 at 12:02 AM Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> >
> > diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> > index 21aed0981edf..e368384445b6 100644
> > --- a/include/linux/compiler_types.h
> > +++ b/include/linux/compiler_types.h
> > @@ -5,20 +5,20 @@
> >  #ifndef __ASSEMBLY__
> >
> >  #ifdef __CHECKER__
> > -# define __user                __attribute__((noderef, address_space(1)))
> >  # define __kernel      __attribute__((address_space(0)))
> > +# define __user                __attribute__((noderef, address_space(__user)))
> 
> I guess `__kernel` moves to the first place since it uses the first
> address space?

No, there is no really an order between address spaces. Even before
this patch, the number were only used as an ID to distinguish them
from each other.

I just moved __kernel above because it is quite different from
the others because it's the default one, and so:
* it's never displayed
* it's normally not needed, nor in type annotations, nor in cast
  between address spaces. The only time it's needed is when it's
  combined with a typeof to express "the same type as this one but
  without the address space"
* it can't be defined with a name, '0' must be used.

So, it seemed strange to me to have it in the middle of the other ones.
   
-- Luc
