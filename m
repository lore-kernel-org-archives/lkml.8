Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E482AC2BA15
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 15:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBF7C20678
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 15:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QWtXPAyi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404181AbgDCPPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 11:15:19 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41309 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2403991AbgDCPPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 11:15:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585926918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SRb6CsmI17uMNzLCPreryxqmrirK+0qj0zIO/GeumII=;
        b=QWtXPAyiSMWjzvCiw3dgOe2gmdlR09/0AhGafeMNmrpQyt7h+R04S5gq7fzbPGtUkP6bkE
        IxxSsHJOVehKTMb8Bm+Sic88pY6piGCwNOr4sZU9kk3rlq864fnXW7lfxS8QGePevMUD7m
        gKp5q2K7pHYDWLE2FeVP/DgbUmyQGMk=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-_Ii71nyPO9a8ZFhIX8T6ew-1; Fri, 03 Apr 2020 11:15:16 -0400
X-MC-Unique: _Ii71nyPO9a8ZFhIX8T6ew-1
Received: by mail-qv1-f72.google.com with SMTP id d2so6013977qve.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 08:15:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=SRb6CsmI17uMNzLCPreryxqmrirK+0qj0zIO/GeumII=;
        b=h6YGxXVGwv3hxjP9QZoA4eagArzWfjVxOnvFM7SfOt0QuQ+zSzn8DPVdeDYoGML+he
         EQGiOQw9qeBd2LV312oaHKwYNDIGvRf7Pg+/9VdMvwx3Q3WWEMhVOq4/5keify8KR6Ks
         q1F7cGbejzqElW6EyF+tRSOlRr2zbyUsKeru2+j4ySoh16XGpZhzzqY7DXInwPAdqLbD
         3gKEogYLr4gX7fyepO0z3ULBIvgpHF8TrGPLEayk6BXWuhONh69bUyJ/Hv3liOoj11yy
         QYexDrmHorlhRkoePi8yksXLLGG5UpqJFIqDVP1RhIjaCTife+HxybVarPmnen2u+vok
         GZFg==
X-Gm-Message-State: AGi0PubUiHAasZG9JskMMAbJCxPNFeFOZIJvGq7e3+N6xPs6uCjPzaJs
        UQ6uXKG6z3WNDG6PWDa7no9DE4i7BssoTDTiQc/0GANWl3o7tTmN59p5xD8PKU7jAwoUKRqTz/r
        xdkLbUlD0S4Fd9MBaBErJ3EQnWLrsSpEPIF4n/0c8
X-Received: by 2002:a37:4852:: with SMTP id v79mr8867485qka.459.1585926916384;
        Fri, 03 Apr 2020 08:15:16 -0700 (PDT)
X-Google-Smtp-Source: APiQypJUV2d7K2It0zrkL8C79HBnt1r3tN9WNQmjeddv/tPrQG2xyyWE8oxqPtbZqLWgqoyz+1oPB7uh1dY7LeRDiKI=
X-Received: by 2002:a37:4852:: with SMTP id v79mr8867461qka.459.1585926916112;
 Fri, 03 Apr 2020 08:15:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200112235009.4074405-1-lains@archlinux.org> <nycvar.YFH.7.76.2004031531190.19713@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.2004031531190.19713@cbobk.fhfr.pm>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 3 Apr 2020 17:15:04 +0200
Message-ID: <CAO-hwJJwBUqSMj_E71YBYEfqY7hCsvgqexFvPyU5dnyCyLxtcg@mail.gmail.com>
Subject: Re: [PATCH v2] HID: logitech: drop outdated references to unifying receivers
To:     Jiri Kosina <jikos@kernel.org>
Cc:     =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@archlinux.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 3, 2020 at 3:31 PM Jiri Kosina <jikos@kernel.org> wrote:
>
> On Sun, 12 Jan 2020, Filipe La=C3=ADns wrote:
>
> > The hid-logitech-{dj,hidpp} were originally developed for unifying
> > receivers but since then they have evolved and now support other types
> > of receivers and devices. This patch adjusts the original descriptions
> > with this in mind.
>
> Benjamin, I guess you are fine with this change ... ?

Yes, work for me.

[Sorry for being unresponsive for a while, got a bunch of things on my
plate right now :( ]

Cheers,
Benjamin

>
> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
>

