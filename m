Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF57C34021
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C41B2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 15:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729424AbgBQPHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 10:07:05 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:35777 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729365AbgBQPHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 10:07:04 -0500
Received: from mail-qk1-f181.google.com ([209.85.222.181]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MrxfX-1jrK5K19u9-00nzVd for <linux-kernel@vger.kernel.org>; Mon, 17 Feb
 2020 16:07:03 +0100
Received: by mail-qk1-f181.google.com with SMTP id j8so122967qka.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 07:07:03 -0800 (PST)
X-Gm-Message-State: APjAAAXYcUxh+SGQ487vEU4hYZXQgOKwPxJpo6kVd5GSH38vg54yZl4P
        ryqea7XO3RKBEjZKfU8ov55FA2BTM9Fz3sk2cUE=
X-Google-Smtp-Source: APXvYqz9OqBtba+abUUUMNKz6i3LC/Dw5ZdyGM5IHyBgCPdVBvXaDD8QWPzvQe5BJJJR3ttaBrcK7BJIlG+yyD9Ni5o=
X-Received: by 2002:a05:620a:909:: with SMTP id v9mr14320839qkv.138.1581952022158;
 Mon, 17 Feb 2020 07:07:02 -0800 (PST)
MIME-Version: 1.0
References: <cover.1580299067.git.vitor.soares@synopsys.com> <20200217155141.08e87b3f@collabora.com>
In-Reply-To: <20200217155141.08e87b3f@collabora.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 17 Feb 2020 16:06:45 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0jAbevb6mjy7Q=C-TFGn7uHRvshHNEO8XrDPRvRoAiTA@mail.gmail.com>
Message-ID: <CAK8P3a0jAbevb6mjy7Q=C-TFGn7uHRvshHNEO8XrDPRvRoAiTA@mail.gmail.com>
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
X-Provags-ID: V03:K1:xITar22n6qkLifOsSh3/os2mB+G40VnAXEzvcQhDeimHGA3Pfh+
 bpGehj4vkDTpuIOf+wSoyZxwaDLU8HXPnUBfPKWSGgv0qqM3iD2XE/rBdYrl2mYsVAucWgn
 IdcedLlzMQtqnlFnERzKy9yzxtWvysIUvqzZB0km6Up3G+jwpSfMeoEYD5YX4JKLT8LBjvw
 Hft/v2afcrKY4a0H4iGgA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iwfyxnvV6v8=:u1J4dijQVImUIHFBqLgQYZ
 sF1SJeUkvYsaAbfr5l202ckzNH4HbaorN/IAAGCK6Jb+3+aclpHRhE/UInMJ0hCRfsNTQ/R9r
 hm8jKsCX+h9VRugorFG26WF3QeCNZF1wpLV5bzjsBKlf4ZIFNu4VD1NxazU0nJMjoV5iKGZqV
 SevtC+Wf2vUPak6Fm+oTKJJtrISB/eo7LXY+rxSTDsuccHGxKJ1F36OFWbkcut5SGLHzjRvnL
 ssEaPdu+GG6tuMujyLJ68L52pQbXR6I0X/jXsKD0COQHNLkWkcbxBdNMY4UpbjtLaCzU9AWyn
 AlN1NLkl98r3YnijcXSlmh0xaH4rP2J3CmMD0AuKTCndM6dDwrJgsyavyRzd97YsPxDlqMh+1
 qcJsWPY/DIIIJeV6XmAYGQnIzUZkUrBJi3kcps00t+4+G2wkYJL71unVTnabQq+2zOLIbrSmL
 VLzlrwLUhstJN1nj98SAAhFlW11VjjlA/EBNvNLaYUtP3OqRF5Mgo2lGH6ANjJ6t2r5arCwzj
 2NWxTWX2MwwS92uU2e7XtzMwhm9Zy7s6DF3vh6uDSE0gC7qAHd5RnbKc3CUjtBzRzfoOoz+es
 bPgtCjhkG0S4nKKHwlvv84d+r479kUo/mlO9A7z4JeYISO3sFrDu6XXxioj8nY1GArxEiKWcl
 oYHUd7pT93K/aXcX5v6VFhgjjkyTs9xE2Gx3YHCA3t7ryMCtapd9809x6hn572GYXhF1IaMdi
 qD5wGkQetqXnWO0wkeLVHc4KfhtUgctj0XaglNC+Ej8RLptz9AYINc+qgtgWQjD3qIpLZxEtg
 xDOHi8QR4K7x+ALeBDI7j7d7iIii0zWcq9iz2OCdzAaWVpNiW4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 17, 2020 at 3:51 PM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
> Sorry for taking so long to reply, and thanks for working on that topic.
>
> On Wed, 29 Jan 2020 13:17:31 +0100
> Vitor Soares <Vitor.Soares@synopsys.com> wrote:
>
> > For today there is no way to use i3c devices from user space and
> > the introduction of such API will help developers during the i3c device
> > or i3c host controllers development.
> >
> > The i3cdev module is highly based on i2c-dev and yet I tried to address
> > the concerns raised in [1].
> >
> > NOTES:
> > - The i3cdev dynamically request an unused major number.
> >
> > - The i3c devices are dynamically exposed/removed from dev/ folder based
> >   on if they have a device driver bound to it.
>
> May I ask why you need to automatically bind devices to the i3cdev
> driver when they don't have a driver matching the device id
> loaded/compiled-in? If we get the i3c subsystem to generate proper
> uevents we should be able to load the i3cdev module and bind the device
> to this driver using a udev rule.

I think that would require manual configuration to ensure that the correct
set of devices get bound to either the userspace driver or an in-kernel
driver. The method from the current patch series is more complicated,
but it means that any device can be accessed by the user space driver
as long as it's not already owned by a kernel driver.

     Arnd
