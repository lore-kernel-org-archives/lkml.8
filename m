Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SHORT_URL,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076E8C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 03:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C84C221D40
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 03:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbgIJDrK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 23:47:10 -0400
Received: from marcansoft.com ([212.63.210.85]:38072 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbgIJDrH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 23:47:07 -0400
X-Greylist: delayed 1779 seconds by postgrey-1.27 at vger.kernel.org; Wed, 09 Sep 2020 23:47:05 EDT
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 4C1AA425DF;
        Thu, 10 Sep 2020 03:47:01 +0000 (UTC)
Date:   Thu, 10 Sep 2020 12:46:57 +0900
User-Agent: K-9 Mail for Android
In-Reply-To: <CADvTj4oznyY=sfbmtmdcYMgkYriV_Ujk=+0Fz--XumNa8ZvD=A@mail.gmail.com>
References: <20200909193419.2006744-1-james.hilliard1@gmail.com> <1599706954.10822.3.camel@suse.de> <CADvTj4oznyY=sfbmtmdcYMgkYriV_Ujk=+0Fz--XumNa8ZvD=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v2] usb: serial: Repair FTDI FT232R bricked eeprom
To:     James Hilliard <james.hilliard1@gmail.com>,
        Oliver Neukum <oneukum@suse.de>
CC:     linux-usb@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russ Dill <Russ.Dill@gmail.com>
From:   "Hector Martin \"marcan\"" <hector@marcansoft.com>
Message-ID: <36F0CEB4-DE2E-41DA-9569-4706B00FCF7D@marcansoft.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On September 10, 2020 12:40:59 PM GMT+09:00, James Hilliard <james.hilliard1@gmail.com> wrote:
>On Wed, Sep 9, 2020 at 9:02 PM Oliver Neukum <oneukum@suse.de> wrote:
>>
>> Am Mittwoch, den 09.09.2020, 13:34 -0600 schrieb James Hilliard:
>> > This patch detects and reverses the effects of the malicious FTDI
>> > Windows driver version 2.12.00(FTDIgate).
>>
>> Hi,
>>
>> this raises questions.
>> Should we do this unconditionally without asking?
>Well I think since we can reliably detect devices that have been
>bricked by the malicious windows driver it's fine. I was careful to
>ensure that this will bail out and not try to change anything unless
>all
>conditions match this specific brick attack.
>> Does this belong into kernel space?
>This seemed to be by far the simplest option for embedded systems
>that need to automatically detect and repair the bricked eeproms.
>
>People seem to have plugged a bunch of counterfeit FTDI Arduino's
>that normally attach to an embedded Linux host into windows for
>some reason for a kiosk platform of mine which messed up the
>userspace detection/mappings. This seemed like the best way to
>avoid this being a support issue requiring manual unbricking
>prochedures.

If you need to update the kernel on this platform anyway to use this feature, why not just introduce a userspace script to fix the bricked units instead?

Needing this autofixed seems like somewhat of a niche use case better served by a script on platforms where it might be a problem, rather than upstream kernel code.

>>
>> > +static int ftdi_repair_brick(struct usb_serial_port *port)
>> > +{
>> > +     struct ftdi_private *priv = usb_get_serial_port_data(port);
>> > +     int orig_latency;
>> > +     int rv;
>> > +     u16 *eeprom_data;
>> > +     u16 checksum;
>> > +     int eeprom_size;
>> > +     int result;
>> > +
>> > +     switch (priv->chip_type) {
>> > +     case FT232RL:
>> > +             eeprom_size = 0x40;
>> > +             break;
>> > +     default:
>> > +             /* Unsupported for brick repair */
>> > +             return 0;
>> > +     }
>> > +
>> > +     /* Latency timer needs to be 0x77 to unlock EEPROM
>programming */
>> > +     if (priv->latency != 0x77) {
>> > +             orig_latency = priv->latency;
>> > +             priv->latency = 0x77;
>> > +             rv = write_latency_timer(port);
>> > +             priv->latency = orig_latency;
>> > +             if (rv < 0)
>> > +                     return -EIO;
>> > +     }
>>
>> Do you really want to change this without returning to the original?
>> @@ -2255,6 +2364,12 @@ static int ftdi_sio_port_probe(struct
>usb_serial_port *port)
>>         ftdi_set_max_packet_size(port);
>>         if (read_latency_timer(port) < 0)
>>                 priv->latency = 16;
>> +       vendor_id =
>le16_to_cpu(port->serial->dev->descriptor.idVendor);
>> +       product_id =
>le16_to_cpu(port->serial->dev->descriptor.idProduct);
>> +       if (vendor_id == FTDI_VID &&
>> +               product_id == FTDI_BRICK_PID &&
>> +               priv->chip_type == FT232RL)
>> +               ftdi_repair_brick(port);
>>         write_latency_timer(port);
>It should get restored here.
>>         create_sysfs_attrs(port);
>>
>>
>>         Regards
>>                 Oliver
>>

-- 
Hector Martin "marcan" (hector@marcansoft.com)
Public key: https://mrcn.st/pub
