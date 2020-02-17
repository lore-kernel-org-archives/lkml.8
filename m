Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FEA0C34021
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 16:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FB4F20801
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 16:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbgBQQUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 11:20:16 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:37999 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbgBQQUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:20:16 -0500
Received: from mail-qv1-f53.google.com ([209.85.219.53]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MS3zP-1isTnI0KwF-00TYUK for <linux-kernel@vger.kernel.org>; Mon, 17 Feb
 2020 17:20:15 +0100
Received: by mail-qv1-f53.google.com with SMTP id y2so7788168qvu.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 08:20:14 -0800 (PST)
X-Gm-Message-State: APjAAAWihEqOlChBvk1J58pqVWk1G68M8Fzd3rX1xsH+z1UV39On1Nch
        xdQWKPdD88+uSWY5qlewItIhiXXJkgo3hLAxkKQ=
X-Google-Smtp-Source: APXvYqzYCO15qEyUkpdnFmwa26IRA+4Z3t8KgCeJYJa2fcHKMjmSuPHCLc9jCWIGCokb9o8Y9wrFM1dftVMO8mDjlBk=
X-Received: by 2002:a05:6214:524:: with SMTP id x4mr13442601qvw.4.1581956413750;
 Mon, 17 Feb 2020 08:20:13 -0800 (PST)
MIME-Version: 1.0
References: <cover.1580299067.git.vitor.soares@synopsys.com>
 <20200217155141.08e87b3f@collabora.com> <CAK8P3a0jAbevb6mjy7Q=C-TFGn7uHRvshHNEO8XrDPRvRoAiTA@mail.gmail.com>
 <20200217163622.6c78fa3f@collabora.com>
In-Reply-To: <20200217163622.6c78fa3f@collabora.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 17 Feb 2020 17:19:57 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2EhRyRG20GqMZjYa_-5X2eMiYk20NdsaXe1qVhy5si=A@mail.gmail.com>
Message-ID: <CAK8P3a2EhRyRG20GqMZjYa_-5X2eMiYk20NdsaXe1qVhy5si=A@mail.gmail.com>
Subject: Re: [RFC v2 0/4] Introduce i3c device userspace interface
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Vitor Soares <Vitor.Soares@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-i3c@lists.infradead.org,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        gregkh <gregkh@linuxfoundation.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:g+UpWlHjuSTTJLK08YLd+oHfifIgzuoa7a0t8p6HCeak7K+ng8c
 mp4MYM7jui9SnNMiguKBKFpDxPm2hN1WI2Kir9S3Dg5WPMDew7lZ8P0bN5MbVrVl9Oblz7l
 5Nru81BmDVLHnpWf1y4lVgg1gQm4m3uNn5nxYQdzBuaaahyoFRhI8VOFScEjEDjZVTKaLuZ
 x/Aju0LA4cytZqBWzs71w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qeIXXhfCi8c=:gbJd3OxhP3Yv4BJwUf5mCi
 /BRi/GyyG834gpER1Dxyk5qFYBR2l5RCkHNuweME/i6f+YB99xQvDsQIACjSN9cAH03sadccP
 xNDV20mL7ttthK8DcwlTjWrZnMmEo8Nzm2BxTM6N3XfEr3uCpYjCqHfTCgvJ1lmuzhLN1i0Fg
 h2XEtjqJNT5zYja+Bij0lVnItR8OOGy8FSNrp/g/FfCGW7hPin5IQRiKBQOI4HfynI6TSggdp
 XTmZqm0+X23ts16DDzc1aycBtmU0O0Wu0nZyF1nxek1+NQOCs3ACyjFNz/nbnXMom0aIsxX2W
 Y6mtbDk/BPWMxfCdhQKQJnc6BrkwSajiZ6pjqyHlRsK/LgWWu119eXXumvdYI3XA3fRMvPkjw
 Zymouf3f7sYAg4c/M44wfCyiuEUNKQV/jdeL1VmlqkGlyE9msxWb4Kdg0DhzIoGeNUL6fj9sJ
 ybj79ZbqcK1qBZ07DXL+HtFoBLw225r1ge3ugmJUoIOv05kKZEV7ueiArr5uySTLEpu/DfUjd
 QToHkwVNkt3wzOgNx1YYoPg5U19xBH4gWm/zmNP54Cv5Cfn5GCL9WhsKDWZhxDWuxFs3zeEjf
 2zozqY+oQ/3R1yLdR5Mg9dBvtvaKrowmOARu7UgAhJuIhkzDiSi4meBLgwtJTTVLf+cwMjgqo
 NqjdIqeTIGY6f02yDI/uIiEpcju3/gLuKUzdp4KhrTgszk+fTShUkXf8z17NjwRRNF/qItFte
 Le8lA+nmt82PCmcFNjs56oDZApm08yx6/kfde2VvP8p9XahIM7bhME0rjHLYXwkDoMj9JXwbw
 gMcFrffYlfOCk0IYQu16cqTj3vBII/YRKcT8mQA7tU6Bde9I1s=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 4:36 PM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
> On Mon, 17 Feb 2020 16:06:45 +0100 Arnd Bergmann <arnd@arndb.de> wrote:
> > On Mon, Feb 17, 2020 at 3:51 PM Boris Brezillon
> > <boris.brezillon@collabora.com> wrote:
> > > Sorry for taking so long to reply, and thanks for working on that topic.
> > >
> > > On Wed, 29 Jan 2020 13:17:31 +0100
> > > Vitor Soares <Vitor.Soares@synopsys.com> wrote:
> > >
> > > > For today there is no way to use i3c devices from user space and
> > > > the introduction of such API will help developers during the i3c device
> > > > or i3c host controllers development.
> > > >
> > > > The i3cdev module is highly based on i2c-dev and yet I tried to address
> > > > the concerns raised in [1].
> > > >
> > > > NOTES:
> > > > - The i3cdev dynamically request an unused major number.
> > > >
> > > > - The i3c devices are dynamically exposed/removed from dev/ folder based
> > > >   on if they have a device driver bound to it.
> > >
> > > May I ask why you need to automatically bind devices to the i3cdev
> > > driver when they don't have a driver matching the device id
> > > loaded/compiled-in? If we get the i3c subsystem to generate proper
> > > uevents we should be able to load the i3cdev module and bind the device
> > > to this driver using a udev rule.
> >
> > I think that would require manual configuration to ensure that the correct
> > set of devices get bound to either the userspace driver or an in-kernel
> > driver.
>
> Hm, isn't that what udev is supposed to do anyway? Remember that
> I3C devices expose a manufacturer and part-id (which are similar to the
> USB vendor and product ids), so deciding when an I3C device should be
> bound to the i3cdev driver should be fairly easy, and that's a
> per-device decision anyway.
>
> > The method from the current patch series is more complicated,
> > but it means that any device can be accessed by the user space driver
> > as long as it's not already owned by a kernel driver.
>
> Well, I'm more worried about the extra churn this auto-binding logic
> might create for the common 'on-demand driver loading' use case. At
> first, there's no driver matching a specific device, but userspace
> might load one based on the uevents it receives. With the current
> approach, that means we'd first have to unbind the device before
> loading the driver. AFAICT, no other subsystem does that.

As I understand it, this is handled by the patches: when a new device
shows up, this triggers the creation of the userspace interface and
also the event that leads to the kernel driver to get loaded. If there
is a kernel driver for the device, that should still load and bind to the
device, at which point the user space interface will go away again.

This may waste CPU cycles for first creating and then destroying
the user space interface, but I don't see how it requires extra work.
If it does require manual configuration or unbinding, that would
indeed be a bad design.

      Arnd
