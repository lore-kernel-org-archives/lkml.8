Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59ECC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 19:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97335206DA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 19:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="r4+Hnsvg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgHLTeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 15:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726574AbgHLTeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 15:34:12 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF8BC061384
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 12:34:12 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id l64so3125473qkb.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 12:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UNDeeEu8OInqbqByJ2ZOXoAVRjNpv1vP3OHX17fDEvU=;
        b=r4+HnsvgN0jJa837wtb65Cs7IAk9eOD6BOLmmqils8rqCozIQk8nMQH4UjLdQUceV9
         FutaSFNF12VW1gYyIbe9bMf24E28UUKNTS6f63KvHph8c2/tf63EykMrCPjZt/rJMKyP
         RaxNrHoQT9E7OaopVveRyAoLL6QVJf8wAhmhWB49gk6BoX+rXwkafWX5Zoulv8q6dL/B
         xny5ju9y/uT9f5/nEsCGNUHC4HaGW+7DSeISwT/u9ENEk9nejSi2Y632D2xk/CzWEONt
         +drlx/CsAIZPzWnSKOZ4LRiye5IwLqLGQ2YeCoSyTtxbIUcxoNsZP0gyIY7/VnO1F5dI
         JR7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UNDeeEu8OInqbqByJ2ZOXoAVRjNpv1vP3OHX17fDEvU=;
        b=BL/1OS3YSfelmXn45Vm2Ocpx95aPVMVm9z/Pk3aBL27+hJaCCtzCVlif7zMqRv2MsZ
         OlcT70gfPHtxHrLRnAHXH8cx9T51iZFcQBNSzmKdrYZNNKyhT6j23zkTbjSzune+ikGf
         NNLJc5y2pz1GyNgCseK3tiJt8NIBp5ZrdMwkug02Fg3vooRQZO3VAP6eF80R2Xs2wM/o
         HqtDPFzMXb5S34Sa7wfwPFH8fm9GQUs5vBL541UocASSicygkmATEO57chMeUEF8lkhf
         0DBuvPNTWm1zOUdn3vzcKGNPHbINMuhPzmbp63zQ75Y23s2G2gONUvO8uyK17VdCjr2i
         cR3w==
X-Gm-Message-State: AOAM531Mfno/30qOlUXDvcLxD+tDlAI5S46pWPgWFF/7wtCtM38gZk6p
        09nJ1XuW141lQYYhx+TxCr72/11KuGdmSv5GyXVA9g==
X-Google-Smtp-Source: ABdhPJxPajgg+Gh2SZMQyrFoBo5ccaZiV7aSQ1OH1I03oez0nz6bNWlF+MeK2Mit08rZfVypEhouZhxdPgfg4YTfPjI=
X-Received: by 2002:a37:a5c1:: with SMTP id o184mr1415589qke.323.1597260850654;
 Wed, 12 Aug 2020 12:34:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200121134157.20396-6-sakari.ailus@linux.intel.com>
 <CAMpxmJU5dG49N2FA0oSQsOfKrCr3KQ1BisON4c+nUJJmZQG=bQ@mail.gmail.com>
 <20200311085555.GH5379@paasikivi.fi.intel.com> <CAMpxmJVPTKW+sYSJ3dnfF8nLAOKEa4Ob7bpxG0KD3Tkdm+rtYw@mail.gmail.com>
 <20200323213101.GB21174@kekkonen.localdomain> <CAMpxmJVdyTkZMVuhSy0Ux8VUYTmQN_YEfH-akQsAL3zrwiz8Dw@mail.gmail.com>
 <20200810082549.GD840@valkosipuli.retiisi.org.uk> <CAMpxmJUKSR-oCGnV1E5XiAMA2nYBy5f_f8=VSoMn0zf+qF39vg@mail.gmail.com>
 <20200811080009.GE840@valkosipuli.retiisi.org.uk> <CAMpxmJWziqW-PiJPSm6aH5aXbYktMJfVjJfvfGxv8fdbWKydqg@mail.gmail.com>
 <20200812192500.GA8942@ninjato>
In-Reply-To: <20200812192500.GA8942@ninjato>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 12 Aug 2020 21:33:59 +0200
Message-ID: <CAMpxmJXzaA7M94D7O5RB1WMVPz5dK61aVO_SOsu-TGTLtBZU6Q@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] at24: Support probing while off
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     Sakari Ailus <sakari.ailus@iki.fi>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        linux-acpi@vger.kernel.org, Bingbu Cao <bingbu.cao@intel.com>,
        linux-media <linux-media@vger.kernel.org>,
        Chiranjeevi Rapolu <chiranjeevi.rapolu@intel.com>,
        Hyungwoo Yang <hyungwoo.yang@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Tomasz Figa <tfiga@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 9:25 PM Wolfram Sang <wsa@the-dreams.de> wrote:
>
>
> > Wolfram says. From my side: I'd prefer to see the
> > disable_i2c_core_irq_mapping converted to flags first and then the
> > flags extended with whatever you need. disable_i2c_core_irq_mapping
> > could also be removed AFAICT - nobody uses it.
>
> I haven't read the details here, just saying that
> 'disable_i2c_core_irq_mapping' is already removed in -next and also
> within the next days in Linus' tree.
>

Ok, then nevermind my previous comment.

Bart
