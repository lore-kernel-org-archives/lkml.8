Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 485E6C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 08:38:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14C2D206BE
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 08:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593506299;
	bh=iL0CoVXXj2mUF49EuAzrBZzrnD/F4kq/OYEiPJhQl4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=l7iEuMHIZ4rgfh3YXQMU9N7iyGzIUxPNbYTquVGC11eFuaJUMvyKkgtlOY1s/byLe
	 bxX9MNyRDtascn9SUd+V4JOkivsiBPWKFLvzyPKvtLFklVUqkfo5pf5r0/owA++c6D
	 x3mUiFrlzNts7h/K80i/HbGBv6zIhgfjnrgMm3GI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731563AbgF3IiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 04:38:17 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40575 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731458AbgF3IiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 04:38:17 -0400
Received: by mail-lj1-f193.google.com with SMTP id n23so21503330ljh.7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 01:38:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=EbYeb+xUSTFe+QxI4hQUUuiFupYXSj7BZsfh1VgaQ5I=;
        b=Ggl1IOtScH4+WJxrgYxHM/g5rkiaZWv76iNpgzMg+7Nyxvey5stRL+yVgHBnEtt/w5
         k6TbZzzreHngcbLMXnhcNGAVE8oH3sJkLrAwnBEfqE21nq4rT6krCKP6R1DnK7dc8EdR
         8lMhNKes6V0T/pbIamxwFlbBvYilURhCfU9bmW9n1pRHuKnp9i5nBpsk3f6i8IGbn2oM
         kYdKGQQPMIoEChdlawILXLEOTJyRZA1nCxiYd9bVdTl6hiGdhdKemBqJC4N4mQOjGk38
         3augH7w46nXVva6dRA7QWILJ/Kn59FSt0oUD3bh4Xpemsx68SI9N2pH9R5RvoTTdFPjj
         t7ug==
X-Gm-Message-State: AOAM530x3fZT1hqH8WIb8iJ3zY3M0Kag5Kfw7ayXxvbrYjCdjmMl90gD
        z41aGxgHE7vjR1Tr0kvm1cA=
X-Google-Smtp-Source: ABdhPJxhA/FhqB07otgT2WGiw0kWHtHCtxa3xrejsmVvGZcRGAWXYVzCO1KjTEu3bs0EUHFbt6elcg==
X-Received: by 2002:a2e:b8c4:: with SMTP id s4mr9673092ljp.374.1593506294828;
        Tue, 30 Jun 2020 01:38:14 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id w6sm510268ljw.11.2020.06.30.01.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 01:38:13 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1jqBmM-0001nh-86; Tue, 30 Jun 2020 10:38:11 +0200
Date:   Tue, 30 Jun 2020 10:38:10 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Johan Hovold <johan@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Johan Hovold <jhovold@gmail.com>
Subject: Re: [PATCH 2/5] mfd: lm3533-ctrlbank: Cap BRIGHTNESS_MAX to 127
 since API uses u8 as carrier
Message-ID: <20200630083810.GY3334@localhost>
References: <20200629123215.1014747-1-lee.jones@linaro.org>
 <20200629123215.1014747-3-lee.jones@linaro.org>
 <20200629125102.GT3334@localhost>
 <20200629132506.GJ177734@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200629132506.GJ177734@dell>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 02:25:06PM +0100, Lee Jones wrote:
> On Mon, 29 Jun 2020, Johan Hovold wrote:
> 
> > On Mon, Jun 29, 2020 at 01:32:12PM +0100, Lee Jones wrote:
> > > Since its conception in 2012 brightness has been artificially capped
> > > at 127 since the variable carrying the value is u8.  We could go to
> > > the trouble of changing the whole API (crossing 3 different subsystems),
> > > but clearly this hasn't bothered anyone in the best part of a decade.
> > > 
> > > Simply, cap BRIGHTNESS_MAX to 127 instead (for now at least).
> > 
> > Hmm. This patch is clearly broken and would contrary to the claim be
> > introducing an artificial cap at half brightness. u8 can hold the max
> > brightness value 255 just fine.
> 
> Yes, of course it can.  Senior moment on my account.
> 
> > > Fixes the following W=1 warning(s):
> > > 
> > >  drivers/mfd/lm3533-ctrlbank.c: In function ‘lm3533_ctrlbank_set_brightness’:
> > >  drivers/mfd/lm3533-ctrlbank.c:98:10: warning: comparison is always false due to limited range of data type [-Wtype-limits]
> > >  98 | if (val > LM3533_##_NAME##_MAX) | ^
> > >  drivers/mfd/lm3533-ctrlbank.c:125:1: note: in expansion of macro ‘lm3533_ctrlbank_set’
> > >  125 | lm3533_ctrlbank_set(brightness, BRIGHTNESS);
> > >  | ^~~~~~~~~~~~~~~~~~~
> > 
> > This warning is benign. The same macro is used to defined two function
> > where in one case the max value coincides with U8_MAX so that the sanity
> > check becomes redundant.
> 
> A benign warning, as most W=1 warnings are, is still a warning.

Not every warning needs to be addressed, there's a reason some of these
are hidden behind W=1 or higher.

> So how do you propose we fix it?
> 
> Is 255 a valid and used brightness level?

Yes.

> If so, how do you feel about:
> 
>   /* Avoid 'always false' check '(u8) > 255' */
>   if (LM3533_##_NAME##_MAX != 0xff && val > LM3533_##_NAME##_MAX)
>           return -EINVAL;        

I'm afraid that's not sufficient to shut the compiler up.

I'll send you patch expanding these accessors instead. Having exported
functions implemented by macros is particularly nice (hard to grep for
etc). There are a couple of more sets of control-bank registers that
could potentially have shared the implementation and which motivated the
use of macros, but it does not seem very likely that we'll be adding
those anytime soon anyway.

Johan
