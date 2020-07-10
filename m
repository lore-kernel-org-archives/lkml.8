Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC00C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8F8320836
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:13:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cOJ2faaA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbgGJONY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 10:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728024AbgGJONY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 10:13:24 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFB1C08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 07:13:23 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id gc9so2677713pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 07:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rz6xdVmVO1fI5J/k77Wza7Px4ula12XNoan7SjUJJ80=;
        b=cOJ2faaArVwW21X5OKc30EMsj4I3BFEhzS7380UkZEhazYSqmdqAU3HPgCMcrLYs19
         pLw4kI/iUKcES1L4dDExV8TSNgIoJkfZNxyaqUfeGgGEFYHS3A6TeRvjLnOYYnzDS3Kd
         8tRPxcrCslGJNk8s3PhNWZ5DZgiyDKu2CMQK88sMQi6Aqt8kvhyNbbpHBBEuJ1RfnCST
         xrohyXChz9nipaG+Gmw5AIlQqHSfKQnvhA6Uwnurpapjh2fcnZlc9EmtAXSwbvUjSeUU
         AtZUu7yuuf0NDjZWuJeTxaGnZOcEMr540nhwvXnuPQUTluEAdF8sG/lO/evegmdKl3F1
         +ebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rz6xdVmVO1fI5J/k77Wza7Px4ula12XNoan7SjUJJ80=;
        b=PlDC6xkSS7twmIPi8IQpbynfy6AMbdycdQezRJR88lRJO2rwITDsWrYFAR4LmnZyvk
         Fl9nzUPclPVMpehl92PrBnwTyRZcCN3Hb9S4jCKd3GVDtY/N90JtrdsFGsLej6sFObQN
         Eqo2465fiiJSlnMXj9ytjLEj5H/X9jNS5JORSdz59+olr6m5BdcZMf2RTnO/qx95NDh0
         t9gie1Vqv0hYIxqlOEW0U5oPALANwPgoNL3YhwTV+B+LX2YpHSvCpEXstLGooh51HNom
         Xnz5FioLqVn9yC9QhWS+C/gKueNUtcf+h81u9yS3rvj/RDK6q1ydB+xBiyDzcVzdBtgx
         6TdQ==
X-Gm-Message-State: AOAM532DNDQOZOIVfQPpFt0qTTazbP5AW4uDgdNUsp7mnDwKK+JN165n
        TRHo044lHWBKKDnje7VhmfA6r7i0e9mEaKdAFDQ=
X-Google-Smtp-Source: ABdhPJwKM50UBfr+PKE7fxWYybdnVEqPNANrHt+YMbWrWQQT8thi9El6zvRss9vhYeMhcLl/hZmr0eAfVX5pDlN6/04=
X-Received: by 2002:a17:902:7611:: with SMTP id k17mr59583516pll.255.1594390403488;
 Fri, 10 Jul 2020 07:13:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200708161232.17914-1-andriy.shevchenko@linux.intel.com>
 <20200708162117.GV4655@sirena.org.uk> <20200710100558.GI3703480@smile.fi.intel.com>
 <20200710110132.GA5653@sirena.org.uk> <20200710114622.GJ3703480@smile.fi.intel.com>
 <20200710120856.GD5653@sirena.org.uk> <20200710133233.GF5653@sirena.org.uk>
In-Reply-To: <20200710133233.GF5653@sirena.org.uk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 10 Jul 2020 17:13:06 +0300
Message-ID: <CAHp75VeWmWU6=ybDmQmv7ymwaHG+FxNBzZM9eBxp2Oie6MrZQw@mail.gmail.com>
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

On Fri, Jul 10, 2020 at 4:36 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Jul 10, 2020 at 01:08:56PM +0100, Mark Brown wrote:
> > On Fri, Jul 10, 2020 at 02:46:22PM +0300, Andy Shevchenko wrote:
>
> > > You mean it's being synchronised with git.kernel.org, but not yet contains that
> > > patch? Okay, I will monitor the regmap tree (as of now I didn't see any update).
>
> > 5cc2013bfeee756a1ee6da9bfbe42e52b4695035
>
> Oh, I see your patch covered a different bit of code without covering
> the stuff in regmap-irq (which I'd just handled when your patch came in)
> for some reason so the changelog made it sound like the same code, and
> at the time you submitted it the patch was incomplete.

Should I do anything to improve it?


-- 
With Best Regards,
Andy Shevchenko
