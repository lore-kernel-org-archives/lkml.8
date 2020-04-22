Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B803CC55181
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 02:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 940EA20724
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 02:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVhm6vBU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgDVCEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 22:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgDVCEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 22:04:06 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D5BC0610D6;
        Tue, 21 Apr 2020 19:04:06 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id w20so294648pll.4;
        Tue, 21 Apr 2020 19:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ToKzHi88KUDCwxX2NbfwDgfuG5Ihi+Tt5yodZXzkNFY=;
        b=XVhm6vBU+VWXvVfdng0/kTGsT3JWJrh5z+CNgLTgSJDOq3Jw3/NWsiP9ZiNvMBNpyB
         UVTKb5Op/4TkgwME2B0KA4bYV+JmYEV3/DxB8BzOrNHX8eF2eNBd4Nq/s3pmvaoAYq5t
         pmz6nO0C+Pl+01573VSuP1HpWFJG72ZReLsM5kgzWHiYP8TI0eoVRHlOEdxXUlF/6kC3
         /dwdoJWnPtYxd4aCxhykLyanGZMy/H/ubusp5DHRQKmWUnvkiGFLmpKMDDieG1EKoSW0
         EVTtyqGfJhg79UNZUHFK7e/pbGXx//yaM7phTKz8SDfky9mfQTWSAaalSZqiiw9UaW2U
         C0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ToKzHi88KUDCwxX2NbfwDgfuG5Ihi+Tt5yodZXzkNFY=;
        b=c51fGe4TpyBMMpIU5nBv/Ex+5bd0Kzc98cTRpOuPVW40GNPy/maRcyLS2l2rZXBpix
         aNHAS39JkCX9YOWaS4Ua9vM41NaxeZjFSpVKLrjpzerVj/v2akgzpVfKJ/dGLh8iNswC
         XvLV9A6v6S0hyJvW9Pm3t9nwvco5NzDNMQ/0qkJXPPBH5B54T6ElnRdkocbbtmhyUUyp
         /k/EPB0KKTUPCa4cV3NOLfPfLwdb+974tYdaWwKVc3aK7/JofG0XS2YvvnotLwtF6ynf
         V8wxGqhdcCSgZszUTLahrwgHQ1SjkZOsVUpQDbSgtStL73Ex7fAN9UavX9SBkjMZ+OOD
         QH/g==
X-Gm-Message-State: AGi0PuYso7o+j9Uiah0mZA+dRuAl2Nwdf822xikWGjCkKuSQKP9aRaFb
        zkVCwn6O82gGmdP3tORVhMY=
X-Google-Smtp-Source: APiQypJXgydNfvsjf8hhXuV566aJN1m1ixhOB1Bi0Ykz2yql7YMQ2LOopzTvyIJWC/wy2J1KR+rYvA==
X-Received: by 2002:a17:902:8688:: with SMTP id g8mr25431832plo.268.1587521046418;
        Tue, 21 Apr 2020 19:04:06 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p68sm3686505pfb.89.2020.04.21.19.04.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 21 Apr 2020 19:04:05 -0700 (PDT)
Date:   Tue, 21 Apr 2020 19:04:04 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Grant Peltier <grantpeltier93@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        adam.vaughn.xh@renesas.com, grant.peltier.jg@renesas.com
Subject: Re: [PATCH 1/2] hwmon: (pmbus/isl68137) add debugfs config and black
 box endpoints
Message-ID: <20200422020404.GA126375@roeck-us.net>
References: <cover.1587408025.git.grantpeltier93@gmail.com>
 <203a7cd37dd95a0127cc06de14986721ab621e93.1587408025.git.grantpeltier93@gmail.com>
 <20200421185851.GA95204@roeck-us.net>
 <20200421214917.GA28170@raspberrypi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421214917.GA28170@raspberrypi>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 04:49:17PM -0500, Grant Peltier wrote:
> On Tue, Apr 21, 2020 at 11:58:51AM -0700, Guenter Roeck wrote:
> > Normally this is emulated for such controllers. I don't recall seeing
> > such a need before. The code below duplicates similar code in
> > i2c_smbus_xfer_emulated(), which is much more sophisticated.
> > Are you sure this is needed ? Can you point me to an affected
> > controller ?
> > 
> > > +static s32 raa_smbus_read40(const struct i2c_client *client, u8 command,
> > > +			    unsigned char *data)
> > > +{
> > > +	int status;
> > > +	unsigned char msgbuf[1];
> > > +	struct i2c_msg msg[2] = {
> > > +		{
> > > +			.addr = client->addr,
> > > +			.flags = client->flags,
> > > +			.len = 1,
> > > +			.buf = msgbuf,
> > > +		},
> > > +		{
> > > +			.addr = client->addr,
> > > +			.flags = client->flags | I2C_M_RD,
> > > +			.len = 5,
> > > +			.buf = data,
> > > +		},
> > > +	};
> > > +
> > > +	msgbuf[0] = command;
> > > +	status = i2c_transfer(client->adapter, msg, 2);
> > > +	if (status != 2)
> > > +		return status;
> > 
> > i2c_transfer() can return 1 if only one of the two messages was sent.
> > 
> > > +	return 0;
> > > +}
> I have been using BCM2835 for most of my testing. I originally tried using
> i2c_smbus_read_block_data() but that was returning errors. However, from your
> email, I went back and tried i2c_smbus_read_i2c_block_data() and that appears
> to be working so I will switch to that instead.
> 
This is odd, since the function should do a SMBus block read. Did you pass a
buffer that was too small, by any chance ?

> > > +
> > > +/**
> > > + * Helper function required since linux SMBus implementation does not currently
> > > + * (v5.6) support the SMBus 3.0 "Read 32" protocol
> > > + */
> > > +static s32 raa_dmpvr2_smbus_read32(const struct i2c_client *client, u8 command,
> > > +				   unsigned char *data)
> > > +{
> > > +	int status;
> > > +	unsigned char msgbuf[1];
> > > +	struct i2c_msg msg[2] = {
> > > +		{
> > > +			.addr = client->addr,
> > > +			.flags = client->flags,
> > > +			.len = 1,
> > > +			.buf = msgbuf,
> > > +		},
> > > +		{
> > > +			.addr = client->addr,
> > > +			.flags = client->flags | I2C_M_RD,
> > > +			.len = 4,
> > > +			.buf = data,
> > > +		},
> > > +	};
> > > +
> > > +	msgbuf[0] = command;
> > > +	status = i2c_transfer(client->adapter, msg, 2);
> > > +	if (status != 2)
> > > +		return status;
> > > +	return 0;
> > > +}
> > 
> > Maybe it would be worthwhile to consider implementing it ?
> > 
> I could add these functions to i2c-core-smbus instead if that is desired.
> However, I am unsure if it would be proper to only partially update the SMBus
> implementation to match the 3.0 spec. Is there perhaps a better forum to
> discuss adding all of the 3.0 changes?
> 
Never mind, just keep it local. I don't like it too much, but getting patches
accepted into the i2c core might take several releases, and it would be unfair
to impose that on you.

Guenter
