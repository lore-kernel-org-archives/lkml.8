Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C5FC1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 16:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FC96206F8
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 16:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvdmNj4X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgCYQTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 12:19:39 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35729 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbgCYQTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 12:19:38 -0400
Received: by mail-ot1-f66.google.com with SMTP id k26so2550187otr.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 09:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Gk96g19HuUDfJIbXBvVzBIn54zxa3+ZdscBdWExaqU=;
        b=mvdmNj4XZXwOge/xwzkDxuLTCHhOMnOe3VGEVQldATILynhdcuCL/r/h0YrudAImzD
         xt03sExFwilKsdjJ1mJJrlRBVcv9aZ1xeBgWoUmBk1LGQoESjiNkGLNnKFim7QYk5oDE
         4HFC1XgEm+r+THLKKloNls1q62CqNc12xQQT/s5Ivg2NUq7gEsQ1oeaOp3n9H8uC7vX4
         We9Bk1HXdpz5VV9VmKM2EoGNIQKDUr5rURxCqF/WIKe8nS9dIOSZAvO9NGxcinzmpOvU
         pMO3dAHvfC7x3EMBapv1UlMH79mM/QsfCxFJ473iAVeolb0iWddoMP9OZTtR5mpiFnyI
         3TtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Gk96g19HuUDfJIbXBvVzBIn54zxa3+ZdscBdWExaqU=;
        b=VdOAnmRp7Ot6NXa/+RfJpRSJsP9L/cV+T3TemWIK1lgqfUXaIFOm+y/y2Yld0VxLBR
         rELwRraSJ54g9zg5LOOPETmFuV2z/FKxc4gTqhTKyy6vhxYL8m0n1y5H7i4IGWeiDPK1
         ytHGn8CA27+OOlCHTl7MOM02rLxEcPYYo6w4rARikrPwSZEUFXDHTyMmIjDVPeb6eEMi
         AgGNbjzzk8fogeD01JnOk3mOBV1wt5MApCZvsztnhd3FRqQ+6WinTdCZ1H/PYXNe3AYj
         9GwggiD0yWAmc8AtQmppR151CfKtoDgJiLa39jDRjkJCZ03Ra+9hnd1QQIOlJUpgR2Wd
         /kkw==
X-Gm-Message-State: ANhLgQ1GeM93nRo3l47/CuNnbAXGQwqtXQJROSQnJSD8Q2FC6TZY7Wb8
        hLk77/7kprS5VBk6aMnnANP/QoI9AUzkaAHbfqNmQmB7
X-Google-Smtp-Source: ADFU+vvDNk2QqWl7+plzmA3wELdx3MDgQlWMj9eppsBM93fmPf4xEcWE8nZz3fTQfAwFDxfjBZ78wBsyKwBP/ZLXe+w=
X-Received: by 2002:a9d:412:: with SMTP id 18mr3018888otc.134.1585153178034;
 Wed, 25 Mar 2020 09:19:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAP6exY+LnUXaOVRZUXmi2wajCPZoJVMFFAwbCzN3YywWyhi8ZA@mail.gmail.com>
 <D31718CF-1755-4846-8043-6E62D57E4937@zytor.com> <CAP6exYJHgqsNq84DCjgNP=nOjp1Aud9J5JAiEZMXe=+dtm-QGA@mail.gmail.com>
 <8E80838A-7A3F-4600-AF58-923EDA3DE91D@zytor.com> <CACdnJusmAHJYauKvHEXNZKaUWPqZoabB_pSn5WokSy_gOnRtTw@mail.gmail.com>
 <A814A71D-0450-4724-885B-859BCD2B7CBD@zytor.com> <CAP6exYJdCzG5EOPB9uaWz+uG-KKt+j7aJMGMfqqD3vthco_Y_g@mail.gmail.com>
 <CF1457CD-0BE2-4806-9703-E99146218BEC@zytor.com> <CAP6exYJj5n8tLibwnAPA554ax9gjUFvyMntCx4OYULUOknWQ0g@mail.gmail.com>
 <C2B3BE61-665A-47FD-87E0-BDB5C30CEFF4@zytor.com> <CAP6exY+avh0G3nuqbxJj2ZgKkRdvwGTKeWyazqXJHbp+X-2u+A@mail.gmail.com>
 <0f31f437-c644-210c-8dc9-22630ab9bd0d@zytor.com>
In-Reply-To: <0f31f437-c644-210c-8dc9-22630ab9bd0d@zytor.com>
From:   ron minnich <rminnich@gmail.com>
Date:   Wed, 25 Mar 2020 09:19:26 -0700
Message-ID: <CAP6exYKCgyM-PFPGLds9LcLPjOMOX40ff2261ZpUuUYijRrCxg@mail.gmail.com>
Subject: Re: [PATCH 1/1] x86 support for the initrd= command line option
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Matthew Garrett <mjg59@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE..." <x86@kernel.org>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I think it may be fine at this point. The only reference to initrd= is
in some of the platform-specific docs and I'm reluctant to change
those. wdyt?

thanks again

On Tue, Mar 24, 2020 at 8:31 PM H. Peter Anvin <hpa@zytor.com> wrote:
>
> On 2020-03-23 15:29, ron minnich wrote:
> > sounds good, I'm inclined to want to mention only initrdmem= in
> > Documentation? or just say initrd is discouraged or deprecated?
>
> Deprecated, yes.
>
>         -hpa
>
