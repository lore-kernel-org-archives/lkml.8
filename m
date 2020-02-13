Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2764CC352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 22:27:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA9C62082F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 22:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581632866;
	bh=SRtP8pkvAAiuwHsxABDH84x3VSuC9ZAaIoBIlv/+HFs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=TtRJmjXkUwf/gzf0OEDAVakBnXhc6L554sWt7GTQEHuLEwSRkJLWUrnt7Ga71otBp
	 S0iPaqoJ4CmT4hdRnIlikWS+6ppXFh5QGJHuqusP3q3VLkbggsAdWu0NF63uc6AA/T
	 uNjvROFq+axAu1V6Yc5o5wgy5G6E0UM6a3xy4aVM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgBMW1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 17:27:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:33580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726780AbgBMW1o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 17:27:44 -0500
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 186822082F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 22:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581632864;
        bh=SRtP8pkvAAiuwHsxABDH84x3VSuC9ZAaIoBIlv/+HFs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZDoGWRiYk87A+My3o5po3FXcsuYvRfERkmYRnQ1jifjpPLdzFag2KmuQkNs0l0lgL
         d9eDPa4eiRNgO4cE6Lc5p5K0z09o9UuL9G5yPCrXGruXG6sZjMjPV1JrrZmSKK0dsO
         DqmBgiDeNjk8I/FdT+1LbG6z5DFmSbDKWF66V4Q0=
Received: by mail-wr1-f43.google.com with SMTP id n10so6747113wrm.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 14:27:44 -0800 (PST)
X-Gm-Message-State: APjAAAXddpxSeokJQmCKahfytmrKm/F4ey1Q4KoBS+IwhAbx+0AmM0Fb
        rwL4NK+NVd1+m/yk9zvhiCTv8Vi4H0h8DraPyusVrQ==
X-Google-Smtp-Source: APXvYqxEATt8gqwMkpoZDC4PKFMldll/nLW5HggQMlZbcat0HevpC3zeHLonBBPiDLtuGM4TKcmOMRvBzQUYzZ9gYTA=
X-Received: by 2002:adf:a354:: with SMTP id d20mr23603033wrb.257.1581632862640;
 Thu, 13 Feb 2020 14:27:42 -0800 (PST)
MIME-Version: 1.0
References: <20200212204652.1489-1-tony.luck@intel.com> <20200212204652.1489-5-tony.luck@intel.com>
 <20200213170308.GM31799@zn.tnic> <20200213221913.GB21107@agluck-desk2.amr.corp.intel.com>
In-Reply-To: <20200213221913.GB21107@agluck-desk2.amr.corp.intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 13 Feb 2020 14:27:31 -0800
X-Gmail-Original-Message-ID: <CALCETrVrL1Ps9ubAcKQykxTofn4hbkESBYE9H22Ws5Pis_vG+g@mail.gmail.com>
Message-ID: <CALCETrVrL1Ps9ubAcKQykxTofn4hbkESBYE9H22Ws5Pis_vG+g@mail.gmail.com>
Subject: Re: [PATCH 4/5] x86/mce: Fix all mce notifiers to update the
 mce->handled bitmask
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 2:19 PM Luck, Tony <tony.luck@intel.com> wrote:
>
> On Thu, Feb 13, 2020 at 06:03:08PM +0100, Borislav Petkov wrote:
> > On Wed, Feb 12, 2020 at 12:46:51PM -0800, Tony Luck wrote:
> > > If the handler took any action to log or deal with the error, set
> > > a bit int mce->handled so that the default handler on the end of
> > > the machine check chain can see what has been done.
> > >
> > > [!!! What to do about NOTIFY_STOP ... any handler that returns this
> > > value short-circuits calling subsequent entries on the chain. In
> > > some cases this may be the right thing to do ... but it others we
> > > really want to keep calling other functions on the chain]
> >
> > Yes, we can kill that NOTIFY_STOP thing in the mce code since it is
> > nasty.
>
> Well, there are places where we want to keep NOTIFY_STOP.

I very very strongly disagree.

>
> 1) Default case for CEC.  We want it to "hide" the corrected error.
>    That was one of the main goals for CEC.  We've discussed cases
>    where CEC shouldn't hide (when internal threshold exceeded and
>    it tries to take a page offline ... probably something related to
>    CMCI storms ... though we didn't really come to any conclusion)

Then put this logic in do_machine_check() or in some sensible place
that it calls via some ops structure or directly.  Don't hide it in
some incomprehensible, possibly nondeterministic place in a notifier
chain.

> 2) Errata. Perhaps a vendor/platform specific function at the head
>    of the notify chain that weeds out errors that should never have
>    been reported.

No, do this before the notifier chain please.

AMA Capital Management, LLC
