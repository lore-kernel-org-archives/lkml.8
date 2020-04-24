Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21F3C2BA1A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 08:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9C1F20767
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 08:43:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tgWUgeVt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbgDXInE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 04:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgDXInE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 04:43:04 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54DDC09B045
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 01:43:03 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id f11so4490399ljp.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 01:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3/5V9rfViLiIb3lSUOpxPhyBVl/15uDOkbFOxJipIyA=;
        b=tgWUgeVt7DG6b5h4PlBnjqc4eCwJPI2AosELfpmCWn59Cg3NDw74znWUe+s2G1ef8e
         CZ3Nq/voUq5ST78kTQD0PTfeJh88Cw/Gh2i0BWYA1TAPNsppYaQiJopPD1tuqR1X23J+
         u2Rmpy11NykrZ8zz+ZB3mdIzp9dRzpua0A/x12OLCXUmLWoquyMaDOpdIn7xdiDo5nsc
         E3BOFNlq2QiwCPVC9ei3naFh+Dfl9i0Ul/+pL7m5FkMMUGQHEkVvg35JbisitY1f2TRh
         2syeY0wtkOKQAyjD7P5aJADQcqZ2MypVDmE9/2ndn/sBrx+Co8xJN7ltzWHquO9EQirI
         6nxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3/5V9rfViLiIb3lSUOpxPhyBVl/15uDOkbFOxJipIyA=;
        b=XPBh9ks1DOiOInge1hpMM5R1PTR18sHU1AoRjb6yDhRH44bn1CGudeuyiMPCGkGq4j
         rV/kFEhRbhGnw7mP3lc5prEdvzAS3r/P/VoRzq8vybW22LjpCYCbE2Pe1NXCyJS0CJmh
         mDxlF0+BH2jpoOPFx7r6Qy4FNfv69YmDPvEXwFgUKL03FLoqRw+O3NCmB0ZYhxqJfJXV
         4SRAsOmuHYOO5IUwj6Vr4JYAAn2LSIIlAuBQgWhgHpAo9cpj/juDqAAl5V0zdtsZ9xYU
         E3mqb7ByTUvRHVWbipr/1dcTgwJeiQzYHjTBZA3uye5+7pH/nd3KkmUck9WQbHIFCObU
         5lgQ==
X-Gm-Message-State: AGi0PuaIRRO8pxuyjrBttXdizVEIAdunXqHXxXpECjXrsLAZ4gzFhqaU
        4U0vV0eRSrjqHUDoTE5A4SDhfqL8TEX+2ng2hxY=
X-Google-Smtp-Source: APiQypJV8HBqJ9jW2FLsSv1wRY2BDsPGk0pWu/jMUuWVdKZxlr1XPtUb5tvSO1QSAE8+NlG7IZGNo/bH6DKm09pDI2M=
X-Received: by 2002:a2e:6c08:: with SMTP id h8mr4950543ljc.48.1587717782344;
 Fri, 24 Apr 2020 01:43:02 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1587088646.git.baolin.wang7@gmail.com> <96d444cd73239e0166316bd8f44082031cf72491.1587088646.git.baolin.wang7@gmail.com>
 <20200424081138.GP3612@dell> <CAK8P3a1e15P6xRUgYLYxT8XUx7FREbs5mMbfL1Qj+qwoDfFX+Q@mail.gmail.com>
 <20200424083255.GQ3612@dell>
In-Reply-To: <20200424083255.GQ3612@dell>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Fri, 24 Apr 2020 16:42:50 +0800
Message-ID: <CADBw62pisHz=ejgnhL=Y_qufCoZjPDLT90X2bztTZzMgbNMvmQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mfd: syscon: Support physical regmap bus
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 4:32 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Fri, 24 Apr 2020, Arnd Bergmann wrote:
>
> > On Fri, Apr 24, 2020 at 10:11 AM Lee Jones <lee.jones@linaro.org> wrote:
> > > On Fri, 17 Apr 2020, Baolin Wang wrote:
> > > > @@ -106,14 +107,25 @@ static struct syscon *of_syscon_register(struct device_node *np, bool check_clk)
> > > >       syscon_config.val_bits = reg_io_width * 8;
> > > >       syscon_config.max_register = resource_size(&res) - reg_io_width;
> > > >
> > > > -     regmap = regmap_init_mmio(NULL, base, &syscon_config);
> > > > +      /*
> > > > +       * The Spreadtrum syscon need register a real physical regmap bus
> > > > +       * with new atomic bits updating operation instead of using
> > > > +       * read-modify-write.
> > > > +       */
> > > > +     if (IS_ENABLED(CONFIG_ARCH_SPRD) &&
> > > > +         of_device_is_compatible(np, "sprd,atomic-syscon") &&
> > >
> > > Please find a more generic way of supporting your use-case.  This is a
> > > generic driver, and as such I am vehemently against adding any sort of
> > > vendor specific code in here.
> >
> > I suggested doing it this way, as all alternatives seemed worse than this.
>
> If we're using a registration function (could probably be swapped out
> for or accompanied by a Device Tree property) anyway, then why conduct
> the vendor platform checks?

Actually I've send out the v3 patch according to Arnd's suggestion. In
v3 patch, I removed the registration function, but we agreed that
adding the vendor specific support in the syscon driver seems a better
way than others.

-- 
Baolin Wang
