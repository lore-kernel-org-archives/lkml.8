Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B885FC433E7
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 20:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 931B22064B
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 20:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZ9vgJDo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbgH3UPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 16:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgH3UPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 16:15:50 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3319C061573;
        Sun, 30 Aug 2020 13:15:50 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id h12so3135692pgm.7;
        Sun, 30 Aug 2020 13:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uN5su8o3xsbvCOgWhY0UzbAHV++yuovb1ibI32bJbhI=;
        b=OZ9vgJDoErBur4ViHs9sOePZI0qBL1x/3N3seJxZCGqlZ5QLwQEnSxLHF6YqDlqW8I
         xBGjqJ5vgak4670DiMXxxSMs3fXMkJjj3e4AXuATL6IuYmV7stn2FnHMPnm7QDiYn2Ym
         nB/6dMf5bxF+F8cbX1TnzCGQjXskNhK9Ix81MfyJ3+spsZGrIFyFa8RtfIRf2//H1H/S
         8Dhj7Mqb3ENy013DktbfTp4Zx9Dvdfxk8SE8P4NDtQcs34YnSQT/sm1+7057Cgg15O4E
         aq7CcSs0bI12REcNIxB4jHVw/J6vfKbsZQ1U7MKMCk3/pdm1sxRguZSdsBaw/ykCYqrb
         O83g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uN5su8o3xsbvCOgWhY0UzbAHV++yuovb1ibI32bJbhI=;
        b=ZxvSaFoVO69gqMuKhmKaGUDKTk/X/27KmKpbVc5DCCTCVJLaGxaUAmHFmm5zLA/pNQ
         uS6rYsVSVs4NvH0u8NKtIioRj04mno+6L+XxlSNdLK0J/iNyZd+fmNY3vd4be3NRTmge
         ccozeS3+V0TiKuvFN011RI0hRzpS7dhSKyV3m07JhlKa1dZJ2a50Sc6BKbYtuFP62z+w
         6yncxOmCDh+9SoeNan5Q7sj2txXyyfcakdt1Pzi4Fct+C/Rw2xqVglHJlpWFMxXMYUk5
         zWIRlzY2TwK3twHLekbL2iuxg1NWcspjXPIJxmcFq1tra3Hq+o3kIFzcKYBUnG1NIowL
         SQ9A==
X-Gm-Message-State: AOAM532pQblrG8TjXoIE/yOusGSVSRv7j7Z3WYbfcMM9VDh6GMnOvw8U
        /8ooHxzosnwAWRzCh38hlTI8KLmQAy3hugKhl0k=
X-Google-Smtp-Source: ABdhPJynKyxo87BjNt2aLZoSW+tfeQGcmaaGm3ORU9EpaNo+zbAim0QhxmamgpjDqx+iuGg2e2oMSOBwfB8/OBNleg8=
X-Received: by 2002:a63:c543:: with SMTP id g3mr6051803pgd.203.1598818548769;
 Sun, 30 Aug 2020 13:15:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200828021939.2912798-1-andrew@lunn.ch> <20200828130034.GA2912863@lunn.ch>
 <CAL_JsqK18GoqkNPePh1+jiEk0JoLH01yPr0dD0AkswXP1N+qzA@mail.gmail.com> <20200830152332.GE2966560@lunn.ch>
In-Reply-To: <20200830152332.GE2966560@lunn.ch>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 30 Aug 2020 23:15:32 +0300
Message-ID: <CAHp75Vd5WXdYPvrr=_CChCHGdWR1iJqxwnMVtgggHGJ6hnVd5Q@mail.gmail.com>
Subject: Re: [PATCH] of: of_match_node: Make stub an inline function to avoid
 W=1 warnings
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 30, 2020 at 6:25 PM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Fri, Aug 28, 2020 at 05:09:52PM -0600, Rob Herring wrote:
> > On Fri, Aug 28, 2020 at 7:00 AM Andrew Lunn <andrew@lunn.ch> wrote:
> > >
> > > On Fri, Aug 28, 2020 at 04:19:39AM +0200, Andrew Lunn wrote:
> > > > When building without CONFIG_OF and W=1, errors are given about unused
> > > > arrays of match data, because of_match_node is stubbed as a macro. The
> > > > compile does not see it takes parameters when not astub, so it
> > > > generates warnings about unused variables. Replace the stub with an
> > > > inline function to avoid these false warnings.
> > >
> > > Hi Rob
> > >
> > > So 0-day shows some people have worked around this with #ifdef
> > > CONFIG_OF around the match table.
> > >
> > > I checked the object code for the file i'm interested in.  The
> > > optimiser has correctly throw away the match table and all code around
> > > it with the inline stub.
> > >
> > > Which do you prefer? This patch and i remove the #ifdef, or the old
> > > stub and if add #ifdef around the driver i'm getting warnings from?
> >
> > Use of_device_get_match_data instead of of_match_node.
> >
>
> Hi Rob
>
> That does not work in the use case i'm interested in, which is giving
> a W=1 warning. Take a look at the last example in
> Documentation/devicetree/bindings/net/dsa/marvell.txt
>
> We have an Ethernet switch, using the compatible string
> "marvell,mv88e6390". Embedded within the hardware, and within the same
> driver, we have two MDIO busses. One is internal, for the PHYs
> integrated into the switch, and one is external, of discrete PHY
> connected to the switch. The external MDIO bus has its own compatible
> string. However, there is no struct driver for it, the switch driver
> is driving the MDIO bus. So of_device_get_match_data() will use the
> wrong match table.

Looks like in that code you may use of_device_is_compatible().

-- 
With Best Regards,
Andy Shevchenko
