Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EBAC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 07:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83AAF20899
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 07:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C0JO+OqU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbgFRH4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 03:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727964AbgFRH4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 03:56:18 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198EEC061755
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 00:56:18 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id c11so2898890lfh.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 00:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9krHxDm9232DkZH73IfiKQDn78nhY5adj2UGMySsUag=;
        b=C0JO+OqUyzOIPzVhe0IKx5WiIHZGVLIjjF8TPiG06mccd1TI0Qcu4Z8e7q4ImmuvWC
         y/zNLAWSG6DGOwuj4XlorHkNxi0G6F/mXRLNYhYVUVTiSyEBK26ys7DSNG6a90kQAjuC
         oIPSY50dBh7S1WLtoJDf1JDy5g7zWJwC0uCEbfA/4kksWZDQU5m95QeW9tvVNk9PBjJm
         wbPoRxwcQFyRiP807OppItugR1cicnXpSfHpZY7shsPjFCva1FhO9KZ6WtXs9Ou8WrOD
         gDBwGOVmstHfGaW5MpoWs457chL7M/SCdEgJmd7uAMdZc178bvY+yIHqi1eCRxnGzIfH
         IBiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9krHxDm9232DkZH73IfiKQDn78nhY5adj2UGMySsUag=;
        b=iSsfWRAqEPUoksKfMFTuImk7BssCzIsqs/XB4gL2qLmmBxN2FcDW4H/shB082zWoRb
         /WkZvUajxHrxZ2ye5949nTA0z03xCJu+sRO5x1NBMFK1w1Ma1p6IsBS6r317LH8v/hgy
         idMbbe0r0R4nb/BhgtpOggV4l0Me7fo03d0UdFCWDgXAkFfbW+Qqp7HFLTnZvL53C6oO
         /yZxfU4CkNAAiusWto49wHSGAPnN4ntFApTXYoR5w2if1ow1unAyl1IBvnGQfaKcOJS4
         /mS2MVdLq9cQk64m73EgXtR11125uayWFgyfH/QWKY0K6oauFYy0hqr/iz1nJSvGJsY/
         Midw==
X-Gm-Message-State: AOAM531FB/DAgECAqX7aQhw08g0JaxmrdSf6zE7HZQLoWzvRXb1E3USv
        +nzcglndkFA6zHrk5jfQCcVgYA==
X-Google-Smtp-Source: ABdhPJxI+czQ4wnj4ttlJ5Va+zsODJ2h7H00X3rtIM3suScO0bPx40diTMspq4kLSgr9XVn87noe3g==
X-Received: by 2002:ac2:5df2:: with SMTP id z18mr1652377lfq.151.1592466976306;
        Thu, 18 Jun 2020 00:56:16 -0700 (PDT)
Received: from jade (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id e21sm526724ljb.135.2020.06.18.00.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 00:56:15 -0700 (PDT)
Date:   Thu, 18 Jun 2020 09:56:13 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Maxim Uvarov <maxim.uvarov@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>,
        peterhuewe@gmx.de, Jason Gunthorpe <jgg@ziepe.ca>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, Arnd Bergmann <arnd@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCHv8 0/3] optee: register drivers on optee bus
Message-ID: <20200618075613.GA97184@jade>
References: <20200604175851.758-1-maxim.uvarov@linaro.org>
 <CAD8XO3YTz=xN2k5h8HsrYsLUgmC6dD57XbBj63e+3_xFF1H0rw@mail.gmail.com>
 <20200616082907.GA2305431@jade>
 <20200617233755.GI62794@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200617233755.GI62794@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 02:37:55AM +0300, Jarkko Sakkinen wrote:
> On Tue, Jun 16, 2020 at 10:29:07AM +0200, Jens Wiklander wrote:
> > Hi Maxim and Jarkko,
> > 
> > On Mon, Jun 15, 2020 at 05:32:40PM +0300, Maxim Uvarov wrote:
> > > ping.
> > > Patchset was reviewed and all comments are codeverd. Optee-os patches
> > > were merged. These kernel patches look like they are hanging
> > > somewhere...
> > 
> > I'm almost OK with this patchset, except that
> > Documentation/ABI/testing/sysfs-bus-optee-devices needs to be updated
> > for the new kernel version and TEE mailing list which we're changing right
> > now.
> > 
> > The last patch touches files I'm not maintainer of. That patch depends
> > on the previous patches so it makes sense to keep them together.  If a
> > TPM device driver maintainer would ack that patch I can take it via my
> > tree. Or we can do it the other way around (with a v9 patchset),
> > whichever is preferred.
> > 
> > Cheers,
> > Jens
> 
> Probably easier if you pick all three and I ack the one touching TPM.

Makes sense, let's do that.

Cheers,
Jens
