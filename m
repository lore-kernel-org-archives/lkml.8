Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE866C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 14:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6BD12223F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 14:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eCqbaZT2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730920AbgDQOKt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 10:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730563AbgDQOKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 10:10:48 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB243C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 07:10:46 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id q22so2207721ljg.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 07:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v1W0PODyJVZoCKaKuCcq89qVrtLZR8TZE0fDKQteYlY=;
        b=eCqbaZT2CqSL+BVAbe8ZLyMgaFBngLYb6BoZKqsSYq47MuzhIaw7uNXYR87pvvZHyd
         q+SAZ5qYuLMJErUhlnuJjUkFl2hDpdvA4D3m3t8KUpq1Q8500oIwMMXUXMN4Ls6WwV4D
         geeKFWdYPOzoycUa13WJZX8hCXQXbg+XXSLwMlPUbiqvkQifhJynENRCJ8XtTzs/edH4
         G0aWAnxkSNcGQGNKxwcnjrhPtzsNXy0FD4GMwqBWfvFp0nP2eKFGdB4AHp9SbA637E/l
         VWR13bVyuyyQmXlnx92Eg5m0zXE3IvIgDlHoboQnsjUPu0KhRjAF3t5IjiFiJu/VxPfF
         Bo/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v1W0PODyJVZoCKaKuCcq89qVrtLZR8TZE0fDKQteYlY=;
        b=RNL7yp0+sMRs0ZcoIYwyYqMdVRygXdscZYEpb4Idn5kR0I6Is23lZ1Oo6kom/OHY50
         mRo52J244jDhM/Txq53bfVrf+mXPLKCKPBW1iqmGGnG14LFHhHAA0rmzs/khuSRz9AUA
         Eg5D0OXZkcrFmFZmePD1z2iAZvCXEcLvKrU/HJAXzKXKbqP9FqvqoqmZikIRPgEpc4q/
         mNN3/Ri8SwvM8ZN+LMQrv6BnTv0aI25V0kbm2+7jwbicq2eJquxwQ2FkyELlJdBAVv9S
         yEJRWx2WliwzJgqM+twFQt6IWiyHw2hGxR+Z4prtGrVrDZEH/O11i+kDrmy91F+D/UR3
         XXgA==
X-Gm-Message-State: AGi0PuausiB0Qu0UScdque8BJPGJrR04dNRh1uQ6e9mdmzzZdRISOMD5
        P2tEtmCPqoS+jU5PSBSfC5pDjRraadYSE2JK7CY=
X-Google-Smtp-Source: APiQypKsi89y/cDUeSzxmjRLqgmFQGEKO8p6ASmtU+lE0lwSURck3OyDqa3wK+tIeJnDiuUa6reGBfavzn6uRQOSQ0A=
X-Received: by 2002:a05:651c:8:: with SMTP id n8mr2242323lja.196.1587132645214;
 Fri, 17 Apr 2020 07:10:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1587088646.git.baolin.wang7@gmail.com> <dad648071fd163140f6534295cfce76562003b5a.1587088646.git.baolin.wang7@gmail.com>
 <CAK8P3a22NMzCQHDoE7Ed0a1_f7yOTO4x4PM6KArXJnaaig4ZTw@mail.gmail.com>
In-Reply-To: <CAK8P3a22NMzCQHDoE7Ed0a1_f7yOTO4x4PM6KArXJnaaig4ZTw@mail.gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Fri, 17 Apr 2020 22:10:34 +0800
Message-ID: <CADBw62q2+nWOFp+BLuNvpztyy-wYJYO=3024eBun4J=grqJhVg@mail.gmail.com>
Subject: Re: [PATCH 2/2] soc: sprd: Add Spreadtrum special bits updating support
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Lee Jones <lee.jones@linaro.org>, Mark Brown <broonie@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 9:39 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Apr 17, 2020 at 4:14 AM Baolin Wang <baolin.wang7@gmail.com> wrote:
> > + *
> > + * Note: there is a potential risk when users want to set and clear bits
> > + * at the same time, since the set/clear method will always do bits setting
> > + * before bits clearing, which may cause some unexpected results if the
> > + * operation sequence is strict. Thus we recommend that do not set and
> > + * clear bits at the same time if you are not sure the results.
>
> Would it make sense to have a
>
> WARN_ONCE(set && clk, "%s: non-atomic update", __func__);
>
> in the code to check for this?

Yes, will add.

>
> > +static int sprd_syscon_init(void)
> > +{
> > +       syscon_register_phys_regmap_bus(&sprd_syscon_regmap);
> > +
> > +       return 0;
> > +}
> > +core_initcall_sync(sprd_syscon_init);
>
> This no longer breaks at runtime based on the changes in the other
> patch, but I still don't like how you have to manually load this module
> on spreadtrum platforms.
>
> What I meant to suggest in my previous reply was to add the regmap_bus
> instance into drivers/mfd/syscon.c itself.

Sorry, I misunderstood your meaning before, but what you suggested
will add some vendor-specific things into the common syscon driver, if
other platforms have different update bits method, we will add another
vendor-specific regmap bus into the syscon.c, which will make syscon.c
more complicated.

But if you still prefer to add these vendor-specific things into the
syscon.c, I will follow your suggestion in next version. Thanks.

-- 
Baolin Wang
