Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF80C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 10:16:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 837282074C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 10:16:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbgCMKQt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 06:16:49 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33527 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgCMKQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 06:16:48 -0400
Received: by mail-ot1-f68.google.com with SMTP id g15so9507949otr.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 03:16:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jua92NQloJZLKybkpufWAYb9BLz9N/qiUngHkqkKW74=;
        b=Semho+Hqn5Du/45WFb+kV+8sNpKG1q+fXnIxCAtXJ/cQLymINRbOc5eDeWBCAnFjrv
         pkpooLzYODOE2RJgbzpq/w4GWPpi4u+GVbhQ3hJHgzmA6VQEN1BOmVEahcTwgWJjsep9
         F54xMvl5VVe80e79HVVLYL9y8j22fe0F3JQa/Ro5s9kEOSZ8uR2pednAKJHKMSYcRHRA
         0PqWpkLHK2eHNTrURqXPEkH30sIPXaGnI5nyGt9qrNExHQqd7y5tei9YnBInII2BmjPZ
         9Jby8vr5cEiaK6TifjAQPVGLLd1Zdt8bP0IN/1/h95Wz3GVFZOHuwNqlV1CyayyHNkA2
         ET+w==
X-Gm-Message-State: ANhLgQ36dUPNeFN4buIJ+QOOkDZsAIsoIXwvu43jHqix9R4JzBmw2H1u
        knjqBgJhpLOkyWWSbXCdBUhL0B/SMUmDU9ZOG7E=
X-Google-Smtp-Source: ADFU+vtPD5EjMs8XWjMLmd1y66lVZWhosnYNobYGDQsn++67Rqv2tj1vpKQAPtjj2I9seOiikClZpaGzcgYTR/O4YBQ=
X-Received: by 2002:a9d:b89:: with SMTP id 9mr10423838oth.297.1584094607744;
 Fri, 13 Mar 2020 03:16:47 -0700 (PDT)
MIME-Version: 1.0
References: <6d6dd6fa-880f-01fe-6177-281572aed703@labbott.name>
 <20200312003436.GF1639@pendragon.ideasonboard.com> <MWHPR13MB0895E133EC528ECF50A22100FDFD0@MWHPR13MB0895.namprd13.prod.outlook.com>
 <20200313031947.GC225435@mit.edu> <87d09gljhj.fsf@intel.com>
 <20200313093548.GA2089143@kroah.com> <24c64c56-947b-4267-33b8-49a22f719c81@suse.cz>
 <20200313100755.GA2161605@kroah.com>
In-Reply-To: <20200313100755.GA2161605@kroah.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 13 Mar 2020 11:16:36 +0100
Message-ID: <CAMuHMdVSxS1R2osYJh29aKGaqMw3NkTRgqgRWuhu4euygAAXVg@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [Tech-board-discuss] Linux Foundation Technical
 Advisory Board Elections -- Change to charter
To:     Greg KH <greg@kroah.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, "Bird, Tim" <Tim.Bird@sony.com>,
        "ksummit-discuss@lists.linuxfoundation.org" 
        <ksummit-discuss@lists.linuxfoundation.org>,
        "tech-board-discuss@lists.linuxfoundation.org" 
        <tech-board-discuss@lists.linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Fri, Mar 13, 2020 at 11:08 AM Greg KH <greg@kroah.com> wrote:
> On Fri, Mar 13, 2020 at 10:41:57AM +0100, Vlastimil Babka wrote:
> > On 3/13/20 10:35 AM, Greg KH wrote:
> > >> Not that I'm saying there's an easy solution, but obviously kernel.org
> > >> account is not as problem free as you might think.
> > >
> > > We are not saying it is "problem free", but what really is the problem
> > > with it?
> >
> > IIUC there is no problem for its current use, but it would be rather restrictive
> > if it was used as the only criterion for being able to vote for TAB remotely.
>
> Given that before now, there has not be any way to vote for the TAB
> remotely, it's less restrictive :)

But people without kernel.org accounts could still vote in person before,
right?

Obviously the next step beyond "has a kernel.org account" is "is listed
in MAINTAINERS".  All of these can be assumed to be real humans, too.
However, that's still more restrictive than before, as it rules out people
who are not maintainers.

So next step would be developers/maintainers with an SoB.  I think it's still
safe to assume they are real humans, too.
Add a minimum number of commits[*] to raise the bar a little bit, and avoid
the whitespace-fixers who just want to vote.

[*] And e.g. count commits more than one year ago half, more than N years
    ago 1/2^N.  Perhaps add another penalty for staging cleanups ;-)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
