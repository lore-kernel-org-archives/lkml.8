Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SHORT_URL,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E112BC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 03:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 965AA2053B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 03:25:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730136AbgIJDZE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 23:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729992AbgIJDXl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 23:23:41 -0400
X-Greylist: delayed 366 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Sep 2020 20:23:40 PDT
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E154CC061573;
        Wed,  9 Sep 2020 20:23:40 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: hector@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 44F91425DF;
        Thu, 10 Sep 2020 03:17:21 +0000 (UTC)
Date:   Thu, 10 Sep 2020 12:17:13 +0900
User-Agent: K-9 Mail for Android
In-Reply-To: <1599706954.10822.3.camel@suse.de>
References: <20200909193419.2006744-1-james.hilliard1@gmail.com> <1599706954.10822.3.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v2] usb: serial: Repair FTDI FT232R bricked eeprom
To:     Oliver Neukum <oneukum@suse.de>,
        James Hilliard <james.hilliard1@gmail.com>,
        linux-usb@vger.kernel.org
CC:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Russ Dill <Russ.Dill@gmail.com>
From:   "Hector Martin \"marcan\"" <hector@marcansoft.com>
Message-ID: <D2C1360E-65CC-410A-8B39-48F7340FEFCE@marcansoft.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On September 10, 2020 12:02:34 PM GMT+09:00, Oliver Neukum <oneukum@suse.de> wrote:
>Am Mittwoch, den 09.09.2020, 13:34 -0600 schrieb James Hilliard:
>> This patch detects and reverses the effects of the malicious FTDI
>> Windows driver version 2.12.00(FTDIgate).
>
>Hi,
>
>this raises questions.
>Should we do this unconditionally without asking?
>Does this belong into kernel space?

I agree; this is very cute, but does it really need to be an automatic Linux feature? Presumably someone looking to fix a bricked FTDI chip can just run my script, and those who just want to use those chips with Linux already can since the driver binds to the zero PID.

I am deeply amused by the idea of Linux automatically fixing problems caused by malicious Windows drivers, but thinking objectively, I'm not sure if that's the right thing to do.

>
>> +static int ftdi_repair_brick(struct usb_serial_port *port)
>> +{
>> +	struct ftdi_private *priv = usb_get_serial_port_data(port);
>> +	int orig_latency;
>> +	int rv;
>> +	u16 *eeprom_data;
>> +	u16 checksum;
>> +	int eeprom_size;
>> +	int result;
>> +
>> +	switch (priv->chip_type) {
>> +	case FT232RL:
>> +		eeprom_size = 0x40;
>> +		break;
>> +	default:
>> +		/* Unsupported for brick repair */
>> +		return 0;
>> +	}
>> +
>> +	/* Latency timer needs to be 0x77 to unlock EEPROM programming */
>> +	if (priv->latency != 0x77) {
>> +		orig_latency = priv->latency;
>> +		priv->latency = 0x77;
>> +		rv = write_latency_timer(port);
>> +		priv->latency = orig_latency;
>> +		if (rv < 0)
>> +			return -EIO;
>> +	}
>
>Do you really want to change this without returning to the original?
>
>	Regards
>		Oliver

-- 
Hector Martin "marcan" (hector@marcansoft.com)
Public key: https://mrcn.st/pub
