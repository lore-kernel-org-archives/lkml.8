Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1609BC2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 23:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBCA02070E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 23:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Mmdzqguz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbgA2Xt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 18:49:29 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45296 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727124AbgA2Xt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 18:49:28 -0500
Received: by mail-lf1-f67.google.com with SMTP id 203so933525lfa.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 15:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hZuYO1iwTS6qTMEuTEAkXWId/UBWv4N98s5kLzpeWFk=;
        b=Mmdzqguz0RYjmqywHXsnnBq1PdYo4sEDQvqeVgCcrxrK3x4W6UMUDCboC/Le9yM/eX
         4+GaCZCfx4fDwOpfU7dHJTWHzF+yfSKLllDfGhshvjXnlZPG3siNr2aa6jyb/1ZYnJtX
         EpWbRtyk0rfwFsoj1VzGp/DiH69QHf88kVbL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hZuYO1iwTS6qTMEuTEAkXWId/UBWv4N98s5kLzpeWFk=;
        b=dFmjPBZFEr5wS25evGaB/KpKWuLGShGqFUFmJjJ4fpIuQNXPqotWJZ/l73nDl0Eubk
         Jb5nA34hRogXimQdZKnW3S2EB5ardo1ogsLckZfMXMEn5NWyvdb8VdI0Lmy+ROw4feTL
         +XMlHC4HGnQJgwZNSFigyXhJJlomaGkLrR9qif/JWxZdoWwtUGPjC/YnTZgdwEfGoqIQ
         ffhxPhvCeAAd3CIySup/vPGfp1wBKCsP6Uaxqc91aIoiH2DROv0syxG2yJs7NLG9HSjR
         4FvrDucMJVaxeg7E3cQjtz95V6Qe6Z0us2/cvXG28Mx8/h5HnHM2yOCnWcWMh7xpKtwI
         lKcQ==
X-Gm-Message-State: APjAAAWOKL9OZSXfpuVo+aK2habT/2DeETeG8jP5N0f8fSS3D12S+osa
        9nQdugebi4k6jMOMkSNxTl7i3lgzLwI=
X-Google-Smtp-Source: APXvYqxU2+MdW4SeY8JKXKu8BcRQPvkBdnoIA3V8xMOFDs+740uYM8SusCWx9Iu3lOcr0AI4Ej3ZVA==
X-Received: by 2002:a19:8456:: with SMTP id g83mr965603lfd.0.1580341766561;
        Wed, 29 Jan 2020 15:49:26 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id s22sm1791142ljm.41.2020.01.29.15.49.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2020 15:49:25 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id h23so1302388ljc.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 15:49:25 -0800 (PST)
X-Received: by 2002:a2e:85ce:: with SMTP id h14mr988980ljj.41.1580341764990;
 Wed, 29 Jan 2020 15:49:24 -0800 (PST)
MIME-Version: 1.0
References: <20200117162444.v2.1.I9c7e72144ef639cc135ea33ef332852a6b33730f@changeid>
 <CACK8Z6Ft95qj4e_fsA32r_bcz2SsHOW1xxqZJt3_DBAJw=NMGA@mail.gmail.com>
 <CAE=gft6fKQWExW-=xjZGzXs30XohfpA5SKggvL2WtYXAHmzMew@mail.gmail.com>
 <87y2tytv5i.fsf@nanos.tec.linutronix.de> <87eevqkpgn.fsf@nanos.tec.linutronix.de>
 <CAE=gft6YiM5S1A7iJYJTd5zmaAa8=nhLE3B94JtWa+XW-qVSqQ@mail.gmail.com>
 <CAE=gft5xta4XCJtctWe=R3w=kVr598JCbk9VSRue04nzKAk3CQ@mail.gmail.com>
 <CAE=gft7MqQ3Mej5oCT=gw6ZLMSTHoSyMGOFz=-hae-eRZvXLxA@mail.gmail.com>
 <87d0b82a9o.fsf@nanos.tec.linutronix.de> <CAE=gft7C5HTmcTLsXqXbCtcYDeKG6bCJ0gmgwVNc0PDHLJ5y_A@mail.gmail.com>
 <878slwmpu9.fsf@nanos.tec.linutronix.de> <87imkv63yf.fsf@nanos.tec.linutronix.de>
 <CAE=gft7Gu0ah4qcbsEB1X+kUMagCzPR+cdCfn2caofcGV+tBjA@mail.gmail.com>
 <87pnf342pr.fsf@nanos.tec.linutronix.de> <CAE=gft69hQcbmT46b1T8eLdPFyb9Pp-sDYd5JfPsZ2JWL4PXqQ@mail.gmail.com>
 <877e1a2d11.fsf@nanos.tec.linutronix.de> <CAE=gft7mLAU3G+f8gi_etRSpUijoCh7_6ni9Ob2JqjW7Q1n3yQ@mail.gmail.com>
 <874kwd3lbn.fsf@nanos.tec.linutronix.de>
In-Reply-To: <874kwd3lbn.fsf@nanos.tec.linutronix.de>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 29 Jan 2020 15:48:48 -0800
X-Gmail-Original-Message-ID: <CAE=gft52iBTJyyvDTXeHdEYnpSSROvrQsweuXjd6OuaLO47ACw@mail.gmail.com>
Message-ID: <CAE=gft52iBTJyyvDTXeHdEYnpSSROvrQsweuXjd6OuaLO47ACw@mail.gmail.com>
Subject: Re: [PATCH v2] PCI/MSI: Avoid torn updates to MSI pairs
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Rajat Jain <rajatja@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        x86@kernel.org, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 3:16 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Evan,
>
> Evan Green <evgreen@chromium.org> writes:
> > On Wed, Jan 29, 2020 at 1:01 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> >> Could you please add some instrumentation to see how often this stuff
> >> actually triggers spurious interrupts?
> >
> > In about 10 minutes of this script running, I got 142 hits. My script
> > can toggle the HT cpus on and off about twice per second.
> > Here's my diff (sorry it's mangled by gmail). If you're looking for
> > something else, let me know, or I can run a patch.
> >
> No, that's good data. Your testing is hiting the critical path and as
> you did not complain about negative side effects it seems to hold up to
> the expectations. I'm going to convert this to real patch with a
> proper changelog tomorrow.
>
> Thanks for your help!

Sounds good, please CC me on it and I'll be sure to test the final
result as well.
-Evan
