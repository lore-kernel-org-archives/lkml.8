Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730CBC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 16:15:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42CD62065C
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 16:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DuqEyAzU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgEPQP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 12:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbgEPQP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 12:15:28 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6ADEC061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 09:15:28 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id d26so4477362otc.7
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 09:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HzirPJr8B+We0KXUcmx0Ppg1bldadwDRdOYhZA/qcOA=;
        b=DuqEyAzUBs810YvqTHyDEW9Z9XIitPau58ZVpkfnYlvUDgiNYP2M3OEIj+GO2f2jXS
         c2nFr3O2HJBItokgtKl7+YE9S2rIlralZUMPb6TfHf08TFJADXewsUr4M/sm4PNtTtDh
         yvKsfbV8ra0huKouVxR5W0jmix7qaPLUklJ5kaG81Jh87VD2sv0LSDo58M2ZdunI+nIo
         x2y+NOM9+fGEIsW9rZ4w5U28VBKvAeUfV/YLHNl4rhdFTKul9a77G5qcGFUAzoPOXFpl
         HdKfDcdDHf3AR9VnERd6FrCAhgW8VEgVPNsuduT+M2HgpnC6o0SWXFRFzHjbbwpSSW8I
         +P7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HzirPJr8B+We0KXUcmx0Ppg1bldadwDRdOYhZA/qcOA=;
        b=eTrZaGQUkDgvbua6XY/RtfMa/pMocxIq3Z9P3ngjDvSfVbyy1AcETDqzO9ZUdgwSIR
         STq0GKNHimVhRiyXRlncq8yLwXMd+Of9Sz+yW5UvYZ88S690X2gCvF9lN2TymhafEnkA
         byHlCo7/AXLIalRiLI39E1e+/22c/gOD1C1DOGIShXB5K0GfRO7ZqIdVIQZlifSod4/o
         BLBuGkuAh7rH7BvssQF80WBcf5jhKoAHsU6S/qNVzkkcwZwQx5sG9lPVYLC+HebGfRau
         QPWaq+Y8CyLGg2sxH2k4rWGar1qsPGgB0OEVAsuLyKLzWdyB9J35ahg95hFxJER4BcfJ
         Gm+g==
X-Gm-Message-State: AOAM5313jyp7X/Q5+bRT+suBB6dZxEoabJgOku4ZukN8gfVdBCefeHTI
        xjDPZcYxeqqBsvdKkbST9u2t37dm5cMaP9SHSAbPxXMe
X-Google-Smtp-Source: ABdhPJy+iD2PmhBxeiC4UCrNwCEX8hrZcrVdc6SErVCJEz8oZjqkmCtwcAeKHXMuRabO5ADb21p84pLOCRTL0Uyg860=
X-Received: by 2002:a9d:7d8a:: with SMTP id j10mr5623386otn.266.1589645727993;
 Sat, 16 May 2020 09:15:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAPY=qRQ6gzN1BWh=ianVDBQ1C9kibWHwxs5Z0+QSwGxKymLDTQ@mail.gmail.com>
 <374485.1589637193@turing-police> <af03bee5-27b2-4e92-359a-b1cc8f500d6d@infradead.org>
In-Reply-To: <af03bee5-27b2-4e92-359a-b1cc8f500d6d@infradead.org>
From:   Subhashini Rao Beerisetty <subhashbeerisetty@gmail.com>
Date:   Sat, 16 May 2020 21:45:15 +0530
Message-ID: <CAPY=qRRJ6aZbbRnWfvjqojs08Z7H-+-6nzLAcpzjDcQOJ40fOQ@mail.gmail.com>
Subject: Re: general protection fault vs Oops
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     =?UTF-8?Q?Valdis_Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 16, 2020 at 9:29 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 5/16/20 6:53 AM, Valdis Kl=C4=93tnieks wrote:
> > On Sat, 16 May 2020 18:05:07 +0530, Subhashini Rao Beerisetty said:
> >
> >> In the first attempt when I run that test case I landed into =C3=A2=E2=
=82=AC=C5=93general
> >> protection fault: 0000 [#1] SMP" .. Next I rebooted and ran the same
> >> test , but now it resulted the =C3=A2=E2=82=AC=C5=93Oops: 0002 [#1] SM=
P".
> >
> > And the 0002 is telling you that there's been 2 previous bug/oops since=
 the
> > reboot, so you need to go back through your dmesg and find the *first* =
one.
> >
> >> In both cases the call trace looks exactly same and RIP points to
> >> =C3=A2=E2=82=AC=C5=93native_queued_spin_lock_slowpath+0xfe/0x170"..
> >
> > The first few entries in the call trace are the oops handler itself. So=
...
> >
> >
> >> May 16 12:06:17 test-pc kernel: [96934.567347] Call Trace:
> >> May 16 12:06:17 test-pc kernel: [96934.569475]  [<ffffffff8183c427>]__=
raw_spin_lock_irqsave+0x37/0x40
> >> May 16 12:06:17 test-pc kernel: [96934.571686]  [<ffffffffc0606812>] e=
vent_raise+0x22/0x60 [osa]
> >> May 16 12:06:17 test-pc kernel: [96934.573935]  [<ffffffffc06aa2a4>] m=
ulti_q_completed_one_buffer+0x34/0x40 [mcore]
> >
> > The above line is the one where you hit the wall.
> >
> >> May 16 12:59:22 test-pc kernel: [ 3011.405602] Call Trace:
> >> May 16 12:59:22 test-pc kernel: [ 3011.407892]  [<ffffffff8183c427>] _=
raw_spin_lock_irqsave+0x37/0x40
> >> May 16 12:59:22 test-pc kernel: [ 3011.410256]  [<ffffffffc0604812>] e=
vent_raise+0x22/0x60 [osa]
> >> May 16 12:59:22 test-pc kernel: [ 3011.412652]  [<ffffffffc06b72a4>] m=
ulti_q_completed_one_buffer+0x34/0x40 [mcore]
> >
> > And again.
> >
> > However,  given that it's a 4.4 kernel from 4 years ago, it's going to =
be
> > hard to find anybody who really cares.
>
> Right.
>
> > In fact. I'm wondering if this is from some out-of-tree or vendor patch=
,
> > because I'm not finding any sign of that function in either the 5.7 or =
4.4
> > tree.  Not even a sign of ## catenation abuse - no relevant hits for
> > "completed_one_buffer" or "multi_q" either
>
> Modules linked in:
> dbg(OE) mcore(OE) osa(OE)
>
> Out-of-tree, unsigned modules loaded.
Yes, those are out-of-tree modules. Basically, my question is, in
general what is the difference between 'general protection fault' and
'Oops' failure in kernel mode.

> We don't know what those are or how to debug them.
>
> > I don't think anybody's going to be able to help unless somebody first
> > identifies where that function is....
> >
>
>
> --
> ~Randy
>
