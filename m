Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SHORT_URL,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B2FC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:10:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ACDC204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730233AbgIJIKd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 04:10:33 -0400
Received: from marcansoft.com ([212.63.210.85]:49254 "EHLO mail.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbgIJIKa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:10:30 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id A246B3FA50;
        Thu, 10 Sep 2020 08:10:24 +0000 (UTC)
Subject: Re: [PATCH v2] usb: serial: Repair FTDI FT232R bricked eeprom
To:     James Hilliard <james.hilliard1@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, Johan Hovold <johan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russ Dill <Russ.Dill@gmail.com>
References: <20200909193419.2006744-1-james.hilliard1@gmail.com>
 <20200910054933.GA525707@kroah.com>
 <CADvTj4pZKeic1-Yb_baJkbfn8UWXczuoSRXqhH_1qHB=NV4FjA@mail.gmail.com>
From:   Hector Martin <hector@marcansoft.com>
Message-ID: <ca3dfd1e-b595-18aa-3442-30363b2e2797@marcansoft.com>
Date:   Thu, 10 Sep 2020 17:10:20 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <CADvTj4pZKeic1-Yb_baJkbfn8UWXczuoSRXqhH_1qHB=NV4FjA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/09/2020 15.45, James Hilliard wrote:
>>> +static int ftdi_write_eeprom(struct usb_serial_port *port, u8 addr, u16 data)
>>> +{
>>> +     struct usb_device *udev = port->serial->dev;
>>> +     int rv;
>>> +
>>> +     rv = usb_control_msg(udev,
>>> +                          usb_sndctrlpipe(udev, 0),
>>> +                          FTDI_SIO_WRITE_EEPROM_REQUEST,
>>> +                          FTDI_SIO_WRITE_EEPROM_REQUEST_TYPE,
>>> +                          data, addr,
>>> +                          NULL, 0, WDR_TIMEOUT);
>>> +     if (rv < 0)
>>> +             dev_err(&port->dev, "Unable to write EEPROM: %i\n", rv);
>>
>> You don't check for a "short write"?
>  From my understanding the hardware only accepts 2 byte writes, and
> the non-counterfeits actually only commit writes on odd addresses
> while they buffer writes on even(this difference is what FTDI's windows
> driver exploits). So I guess this should be "if (rv < 2)"?

It's not "data" anyway, the data word gets sent in control message 
headers. Unless I'm mistaken rv == 0 on success, so the code should be 
correct as-is.

>>
>>> +     return rv;
>>> +}
>>> +
>>> +static u16 ftdi_checksum(u16 *data, int n)
>>> +{
>>> +     u16 checksum;
>>> +     int i;
>>> +
>>> +     checksum = 0xaaaa;
>>> +     for (i = 0; i < n - 1; i++) {
>>> +             checksum ^= be16_to_cpu(data[i]);
>>> +             checksum = (checksum << 1) | (checksum >> 15);
>>> +     }
>>
>> What type of function is this, don't we have all of the needed checksum
>> functions in the kernel already?
> Some custom crc16 style checksum I guess, I'm not seeing anything
> in the kernel that's the same, although I might not be looking in the
> right places.

This isn't a CRC, it's some random xor all the words thing with a 
somewhat pointless rotation in the way. I'd be surprised if anything 
elses uses this particular function. Pretty sure other drivers are 
littered with stuff like this too, hardware manufacturers love to 
reinvent checksums.

-- 
Hector Martin (hector@marcansoft.com)
Public Key: https://mrcn.st/pub
