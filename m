Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F9EC83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46F912083B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbDsAEhG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgD2OLu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 10:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726861AbgD2OLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 10:11:49 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B16C03C1AD;
        Wed, 29 Apr 2020 07:11:49 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id ms17so804429pjb.0;
        Wed, 29 Apr 2020 07:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fi8nr3NsAL0lJQ0AmANnBpm6h197A9dlmy0t2HE2WsU=;
        b=jbDsAEhGDmRRTvAkM4OiGbWTUBTaq6MhMBpfmQBwLLOep2qxJCDWLMZ670C22pxKhV
         63NeNutFiDK8iaRbUJtaR6k9J7jD1jmwus0unWDFVhrkx9XUeEy+rCrh2sAYjDudpegq
         nIwgAoMevcJPyjpvPsL/2X4jNeWN2KwbMAGiWx80tFnGWAPFl1nMA7gm5wh8LEUoDMhJ
         NTd5vXfd/O2zuDf1MQBb+uyGrPLoYsHtInTN9FkcEDocIIxQNUqFfJZmldu4uZcDPJIj
         qLxAsWH0KjheXqQXyCH2PssGea6FVb8jOJAAjPSyNZFfxlilv9zTx6Y4dTzfZN2rr/71
         DcXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=fi8nr3NsAL0lJQ0AmANnBpm6h197A9dlmy0t2HE2WsU=;
        b=d8KlqWAnD2/HluecXiTwwDsec9xX501NkyQmQczjIWhy8Us3bXNPz4rZzMXSj2pwP2
         H25cEzgNkEEuuk5nAjiTugfYpUkodkoRaN5MCoBD0IZFrbkSaQvSbaFnuTs0lCWAVIIt
         daNAXlqOd+uGVWqljVFOf1KREBk+SqIS5ZhBhlxk0diNBbrncTTYnR7aPHwJzfN4GoxG
         scmk9eodxXmpEkWt9xo0BuDImmITQRgW/QvBrEdRJJZwRml5UNVpoz7W6oj3dCK1gkbU
         9V/g5WBuZjUYM61wQ/glkqUc5rkxIM9y2uDlSJ3c3VeqeemZ9sH//oqF8RW4V8Va2f2F
         DlaA==
X-Gm-Message-State: AGi0PuY4Am5+J+4F6xo/0xyJHMPjueKHCDHTm9ouBN9qdTAN1ZZKFD9M
        RarnFdS+yURUWjg19OS2HXA=
X-Google-Smtp-Source: APiQypKjfaDfu68AEIKmhlf9dOmJLBj2BgOzoMAHZ9nGIcvHTwFFTDm9wqrGZ2ULJAmN6c1QeLmWhg==
X-Received: by 2002:a17:90b:14c1:: with SMTP id jz1mr3647909pjb.112.1588169509354;
        Wed, 29 Apr 2020 07:11:49 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p66sm1225332pfb.65.2020.04.29.07.11.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Apr 2020 07:11:48 -0700 (PDT)
Date:   Wed, 29 Apr 2020 07:11:47 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Grant Peltier <grantpeltier93@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        adam.vaughn.xh@renesas.com, grant.peltier.jg@renesas.com
Subject: Re: [PATCH v2 1/2] hwmon: (pmbus/isl68137) add debugfs config and
 black box endpoints
Message-ID: <20200429141147.GD8469@roeck-us.net>
References: <cover.1587572415.git.grantpeltier93@gmail.com>
 <acbdc26389b6ab5f5f4536de7332b03c45a95f00.1587572415.git.grantpeltier93@gmail.com>
 <20200425174318.GA40266@roeck-us.net>
 <20200427170729.GA13285@raspberrypi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427170729.GA13285@raspberrypi>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 12:07:29PM -0500, Grant Peltier wrote:
