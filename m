Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B0FCC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 19:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07C332086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 19:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgHDTGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 15:06:53 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:46425 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbgHDTGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 15:06:52 -0400
Received: from mail-qt1-f180.google.com ([209.85.160.180]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1N2E9Y-1kkOUn0loM-013epL for <linux-kernel@vger.kernel.org>; Tue, 04 Aug
 2020 21:06:51 +0200
Received: by mail-qt1-f180.google.com with SMTP id d27so31792426qtg.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 12:06:51 -0700 (PDT)
X-Gm-Message-State: AOAM53198KT/ltHLslml8eqcPJSnIbJKJHLNUPMIH66b63d4GB32cL6i
        A+ryZUTzwcjt1IIT5CU85ZX9tjaYcu7MP+4qihk=
X-Google-Smtp-Source: ABdhPJw6CNFtZzp1Y4f2ymVMDAs5tsX39XjtcTFQ0oGQ/v8PSJdHj9DFeJUOOpF/S+U3b1KheF+OKZkTGqRkaEBRGQs=
X-Received: by 2002:aed:2946:: with SMTP id s64mr23446375qtd.204.1596568010056;
 Tue, 04 Aug 2020 12:06:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200804135817.5495-1-daniel.gutson@eclypsium.com>
 <CAK8P3a0_fJ0BfD5Qvxdo0s7CbjPWaGA8QTgYhbXR=omafOHH4Q@mail.gmail.com> <CAFmMkTHEm8k+5GZkVJbDZMEhMwpsqVKRb-hGskSpBstdLRuFyA@mail.gmail.com>
In-Reply-To: <CAFmMkTHEm8k+5GZkVJbDZMEhMwpsqVKRb-hGskSpBstdLRuFyA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 4 Aug 2020 21:06:34 +0200
X-Gmail-Original-Message-ID: <CAK8P3a27bTYyn3N+tX=i_6f4KrQkOmkUA1zUQfvCW7qw6smSkQ@mail.gmail.com>
Message-ID: <CAK8P3a27bTYyn3N+tX=i_6f4KrQkOmkUA1zUQfvCW7qw6smSkQ@mail.gmail.com>
Subject: Re: [PATCH] mtd: spi-nor: intel-spi: Do not try to make the SPI flash
 chip writable
To:     Daniel Gutson <daniel@eclypsium.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alex Bazhaniuk <alex@eclypsium.com>,
        Richard Hughes <hughsient@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:C00j320KpMz75P1cdu+bM//5fJ1FaGVFHmONrzYcDuX5zNQmVf/
 np452Fu7QVmbRIzGSynqOSiKpO5S2TS5gyVLvEoVxhdc3PXnrK1tnrC0oXSpmGDvgO5NEGf
 TZkMdLovGpsU0JkTleU0xEmVR3jQrc81udRLJe0vSL2s8PxvopT99wDyYBGQ1bT+rS8GCCC
 088hhQIW9+oSjWqWEzl3Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/tkyDmTlYIE=:H49a3ivIW5qMARTGdNbBYc
 7diuxAflCFJC9JhmGeFdb2pelc5RekaRMl2/3l16pwYbSSsTTRyjjX8qLVUkshmDg2g4gEthp
 S0s0b5KCMdxu33JwaKVsLkhEUqXbwWLGwpLpd1mnexiR7ALBOutcxDEgae/DybCvSg+B62iVr
 E9Bsnw5gU/FHn4y91cpieqS3UGl6Ob/krF9PRdJa9jsHavZWxUu23TeGjj3NoVjLnG7BTCyBM
 5QgcC+JqmNsxUFqfmWQZLHM5EJJWMCf8FkVlvJb9w+/KJBXAjNUqrmRCbjmlS3QuRWwicLwzT
 8RLNsZEKFttJQcdtXR0K2ouwTnhak87TDdSD1C4YnilMpoyPl/1koN5h/g5KJtXPCjTaRYaYL
 aD52MnkT12IddPnO+Sz64bSfryQsHnZaBbejTeb6KZBCVB3KfH7aqZLU5MbtKFs6NSGla5zXN
 D9ye28FZfH/q60fk4JN3OgOwUAe81XezsNkZOkOP6qESozFz1i9wciAbRLRmVlWFbRPk35l2H
 DPWzKFKIDGDi2ainefccBJit72WP2vbAbEd+a3y7kbJ0IeAvYnjRX9Fu1vAdyfVLnewKuzNNt
 cFR/LO0A63L0tBUo9enMh1/U/N8qjHXYDNfSHZcsIe9eNJm4Ny1k6lA4QiFSyb8gS/0hOPZWP
 f3i9mdD+KlQ4/CvL3MYVRW8CA5wtrnpzVmmx3wrJrt++/6yzbi7EInGA93uYY/mRYw4n9S1bQ
 AChKQ+QlIctjT8ztZqxt7KJzVpo463t6+dfIdfsBcR/V/ns7pAu0b5JKBlZq1MqjYlJwf1tZU
 E4AZF1krqOtKmEa9PeQRBEMSvUSEGVY6Bwtw8qHn/N7VwXPogtSxvfCwK8JG8RGWezACRbsrz
 YWgamOajMu4S+T3hl2edmFkB65LzxwUyetFNvCyRaLzGtDnSiC44BjwRJc2ehusjlUVedW3qu
 dKYYoVUyFp0vwRmcFRjrYgAO92CKeytmMhnXQBpsNb5Nixant/C1C
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 4, 2020 at 5:49 PM Daniel Gutson <daniel@eclypsium.com> wrote:
> On Tue, Aug 4, 2020 at 12:21 PM Arnd Bergmann <arnd@arndb.de> wrote:
>>
>> On Tue, Aug 4, 2020 at 3:58 PM Daniel Gutson
>> <daniel.gutson@eclypsium.com> wrote:
>> >
>> > Context, the intel-spi has a module argument that controls
>> > whether the driver attempts to turn the SPI flash chip writeable.
>> > The default value is FALSE (don't try to make it writeable).
>> > However, this flag applies only for a number of devices, coming from the
>> > platform driver, whereas the devices detected through the PCI driver
>> > (intel-spi-pci) are not subject to this check since the configuration
>> > takes place in intel-spi-pci which doesn't have an argument.
>>
>> This is still factually incorrect, as explained at least three times
>> now.
>>
>> Please either make the same change for both the Bay Trail
>> platform driver and the PCI driver, or explain why you want them to
>> be different rather than incorrectly claiming that you change them to
>> be the same.
>
>
> What about just saying
>
> "This patch removes the attempt by the intel-spi-pci driver to
> make the chip always writable."

Yes, that is much better, though it still sounds like it would at the
moment allow writing to the device from software without also
setting the module parameter. I would say something like

"Disallow overriding the write protection in the PCI driver
with a module parameter and instead honor the current
state of the write protection as set by the firmware."

(note also: imperative form in the patch description rather than
"this patch ...").

      Arnd
