Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779E3C4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 19:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AE1E205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 19:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588016481;
	bh=PblMWBtQoFDJTZU5sYrsa18EQC2ghwnYCorJeG/zksQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=dglaEWwGeEbnbPPltpMPBzIH1UGs0OigoymC/fuwI8nt3MX0QDRGXJ76z9PcwewnU
	 jpJAgiesKopqfrW/G1IzMOcKB8+IuZ/4gx90GDutbu2UI1xR3oEnG9l+TN8/2qdmLd
	 WFqwl9rKWhcCHPv5s75zRDVGagi1iP2IJX3Ir+s8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgD0TlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 15:41:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726587AbgD0TlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 15:41:20 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE83C0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 12:41:19 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id l11so14884866lfc.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 12:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/diWUIXgSQwef0RKUapiKWcDC4ZexJVcsy5yNjXeH6I=;
        b=W+iws1Uhvb61PrxQjvV/PFk7COkKMfJT3gvdmPLDy0AkzMWVNNtRkNa0mIQQ8RS46h
         wtemENd3mU9RrYEkZPK9CWqOUc2sgBxg2g/Yks8pTCsCdB0FAAwwrV8M7mcKVgAN1jLN
         uWE2KNsGAcoRArxjWyEFkcLzSTLfR54TY0Ay8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/diWUIXgSQwef0RKUapiKWcDC4ZexJVcsy5yNjXeH6I=;
        b=MiL3Cm9lUTtPq8L8PiEjnL1nFRFCM/oqmg8ODRAYWl0t/3/Jw0DzBObibRst23aC9M
         +bQbppt5f/soSYdMnbIB5IFrHpIlz6+objZLJVKqmwkDeXnMm12sZTOy1wUoF7eL0ZRt
         gyDzlfVkYg0AKbEW4Jy2lYXn1BGydjvgazr6QQczi6v1lnFRzfel6p41TadZp3djMuif
         odjgqfRZwJ1LDmALgpr+RjE961RYxwNnRjWgjPFiBdpLr0Y6n85MZueQoIAMx6Jd8a5X
         r/w3t4H6lMdr2R8FHsKF0Mcpo1LJmjFvphj/DI6TYX9FBQvbg6s3pEnKcJJ6f1gBFW40
         ml1g==
X-Gm-Message-State: AGi0PuZT+l5AKHnctQyThSZAMmz9mMXAf6aefTOGbsGL6SR82umMqSvd
        SYb+CO1RdUSrWkxUwuoJP2ZxQsPZzA4=
X-Google-Smtp-Source: APiQypJkho1O0fFpn9dcV9E+yRhmuFKrrMcj9DJMNKqM5Easxnl44wgM0XxXvgoS217b1qmSBubShg==
X-Received: by 2002:a19:2d1d:: with SMTP id k29mr16461534lfj.46.1588016476467;
        Mon, 27 Apr 2020 12:41:16 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id a28sm11769027lfr.4.2020.04.27.12.41.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 12:41:15 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id 198so14916822lfo.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 12:41:14 -0700 (PDT)
X-Received: by 2002:a05:6512:14a:: with SMTP id m10mr16317524lfo.152.1588016474219;
 Mon, 27 Apr 2020 12:41:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200425133504.GA11354@nishad> <20200427155617.GY6749@magnolia>
 <20200427172959.GB3936841@kroah.com> <515362d10c06567f35f0d5b7c3f2e121769fb04b.camel@perches.com>
 <20200427174611.GA4035548@kroah.com> <791a97d5d4dfd11af533a0bbd6ae27d1a2d479ee.camel@perches.com>
 <20200427183629.GA20158@kroah.com> <16b209d0b0c8034db62f8d4d0a260a00f0aa5d5e.camel@perches.com>
In-Reply-To: <16b209d0b0c8034db62f8d4d0a260a00f0aa5d5e.camel@perches.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 Apr 2020 12:40:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgN=Ox112_O=GQ-kwMxYduix9gZFsr1GXXJWLpDpNDm5g@mail.gmail.com>
Message-ID: <CAHk-=wgN=Ox112_O=GQ-kwMxYduix9gZFsr1GXXJWLpDpNDm5g@mail.gmail.com>
Subject: Re: [PATCH] xfs: Use the correct style for SPDX License Identifier
To:     Joe Perches <joe@perches.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Nishad Kamdar <nishadkamdar@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 11:59 AM Joe Perches <joe@perches.com> wrote:
>
> There's no real reason not to prefer the latest versions
> over the deprecated ones.

Joe, your pedantic approach is really hard to work with. Please work on it.

The fact is, there *is * a reason to avoid the pedantic "change to new
version" - pointless churn.

We have a lot of the original style spdx markers, because those are
what we started with. And changing them is pointless.

I know you love your scripts to change things around, but to everybody
else it tends to be just extra work and noise.

              Linus
