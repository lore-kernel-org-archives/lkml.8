Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC9BC433E7
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:13:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC435207DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kj+qoxxB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgGJONE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 10:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728131AbgGJOMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 10:12:12 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91CBC08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 07:12:12 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id 72so2313628ple.0
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 07:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=muBce3IUa+wPFXJgVmo9e/4Gh0cu3fqX5sLtUd9ccC8=;
        b=kj+qoxxB8his39iWNt78qr7SHRjZO4qqyfgzR32JD5Ukjyv9eBAVEo0otUiZCyN0/r
         HW7JdE9b+FAMo3/8urdtbNzVKwVNzjDotfvqZT5NPaEozSeNVtg7fOUexuOgoNs6GNFD
         xfJO38tqRwaNcwlkROvdMyeFzlNcDq9fRJZuR86yCJGPaR1kS1wQkpFtS5OFVW02mEwk
         hwUrHayp5yntid/HqVQLnUYGDjDRLVZ1E0FhfYVxPepnCvJzuaDIMQxsNYZ7Lt8a8wpO
         LN+YDY8Y4gtGkE1MkOsCa18/sHHDksvlPQfmyYiF/pCDzFPOKOSknkiQgORgm7LNzduw
         rdZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=muBce3IUa+wPFXJgVmo9e/4Gh0cu3fqX5sLtUd9ccC8=;
        b=VqJYiOl2HBmYjpAuo2rdn4EQKX9fWiC1Gah4QBN+kXYHLPzOqgZg0DZ0JS6Vi7lDwi
         SpqpKGKsLIvwVtkgB7ZobH3kukg2tVUxu8obAbEeBmPKPzwISUg4s/TmABHQQ1KFuhpY
         0Oez34+8iTJB10Hfu2npwMesIgiGsrnU0LZmtLFMQI/6RXc1qDmnnQtTrAD5jjK5Fran
         FOc0pKZZo3vAxrXR+NsKXJtg4QWocPmDIXGCt2coDnSu7ayUee7AUkUSoxEHFQKFif2y
         6295lKgAzMybb2ECAyzLrJGCTJH5mrk71z2xJorJkLgVOF8OHLiQ4Ff7qY++n6uH9bjR
         l41g==
X-Gm-Message-State: AOAM530FK9cdvMd8W9Ru/p5ktld0asu/few4931Y+HzeigTTP6jLIwgT
        MEyAhpxOr3rSHM84nDcTfIFdOY7BYWVJgaTjqLcPHo3B
X-Google-Smtp-Source: ABdhPJz/2bKSVq1xkbn40jQlOqhNk/US3g2ZzhXFBwphGuL5/g1M5agcvZ2HiAPWX6fMIGx5byxozBhKyZ+PsdBhMk4=
X-Received: by 2002:a17:90b:3547:: with SMTP id lt7mr5865262pjb.181.1594390332149;
 Fri, 10 Jul 2020 07:12:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200708161232.17914-1-andriy.shevchenko@linux.intel.com>
 <20200708162117.GV4655@sirena.org.uk> <20200710100558.GI3703480@smile.fi.intel.com>
 <20200710110132.GA5653@sirena.org.uk> <20200710114622.GJ3703480@smile.fi.intel.com>
 <20200710120856.GD5653@sirena.org.uk>
In-Reply-To: <20200710120856.GD5653@sirena.org.uk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 10 Jul 2020 17:11:55 +0300
Message-ID: <CAHp75VfukDNXksxZPeLHccn66ZsTwG99Vetmyp71WJGFTC5Ngw@mail.gmail.com>
Subject: Re: [PATCH v1] regmap: Switch to use fwnode instead of OF one
To:     Mark Brown <broonie@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 3:11 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Jul 10, 2020 at 02:46:22PM +0300, Andy Shevchenko wrote:
>
> > You mean it's being synchronised with git.kernel.org, but not yet contains that
> > patch? Okay, I will monitor the regmap tree (as of now I didn't see any update).
>
> 5cc2013bfeee756a1ee6da9bfbe42e52b4695035

And how is it the same as the proposed patch?


-- 
With Best Regards,
Andy Shevchenko
