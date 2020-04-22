Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DDAC55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 15:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9619620774
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 15:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pw4+osXk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbgDVPWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 11:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgDVPWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 11:22:33 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73121C03C1A9;
        Wed, 22 Apr 2020 08:22:32 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id q204so600147ooq.1;
        Wed, 22 Apr 2020 08:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DhRwkh7hDxePI3EThl93gXt81KT2U83BYwmBpOJ1yA0=;
        b=pw4+osXk6sAcBWZ4c2nFxicMVPIgxjukpj3OZu87w1PWtEC0+sia7xRN6rXVXUp8nJ
         HiRiqQUPmNhqtBkIkkzlPAchUYtqkaZyYTjnXrhUx4ds9nR2ySdqolSXMUdfCjVSI9sS
         pUjcHg25BWKBGl3SglgFrsjW9vh5H/XaYwLXyJqkj3L10A8EdtWxWrRdicsow8p/7yq3
         Y39/UCO+ZAgN6mxsTRD9U7V5+4B9kVo9juAMrqiEaP6SDGf4+KamNvLqpeVRUjEFtd73
         SYiqwCw43DVZMsV4sXyi31Ikx/5usAQu8pthl6kCVr4j0CC+j52uBrdetW99xRsNdzW/
         /kuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DhRwkh7hDxePI3EThl93gXt81KT2U83BYwmBpOJ1yA0=;
        b=Y3ScZaU1WGibxVxK4lZ3BteiD/+Uurb41xNjkIWXGAEkEYjqpJx4uBFe47Ojoe9nfn
         DSgWrJRUHDMMvSzLUoE8swBbsxTLm4Z1iYQ6spgYIlRPcXlTf6UIG1PBz8mDQhG/3dr9
         NGGxlkVh1sEvKGTg9U4iCgtoAz46QHX3/Mw5CxH/YaXmR59EPHwnbgqhBpKEoDYF4tGC
         RvepGz99dqWycqqzGc3eoRlC8HtxUqA4rWeVz+CFrVgSgu1LCRIzs6CKO//k0OOaC26w
         QFx16ZK0lZqdqfSfgVUy/nPGkK4mSLN4Kzt5WfZDzJEv7v+cLDoXT57egff14LdrrAAC
         XTRA==
X-Gm-Message-State: AGi0PuYLEzQ6dVWp7scwRvNbxdaADEqVsmvOsRyPOszBUMh/du2WvcAN
        K5eR7t9VYdNfiNWWIcLSGNE1PA2IVwE=
X-Google-Smtp-Source: APiQypLn+fX7u0KM+9C2/1Jbw6Ib6SbmWHHoTHgqu3zVi/Kds1N8edIrwhapY439HPPIgCzoHQYy6g==
X-Received: by 2002:a4a:a286:: with SMTP id h6mr15759338ool.38.1587568951701;
        Wed, 22 Apr 2020 08:22:31 -0700 (PDT)
Received: from raspberrypi (99-189-78-97.lightspeed.austtx.sbcglobal.net. [99.189.78.97])
        by smtp.gmail.com with ESMTPSA id l19sm1587102otp.16.2020.04.22.08.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 08:22:30 -0700 (PDT)
Date:   Wed, 22 Apr 2020 10:22:28 -0500
From:   Grant Peltier <grantpeltier93@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        adam.vaughn.xh@renesas.com, grant.peltier.jg@renesas.com
Subject: Re: [PATCH 1/2] hwmon: (pmbus/isl68137) add debugfs config and black
 box endpoints
Message-ID: <20200422152228.GA32630@raspberrypi>
References: <cover.1587408025.git.grantpeltier93@gmail.com>
 <203a7cd37dd95a0127cc06de14986721ab621e93.1587408025.git.grantpeltier93@gmail.com>
 <20200421185851.GA95204@roeck-us.net>
 <20200421214917.GA28170@raspberrypi>
 <20200422020404.GA126375@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422020404.GA126375@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 07:04:04PM -0700, Guenter Roeck wrote:
> On Tue, Apr 21, 2020 at 04:49:17PM -0500, Grant Peltier wrote:
> > On Tue, Apr 21, 2020 at 11:58:51AM -0700, Guenter Roeck wrote:
> > > Normally this is emulated for such controllers. I don't recall seeing
> > > such a need before. The code below duplicates similar code in
> > > i2c_smbus_xfer_emulated(), which is much more sophisticated.
> > > Are you sure this is needed ? Can you point me to an affected
> > > controller ?
> > > 
> > > > +static s32 raa_smbus_read40(const struct i2c_client *client, u8 command,
> > > > +			    unsigned char *data)
> > > > +{
> > > > +	int status;
> > > > +	unsigned char msgbuf[1];
> > > > +	struct i2c_msg msg[2] = {
> > > > +		{
> > > > +			.addr = client->addr,
> > > > +			.flags = client->flags,
> > > > +			.len = 1,
> > > > +			.buf = msgbuf,
> > > > +		},
> > > > +		{
> > > > +			.addr = client->addr,
> > > > +			.flags = client->flags | I2C_M_RD,
> > > > +			.len = 5,
> > > > +			.buf = data,
> > > > +		},
> > > > +	};
> > > > +
> > > > +	msgbuf[0] = command;
> > > > +	status = i2c_transfer(client->adapter, msg, 2);
> > > > +	if (status != 2)
> > > > +		return status;
> > > 
> > > i2c_transfer() can return 1 if only one of the two messages was sent.
> > > 
> > > > +	return 0;
> > > > +}
> > I have been using BCM2835 for most of my testing. I originally tried using
> > i2c_smbus_read_block_data() but that was returning errors. However, from your
> > email, I went back and tried i2c_smbus_read_i2c_block_data() and that appears
> > to be working so I will switch to that instead.
> > 
 
> This is odd, since the function should do a SMBus block read. Did you pass a
> buffer that was too small, by any chance ?

I tried with a variety of buffer sizes from 4 (data size) to 32 (max block size)
and it always returned an error. I believe that i2c_smbus_read_block_data()
attempts to do a legitimate SMBus block read which depends on the controller
interpretting and reading the correct number of bytes as signaled from the
client. This is in line with the docstring for the function and the fact that
the BCM2835 responds with false (0) from i2c_check_functionality() for
I2C_FUNC_SMBUS_READ_BLOCK_DATA. On the other hand,
i2c_smbus_read_i2c_block_data() appears to do a fixed length read similar to
the function that I wrote above.

Thanks,
Grant
 
