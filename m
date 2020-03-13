Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E8CC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 10:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C20F120746
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 10:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgCMKu5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 06:50:57 -0400
Received: from mail-ot1-f54.google.com ([209.85.210.54]:41153 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbgCMKu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 06:50:57 -0400
Received: by mail-ot1-f54.google.com with SMTP id s15so9574294otq.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 03:50:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NdCnD1rhp0kIebtvrPQrBvc9ez8VJIn2F1YZ3NGfymI=;
        b=jt2sgMtjiQUbfoitzI4S9Ph4Cv1+drdDI36kWHir9pLVdZp4ReXU2byRp5Iag24zI4
         cgCoTtEVOlOVBMDhPt/Uo7uhiOaptHOzI3xm5GiovNaDSZhOZYbi2q9HvxbViBq/RQ64
         tVpS10zJ+NcXPbwHLzYM4hMfOKp94miSJ+SSGZZI3pLsjYFqzBhAOdg6XSxmzA3XAkot
         fmWGioeLLN2d4sJa0O7UXRZEwrI683DQL4izjQU/fBsQ6icaTJkH1dVHi8NS4r/aTa5c
         5pM66li3B+9GDK+BRmIENWliMBtzdaugIEhum9rI8kfG5+mYDhF0Al51KxJ8Ik6q8aWs
         y7/Q==
X-Gm-Message-State: ANhLgQ14/9y7HgtybHsQ00ZKkqhPHp0cyLjeSRZVE9YwsYFK96fpCAUq
        Op5q8nf2QKF0YeoY13/mm5I9rEL+HtOYwKEoNTk=
X-Google-Smtp-Source: ADFU+vupQFkPI7y0i6JcQD7lmo4nLgfJAu3D5Ee2TWOOuOx9k2VieHD0iksVrf4wo3dKi6qTpiyJKwyaNjuUn4B1An8=
X-Received: by 2002:a9d:1708:: with SMTP id i8mr10382578ota.250.1584096656312;
 Fri, 13 Mar 2020 03:50:56 -0700 (PDT)
MIME-Version: 1.0
References: <6d6dd6fa-880f-01fe-6177-281572aed703@labbott.name>
 <20200312003436.GF1639@pendragon.ideasonboard.com> <MWHPR13MB0895E133EC528ECF50A22100FDFD0@MWHPR13MB0895.namprd13.prod.outlook.com>
 <20200313031947.GC225435@mit.edu> <87d09gljhj.fsf@intel.com>
 <20200313093548.GA2089143@kroah.com> <24c64c56-947b-4267-33b8-49a22f719c81@suse.cz>
 <20200313100755.GA2161605@kroah.com> <CAMuHMdVSxS1R2osYJh29aKGaqMw3NkTRgqgRWuhu4euygAAXVg@mail.gmail.com>
 <20200313103720.GA2215823@kroah.com>
In-Reply-To: <20200313103720.GA2215823@kroah.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 13 Mar 2020 11:50:45 +0100
Message-ID: <CAMuHMdW6Br+x+_9xP+X4xr6FP_uNpZ6q6065RJH-9yFy_8fiZA@mail.gmail.com>
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

On Fri, Mar 13, 2020 at 11:37 AM Greg KH <greg@kroah.com> wrote:
> On Fri, Mar 13, 2020 at 11:16:36AM +0100, Geert Uytterhoeven wrote:
> > On Fri, Mar 13, 2020 at 11:08 AM Greg KH <greg@kroah.com> wrote:
> > > On Fri, Mar 13, 2020 at 10:41:57AM +0100, Vlastimil Babka wrote:
> > > > On 3/13/20 10:35 AM, Greg KH wrote:
> > > > >> Not that I'm saying there's an easy solution, but obviously kernel.org
> > > > >> account is not as problem free as you might think.
> > > > >
> > > > > We are not saying it is "problem free", but what really is the problem
> > > > > with it?
> > > >
> > > > IIUC there is no problem for its current use, but it would be rather restrictive
> > > > if it was used as the only criterion for being able to vote for TAB remotely.
> > >
> > > Given that before now, there has not be any way to vote for the TAB
> > > remotely, it's less restrictive :)
> >
> > But people without kernel.org accounts could still vote in person before,
> > right?
>
> Yes, and they still can today, this is expanding the pool, not
> restricting it.

Oh right, assumed we'll still have a conference in person, and unrestricted
travel.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
