Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED8BAC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 15:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D384F2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 15:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbgG0PP4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 11:15:56 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:46491 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbgG0PPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 11:15:55 -0400
Received: from mail-qv1-f46.google.com ([209.85.219.46]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1Mjjzx-1kfPo90V91-00lBjw for <linux-kernel@vger.kernel.org>; Mon, 27 Jul
 2020 17:15:54 +0200
Received: by mail-qv1-f46.google.com with SMTP id dm12so7598488qvb.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 08:15:53 -0700 (PDT)
X-Gm-Message-State: AOAM532kwl1dGaXmc3+QgYhJMw8Tifrm95VeOdwANoUNqfs3yduCI/7Z
        0apZVdZGR0b5Zo2jPA86Kr/jbCef4NXqvvKH7ho=
X-Google-Smtp-Source: ABdhPJz8JYqQMrxytjrFJZ6So17u6EFfd3xP72JlJzwExdG83wSW6pg2ww44Y8DvCC/6WlC7KCmUOokvY6zbG6c7byE=
X-Received: by 2002:ad4:4c09:: with SMTP id bz9mr21830645qvb.210.1595862953011;
 Mon, 27 Jul 2020 08:15:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200724212853.11601-1-daniel.gutson@eclypsium.com>
 <20200725055649.GA1047853@kroah.com> <CAFmMkTE_dT9+WJYyb19uQ_HmgJWZSARBy6PveheQJk++NuGbkQ@mail.gmail.com>
 <20200726071723.GB441916@kroah.com> <CAFmMkTFzGfFDrJrdgHztzLK2K-zBWy6T2Tv+G4-rrbVpbahkgg@mail.gmail.com>
In-Reply-To: <CAFmMkTFzGfFDrJrdgHztzLK2K-zBWy6T2Tv+G4-rrbVpbahkgg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 27 Jul 2020 17:15:37 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1nA7K15Cxz84Q8Grw3tKfgkUmsfURcytJEWb_0Wjqm5w@mail.gmail.com>
Message-ID: <CAK8P3a1nA7K15Cxz84Q8Grw3tKfgkUmsfURcytJEWb_0Wjqm5w@mail.gmail.com>
Subject: Re: [PATCH] Module argument to control whether intel-spi-pci attempts
 to turn the SPI flash chip writeable
To:     Daniel Gutson <daniel@eclypsium.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alex Bazhaniuk <alex@eclypsium.com>,
        Richard Hughes <hughsient@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:hOc+ZkqHfgNWGLVbPWlrhOmb5zC6xv/hIC+TVHVn8xzjtdMf5/0
 bApDUjnlcyN7zYtHAmokOJHGDjlXRUAXWzIjYBRTeWXqpfqKuJNYVuQx1mVqrDwfttDtgAf
 zAIjKcpZCoejpkICjTdFLaFbD48bc3biph/yUeO7hZMjBIGEoTM7BmnugLFJpn9GaGtbTeT
 HCgzht//u1ffI324Dxkaw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lM9a73egz7I=:jRgB6SnjzPmh9pwPEvh5qD
 1RqHmRj04f5oXNrJYWFYjwO6qy7Mino+j34bx54RRsT2IlvHp1qWeKda0EsWmZTRGi8kINH6E
 p1fuh3q25ldyUs6FX6Nt8Jg68uf3sJbawvxuV/lmhtlQKPS+9JuurZ8vAg8v5jNH6hC6gDfKw
 gWFQk/XMQ1uKkGDnbuvRHwze0Z3mrlWekwqG/tx/2JAEOpE+CNgnuuWwDzyd+PxEJoK5LaEzK
 kkkp/7nUb17uUQ3pCtIvWj/Nl64B9vMErS7zU3FToSunjxNzh0zuprQC+0Scnis/YA7wZfOFq
 Sj3B3fJofb0JzynGDDdz8RnZaryvXLAxr3CnCd4h01ajRaUH0jMe3aqlHqh4yYJNyNWbmsLRP
 wFhmBeVC3rYthDaUDbQh73ma5kiRYU4Xy/fyJfj5G65XX6oERtK7L8tghRxOmJLIyY+7pDYhp
 fC5VHTuHtduvL4a3ugmktyeAp969JsAdNxZy+R9xosg8S1RnOyOn+n9R2Apo1aHg1XbNlUQf7
 QOh9IraA0uJ7Gf1TL+7G9VLnr3xZZhVfiVQasbGcZaBO3mS932i0bEyXjRWYaI5+9kUtWwIMX
 np7EpzhJ32RHI3MyJs79ZjIdIr4HpJx468aaABEofbeFsXozIJW5pUtM/+BYWEPELrGk+KxIQ
 qxRgmKu4bHgLW9zBQEgIm6tXxD4ezEOXp4TUTkxJ7t7i3loOY0klr99yUHXDdTIDLPw3xUxzk
 XDzHpy4ixyaeZUmBRE3dXIaFD2U5oKkmes+oDFLkXD1vFJOtMkdC8qTX4O79PT2jcP1P0C9t7
 QTAx1D82Z1yyUgfZLdXjk2yH1ajzmzdWSyPIec/ck+sSARiMD6rMbEAFmxewxCsBbU6rYIr2d
 d3DF0C4KYezfb46FFX5/cMkfZZSEtsF78ITG2rxVadLjvQ2bfSTj68vQPxWUd2PDlmYicJmtc
 tYI0o3+FabE5k5EvjGCmPfLCnFp+bjueYWOfDe0xLWV6z4lnNFe8V
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 5:05 PM Daniel Gutson <daniel@eclypsium.com> wrote:
> On Sun, Jul 26, 2020 at 4:17 AM Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>>
>> On Sat, Jul 25, 2020 at 02:20:03PM -0300, Daniel Gutson wrote:
>> > El sáb., 25 jul. 2020 2:56 a. m., Greg Kroah-Hartman <
>> > gregkh@linuxfoundation.org> escribió:
>> >
>> >
>> > 1) I just did the same that intel-spi.c does.
>>
>> No need to copy bad examples :)
>
>
> Didn't know it was a bad example. What's is the current modern mechanism that replaces initialization-time configuration?

I'd say you'd generally want this to be a per-instance setting, which
could be a sysfs attribute of the physical device, or an ioctl for an
existing user space abstraction.

In the changelog, you should also explain what this is used for. Do
you actually want to write to a device that is marked read-only, or
are you just trying to make the interface more consistent between the
two drivers?

     Arnd
