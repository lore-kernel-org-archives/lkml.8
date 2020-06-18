Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD71C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 22:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06269206E2
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 22:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HHlLX0nO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731510AbgFRWtD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 18:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731370AbgFRWtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 18:49:01 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52759C06174E;
        Thu, 18 Jun 2020 15:49:01 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id k13so4518525vsm.13;
        Thu, 18 Jun 2020 15:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jDIjOjdbiarDk2Fl4NccItO3BDRjCw45WmDaZ8+rKkQ=;
        b=HHlLX0nOmr6wW2RWLAku8iPrG44Nci8A5hAoFIz4UYNne5JW1NP3V+Zco1a9hQJFBo
         aOVr2SzL6FStgoGlqcxedDN3PZGcK4wElWjvSHO9fjsnl/YzVEsp2CrZ50wPiYkPBww5
         lWw+A0c8Dy0IwzCNovbCNqfZOMyI6hU1cz+lRMnOE2cVl1QO8ikpU9ZsDnK/mQc3Anfj
         mPFJdEY5Sw4qEsuO08bUKKK2ChO3ym92zuyc+6XEhq3WI9MLcYAcPo9b+J38at0QRQlQ
         hXlJCtQjf5wXp57J6WZYNu5z8NUM4ZVdFZyzxJN4168al64/KFjKXkgLZqcNarhnxA48
         NdbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jDIjOjdbiarDk2Fl4NccItO3BDRjCw45WmDaZ8+rKkQ=;
        b=dLBf+X20TLTYfFEp5DjJvyHmGeliNIFuv8uPnLGCG29y2zXA0YhyrLc/I1WL7C8B1w
         W6j0StY/QxWf/qHiwU7RPCpejt/JdhhvxfPXhsvudf3g59Z9w47kXF++EbpqSlP1Sxyw
         0wPulAhmVvh84td1QYe7OaVS4ODcXADDJRo4U//4KeseN74WM3RxVT3W1xZmM1pJTwFD
         LbzIg/j+IfxctA4xpOy7O6OD2fx8Iwg2JizD0XEyf1RIDKF5WR4/aJR0CYxh+lp3EFis
         KOxsblae37O3VpmTu/S2Mty9623NqlYcFFT4LpDazW/hzZ5dBXJ1Xz+mZLt0NWh+KaqS
         lZ3g==
X-Gm-Message-State: AOAM533drHpuS23z0W3btBG4t640nXEdGAoYzIPGBFRnC1WLpiNMRB17
        6E2vqLSkiKhSFa1UB4eafvLwRQC4v1svwyJMbbk=
X-Google-Smtp-Source: ABdhPJzuqXckBtIz1OgonMxHLlYJJSsdmJUV0kcoNtHizS2HYe9rZRSXH6UkCAlVYv1h1PPrCWOzBGu82ZvIpFSBebY=
X-Received: by 2002:a67:c511:: with SMTP id e17mr5222120vsk.210.1592520540021;
 Thu, 18 Jun 2020 15:49:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200617162536.611386-1-jim.cromie@gmail.com> <20200617162536.611386-23-jim.cromie@gmail.com>
 <20200618161912.GD3617@alley> <20200618174058.GE3617@alley>
 <746984fb-00ee-9079-efac-50167f3c3e40@akamai.com> <CAJfuBxwLKDSx6RA_ZOk=eEHw0P3FeAcT=PCr-aHjUFKDS2p8cQ@mail.gmail.com>
 <172c0580-279f-aa3e-817a-4216067bea10@akamai.com> <23396523-28c3-74e6-3e62-be68e5a5465a@linaro.org>
In-Reply-To: <23396523-28c3-74e6-3e62-be68e5a5465a@linaro.org>
From:   jim.cromie@gmail.com
Date:   Thu, 18 Jun 2020 16:48:33 -0600
Message-ID: <CAJfuBxx2KDBLX9H6N-79VPOXBwbdzSQse41azTCk0SZs7PtQuA@mail.gmail.com>
Subject: Re: [PATCH v3 20/21] dyndbg: add user-flag, negating-flags, and
 filtering on flags
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     Jason Baron <jbaron@akamai.com>, Petr Mladek <pmladek@suse.com>,
        LKML <linux-kernel@vger.kernel.org>, akpm@linuxfoundation.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Orson Zhai <orson.zhai@unisoc.com>,
        Linux Documentation List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 4:34 PM Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
>
> Hi Jason, Jim,
>



> > I would be curious to see what Stanimir thinks of this proposal
> > and whether it would work for his venus driver, which is what
> > prompted this module group discussion.
>
> Hmm, we spin in a circle :)
>
> Infact this was my first way of implementing the groups in Venus driver,
> you can see it at [1].
>
>  +#define VDBGL(fmt, args...)   pr_debug("VENUSL: " fmt, ##args)
>  +#define VDBGM(fmt, args...)   pr_debug("VENUSM: " fmt, ##args)
>  +#define VDBGH(fmt, args...)   pr_debug("VENUSH: " fmt, ##args)
>  +#define VDBGFW(fmt, args...)  pr_debug("VENUSFW: " fmt, ##args)
>

I recall :-)

I think Greg K-Hs   distaste for those defines was for using them,
as it tosses the utility of grep pr_debug

pr_debug("VENUSM:"
is barely longer than
VDBGM

with ddebug_exec_queries, you can leverage the existing format.

>
> [1] https://lkml.org/lkml/2020/5/21/668
>
> --
> regards,
> Stan

thanks
Jim
