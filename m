Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47835C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 20:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26DD62063A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 20:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730089AbgGUUu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 16:50:28 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:49855 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbgGUUu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 16:50:28 -0400
Received: from mail-qk1-f182.google.com ([209.85.222.182]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1Mj8eD-1kRWbf2kzd-00f8yZ for <linux-kernel@vger.kernel.org>; Tue, 21 Jul
 2020 22:50:26 +0200
Received: by mail-qk1-f182.google.com with SMTP id k18so20793034qke.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 13:50:26 -0700 (PDT)
X-Gm-Message-State: AOAM533IKaBrZhFCu9gbPq8gEHqf7J5RQssCXA60Mu+dcGNYLBPULRH3
        1mZaB3q6RBlyBwCsJGQTx3pwPEtIIsvky1TwfVY=
X-Google-Smtp-Source: ABdhPJy0J/jNC3Ntkb9bisfBwc22cOAjqjDXF319stddxiTgvuWvLo+KEO3SQ8VlH9Y4PpuFAVrcmu8WcMqbAvdetC4=
X-Received: by 2002:a37:b484:: with SMTP id d126mr28688657qkf.394.1595364625563;
 Tue, 21 Jul 2020 13:50:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200716223627.253936-1-daniel.gutson@eclypsium.com>
 <CAK8P3a2miOXUESw+ayiEzAZ07NcieztVMEY31wUgrkD2tBAtDg@mail.gmail.com>
 <CAFmMkTG3rMtmNxYf0jXgGN7zJgK2U8Ogtrd4yH0Ee1rC7pf9Mg@mail.gmail.com>
 <CAK8P3a384fKBEYU22UDOyr2vpdo+A+keoF_4jhcevG-w9rvtdw@mail.gmail.com> <CAFmMkTF23JVfCe-ynBzbYQ_eF=z6fKCPdA6DbTrJ9OFYxGBWkQ@mail.gmail.com>
In-Reply-To: <CAFmMkTF23JVfCe-ynBzbYQ_eF=z6fKCPdA6DbTrJ9OFYxGBWkQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 21 Jul 2020 22:50:08 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2cP2JpWO4PumaRENcOSj8pLwvJfTe6uP9QtRY8eGi_fA@mail.gmail.com>
Message-ID: <CAK8P3a2cP2JpWO4PumaRENcOSj8pLwvJfTe6uP9QtRY8eGi_fA@mail.gmail.com>
Subject: Re: [PATCH] [PATCH] Firmware security information in SYSFS
To:     Daniel Gutson <daniel@eclypsium.com>
Cc:     Derek Kiernan <derek.kiernan@xilinx.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Richard Hughes <hughsient@gmail.com>,
        Alex Bazhaniuk <alex@eclypsium.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:XFCRV57n8lc2c4nXLuLzPsaiIy9oNKovSXugEQ5Te7ZzAgTe52M
 i6v+5ku4J1Kdc9gZALd55mLDrbzMm5PYoUI5Pcx9zpi9s7kldz17tUMMkFw1H6nEHzu2oTx
 /QdW6htNEt10uJIO9OhMLyZ3NHVe8o2kUJbmTO6Uw0MqtGZSq7h1gPy2DaeuUXBYOQ9dIZH
 sffdBBjvdqezG7eKdfILA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Wa54Ie32LFY=:7lsbXAL0QlG6TmwNNMCvl9
 Mw4wsJ8PRUQa3mTOMq6RQV82zaqEtYBfCA+/6BC1yW3JcbHX2eHnfdVyo1qaL9pJSBVXHjFx7
 3/U/JHDjeetoRdWXesWcxORwZjggnHD4SVo0B6gGMlo6DXyWKnwMF1EdS1u0E3S8UyCy6dNvc
 xTWfo83FdJJ5CuQlI70uN6KTYPZfcQwzVJN0D2Czfx86g8jbVEYhBx/ysuAAvt5Ixmalb/L+H
 fjIkU1bNBmlQyvKWcwiNVk55IYOP9YVgnZkhi31GQDXOPh4RFP4AMZTdtTTZ8kh5mp98g8JYO
 dWwy0pHJG+uG+S3bo6/rkt3VrKs6w6/mNDYjYUIEaG6wcDLDWLJKHEkeTWeAZ7tHPPk9v6yxr
 pUi0BwU6x+DKCKrOn1BNFlJtVvtlqHHZIiySgmHcLjTNpTjl7pkNzkLmMxnTnTXjDrDUNkZXH
 hDIBVs+9FCJmzdKAdrZYh4gnxWpuhroHOSNGQSp9Ahr6k+Kx7M9uCOxjaxTM6qTW4h39Zp+da
 b6642Trz6/Jk+tixCJCJubRfr5blhK865usqBoigrCM6+gMs+iZVqZ27L4Mm0nkOGA0N/1tZY
 gQvZY88L7a594qb6h19QmQkxYOxbbonBn2Cem/Vfgg/stNwMa/qjW2PbByXxahUw1ZfOcw7E2
 3U45dxn6HTmFrpYHW1lmjex0Oy8u389ZohX1YNgnvwihF3lT3139PDjZQecVPgYD9uMCEUSOP
 45J0qcVkPGvY4ZlxaZxlFazsHy8/7c9LrltyC1z6nahgROSZU5TmWDlJLh4mNTtDOY7hzIbbz
 F16/nF2DjhV9gSGhinTz4XmwzqNR2N2IcDAiYki0QAD7LW2zeYlOlAPAWNw63n8OVN/CO3Cxq
 G6QchsYyhm01Nzun1iF9VUi2kUPS+zhYPkhaE5OYH+E93yq3inheGYfdCW0/xuswuifdsnFC4
 En6FBuqiOugDYpj1vX3S9a6oZHXllWfhttMR3V9QOTZxJ22Rea5W0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 9:49 PM Daniel Gutson <daniel@eclypsium.com> wrote:
> On Fri, Jul 17, 2020 at 12:39 PM Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> My impression was that the state of the registers you read would
>> be the same if you read them multiple times, at least until you
>> reboot and the firmware has a chance to change them.
>
>
> That's not always the case, for example for the SMI count.
> Another example is WPD, a driver (such as the intel-spi for instance) can change its value if it is unlocked.
> But many others don't change so it might be a good idea to add another function to the API to register constant values.

Ok, if the value can change, then I suppose you can pass a pointer to the
'struct class_attribute' or 'struct file_operations' with the appropriate
'show' callbacks, this should be easier than creating another callback
abstraction.

For values that can not change, passing the value should be easier.

       Arnd
