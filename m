Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2309EC3815B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 14:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 025712075E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 14:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com header.i=@bytedance-com.20150623.gappssmtp.com header.b="Wwje0Rnt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391117AbgDNOkx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 10:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391079AbgDNOkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 10:40:32 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3A0C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 07:40:31 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id o127so13505135iof.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 07:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YbefgXjXgHeUC3P4hR4bxjpF4217ar6Ws14g5K+3oCQ=;
        b=Wwje0Rntf8ZnrrhqYnDu0SzHV0cPoc8qcICufXPzSHt4np2xlG+adB6yz6d0yfi5/t
         FFgDG4PgjM/yauxNSgZOCTwIj6893wuEoglOIXx3r004MbrRCwo9dXocnO5wlSvfJog+
         W0+yY+0KD0b0zVRCNJfbuEz/+yWWAsVxObApzsBNxpNUBzCJdx6NGf/FW8puQhE227TT
         4Lp4U1Wm6g0barnTOOSt/NAegtzSNCMcQ2PAE6mADnANg9fiu/V+r2ZMxOW1Ki8fR5Pu
         gLVTt1W8cC60zqsETdr9WgpVRoXG8UCjAuClt8OSYww44XXBdM8XDqtjX1FMHvxv+J1t
         dExg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YbefgXjXgHeUC3P4hR4bxjpF4217ar6Ws14g5K+3oCQ=;
        b=ALmmsG5Qqu7lXmyOb1Flmd/R/+HLUhBsuWBiI37kEKu8Rnd7lWjb0HEh88JcsCnIwM
         +uqpy/3ueQYD3Exz9itQC9YHYWX+zLnm4NH+CTNzFfix829MB5hU0gpq7GFHbOrh44ND
         h2GIMGaTEX0D/5xIGboEx98szdNCFNzfGkGpyEPPIXu/3nqlQD39ePjvZdyf4x/DJSda
         ItW4stWsDA1o3d+5inUshcKtJ7EP9KwxRTwSM2Ac7hJqw0WP7/o6TaygPcK8lolk3Yko
         uylnGGL8XumimXT4a6F/TT9AGL2ub3IU0GEDfJSf96T9oHPru2aJmL//pgbJAnzp0qot
         ydYw==
X-Gm-Message-State: AGi0Pubd42FgPqTn7OXwZSZbec6sXqdfde/O0DNmJ/vX/BSit+zus8O8
        fxm92KP+kuDuqSM4AyS2da7gcIZyIIiz9WD9xRWzJA==
X-Google-Smtp-Source: APiQypIOEDWyBC+MJXnFhM3K3bceWhoQdw2kV3ecdpznyv+m3gsZ+ZKEJD7FpxP9SK4xSRSupxvj9RZtJnPi/kYxX+M=
X-Received: by 2002:a02:cca3:: with SMTP id t3mr13412804jap.3.1586875231002;
 Tue, 14 Apr 2020 07:40:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200414075622.69822-1-songmuchun@bytedance.com>
 <ff540216-7f3e-9841-4896-81907540404d@web.de> <CAMZfGtVpMK38odpd3Ady_xW0hyMpN89Vwo_WNXBZz0yGaZzFQg@mail.gmail.com>
 <36a7d091-440b-a3db-c93f-713fc7cfbb5c@web.de>
In-Reply-To: <36a7d091-440b-a3db-c93f-713fc7cfbb5c@web.de>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 14 Apr 2020 22:39:55 +0800
Message-ID: <CAMZfGtX1wPY=B30Rroj4kDhfU43G0jO8T9CeR3AzjGAD6=nGTQ@mail.gmail.com>
Subject: Re: [External] Re: [v2] mm/ksm: Fix NULL pointer dereference when KSM
 zero page is enabled
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Xiongchun Duan <duanxiongchun@bytedance.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 10:17 PM Markus Elfring <Markus.Elfring@web.de> wro=
te:
>
> >>> to crash when we access vma->vm_mm(its offset is 0x40) later in
> >>
> >> Will another fine-tuning become relevant also for this wording?
> >
> > Sorry, I don't understand what this means because of my poor English.
>
> Our language knowledge can evolve over time.
>
>
> > Could you explain it again.
>
> You integrated a few of my suggestions into your message selection. - Tha=
nks.
> I wonder why you did not like the following small adjustment possibilitie=
s
> so far.
>
>   to a crash =E2=80=A6 vm_mm (its =E2=80=A6
>

Thanks a lot. I will fix it.

>
> >> Will any other tags become helpful in such a case?
> >
> > How about changing
> >     "following calltrace is captured in kernel 4.19 with KSM zero page"
> > to
> >    "The following calltrace is captured with the following patch applie=
d:
> >        e86c59b1b12d ("mm/ksm: improve deduplication of zero pages with
> > colouring")
> >     "
> > ?
>
> I find it unlikely that such a wording alternative would be more appropri=
ate
> while I became just curious for related development consequences around
> the usage of a longterm kernel version.
>
> Would you like to reuse the term =E2=80=9Ccall trace=E2=80=9D?
>

OK, I will reuse the =E2=80=9Ccall trace=E2=80=9D. Thanks again.

Anyone else have any suggestions? If not, I will post another v4 version
to fix the commit message that Markus mentioned.

--=20
Yours,
Muchun
