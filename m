Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E253AC2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 08:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B75D420720
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 08:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="McrXmcwk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbgBFIKM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 03:10:12 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:22270 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727572AbgBFIKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 03:10:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580976611;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pNqlj/aIPtqooHVrOVDSEY2d6+X7P8FExh0I8Cp7N+M=;
        b=McrXmcwkZxmBrf0fk2DjVFtKG+cuBOkHIo7R3HGeWWSn87eq70c43KlfbSDAqUwo9pRzfk
        w+QhRQ57pr6FGBSju0NeloVyAR8apBJfpZHjMp7fN1Q3KYNySxmnGjXDoSQ5XgG8sNb1Sl
        hwbSi9zsopiljoibR7oiGDbCPNgz4es=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-YJvyVyNaP3efqkA9Stcgzg-1; Thu, 06 Feb 2020 03:10:04 -0500
X-MC-Unique: YJvyVyNaP3efqkA9Stcgzg-1
Received: by mail-qk1-f198.google.com with SMTP id i135so3051965qke.14
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 00:10:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pNqlj/aIPtqooHVrOVDSEY2d6+X7P8FExh0I8Cp7N+M=;
        b=Hqw0Bj+4zArw5hbAay55NLjpKUMOjFVhXE1lSLIAFKbhRGg83gkPYnt4WsHP7cJGkK
         691giLuuBQX20C37Knoq0JzY5eP1LRNjTA4j17vp8iXTm7cZjyn07nv0CKiytqD1u4SF
         k12p4nKgl62XwQYyaX63K++cQFGyMwsMcQrH44SmETDlhj4Zbu8nkjN9p+dVdkwx9e0U
         bWuvJtFW9ZGFTW9XghFtaLSzbOImm304RVEWJRREig+ED5+SUfP+fLhhIaLw01rE3nzT
         zOwXXrPTFsW2Zm0sWnZLw2PnxZD4Go5InWNx+6if9fzljw2BfKSYzop75A9PuOB3bS09
         wxHg==
X-Gm-Message-State: APjAAAUBCrvmjLArVEJKtws347Zz1K0PSbEYn8GqYfAoMwSI/zZNSxh+
        wvIQ1y7GyBb7r+BP2yeTO/bb1q0kvoGPj3CWpYpWO8luHVyrAOm2CC74YSwAWeWNpxCl3UqtjpF
        l+R6T8OV4hfrpkh6NppbXFs+BBMzLrrncsn/7MsCK
X-Received: by 2002:ae9:ef4b:: with SMTP id d72mr1392222qkg.27.1580976604405;
        Thu, 06 Feb 2020 00:10:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqyF+uGZ8Ea+EIqllofbuMHnsKLrT5VS1cxbxgTen+ILjpjQqajo5Rbpeqqd2pOVLfnRIYnnbagS1R64wN2XaTQ=
X-Received: by 2002:ae9:ef4b:: with SMTP id d72mr1392204qkg.27.1580976604136;
 Thu, 06 Feb 2020 00:10:04 -0800 (PST)
MIME-Version: 1.0
References: <20200126194513.6359-1-martyn@welchs.me.uk> <CAEc3jaDjVZF_Z7Guj1YUo5J5C_-GEOYTH=LKARKccCwQAwuZnQ@mail.gmail.com>
 <fb8850c6c1766b4360a69419845aa8bf7a3aa7a6.camel@welchs.me.uk>
 <CAEc3jaB9ubRLJJG9eWL8-QnEU1s-6cOYsY-PKd57e_K9BiPkSA@mail.gmail.com>
 <nycvar.YFH.7.76.2002031100500.31058@cbobk.fhfr.pm> <CAO-hwJ+k8fxULS1xC-28jHmhZLZVN5EGc=kY5sqNX1GCNKpt4A@mail.gmail.com>
 <nycvar.YFH.7.76.2002031218230.26888@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.2002031218230.26888@cbobk.fhfr.pm>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 6 Feb 2020 09:09:53 +0100
Message-ID: <CAO-hwJJk411hGTJ6uSdzAFCzf1WJehhifdN0r5kMG6aqL=dnpw@mail.gmail.com>
Subject: Re: [PATCH] HID: Sony: Add support for Gasia controllers
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Roderick Colenbrander <thunderbird2k@gmail.com>,
        Martyn Welch <martyn@welchs.me.uk>,
        linux-input <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "Conn O'Griofa" <connogriofa@gmail.com>,
        "Colenbrander, Roelof" <roderick.colenbrander@sony.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Feb 3, 2020 at 12:23 PM Jiri Kosina <jikos@kernel.org> wrote:
>
> On Mon, 3 Feb 2020, Benjamin Tissoires wrote:
>
> > I am definitely not in favour of that :(
> >
> > The basic problem we have here is that some vendors are overriding your
> > VID/PIDs, and this is nasty. And I do not see any reasons why you can't
> > say: "well, we broke it, sorry, but we only support *our* devices, not
> > third party ones".
>
> Well, it's not about "we broke it" in the first place, as far as I
> can tell.
>
> Roderick's concern is that 3rd party devices with overriden VID/PID
> malfunction for completely unrelated reason to (correctly working) changes
> done in favor of stock Sony devices, but it'll be Sony receiving all the
> reports/blame.

After re-reading the code, I am not sure we can easily detect the
clones. So at some point, I think we will break them, but there is not
much we can do. I don't really have a solution for that :(

>
> > One thing that comes to my mind (probably not the best solution), is to
> > taint the kernel if you are facing a non genuine product. We do that for
> > nvidia, and basically, we can say: "well, supporting the nvidia blob is
> > done on a best effort case, and see with them directly if you have an
> > issue". Tainting the kernel is a little bit rough, but maybe adding an
> > info message in the dmesg if you detect one of those can lead to a
> > situation were we can count on you for supporting the official products,
> > and you can get community support for the clones.
>
> Yeah; which I wouldn't like to do for upstream kernel, but Sony could
> definitely do this for the products they ship.
>
> The same way distros are tainting their kernels when unsupported modules
> (but otherwise perfectly fine wrt. GPL and everything else) are loaded
> into distro-supported kernels.
>
> > One last thing. Roderick, I am not sure if I mentioned that or not, but
> > I am heavily adding regression tests for HID in
> > https://gitlab.freedesktop.org/libevdev/hid-tools/
>
> ... and words can't express how thankful I am for that :)
>

OK, I played with that idea earlier this week:
https://gitlab.freedesktop.org/libevdev/hid-tools/merge_requests/74
I only have a Sixaxis controller, and I only implemented the USB part
of it (AFAICT).
Currently this ensures the button mapping is correct, and that the
LEDs are working properly.
We are still missing a few bits and pieces, but the initialization
(requests made by the kernel to start the device and press on the PS
button) is handled properly.

If this is something Roderick would be interested in, we can then try
to extend this initial work on Bluetooth controllers and the DualShock
ones.
Adding the clones ones based on the current kernel code is something
doable, but I do not expect Sony to be involved in that process.

That being said, before we merge this particular patch about Gasia
controllers, now we need to implement a regression test first :)

Cheers,
Benjamin

