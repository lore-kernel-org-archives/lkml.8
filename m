Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB48C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 10:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 119972067C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 10:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="QDdavu3Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbgIGK1E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 06:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728913AbgIGK0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 06:26:47 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34145C061755
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 03:26:47 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id i22so17543569eja.5
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 03:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HmvvDOBbOI3Ap25LolJkNiUzAqYW/BkylmIeV4YjRD8=;
        b=QDdavu3QQmHCnnU4KwLOJr5Oqa+V9NiMQ1XwjqwN4Vf2/Yl3FamhFwkRnK9uYu0WMM
         PSIo98ml3rL98H/MFyPHXu20UitXy3KZs6DuWoJyxF5RrbDa1aPfsa1zk2tKopjDf92t
         oxo871xKdzsVRbGhOSWrfmLzWXP1g3/zK22U4SR+waK/pY8uV+I18/6oBOqI7kXsfGG+
         lRPUidIYCyv/fl7hMJdze89IE3yiK8vG8YSPcuMTCt3puxMTRgbzm+XlUiKl6PSZAZFB
         UrTltAyeJJ/5hiL9WET3bwgBk0tFhMnH+r3fxLY6lbC1V0A6JzZcriwY/wtmltFYV3GN
         TqjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HmvvDOBbOI3Ap25LolJkNiUzAqYW/BkylmIeV4YjRD8=;
        b=QSNvlsoSgSVYNyj39agkBbNTmSfQ+GNOzr+LPxv1gs3zkV//UjuwAWb2ygpa9eXIkP
         zrmU0L+g+oONmMJRKe+xVLzIR2dZ9/K5z6JkvkKYOb20MgcJPj09F0DuTl20T4nFehA4
         sMuzEjxJNXe2ODGyxNpo38bJvw+j7d09bYkaUL1u4ur3Ew0E70eyS9ZPU7DyU5tD3dWN
         9Dm6QQJVHWV0sraatkGLJ3kTaAsaGDi8w5Y1kqUtUgDsd6lSokUes3z7pjIScLN8OnLH
         3eHB8bZvdpKEG5UZrDa0XDOk5vi444GWrQqfqj0W+l8HiavWthF7ue7aqLMIDuaQuDXX
         99WQ==
X-Gm-Message-State: AOAM530lBOnMxuGim+93aAzWUrRMeev9q1XhMLgqAf/WPSC2tIFfAarc
        gKnXCyvS9nwaw6CLItkwquVNeV55RvE2O0ZKwTtUUg==
X-Google-Smtp-Source: ABdhPJzU3TRrxz7IZqvY6j9hu2ty43AjKwNnl8X1LKDXaPDRCwBiEKtxjLALYuvJMHAGMXF/jF07pg9xrPNCh4fKRnk=
X-Received: by 2002:a17:907:20d9:: with SMTP id qq25mr15792481ejb.382.1599474405853;
 Mon, 07 Sep 2020 03:26:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200904154547.3836-1-brgl@bgdev.pl> <20200904154547.3836-24-brgl@bgdev.pl>
 <26ea1683-da8f-30e7-f004-3616e96d56b3@infradead.org> <20200907095932.GU1891694@smile.fi.intel.com>
In-Reply-To: <20200907095932.GU1891694@smile.fi.intel.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 7 Sep 2020 12:26:34 +0200
Message-ID: <CAMpxmJXvhYOVkZY7LLf=v+o8E2xKTh1RYhLrdVsS9nN1XZ5QJQ@mail.gmail.com>
Subject: Re: [PATCH 23/23] Documentation: gpio: add documentation for gpio-mockup
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 7, 2020 at 11:59 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Sep 04, 2020 at 08:15:59PM -0700, Randy Dunlap wrote:
> > On 9/4/20 8:45 AM, Bartosz Golaszewski wrote:
>
> ...
>
> > > +GPIO Testing Driver
> > > +===================
> > > +
> > > +The GPIO Testing Driver (gpio-mockup) provides a way to create simulated GPIO
> > > +chips for testing purposes. There are two ways of configuring the chips exposed
> > > +by the module. The lines can be accessed using the standard GPIO character
> > > +device interface as well as manipulated using the dedicated debugfs directory
> > > +structure.
> >
> > Could configfs be used for this instead of debugfs?
> > debugfs is ad hoc.
>
> Actually sounds like a good idea.
>

Well, then we can go on and write an entirely new mockup driver
(ditching module params and dropping any backwards compatibility)
because we're already using debugfs for line values.

How would we pass the device properties to configfs created GPIO chips
anyway? Devices seem to only be created using mkdir. Am I missing
something?

Bart
