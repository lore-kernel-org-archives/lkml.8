Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9C6C34022
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 16:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C44421D7D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 16:31:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbgBQQb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 11:31:27 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:37337 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727922AbgBQQb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:31:27 -0500
Received: from mail-qt1-f182.google.com ([209.85.160.182]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MNssA-1ioNCn26ki-00OGAh for <linux-kernel@vger.kernel.org>; Mon, 17 Feb
 2020 17:31:25 +0100
Received: by mail-qt1-f182.google.com with SMTP id w47so12417235qtk.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 08:31:25 -0800 (PST)
X-Gm-Message-State: APjAAAUjqE8ZK/SN6o5Z9Vwz/rFItc27vaWW0eZoZ3lOuZkJqNe/r0Z9
        hSH9G1D7KSlusg1cR2HdeuBy+nN2uWUiIZhx21k=
X-Google-Smtp-Source: APXvYqyGebgskD9DJnggAXDAzLcpUd37EudJOxUPk6hTCsINePQmNXOJ6CgjR7jrFr4TGbNM4fkWp15166EEI9MfXls=
X-Received: by 2002:ac8:1977:: with SMTP id g52mr13579716qtk.18.1581957084396;
 Mon, 17 Feb 2020 08:31:24 -0800 (PST)
MIME-Version: 1.0
References: <cover.1580299067.git.vitor.soares@synopsys.com>
 <20200217155141.08e87b3f@collabora.com> <CAK8P3a0jAbevb6mjy7Q=C-TFGn7uHRvshHNEO8XrDPRvRoAiTA@mail.gmail.com>
 <20200217163622.6c78fa3f@collabora.com> <CH2PR12MB42166ED8E84503B53340F80DAE160@CH2PR12MB4216.namprd12.prod.outlook.com>
 <20200217172309.26697082@collabora.com>
In-Reply-To: <20200217172309.26697082@collabora.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 17 Feb 2020 17:31:08 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2O23=Jjmj0xTQC7pePnwHBrcJ1YeRAKp-1hVf1GNmA5w@mail.gmail.com>
Message-ID: <CAK8P3a2O23=Jjmj0xTQC7pePnwHBrcJ1YeRAKp-1hVf1GNmA5w@mail.gmail.com>
Subject: Re: [RFC v2 0/4] Introduce i3c device userspace interface
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Vitor Soares <Vitor.Soares@synopsys.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-i3c@lists.infradead.org" <linux-i3c@lists.infradead.org>,
        Jose Abreu <Jose.Abreu@synopsys.com>,
        Joao Pinto <Joao.Pinto@synopsys.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        gregkh <gregkh@linuxfoundation.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:suRVh0DMABCHF5Y/93HhEREtRKP8lcCsn+LHExbJBwq7R4md+Li
 HHoh69xbA9blE0gVsDJXJo1qtH1ax6GmWFNh426kqFbDc54MI3t1FHo49OTpL1jwg4MU//M
 0LDjKfbEUN5EXDdM/KXUUtH0kf/9klqkiEOcPmTSZW8d0nhHfPNQjjTLcvXUsVjPo8Y9rgS
 s18GkeKDEbKgeAhqIg01g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QaOfZ6+nneo=:CtVg9+w01Zr7Szb/WEToFo
 la9+Ve7WHuwaWjJo4/0nG/A3Uj8lutCs6mPkJuGRuz4g0KkK02ZI1/XdfbG1uO6i0ssH7Ji3I
 ABeA08O/vO6xSzQsk3aV5pVNeJtEyOA3eZJySDl3U8Vgarsfjzak2cTJIJX9kiQrE0PAJ/q65
 wsjySo1x1NUEt9BEy0l324P9tT+guLdHnKfVNtGGtPQuczLpdM8/uWd6G8Yyo4eJDJy+wndbj
 ftbniz+0NvEGj2sdSYTXGWIooLVJuHoLXCvT5slsTayprrPNmADEIEa5qwCOhF89lEPwrcFtZ
 3ObDrVIlcAQHbMaY+2rqatV+xEPBeNI98vAYR+VtnFljuvJb2cVF8qtJ1ZiC80CYiGqVhqABL
 zjHRPZ8IRUNlkLFbgGKdLAXr0RJnhUVgVgv6Hzbo/8pmd8AHQKYo7omMkwp44SchmrAd6aiBb
 NKZYvqNDsSSYvPS9Z+zlv0pfAAz0ci0Qz3MTZCCyepXWL+Scn5F4e8OVJRwNMU+E+bCFqWCcI
 FNpGTfFINS2zIovMftyvC6RrbqS5r0Ki7mtTB5JTGvbuP0ohtNl+yyYmxeO130eRePgpJ/w9t
 tZYCHu0VQaGXXjL2HiQ9QI8XOYrxHgLeBvIIqyC0hj120+uuieDJI5WYVT1S/6xAEWH5n0wg1
 wZWjp5u+2W/PMQml+aCp/ITGSWkfPfxzQf9e+chxHbKVwJ5Je0aynlqmhkNI9jIaqkWXxsN4A
 5Sis6K/jXBLkqmACy6MU/HagIxHH+HMma4lsEs4c4GmHKKO5UEbkOyCSxgUDYLzcabhmY6cw9
 fK3PhTPlHzQWQ2A+Wz0yPcXt7/WdZ41HiQQZu4FR3jOa7YlK/U=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 5:23 PM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
> On Mon, 17 Feb 2020 15:55:08 +0000 Vitor Soares <Vitor.Soares@synopsys.com> wrote:
>
> Okay, I have clearly not read the code carefully enough. I thought you
> were declaring a new i3c_device_driver and were manually binding all
> orphan devices to this driver. Looks like the solution is more subtle
> than that, and i3cdevs are actually subdevices that are automatically
> created/removed when the I3C device is unbound/bound. That means the
> 'on-demand driver loading' logic is not impacted by this new layer. I'm
> still not convinced this is needed (I expect i3cdev to be used mostly
> for experiment, and in that case, having a udev rule, or manually
> binding the device to the i3cdev driver shouldn't be a problem).

I'm fairly sure it's not needed, other approaches could be used to
provide user space access, but it's not clear if any other way is
better either. It also took me a while to figure out what is going on
when I read the code.

One thought that I had was that this could be better integrated into
the core, with user space being there implicitly through sysfs rather
than a /dev file.

> I'm also not sure what happens if the device is still used when
> i3cdev_detach() is called, can transfers still be done after the device
> is attached to its in-kernel driver?

I think this is still an open issue that I also pointed out. The driver
binding/unbinding and user space access definitely needs to
be properly serialized, whichever method is used to implement the
user access.

       Arnd
