Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C50C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 23:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2D91207D3
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 23:52:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fAwR1eMp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgFPXwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 19:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgFPXwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 19:52:13 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC81C06174E
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 16:52:13 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id v14so358416pgl.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 16:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6ZttGvOU85rV7DwxVDB2QehNWH/NdI5i83PeBcspPK0=;
        b=fAwR1eMp65J4O5xV+kC6VagulZrCE6RG+VzybQXOKZwY+uLDA/CyOvVYODBP2hPP6m
         sLp7XSOx3zpPtFugWnUnel7pBvyCxpikm7sAPYUUUznr+dtheBk5xVxvwchuBk/hkeAu
         t14JCZkk3EIHMQMvpFtR7yYjJQ8KRxB1F8doQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6ZttGvOU85rV7DwxVDB2QehNWH/NdI5i83PeBcspPK0=;
        b=pe2BIxD5w5dt/ntiLUMARzsPESWwX5MGxNaXODL46KT3OHq2FA2TjoujCgCAqvl2AV
         Qn9oFZ7go6EUYGJil2NilyWbkPDMzRP+d6b3cRvzzTWYp1CdXhDO6SN7cqsjKjZCh+no
         YUhh6hL/cwF21RZkIYwr5yWXiaxnApFx4zy0MdBgwCCHcqAHdBJRJZndYJGlmK8cqHNo
         T/IR8kE+PSZRFtMEfX+0GEUhmNMJeb/MhpRyVeLu42lTKn8V3+tLOw0TqgSHVsnuqmcR
         N7/mTypts4w3eL6bhetKWUpz2i9nIrh8sYp+mBx7I0tIDTjr9zUTRs7htNc2KFiAzkGT
         3Rmw==
X-Gm-Message-State: AOAM531oVFvxcEwCi3mcmmMVaqJt13JQTke+bvd2e1c6MzylM2Gq5RVj
        gNSbNDQ3KPJQUAd+aJcvZyWzjA==
X-Google-Smtp-Source: ABdhPJy8SUzbo7FQSLKRI4RDlQECIGeeur1vAtuTCdtv/vc46sTyJmjtzwunu9fyKZyoo/dihQjpAQ==
X-Received: by 2002:a62:1d8e:: with SMTP id d136mr4074897pfd.323.1592351532598;
        Tue, 16 Jun 2020 16:52:12 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c2sm14988615pgk.77.2020.06.16.16.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 16:52:11 -0700 (PDT)
Date:   Tue, 16 Jun 2020 16:52:10 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Bird, Tim" <Tim.Bird@sony.com>
Cc:     "shuah@kernel.org" <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Gow <davidgow@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: RFC - kernel selftest result documentation (KTAP)
Message-ID: <202006161642.A5F50ED07@keescook>
References: <CY4PR13MB1175B804E31E502221BC8163FD830@CY4PR13MB1175.namprd13.prod.outlook.com>
 <202006141120.96FF8C5@keescook>
 <CY4PR13MB11757D57CD441C5CAEC3F257FD9C0@CY4PR13MB1175.namprd13.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR13MB11757D57CD441C5CAEC3F257FD9C0@CY4PR13MB1175.namprd13.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 07:07:34PM +0000, Bird, Tim wrote:
> From: Kees Cook <keescook@chromium.org>
> > Note: making the plan line required differs from TAP13 and TAP14. I
> > think it's the right choice, but we should be clear.
> 
> [...]
> With regards to making it optional or not, I don't have a strong
> preference.  The extra info seems helpful in some circumstances.
> I don't know if it's too onerous to make it a requirement or not.
> I'd prefer if it was always there (either at the beginning or the end),
> but if there is some situation where it's quite difficult to calculate,
> then it would be best not to mandate it. I can't think of any impossible
> situations at the moment.

I think we should require one of:

- starting plan line
- ending plan line
- ending with something that indicates "I'm done, but I have no idea how
  many tests actually ran" (Maybe "1..?")

To me, the point of the plan line is to be able to say "this test did,
in fact, finish". So even if some test can't even count how many tests
it _ran_, it can at least say "I am now finished".

> > TAP13/14 makes description optional, are we making it required (I think
> > we should). There seems to be a TAP13/14 "convention" of starting
> > <description> with "- ", which I'm on the fence about it. It does make
> > parsing maybe a little easier.
> 
> I would like the description to be required.
> I don't have a strong opinion on the dash.  I'm OK with either one (dash
> or no dash), but we should make kselftest and KUnit consistent.

I find the dash to be distracting -- it doesn't help me scan it, and it
doesn't help a parser (which only needs to find "#").

> > > Differences between kernel test result format and TAP13:
> > >  - in KTAP the "# SKIP" directive is placed after the description on
> > >    the test result line

I sent a bunch of clean-ups for kselftest.h recently[1], but it looks
like we'll need more for adding "description" to skip (right now it only
prints the SKIP reason).

[1] https://lore.kernel.org/lkml/20200611224028.3275174-1-keescook@chromium.org/

> > Yes Documentation/*.rst Not sure on name yet, but where do kselftest
> > docs live? :)
> Documentation/dev-tools/kselftest.rst
> 
> I'll put this at: Documentation/dev-tools/test-results-format.rst

Sounds good!

-- 
Kees Cook