> On Sat, Apr 25, 2020 at 10:43:18AM -0700, Guenter Roeck wrote:
> > On Wed, Apr 22, 2020 at 12:27:14PM -0500, Grant Peltier wrote:
> > > Add debugfs endpoints to support features of 2nd generation Renesas
> > > digital multiphase voltage regulators that are not compatible with
> > > sysfs.
> > > 
> > > The read_black_box endpoint allows users to read the contents of a
> > > RAM segment used to record fault conditions within Gen 2 devices.
> > > 
> > > The write_config endpoint allows users to write configuration hex
> > > files to Gen 2 devices which modify how they operate.
> > > 
> > > Signed-off-by: Grant Peltier <grantpeltier93@gmail.com>
> > 
> > Comments inline.
> > 
> > However, the more I look into this, the more concerns I have.
> > I think we should limit debugfs functions, if they are needed,
> > to reporting detailed device status. Can you consider handling
> > configuration from userspace using i2cget / i2cset commands ?
> 
> The reason we decided to try to implement configuration writes within the
> driver is that we found a userspace implementation to be unstable. The
> process requires anywhere from approximately 650 to a few thousand 32-bit
> writes (dependent on number of NVM slots contained in the file). The entire
> write process therefore takes a non-trivial amount of CPU time to complete
> and the userspace process was often interrupted which would cause for it
> to fail. Writing the configuration directly from the driver has been less
> error prone.
> 
The downside is that anyone can easily mess with the chip. That does make
me quite concerned - I have seen many PMBus chips and even boards blown up
if misconfigured. It is bad enough that this can be done in the first place,
but I don't want to make it even easier by providing the means to do so via
debugfs files.

Did you try with an application sending ioctls directly ? That should
be much less error prone than i2cset/i2cget. Also, a userspace process
like this should have appropriate priorities (ie run as realtime process)
to avoid being preempted.

Thanks,
Guenter

> > > +	res = i2c_smbus_read_i2c_block_data(ctrl->client, PMBUS_IC_DEVICE_REV,
> > > +					    5, dev_rev);
> > 
> > It still puzzles me, quite frankly, why i2c_smbus_read_block_data()
> > would not work here.
> >
> 
> i2c_smbus_read_block_data() requires the underlying driver/controller to handle
> interpretting the initial length byte read from the client device and then
> continuing to read that number of bytes. Not all controllers (e.g. BCM2835)
> support this. On the other hand, i2c_smbus_read_i2c_block_data() just does a
> fixed-length read based on the given length parameter.
> 
> > > +static int raa_dmpvr2_cfg_write_result(struct raa_dmpvr2_ctrl *ctrl,
> > > +				       struct raa_dmpvr2_cfg *cfg)
> > > +{
> > > +	u8 data[4] = {0};
> > > +	u8 data1[4];
> > > +	u8 *dptr;
> > > +	unsigned long start;
> > > +	int i, j, status;
> > > +
> > > +	// Check programmer status
> > > +	start = jiffies;
> > > +	i2c_smbus_write_word_data(ctrl->client, RAA_DMPVR2_DMA_ADDR,
> > > +				  RAA_DMPVR2_PRGM_STATUS_ADDR);
> > > +	while (data[0] == 0 && !time_after(jiffies, start + HZ + HZ)) {
> > > +		raa_dmpvr2_smbus_read32(ctrl->client, RAA_DMPVR2_DMA_FIX,
> > > +					data);
> > > +	}
> > > +	if (data[0] != 1)
> > > +		return -ETIME;
> > 
> > Are you sure ? Normally I would expect ETIMEDOUT.
>  
> My understanding is that ETIME is meant for timer expiration whereas ETIMEDOUT
> is meant for connection timeout errors. Is that correct? In this case, we are
> not really waiting on the device to respond but instead are constantly polling
> until the device responds with the desired value. However, I can understand an
> argument for ETIMEDOUT here and can swtich to that if you think it is more
> appropriate.
> 
> 
> Thank you for your other notes. I will refactor as requested.
> 
> Grant
