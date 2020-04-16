Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B683C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 18:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D969C2222D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 18:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ar1Z/cb6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390176AbgDPS00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 14:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727901AbgDPS0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 14:26:25 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA11C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 11:26:24 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id d7so12345308oif.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 11:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aOBdn9RcUNTUGqzn1cwLdTTT4EHiOQc1gFprlV5Swzo=;
        b=ar1Z/cb6+XVPXZIW71AUbODqEYnpqFqNkc3U7YiTvOdft5wxlVkU0unFkA9HDD0uzZ
         f7Qg4M4jaVhmiqZIbw+yaxSenIN/ZukH+pS0zWIIW0C2lmH9jwvTreeKiozmh+qfz4Vm
         YZJ149OiSsKu2pR9KYc/jiKmkqZbQiOyi8pU0L/33IRUvpP8IAXLOvX/hc6hqz2cfr0y
         q7YWM7uIHNvWfB1Mm5359hqAgX4OuFZt6ASZYmKgNJL0omORM7WArOwtGrqDXgjbxtxm
         /KUbs+50PJsY1aprREnC5uOSM+X4+nrp7cjK4T52boSqCWDWLilGS6mZPRXSJoQQz7UH
         X2dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aOBdn9RcUNTUGqzn1cwLdTTT4EHiOQc1gFprlV5Swzo=;
        b=LVEoJtZx0z5G67ifBvgFymRa5pdGA1VCvLCzE7atW7cmcNGTviby3yp/bcG2Jr0xKr
         BvAVkn5V0TjG9hsIYNeEn/6wVyX7MVrRu42qzB9ZVyxp5mMbN0U+rI3wePkcPySoxLhN
         9R/MvqyUr0UpM1si71nT9BUhLg3v8Ydlor1srfzaemUNPfGj1tz+BNdO+j+dXqgGWZq6
         /2CdVHxybViNo9fEmEgIRwTdx2btUlSDSWm1XG7NnzPuuZ7iVWDs7QdIACFnCdYWET/7
         UyKtxWxWTIXMmfjEmcBCCprCWudHJWjuPXx0LCtiSkGpsDcJyQy2613wWcfS/PjhQDYw
         Op7g==
X-Gm-Message-State: AGi0PubwKHeKNOO1XTWZwV8VAK1UnV1f8tmPBSQ4HKW5f0dqKEFcNfe1
        tCUqeEW1FHKoPd5p/RuZ8O6XlYzVaF3GEUlK5vdkig==
X-Google-Smtp-Source: APiQypImfuGINmzUiAKm+fXdZ4ehIq2ATmivl0tU47oYeAHpGIUVxUBWrMHDUAwnjzFm3Bz2BQ3SVcXY25b83XjVoPo=
X-Received: by 2002:aca:682:: with SMTP id 124mr3885582oig.69.1587061583117;
 Thu, 16 Apr 2020 11:26:23 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200331022842eucas1p29e52dc93c4bd0b6e470c41aef19c9a86@eucas1p2.samsung.com>
 <20200331022832.209618-1-saravanak@google.com> <781eefdc-c926-7566-5305-bb9633e6fac0@samsung.com>
 <CAGETcx8aW-EY+bGEPr+20bZUF-=ghZDPyQ8AdU7eYYd-wOvekA@mail.gmail.com> <20200331072910.GC854501@kroah.com>
In-Reply-To: <20200331072910.GC854501@kroah.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 16 Apr 2020 11:25:47 -0700
Message-ID: <CAGETcx9r_t0AWVaTt5hk9s6Tti0UcNAersjXCJ_A04yJKNPtDA@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: Fix handling of fw_devlink=permissive
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 12:29 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Mar 30, 2020 at 11:18:01PM -0700, Saravana Kannan wrote:
> > On Mon, Mar 30, 2020 at 10:43 PM Marek Szyprowski
> > <m.szyprowski@samsung.com> wrote:
> > >
> > > Hi,
> > >
> > > On 2020-03-31 04:28, Saravana Kannan wrote:
> > > > When commit 8375e74f2bca ("driver core: Add fw_devlink kernel
> > > > commandline option") added fw_devlink, it didn't implement "permissive"
> > > > mode correctly.
> > > >
> > > > That commit got the device links flags correct to make sure unprobed
> > > > suppliers don't block the probing of a consumer. However, if a consumer
> > > > is waiting for mandatory suppliers to register, that could still block a
> > > > consumer from probing.
> > > >
> > > > This commit fixes that by making sure in permissive mode, all suppliers
> > > > to a consumer are treated as a optional suppliers. So, even if a
> > > > consumer is waiting for suppliers to register and link itself (using the
> > > > DL_FLAG_SYNC_STATE_ONLY flag) to the supplier, the consumer is never
> > > > blocked from probing.
> > > >
> > > > Fixes: 8375e74f2bca ("driver core: Add fw_devlink kernel commandline option")
> > > > Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > > ---
> > > > Hi Marek,
> > > >
> > > > If you pull in this patch and then add back in my patch that created the
> > > > boot problem for you, can you see if that fixes the boot issue for you?
> > >
> > > Indeed, this fixes booting on my Raspberry Pi3/4 boards with linux
> > > next-20200327. Thanks! :)
> >
> > Hi Marek,
> >
> > Thanks for testing, but I'm not able to find the tag next-20200327. I
> > can only find next-20200326 and next-20200330. I was just trying to
> > make sure that next-20200327 doesn't have the revert Greg did. I'm
> > guessing you meant next-20200326?
> >
> > > Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> >
> > Thanks!
> >
> > Greg,
> >
> > Can you pull in my fix and then revert the revert?
>
> After 5.7-rc1 is out I will, thanks.

Hi Greg,

Just to clarify, this patch is a bug fix and I think this patch should
go into all the stable branches that support fw_devlink.

The only risky change that you needed to wait on for 5.7-rc1 is the
patch [1] that sets fw_devlink=permissive by default. Well, a revert
of the revert of [1].

[1] - https://lore.kernel.org/lkml/20200321210305.28937-1-saravanak@google.com/

Thanks,
Saravana
