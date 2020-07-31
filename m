Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D906DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 20:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6F5A208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 20:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UZSCRrsN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728044AbgGaUxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 16:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbgGaUxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 16:53:46 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9789BC061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 13:53:46 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id z5so16651978pgb.6
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 13:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ASoX6rfz5bQ5FIRAlZmP6CuXAEI7tVxg2VHGvZXSf5k=;
        b=UZSCRrsNvb7U/6sNOg0nmvM1lhYADZr3xElqLrwf1FAjVXCKUcYXAIB3qluyiUZIIg
         s7Oq8+0gDmPXofchwzcv+GI6UllQAsKwyidQTh4v8czpYX2AUJdfxfRiODZQc/e25ejQ
         4xkCeSRR30UicbY7lFNufWjGwYcHhIMy9yOwjC08T0y9wWFOQaWiAPEVeC1DBxSGRrTm
         w4GiRFgXHOZATK+L7tbeqedgQNwoVvhpwp9oWpewbKI4GPB/NS3sCurlzLHWLrMQ+72B
         3IJyUAei30wFb/kjH1F2VtiY/FNEusyd293eHctGgBsM5yuvoG66Ry1nP3iXobG/XcmW
         Fr4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ASoX6rfz5bQ5FIRAlZmP6CuXAEI7tVxg2VHGvZXSf5k=;
        b=lCDBrwD1Ep1o3wN1Ln4zrNFVMos2lzu4DS+NncIoS/+YVHm3agZqJeJy6FOHE2kyri
         8WKMNxwsdyo4VT+f5DqWjpG4N/b4MzGd4t4q40Bpb7p+HTTJgg3cKgt8xVc94irOTuTs
         JOmCxWTsIuztCCg/l/hJA3C5P2NfHAG6kp0E2FzytTM+icLIeSlPTKn3oQ51MmoLpn3a
         qVqIrfz9RJnnMT0j7yVBFJPtr15/Wgwa89WBsP0K2CzxQtgElSQdW5rdy3TQQUBYkyn9
         EA5f5c61+3efya8NAfqE9qbzXlAj4cEQ4EUmvmYtavgSsSlYanOJaWSdNhgoFVuVg4y+
         PKRA==
X-Gm-Message-State: AOAM5318XBMcd4VEkyAZzzqy9K+NF4bherBRqq9yobnhYgaR22VN4WNS
        WFRJJkJDiFJ1JlbOauTcyQGXdj2frqacF4optTNjyA==
X-Google-Smtp-Source: ABdhPJyGqtQD45YZn7SMj9UvX8QA2GrLrcjRcPgtKJyDQA1M9yb7pFOzWaaAvNB0t6w5NBwOk1uD61A2Sph/u4r9BdI=
X-Received: by 2002:a62:6484:: with SMTP id y126mr5561234pfb.166.1596228825718;
 Fri, 31 Jul 2020 13:53:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200730121656.45302-1-98.arpi@gmail.com> <CAFd5g46wpYxF1=bs3LvXeVg6mPHrT6Ggp=QxScaf87O=yqcpBA@mail.gmail.com>
 <3aae0ade-1a61-5d28-94ee-6b0eee7c7be6@gmail.com>
In-Reply-To: <3aae0ade-1a61-5d28-94ee-6b0eee7c7be6@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Fri, 31 Jul 2020 13:53:34 -0700
Message-ID: <CAFd5g46OBRKFbTAPgq63A5pTaL88D83NjuTP9vK_qwPFxBNBSg@mail.gmail.com>
Subject: Re: [PATCH] lib: Convert test_uuid.c to KUnit
To:     Arpitha Raghunandan <98.arpi@gmail.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 3:02 AM Arpitha Raghunandan <98.arpi@gmail.com> wrote:
>
> On 31/07/20 11:20 am, Brendan Higgins wrote:
> > On Thu, Jul 30, 2020 at 5:18 AM Arpitha Raghunandan <98.arpi@gmail.com> wrote:
> >>
> >> Converts test lib/test_uuid.c to KUnit
> >
> > Can you add some more detail to the commit message? Maybe link to
> > KUnit and say something about why this change is beneficial.
> >
> Sure, I will make this change.
> >> Signed-off-by: Arpitha Raghunandan <98.arpi@gmail.com>
> >
> > Change mostly looks good to me.
> > Thank you for the review.
>
> On failure, the original test calls another function which prints a detailed error. I removed it when converting to KUnit. Is this required?

I think that's probably Andy's call. Do you mind calling out the
segment of code in question?
