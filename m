Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E1DC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 10:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8809520753
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 10:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="SP1ghtcx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgCSKxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 06:53:37 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:43977 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbgCSKxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 06:53:37 -0400
Received: by mail-il1-f194.google.com with SMTP id d14so1748346ilq.10
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 03:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mGv6o90nBAkHN8tZGMFBnMPu1+vfJLDuM2IfjimqHmY=;
        b=SP1ghtcxKDm86Nrinun/aUTKmLh8YvxfNs09WDEPx7kOtKCkXKDhc4YR8iqRTOp/gS
         8P5efpzV/FxasWeGMas6yKVOjmZHlN/U7Vcs0aJQgCFwJkVeQ69oXJHMx4/FdNA71uX6
         wqH9xxtU1P3ClcNJRgAKlGJ0idpOlYBjlQ2nM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mGv6o90nBAkHN8tZGMFBnMPu1+vfJLDuM2IfjimqHmY=;
        b=TbFG2bVqjF5ga2WvWTZg8vUBKewwI0Li2kb4mXNeAVEaVFRtlnF1+nWXEpx8b9u8ew
         5LkOyXxKgdrLtk/ajuO1cwmP/msMPCO6d4/nR5Eojcg5Up8hRFdVqpFqofvI5NHKtg0k
         53sUFeoxwSx5F3CaxVNaptuXPIauYP7PHr5ueGapLAwnCP/19BqYeYdD1UGwL0LKQedQ
         S0Dvgy4DuH0m2+/gW30ekW4CvpEiGHhORADxEPu4R+V7VWWyG0wjetld00B4Vjsxy5TY
         E4dbtxyy/EI5eCr8j86dtEnJYLDVZJFWxF7qAGUX1vC4BKoEJpeZvGCJBOnNuQFTFiD2
         xVPA==
X-Gm-Message-State: ANhLgQ35HBm+qojlqtwruURT+uB7Io/VKoHGAzOS8af6zqFIoiNVUmF+
        /pKOo1Ccs/ZoeTeSQbUS6KIhxQtsSqJ25gDMrkk8Uanu
X-Google-Smtp-Source: ADFU+vsvDXUclE/dotigec15em503ixvkYRgAZl9akg13dIVS4KGv/OyL1NGUG/SO0ckE6T2Lmn93e+sS5SELs6oRrU=
X-Received: by 2002:a92:77c2:: with SMTP id s185mr1287803ilc.297.1584615215203;
 Thu, 19 Mar 2020 03:53:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200318171003.5179-1-jagan@amarulasolutions.com>
 <20200318171003.5179-3-jagan@amarulasolutions.com> <20200318185814.GB28092@ravnborg.org>
 <CAMty3ZDhVfvYXV7OO+NT+d_2YHbsJXebzjdtYkqtdD+X=Ch0yQ@mail.gmail.com> <20200319103159.GA18744@ravnborg.org>
In-Reply-To: <20200319103159.GA18744@ravnborg.org>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 19 Mar 2020 16:23:24 +0530
Message-ID: <CAMty3ZCjHALfw3Hws5A1M3jbjtkGgeerUZb-wnrppFtQ0dvpTg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] MAINTAINERS: Update feiyang, st7701 panel bindings
 converted as YAML
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-amarula <linux-amarula@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

On Thu, Mar 19, 2020 at 4:02 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Jagan.
> On Thu, Mar 19, 2020 at 03:50:44PM +0530, Jagan Teki wrote:
> > On Thu, Mar 19, 2020 at 12:28 AM Sam Ravnborg <sam@ravnborg.org> wrote:
> > >
> > > On Wed, Mar 18, 2020 at 10:40:03PM +0530, Jagan Teki wrote:
> > > > The feiyang,fy07024di26a30d.txt and sitronix,st7701.txt has been
> > > > converted to YAML schemas, update MAINTAINERS to match them again.
> > > >
> > > > Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> > >
> > > The patch is fine.
> > > I just dislike we repeat the maintainer info in two places..
> >
> > Since these are two different panels. and entry similar like other
> > panels.do you look for single entry for both the panels?
> My comment was related to the fact that we have maintainer entry in the
> .yaml file, and in MAINTAINERS.
>
> Seems a waste to have a distributed and a centralized place for this.
> So patches are fine in this respect.
> And merging the two bindings would be very bad, they are not alike.

Seems to be a valid point considering the redundant entry in two
places, but the idea of maintainer entry in binding vs MAINTAINER file
may be different in terms of usage, and knowing to public. the later
part is pretty generic for people to know, and checkpatch to find. I
may not be sure, but some experts can help here.

Jagan.
