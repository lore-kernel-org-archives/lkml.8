Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B138DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 06:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AE1920866
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 06:51:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="K59azOHE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726238AbgHGGv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 02:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgHGGvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 02:51:25 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9AAC061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 23:51:25 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id d6so953877ejr.5
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 23:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GEqwqYzm5hBTHtEMjhPr1RMlBJXotR2ShP/q7XiMds8=;
        b=K59azOHEihLKYtrXBJVdrZ9lhi1MRP4V4B+xsIG+UgkqMVo3Lkigc03xj3IsnpNAtz
         aJhPq1/rFY0tVuSGO4AElm7fKIdIwRNJzcWXUbCyGYZ8DAVto/qzsbBENy4k1EHiRFeR
         1YtgZwuRZLSWv8L58z6bY2Yf7qcnOQvWCU8G0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GEqwqYzm5hBTHtEMjhPr1RMlBJXotR2ShP/q7XiMds8=;
        b=Twdwx3S808iHzstWR9+Qi/73QSTEuIiXcYvWv61IqWyvIof+ab/2ua8UhuPN1643qI
         gaLUOCX0Qh3jsEXcSLfsEXTa1DqfO+o27BhIq58noFrqBArT5nHSs5pbaKcrEAmJY8sQ
         uhDkuznfTvVApu84h6tLE56ZbuUYfXL5bF5Y606Y3kR7HC1LPwH5OCciZlGyBMDMGjtv
         tFeb9Kn5hQaQVWu4AWfYpVtagwV4KBX3Zy/R4af58dVqAhSJQ1FSkYjSvpKUdi3NGrgD
         ika0KXbXjgaW5C28zNqjHPmaQPiYf65ufXfbIXRNuR6ZcaE8297TcS+bOTj6cLU3r9HO
         TYYQ==
X-Gm-Message-State: AOAM530ksVSQmiMqTr6b+g8+Ua99GtJ565WQyrk1Bm8uW44v+7U59ofm
        b+sfJv0ANTP0oCwNGRlgMP+QA432Fi5QqiR4jCKmhQ==
X-Google-Smtp-Source: ABdhPJycBsYihQ6WLQL2DbLBiaCDD4ezOrWrW6HMoL9l4LCvH6nKVPnySRZpJBF1oivhsog0Z9+pM75cdoeYDcnTiNQ=
X-Received: by 2002:a17:906:38c7:: with SMTP id r7mr8318245ejd.118.1596783083914;
 Thu, 06 Aug 2020 23:51:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200710144520.RESEND.1.Id0f52f486e277b5af30babac8ba6b09589962a68@changeid>
 <20200710070332.GA1175842@kroah.com> <CANMq1KDcKWgyYYP_m0-WV7602g7zUbU0PPkvwXxbSTF5vFfKGQ@mail.gmail.com>
 <CANMq1KC7CgUT+neoOUZbnr8MbDgqEikqt2vn8dxAS1rpX=C2aA@mail.gmail.com> <20200807062809.GB979264@kroah.com>
In-Reply-To: <20200807062809.GB979264@kroah.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Fri, 7 Aug 2020 14:51:12 +0800
Message-ID: <CANMq1KD_hJ_ST3du7dcSd8GBtdL4d-C1pWbxXz8Wu8w79-2fUg@mail.gmail.com>
Subject: Re: [RESEND PATCH] media: atomisp: Replace trace_printk by pr_info
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        devel@driverdev.osuosl.org, lkml <linux-kernel@vger.kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 7, 2020 at 2:28 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Aug 07, 2020 at 09:50:23AM +0800, Nicolas Boichat wrote:
> > On Fri, Jul 24, 2020 at 8:41 PM Nicolas Boichat <drinkcat@chromium.org> wrote:
> > >
> > > On Fri, Jul 10, 2020 at 3:03 PM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Fri, Jul 10, 2020 at 02:45:29PM +0800, Nicolas Boichat wrote:
> > > > > trace_printk should not be used in production code, replace it
> > > > > call with pr_info.
> > > > >
> > > > > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> > > > > ---
> > > > > Sent this before as part of a series (whose 4th patch was a
> > > > > change that allows to detect such trace_printk), but maybe it's
> > > > > easier to get individual maintainer attention by splitting it.
> > > >
> > > > Mauro should take this soon:
> > > >
> > > > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > >
> > > Mauro: did you get a chance to look at this? (and the other similar
> > > patch "media: camss: vfe: Use trace_printk for debugging only")
> >
> > Mauro: Another gentle ping. Thanks.
>
> It's the middle of the merge window, maintainers can't do anything until
> after 5.9-rc1 is out, sorry.

Huh, wait, looks like Mauro _did_ pick it (found it in this email
"[GIT PULL for v5.8-rc7] media fixes").

My bad then, I was expecting an ack ,-)

Thanks!

> greg k-h
