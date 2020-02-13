Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0C4C352A4
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 00:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50390206DB
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 00:06:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nziJvcKq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbgBMAGw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 19:06:52 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42446 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbgBMAGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 19:06:52 -0500
Received: by mail-qk1-f193.google.com with SMTP id o28so2628219qkj.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 16:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EDJUToEt64sYdPk/trsg/w/cAFjxyyVNajzKkjxTLpM=;
        b=nziJvcKqFRJii0hlM0b1yxzorRxDn2DultIEe1tCLiSjxuNnSO1bXttdnxOZZsgvLN
         8yK0bAvZ/Rokl9Vtpp8Ruigs+ZYZ+LIN4JdyBTjZe07DHYmsp0OCSfddvYVaCOsC8Uou
         0s+6PqARSelT27SF65WkbORzoubddvlDEXSAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EDJUToEt64sYdPk/trsg/w/cAFjxyyVNajzKkjxTLpM=;
        b=FWGQtSHh48YU4CaE2H58galAjtcui3CXMTlYAeJliiYapFYtAUdYiMJAzJWxKTsI/t
         Xw5E3zxP0czM5MBQAef821GHTaog1eUlN/KXj5YNQ+xOT8xnNBMwTo1xPxOtwdP847/T
         STMKCOREjlatbsHsc6W6jKzAufzHWn24RIkT1EWUqhYSzq9CgiiSaXIAPUEARDj1GNRV
         lomnbEssoQ9JL2bzsJHkB/VDDhmss/FY/VqMKmInI0b816IipRCLILdvLzbKUD5rutlN
         IvnXwjRVEJThTPwHMViNnYsVJvMGVNPaneiijo5f8qJh3tpmGQSo7yC1EYNBG5ZoBrcq
         fB9A==
X-Gm-Message-State: APjAAAVg0Xg0PyY0nacMUHZmEpLIgabI7vLlV8snI8buyEqivlInlg85
        4LNrFCZIjZaSsiSfHz/qzn1H9rejAOfNrDf1I8J6kg==
X-Google-Smtp-Source: APXvYqysZTAX6q7Ru/YaQ5ufa8rnGlLHqhM7dXnZKo1GenZCZZPoChIMT6FeNZFkhvJpov1IoPaCYAR/CjsySzL1LFY=
X-Received: by 2002:ae9:ed88:: with SMTP id c130mr3326135qkg.299.1581552410838;
 Wed, 12 Feb 2020 16:06:50 -0800 (PST)
MIME-Version: 1.0
References: <20200212075529.156756-1-drinkcat@chromium.org>
 <20200212081340.vcfd3t5w5pgxfuha@vireshk-i7> <CANMq1KA1=LTtCD2ic7GcskX7izuEkAqUo1xxwwCXBeTLi0r5vg@mail.gmail.com>
 <20200212090356.x6aieuddym5zea5d@vireshk-i7>
In-Reply-To: <20200212090356.x6aieuddym5zea5d@vireshk-i7>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Thu, 13 Feb 2020 08:06:39 +0800
Message-ID: <CANMq1KCut88owb2r5_uHi-k57io0T_D9ag0rf==UAEsqoH07eQ@mail.gmail.com>
Subject: Re: [PATCH] PM / OPP: Add support for multiple regulators
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 5:04 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 12-02-20, 16:57, Nicolas Boichat wrote:
> > I see... And you're right that it's probably best to change the
> > voltages in a specific order (I just ignored that problem ,-P). I do
> > wonder if there's something we could do in the core/DT to specify that
> > order (if it's a simple order?), it's not really ideal to have to copy
> > paste code around...
>
> I will suggest adding your own version (like TI) for now, if we later
> feel that there is too much duplicate code, we can look for an
> alternative. But as of now, there aren't a lot of platforms using
> multiple regulators anyway.

Will do. Thanks!

> --
> viresh
