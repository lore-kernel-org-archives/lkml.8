Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3481C54E8A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 07:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8151921973
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 07:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TyJjvVE6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgEJHkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 03:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgEJHkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 03:40:04 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CE9C061A0C;
        Sun, 10 May 2020 00:40:04 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id c18so5469204ile.5;
        Sun, 10 May 2020 00:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mX8obe5Y6OipJrXkhzZBoUFMFO3dCzXyeTyerYVN23U=;
        b=TyJjvVE63gFmRfrm8OFUipIF7lrBFXHJ9BQRoE1D4gmlnOwf820qZhXBIxh8nVXnrB
         KrhuhRPUeR7SIxXxrmA7bNxsC1xppIbUcPRJtJZ2BJjzIy8Mg26sEaYj6ghyw55Hjqi4
         TG5yorVfjmSkcyFJ2QLz/ILv+eoI980aB7TXywOreEnNfa3Ri4GG25M9TdZ4x0JMTQe/
         E88pFQyczxpdzYmmqUgdoDB2rJdPY1aptkHE5FEo1w/3YM9Ei49cnVCt+RL9ibvpqGL6
         U7jP9IZ35J1PpT2t3+B/oaqd8dF1D5tr8h7F4NRYk9bBhWPA+S2eQA5/mYU1K7v/oKJ8
         dFcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mX8obe5Y6OipJrXkhzZBoUFMFO3dCzXyeTyerYVN23U=;
        b=Ct7nnOQ5OnWnUoQmxEpSkUqOWz5td8jYbo59F7tecWz3x9dYcgERrBlcxyKEwW/Vq4
         ap2Qc7xLf/ujSvFFM174LWTrSA+t34/G5LN183aveGLm/knmnyNSB0Iq4MoZplurF2OF
         2Y22WkHjLhVC1SBNr0NXh1CkAfLo5QxlAI+vu++Qkfc4hdpsU/GHEpHlSvf6vz+M33HX
         e93Jz2LvckHgc4YkKR0zTnKBJJtd7Y+HPxJ04SREkOkhevACwH2zsK1DtTP/89x8CUcw
         qpC4cOosigmrc2VqNXoPnfAUrE3ttfbnT2lcDYor5ntWE5VqSAb/mt6hzG8upLVizVUy
         TcfA==
X-Gm-Message-State: AGi0PuZ6ZzzoJ7HzFxOsEkBsXHuC+n+9/zbpHPKjZ4/k1PYgy+jXqsBX
        KWq6qHIQmx6ivCNxcC0b4vxLTzl2ghofmaI+GuXd/yz0
X-Google-Smtp-Source: APiQypLQ66tcffOC+J0ZOTG8iVHhQoQTFHTZlpuibvLAzE0MpgEfQpRwRzAY+6ba19Ul5oTkBO7XXA1oy+cOomrOoWY=
X-Received: by 2002:a92:d5cf:: with SMTP id d15mr11149078ilq.131.1589096403781;
 Sun, 10 May 2020 00:40:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200509094515.7082eb92@canb.auug.org.au> <alpine.DEB.2.21.2005090103060.29336@piezo.novalocal>
 <20200509134751.147d747d@canb.auug.org.au>
In-Reply-To: <20200509134751.147d747d@canb.auug.org.au>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Sun, 10 May 2020 09:40:07 +0200
Message-ID: <CAOi1vP8JjtBZoy0zAgz7=wwMuHiiRPCvxz7ZKicE9nh-NZXz2Q@mail.gmail.com>
Subject: Re: linux-next: new contact(s) for the ceph tree?
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Sage Weil <sage@newdream.net>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 9, 2020 at 5:47 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Sage,
>
> On Sat, 9 May 2020 01:03:14 +0000 (UTC) Sage Weil <sage@newdream.net> wrote:
> >
> > Jeff Layton <jlayton@kernel.org>
>
> Done.
> > On Sat, 9 May 2020, Stephen Rothwell wrote:
> > >
> > > I noticed commit
> > >
> > >   3a5ccecd9af7 ("MAINTAINERS: remove myself as ceph co-maintainer")
> > >
> > > appear recently.  So who should I now list as the contact(s) for the
> > > ceph tree?

Hi Stephen,

I thought maintainers were on the list automatically.  If there is
a separate list, please add me as well.

Thanks,

                Ilya
