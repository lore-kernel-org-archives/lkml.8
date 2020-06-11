Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8657C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:25:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4C8F20656
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 07:25:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6e3B4gy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgFKHZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 03:25:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbgFKHZV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 03:25:21 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E42C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 00:25:20 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id 64so2287890pfv.11
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 00:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n9OzD1T7RKQ1aMbwbI45XX0M6uYmCBSjbYUlc3imDBI=;
        b=K6e3B4gy/SQ4URKi7p6s1iSIvQRB94WZk0eq8McqI7HWn7NDOpK3wwlmAM4JLaUqme
         Gsx2gCe+hyUCpCLSiH1JLbkm3UMkC/iiImY0dQs8Z0CTZ9ZGHShqwzCJD06QauEqtJVJ
         PLsli0/t0OdQLDATdRfaOoDn1nziNpVC7x+feh9RLxWWQ560NBDiITTIqrjnn9CoyiOu
         nFqrWk9FMTnIIN2x4CTL5cP3IT1QOEkvPRKO/5BCzvNpTLpDburw5d00w4vRgJn5/0ww
         RlO8PNAo7llokm6F385cDN5x7H8z8VBxY/vU9CwVErHwttDmP+BZYoWdj1XJPKoxRfPV
         Idxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n9OzD1T7RKQ1aMbwbI45XX0M6uYmCBSjbYUlc3imDBI=;
        b=KojnupxUmTBqn7YMc4QIugAFP06FbQI7Q7vX/l/2tbhXtS8mmWxiBt+KB8wTlSF1SZ
         eOAFS30l7StaeKMLrNTCjFMmcu7PkBrtDeJ83f/Jld5JbzUb+J69RzUw/TrFyP9IEZrf
         53q/nxwGHD7sWpM25uXaDf4zp3Nk3lxzPbvF5Ev3qzSXYwGBkF68XZIjia9Eph1dKpIt
         6lKYIetrSzj8bcobo/OrLWtUjyECHG8Zu6/jSli7cSuylzIixaqUKM8dpFrDx+RSi3ym
         EqcH0HBFI0vZK0ORHW4YdVllTHeTWfyfsWV4d3tBa/HNt0KkQ29eQjdgOhJmi3FWOqIE
         CIiQ==
X-Gm-Message-State: AOAM530Kyi59d07iqqNxd+eKpiA7WSdiAJzCJhCmtKZAv58nlRDs85Ih
        cS3rMHwY8WMdNjTV3hEAYTDHvVirXw07KIkPHPykTcBYwFzwHw==
X-Google-Smtp-Source: ABdhPJzWzcP1d4fY/oPY8kL82YYOLPike7ZE9iJ/x8hwP8GpyvnLKh6Dd4hU5oTg37lEHdzF258Xj9hqygv3FX88JRo=
X-Received: by 2002:a62:1792:: with SMTP id 140mr6217129pfx.36.1591860319487;
 Thu, 11 Jun 2020 00:25:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200602223728.32722-1-richard.weiyang@gmail.com>
 <CAMuHMdUfnmm4bXVRvFOmG5DFYR+LtcZ1UviDszr9bByiN=DO+Q@mail.gmail.com>
 <20200604122805.d2ndjmkmti6wl3nz@master> <CAMuHMdXnLUS8F4nWJBqDjoKhBmF2_ihfwe4jTGxuZ1e_WKRNPQ@mail.gmail.com>
 <20200605230610.bizp2j23ivyma5rn@master> <20200605171629.d931068c1a4d720d8faa2704@linux-foundation.org>
 <20200608223112.ftncszh7hfnmqj3m@master> <20200609091649.GX2428291@smile.fi.intel.com>
 <20200609230241.gdqebrspmucnru5k@master> <CAHp75VdVUNqUsfr19jKHjba8CPTQhbSK+WfTKwZFtCfK0JtRCw@mail.gmail.com>
 <20200610220613.ets3envsukjstvlu@master>
In-Reply-To: <20200610220613.ets3envsukjstvlu@master>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 11 Jun 2020 10:25:07 +0300
Message-ID: <CAHp75VcaDX8exWvTimzjwyLKjcKtaZyxugzWmnNMErvTZHDLQQ@mail.gmail.com>
Subject: Re: [Patch v2] lib: test get_count_order/long in test_bitops.c
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 1:06 AM Wei Yang <richard.weiyang@gmail.com> wrote:
> On Wed, Jun 10, 2020 at 01:17:28PM +0300, Andy Shevchenko wrote:
> >On Wed, Jun 10, 2020 at 2:06 AM Wei Yang <richard.weiyang@gmail.com> wrote:
> >> On Tue, Jun 09, 2020 at 12:16:49PM +0300, Andy Shevchenko wrote:
> >> >On Mon, Jun 08, 2020 at 10:31:12PM +0000, Wei Yang wrote:
> >> >> On Fri, Jun 05, 2020 at 05:16:29PM -0700, Andrew Morton wrote:
> >> >
> >> >...
> >> >
> >> >> The test on 64bit machine pass. Since I don't have a 32bit machine by hand,
> >> >
> >> >Out of curiosity what that machine is?
> >> >
> >>
> >> It is a Intel Xeon Gold CPU.
> >
> >I suppose it's x86 (and not ia64).
> >In this case you can always build an i386 configuration and test on a
> >32-bit "machine".
> >
>
> Yes, you are right. While last time I tried to run a 32bit guest, it took me a
> lot of time to setup. If my understanding is correct, to run on a 32bit
> machine, we not only need the kernel but a whole 32bit system. This means I
> need to re-install a 32bit system. And I found many distro doesn't support
> 32bit system any more.
>
> Do you have a better way to setup the environment?

Yes, BuildRoot is your friend. I have a branch [1] to make it suitable
to create bootable images for x86 machines. There is a quick
instructions what it does provide.

[1]: https://github.com/andy-shev/buildroot/tree/intel/board/intel/common

-- 
With Best Regards,
Andy Shevchenko
