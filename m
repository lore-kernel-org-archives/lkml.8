Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5592C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 17:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EC3B2076A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 17:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AkFSpU6d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729296AbgGPRiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 13:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728402AbgGPRiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 13:38:13 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30339C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 10:38:13 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id g20so5375237edm.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 10:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RVT0J9Mnoh6KQFZ+Is1z4W+ElwDxGQDJlUT/PfjxoTs=;
        b=AkFSpU6dl4IWPv94BJbTRzhClWvrcotA8ft9jlYZBWyqGWGpijHqy3bFvogJ6NBmxp
         +RrPka0inm9ERTMBaoGlH/pu1QgWwQuEAIOWKVTpxIq5P6FK9n5ipj65Dz3s48V6Shou
         zXr553DUydsZpqrGw2gItSaEmo2RP0eZ9q0oJtsmHcQkQ8pIOizvzo381PBt4LOMUaDL
         A2V5F/X82783qDM+zPTBVaR8i1AGNyL19KnjcnJZSD4CuqybOciimS8MtpoPG3N7yXqA
         +9VVVxU/yRBNqtmbXQ0z+0jgJqH9rOhXgeduogxc0zqPI3sMJ22Vn+I6w/LD7tifHkK4
         G9Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RVT0J9Mnoh6KQFZ+Is1z4W+ElwDxGQDJlUT/PfjxoTs=;
        b=Dp1qBwqc37k1LaiebNFfp0P2VCCps0JPqWqj6XEsEe2AV+XbEkI7Pd/NXCpc+EQbiK
         qe56dIPlBEL8thqqiBLBC+HDb4SNGUxM5mtK3OsPy59AtampCsxaoxf211iCfYHC7Gau
         6WMzplbh0EsGjs51ZcFaxRf4SFPNVITVqUBu6E1xstvQ2KwQ7KilG1xgWCbtoJpJxEPf
         sGoN4qmzGUG1j2w+a/EUYjOFjv+/EEft8ZIB3o7VuBe62hv1qI+ji1Cp/sNf0n+ID/jb
         ONOtyGtzrt9tPNvL4ddQdtzPOuH5Iu+1xl+QG2Qwhj4d78g4snwDwdTO8d1SEDm4+6iC
         qmTA==
X-Gm-Message-State: AOAM53090wYKq8qO6eQ//xUjlwrGW/XV5hpFZfpzJaQTk63R0CYQd5ot
        LBndj63wmGXkXAL0qLLoSxnm2vjWFhcY11VxB2MfERqYxHQ=
X-Google-Smtp-Source: ABdhPJwj1a0ZBWmjixk6X/sNKVRUUadtEYpVwfYwK0ttL1AyGhEOnWi9jW3CgiHzo3CiylWi4K7r2yTb37BMSsAEXNg=
X-Received: by 2002:a50:ed15:: with SMTP id j21mr5697574eds.246.1594921091453;
 Thu, 16 Jul 2020 10:38:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200710002209.6757-1-apronin@chromium.org> <20200710114000.GD2614@linux.intel.com>
 <CAP7wa8LfEtEATbENjr18jTXShT+YmrAoDt4k9FK1SLpxVqViog@mail.gmail.com>
 <20200714113205.GA1461506@linux.intel.com> <CABXOdTcAZjG8aQvs+M72CFe9rAdBKZH+6x=C1Ha2aX_w0gXiHw@mail.gmail.com>
 <20200716172811.GB14135@linux.intel.com>
In-Reply-To: <20200716172811.GB14135@linux.intel.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Thu, 16 Jul 2020 10:38:00 -0700
Message-ID: <CABXOdTd4oY8TpuE1qZP--dYTJ-czdovsjmhLVbd_tTw=sApHYw@mail.gmail.com>
Subject: Re: [PATCH] tpm: avoid accessing cleared ops during shutdown
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Andrey Pronin <apronin@chromium.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 10:28 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Tue, Jul 14, 2020 at 08:48:38AM -0700, Guenter Roeck wrote:
> > On Tue, Jul 14, 2020 at 4:32 AM Jarkko Sakkinen
> > <jarkko.sakkinen@linux.intel.com> wrote:
> > >
> > > On Fri, Jul 10, 2020 at 11:25:44AM -0700, Andrey Pronin wrote:
> > > > > Why does not tpm_del_char_device need this?
> > > >
> > > > "Not" is a typo in the sentence above, right? tpm_del_char_device *does*
> > > > need the fix. When tpm_class_shutdown is called it sets chip->ops to
> > > > NULL. If tpm_del_char_device is called after that, it doesn't check if
> > > > chip->ops is NULL (normal kernel API and char device API calls go
> > > > through tpm_try_get_ops, but tpm_del_char_device doesn't) and proceeds to
> > > > call tpm2_shutdown(), which tries sending the command and dereferences
> > > > chip->ops.
> > >
> > > It's a typo, yes. Sorry about that.
> > >
> > > tpm_class_shutdown() is essentially tail of tpm_del_char_device().
> > >
> > > To clean things up, I'd suggest dropping tpm_del_char_device() and
> > > call tpm_class_shutdown() in tpm_chip_unregisters() along, and open
> > > coding things that prepend it in tpm_del_char_device().
> > >
> >
> > Personally I would have preferred two separate patches, one to fix the
> > immediate problem (with Cc: stable) and one for the cleanup, but I
> > guess merging both into one is ok as long as it is marked for stable.
> >
> > Thanks,
> > Guenter
>
> Not sure about stable as this issue does not afaik concern earlier
> kernel versions?
>

I just had a quick look into linux-5.4.y, and it seemed to me that it
is affected. Maybe I am wrong. Either case, we already applied this
patch to all affected ChromeOS kernel branches, so from our
perspective it doesn't really matter.

Thanks,
Guenter
