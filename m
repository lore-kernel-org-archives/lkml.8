Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FF8C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 10:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92A182083B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 10:30:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dbei0obF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgIAKau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 06:30:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28819 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726173AbgIAKah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 06:30:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598956234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7xp2NgyNQRcqEmc4bjcRafZrnamtozJTDGfd/4vpEMs=;
        b=Dbei0obFThJStEbRrupRvrG0iSXQ2jtd+jvrfKampJVC9hPXAVBa4UZOdPqlmlqIF16f8l
        Akn/3XX+q51Cz1HqSVvm2EiSZULi4yEW9winsv7dHq8dJ4SUvF8lsSh8WM9LInQldru2UW
        onHbaHW2Otw90cfkwAelqItiqjS+rJo=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-2aos5wAwNyyDBPDX7Vs0Vg-1; Tue, 01 Sep 2020 06:30:32 -0400
X-MC-Unique: 2aos5wAwNyyDBPDX7Vs0Vg-1
Received: by mail-pg1-f200.google.com with SMTP id k26so485605pgf.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 03:30:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7xp2NgyNQRcqEmc4bjcRafZrnamtozJTDGfd/4vpEMs=;
        b=I6bJMtSYv7deWlp5xoRGKpy4t9d1AlLTRW4v447Abs9ZS5u4NxIzC1gx+oXxCgXUnD
         ags4EFxq58eXs0w4axIs3Y8lw3AnDoZOgmh1B373ZlB3eZmFC89RlgfIaxojgdpyw01A
         a2ZvBLPNm1C/3ZVQwDMLucEahdhNTrS7+PdfNnc/eV38CS8lhVB4CEeYmKzBemG1hJ+5
         x6dtkLVMFUsVL+GnpmpLDgke6CMDPMSNd2W2MV0bnJbTTz7wGZcqQMWqCxxAqUNlemgU
         RzE5LQ/LtGP9IcgtKEGtykXGy35mmkt+4cpQW39skkEUSvIWIngve6uvK5xzCZL7U2Ql
         lP4w==
X-Gm-Message-State: AOAM530LpsXBEubOBaFDK9lLEjRkWvGq4giKPKqysghRd4eoHsCt8FBR
        33saMNHKzz03iktozRQyiUowvvou747EistpT0ZJLcVk+tmANPNtrG+fvU1z8R7qbJEnIyxC3PE
        NlkubQxR7p5JuQHZMZcOe5WdI9Lo3WiFrAYAEloCZ
X-Received: by 2002:a17:90a:17cb:: with SMTP id q69mr925069pja.56.1598956231699;
        Tue, 01 Sep 2020 03:30:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztegbyjmEoed7odzziHs1Pf33M/uulBUGEeSZWeyMhPsGb0MYk/NwzotrRqoye5+bB6v4yoAlXvoViSIAm25E=
X-Received: by 2002:a17:90a:17cb:: with SMTP id q69mr925057pja.56.1598956231473;
 Tue, 01 Sep 2020 03:30:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200826134658.1046338-1-maz@kernel.org> <nycvar.YFH.7.76.2008271132050.27422@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.2008271132050.27422@cbobk.fhfr.pm>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 1 Sep 2020 12:30:20 +0200
Message-ID: <CAO-hwJLUk0eO0GC2WQf=iimTOL4JWak96t1z0Zskfv-G_+MGNA@mail.gmail.com>
Subject: Re: [PATCH v2] HID: core: Sanitize event code and type when mapping input
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "3.8+" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 11:33 AM Jiri Kosina <jikos@kernel.org> wrote:
>
> On Wed, 26 Aug 2020, Marc Zyngier wrote:
>
> > When calling into hid_map_usage(), the passed event code is
> > blindly stored as is, even if it doesn't fit in the associated bitmap.
> >
> > This event code can come from a variety of sources, including devices
> > masquerading as input devices, only a bit more "programmable".
> >
> > Instead of taking the event code at face value, check that it actually
> > fits the corresponding bitmap, and if it doesn't:
> > - spit out a warning so that we know which device is acting up
> > - NULLify the bitmap pointer so that we catch unexpected uses
> >
> > Code paths that can make use of untrusted inputs can now check
> > that the mapping was indeed correct and bail out if not.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > ---
> > * From v1:
> >   - Dropped the input.c changes, and turned hid_map_usage() into
> >     the validation primitive.
> >   - Handle mapping failures in hidinput_configure_usage() and
> >     mt_touch_input_mapping() (on top of hid_map_usage_clear() which
> >     was already handled)
>
> Benjamin, could you please run this through your regression testing
> machinery?
>
> It's a non-trivial core change, at the same time I'd like not to postpone
> it for 5.10 due to its nature.

OK, just passed the v4 to the testsuite, and this seems good. It won't
break touchscreens nor keyboards/mice that needed to be added in the
past.

So this is a go for me.

Cheers,
Benjamin

>
> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
>

