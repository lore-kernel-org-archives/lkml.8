Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1274EC55186
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 21:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3C5C206D9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 21:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U8SD7483"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbgDUVtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 17:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgDUVtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 17:49:23 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0C0C0610D5;
        Tue, 21 Apr 2020 14:49:21 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id j26so383337ots.0;
        Tue, 21 Apr 2020 14:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2yzyRCRM1JTzGVNdEOj/hvqYfw/tAgv8E0JZ5mXdHgU=;
        b=U8SD7483h8M7WoucT/ZyR05SFeL89407PaSNinyNDuXq1J4Xkkl8gxgvTWcN/BoVsn
         psfRsAQmoy+JCRIrqX39ef7GaTIzKSTemyfkNbIjTJG2m2llqbL07cDnhJlKQF2i258G
         HDuE8EGsvjn4QT5k6lXKY1Prg6CxUfPUc75f3PlY+MwqVwowV+QyCkiB4XxbRRnZ06lc
         C1ha6CpYk3qryaHDBQDBVxcxSHcKTcws+wqMqHSkV5zJXkJRqHsEOrWU0G7WiE980pwu
         NJxyThDRiz8DGl1PhBYDgRzPc5+FI8WoglvfwX/c+R4GIHjbiALhFlJydi4aoO1KcUHe
         kGEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2yzyRCRM1JTzGVNdEOj/hvqYfw/tAgv8E0JZ5mXdHgU=;
        b=Au+A/RqL7xWzKn1TW6pWa4uy47c/QDVpEYTJziu+wMnz/3OcqVmRhEHgU1qoi3txrn
         zMHBnfNsrhYO7HJrLmJm7FhjR696em7jbv+Sd70RHq0FTSdvvsHkEdKgNssQodtl996p
         BqasJb929MZMJMCOREA4j8vKYc5FhyhCLVfPMCBcPJPaDbirROlZo/3eIP5sBfcQCTzg
         TFNk3a5j8V2MgcE7OrTCaSrFjR9uZJiW+MJuGpzrxhVIA0iMAZTjQucjNRNWwYgvMwzh
         A6vYI1UFgc76+AVHYuYk/Tj1Y8OI5ewuX5yNoN2DrBEux7H5JsxrzdJVHycf2oQJFf3T
         zcgw==
X-Gm-Message-State: AGi0Pua2gDuRhV010Zu5xQc6aDxYOwyrA8IWZqHykUa7TQ9UoPBSJ/xD
        GBPpptiyMWmgoAlu+dLzhy+bZmAfTFE=
X-Google-Smtp-Source: APiQypKy8/UiL6RNh7/9eaRraWDNRRIYsroIRwt7AkPlx6oCBmkllPFEukh+wV+EWkk8UujUNZWddw==
X-Received: by 2002:a9d:19e8:: with SMTP id k95mr14761361otk.132.1587505760915;
        Tue, 21 Apr 2020 14:49:20 -0700 (PDT)
Received: from raspberrypi (99-189-78-97.lightspeed.austtx.sbcglobal.net. [99.189.78.97])
        by smtp.gmail.com with ESMTPSA id e92sm1045115otb.61.2020.04.21.14.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 14:49:20 -0700 (PDT)
Date:   Tue, 21 Apr 2020 16:49:17 -0500
From:   Grant Peltier <grantpeltier93@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        adam.vaughn.xh@renesas.com, grant.peltier.jg@renesas.com
Subject: Re: [PATCH 1/2] hwmon: (pmbus/isl68137) add debugfs config and black
 box endpoints
Message-ID: <20200421214917.GA28170@raspberrypi>
References: <cover.1587408025.git.grantpeltier93@gmail.com>
 <203a7cd37dd95a0127cc06de14986721ab621e93.1587408025.git.grantpeltier93@gmail.com>
 <20200421185851.GA95204@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421185851.GA95204@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 11:58:51AM -0700, Guenter Roeck wrote:
> Normally this is emulated for such controllers. I don't recall seeing
> such a need before. The code below duplicates similar code in
> i2c_smbus_xfer_emulated(), which is much more sophisticated.
> Are you sure this is needed ? Can you point me to an affected
> controller ?
> 
> > +static s32 raa_smbus_read40(const struct i2c_client *client, u8 command,
> > +			    unsigned char *data)
> > +{
> > +	int status;
> > +	unsigned char msgbuf[1];
> > +	struct i2c_msg msg[2] = {
> > +		{
> > +			.addr = client->addr,
> > +			.flags = client->flags,
> > +			.len = 1,
> > +			.buf = msgbuf,
> > +		},
> > +		{
> > +			.addr = client->addr,
> > +			.flags = client->flags | I2C_M_RD,
> > +			.len = 5,
> > +			.buf = data,
> > +		},
> > +	};
> > +
> > +	msgbuf[0] = command;
> > +	status = i2c_transfer(client->adapter, msg, 2);
> > +	if (status != 2)
> > +		return status;
> 
> i2c_transfer() can return 1 if only one of the two messages was sent.
> 
> > +	return 0;
> > +}
I have been using BCM2835 for most of my testing. I originally tried using
i2c_smbus_read_block_data() but that was returning errors. However, from your
email, I went back and tried i2c_smbus_read_i2c_block_data() and that appears
to be working so I will switch to that instead.

> > +
> > +/**
> > + * Helper function required since linux SMBus implementation does not currently
> > + * (v5.6) support the SMBus 3.0 "Read 32" protocol
> > + */
> > +static s32 raa_dmpvr2_smbus_read32(const struct i2c_client *client, u8 command,
> > +				   unsigned char *data)
> > +{
> > +	int status;
> > +	unsigned char msgbuf[1];
> > +	struct i2c_msg msg[2] = {
> > +		{
> > +			.addr = client->addr,
> > +			.flags = client->flags,
> > +			.len = 1,
> > +			.buf = msgbuf,
> > +		},
> > +		{
> > +			.addr = client->addr,
> > +			.flags = client->flags | I2C_M_RD,
> > +			.len = 4,
> > +			.buf = data,
> > +		},
> > +	};
> > +
> > +	msgbuf[0] = command;
> > +	status = i2c_transfer(client->adapter, msg, 2);
> > +	if (status != 2)
> > +		return status;
> > +	return 0;
> > +}
> 
> Maybe it would be worthwhile to consider implementing it ?
> 
I could add these functions to i2c-core-smbus instead if that is desired.
However, I am unsure if it would be proper to only partially update the SMBus
implementation to match the 3.0 spec. Is there perhaps a better forum to
discuss adding all of the 3.0 changes?

