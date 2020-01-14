Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873D1C33CA9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 01:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A37B207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 01:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FVpF3BDa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbgANBLv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 20:11:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55598 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729163AbgANBLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 20:11:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578964310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yJS3SQDuyFcfsfzdSLUzj3J9c/FI6Hl/bpVZVrZ98a8=;
        b=FVpF3BDaEYWQ7X990OCJslqrK7wILUgBxAdxoRjmqiAImRLXI2jcWpEYFVvrKw+g0uE/v9
        ujZexW2CB8vO4ROk+oExIMcqEoortze4hVT6TNsrHQAZtXXaky0jUtx4k+iR2r2NQOmwmV
        rCtginBoQPNoArqPnbJXzN38rmF8WGc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-zO1fxCPOM6qPVPIPot8_Ow-1; Mon, 13 Jan 2020 20:11:49 -0500
X-MC-Unique: zO1fxCPOM6qPVPIPot8_Ow-1
Received: by mail-qv1-f71.google.com with SMTP id g6so7641751qvp.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 17:11:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yJS3SQDuyFcfsfzdSLUzj3J9c/FI6Hl/bpVZVrZ98a8=;
        b=I37rA2ZtlfPczZHNFy38w2YPXEC5qoqcnMRTjKbvVzIFiWN6CtYgGo/f5zW69a5uZB
         wnyoJZxJE1JyTnpMsZn5wAXTZZT18HBhx6P0qFIE1fe9IdVTNLE8nskWocXfGHuextEo
         zaqTxB9nDxKk7LXJeez9KpN+5so5zJhWjG18UdWYWQWUaGMUq7ZdXhEX8sqUVnxBcrGZ
         GYx074P/p/ICIndYSA97j4wVOK1pABqUW46OhaC5m89VqsMlQeK2zjLSd1cRAhzXXgRR
         DCo027MoyET0+VapTuYFqd/251eeVFfz99O6sgyS2Vh6ooAFyMqrRS4QmAXLM1kBM/FY
         DWRg==
X-Gm-Message-State: APjAAAWy+QbW5v8LP6cSJDPaC4zACJsEUMtUtCAt7VnR8JRELF4KBe4m
        7PZgdROOoSOPW+gHyiVMilYJoUDXaHVu+igSoE4WK0iLroNhb98SPOEU8u0OWtCFyH+oHCZCfVi
        wp68xekXakNAamhDkV0LZZQhv7cgcHgnKHzm8i0YD
X-Received: by 2002:ac8:6b98:: with SMTP id z24mr749420qts.294.1578964308732;
        Mon, 13 Jan 2020 17:11:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqxcj0IG1yTGPYw+rvBGa//EjfsrQIdxtjKY9m8WnLqY6tnFhjxIf3+hwKS2Q5MxcKSkwOtS19rpkAkklAKKXnI=
X-Received: by 2002:ac8:6b98:: with SMTP id z24mr749412qts.294.1578964308564;
 Mon, 13 Jan 2020 17:11:48 -0800 (PST)
MIME-Version: 1.0
References: <20200112205021.3004703-1-lains@archlinux.org> <7d49a8444ea1740444d1e9133104530731bfb30a.camel@archlinux.org>
 <CAO-hwJ+56qUTr8HQOLyx9tgbJMuTTPbb6K40cwWnO=PzMcO+tQ@mail.gmail.com> <1e4143394f773df60a2ba329c940b339e4563bee.camel@archlinux.org>
In-Reply-To: <1e4143394f773df60a2ba329c940b339e4563bee.camel@archlinux.org>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 14 Jan 2020 21:08:42 +1000
Message-ID: <CAO-hwJJ00Vy5Hv=gsbopr=8e8xJfmt7wvZf+CSVrSZZ=S0uO9Q@mail.gmail.com>
Subject: Re: [PATCH] HID: logitech-hidpp: add support for the Powerplay mat/receiver
To:     =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@archlinux.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 10:55 AM Filipe La=C3=ADns <lains@archlinux.org> wr=
ote:
>
> On Tue, 2020-01-14 at 20:48 +1000, Benjamin Tissoires wrote:
> > On Tue, Jan 14, 2020 at 1:31 AM Filipe La=C3=ADns <lains@archlinux.org>
> > wrote:
> > > On Sun, 2020-01-12 at 20:50 +0000, Filipe La=C3=ADns wrote:
> > > > I also marked all lightspeed devices as HID++ compatible. As the
> > > > internal powerplay device does not have REPORT_TYPE_KEYBOARD or
> > > > REPORT_TYPE_KEYBOARD it was not being marked as HID++ compatible
> > > > in
> > > > logi_hidpp_dev_conn_notif_equad.
> > >
> > > Actually I had another look at the code and I don't understand why
> > > we
> > > are manually setting |=3D HIDPP in
> > > logi_hidpp_dev_conn_notif_equad/logi_hidpp_dev_conn_notif_27mhz. We
> > > should set it in logi_dj_hidpp_event as it is triggered by
> > > receiving a
> > > HID++ packet.
> >
> > long story short: nope :)
> >
> > The whole purpose of setting the workitem->reports_supported is to be
> > able to create the matching report descriptor in the new virtual
> > device. So having this set in a callback will add an operation for
> > nothing every time we get an event, and will also not ensure a proper
> > separation of concerns.
> >
> > Cheers,
> > Benjamin
> >
> > > What do you think Benjamin?
> > >
> > > --
> > > Filipe La=C3=ADns
>
> Okay, then is maybe better if I add HIDPP to reports_supported based on
> the device ID (7). This is the only product to my knowledge that
> exports a device with ID 7. It's a better solution than setting HIDPP
> on all lightspeed devices.

Yep, looks better.

>
> I will send a new patch if you agree with this approach.

thanks.

Cheers,
Benjamin

>
> --
> Filipe La=C3=ADns

