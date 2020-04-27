Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DC2C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 17:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3F3620738
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 17:07:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5ajrQCB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgD0RHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 13:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgD0RHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 13:07:32 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD0EC0610D5;
        Mon, 27 Apr 2020 10:07:32 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id z25so27413042otq.13;
        Mon, 27 Apr 2020 10:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B3eBYK/kzeNRP96M+6ouxtzsIv+mQZ4EB6uahgWm770=;
        b=R5ajrQCBims2YTx0ZNjnD+FPfVFx8QMDUmxWy6zKaMJHum+eljaVeHP6D+Mn/4UYh5
         vqTn+RHIi1fzXw4NtFNyvgMyEMLN5XkgfMucjBldIRRFTZ+xCXdPzVtdItfcC1kOnZHG
         UHI5+IU9JVPdUgmjnUk//hGM0MMhJvYvDCd7GxjoFvpIaPgMUKqYKTkZqQr/XvqxtM4T
         Jmhd/y5/ugi2vLRQPxSMJyKnYd+Buy5ZW9/jPvs3bH6hBFz6onCC5aZW4JCQnOAsdQFj
         Bbe4moN9SSkCC/bIC6DaJTl/bgW1v7JHD8EpJYCQGjBharoTc4a/6V4XaPBc+TZ8mwfR
         gE5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B3eBYK/kzeNRP96M+6ouxtzsIv+mQZ4EB6uahgWm770=;
        b=KGm93Ko7EsIgezfXFFb5yktfUiZzP2PSL0W40JtH+0Aa430YFJS0hnOIJtaiVIh3U2
         3o5j+BD/C9/lYQHTQyybEa17JF/FG3USj47VBrc9LXYBHhHSU5PGOPVdx8qVZnm9y3Q8
         50+ica32dqbGEfrxPdsLVAg7QetoHdR9T3D2ic//HSASOhLnyoLMXW01tZdLjbxUiVv0
         9kMHK87IkXssF2dd3GK3hdATS29ZNYlIEi0FLE61zNuutbJZjscgrZ29IOggmIoMMvrO
         XWGSlWfb90lWYKHrjPY+LW1T6xDhHUzp2PINAUGk1J6x6jwA23ZADTcKMBJLCjNzbCtA
         9EOA==
X-Gm-Message-State: AGi0PuZWZc76NMLlA3MFjyHQi3caj30qiuaMgmjpWuMKayblpq/AVPz9
        6wXaOAS1Bjyv8r4ABiftkF2oNxFzXdo=
X-Google-Smtp-Source: APiQypKaD/gFAbQnvyaxAd4tr9bbcy4MhmIJk4wgWUAgWIXQzn6pmr4F8lxTGEGBgopidNcmBQp68w==
X-Received: by 2002:a54:4483:: with SMTP id v3mr17114731oiv.0.1588007251883;
        Mon, 27 Apr 2020 10:07:31 -0700 (PDT)
Received: from raspberrypi (99-189-78-97.lightspeed.austtx.sbcglobal.net. [99.189.78.97])
        by smtp.gmail.com with ESMTPSA id q142sm4177867oic.44.2020.04.27.10.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 10:07:31 -0700 (PDT)
Date:   Mon, 27 Apr 2020 12:07:29 -0500
From:   Grant Peltier <grantpeltier93@gmail.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        adam.vaughn.xh@renesas.com, grant.peltier.jg@renesas.com
Subject: Re: [PATCH v2 1/2] hwmon: (pmbus/isl68137) add debugfs config and
 black box endpoints
Message-ID: <20200427170729.GA13285@raspberrypi>
References: <cover.1587572415.git.grantpeltier93@gmail.com>
 <acbdc26389b6ab5f5f4536de7332b03c45a95f00.1587572415.git.grantpeltier93@gmail.com>
 <20200425174318.GA40266@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200425174318.GA40266@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 25, 2020 at 10:43:18AM -0700, Guenter Roeck wrote:
> On Wed, Apr 22, 2020 at 12:27:14PM -0500, Grant Peltier wrote:
> > Add debugfs endpoints to support features of 2nd generation Renesas
> > digital multiphase voltage regulators that are not compatible with
> > sysfs.
> > 
> > The read_black_box endpoint allows users to read the contents of a
> > RAM segment used to record fault conditions within Gen 2 devices.
> > 
> > The write_config endpoint allows users to write configuration hex
> > files to Gen 2 devices which modify how they operate.
> > 
> > Signed-off-by: Grant Peltier <grantpeltier93@gmail.com>
> 
> Comments inline.
> 
> However, the more I look into this, the more concerns I have.
> I think we should limit debugfs functions, if they are needed,
> to reporting detailed device status. Can you consider handling
> configuration from userspace using i2cget / i2cset commands ?

The reason we decided to try to implement configuration writes within the
driver is that we found a userspace implementation to be unstable. The
process requires anywhere from approximately 650 to a few thousand 32-bit
writes (dependent on number of NVM slots contained in the file). The entire
write process therefore takes a non-trivial amount of CPU time to complete
and the userspace process was often interrupted which would cause for it
to fail. Writing the configuration directly from the driver has been less
error prone.

> > +	res = i2c_smbus_read_i2c_block_data(ctrl->client, PMBUS_IC_DEVICE_REV,
> > +					    5, dev_rev);
> 
> It still puzzles me, quite frankly, why i2c_smbus_read_block_data()
> would not work here.
>

i2c_smbus_read_block_data() requires the underlying driver/controller to handle
interpretting the initial length byte read from the client device and then
continuing to read that number of bytes. Not all controllers (e.g. BCM2835)
support this. On the other hand, i2c_smbus_read_i2c_block_data() just does a
fixed-length read based on the given length parameter.

> > +static int raa_dmpvr2_cfg_write_result(struct raa_dmpvr2_ctrl *ctrl,
> > +				       struct raa_dmpvr2_cfg *cfg)
> > +{
> > +	u8 data[4] = {0};
> > +	u8 data1[4];
> > +	u8 *dptr;
> > +	unsigned long start;
> > +	int i, j, status;
> > +
> > +	// Check programmer status
> > +	start = jiffies;
> > +	i2c_smbus_write_word_data(ctrl->client, RAA_DMPVR2_DMA_ADDR,
> > +				  RAA_DMPVR2_PRGM_STATUS_ADDR);
> > +	while (data[0] == 0 && !time_after(jiffies, start + HZ + HZ)) {
> > +		raa_dmpvr2_smbus_read32(ctrl->client, RAA_DMPVR2_DMA_FIX,
> > +					data);
> > +	}
> > +	if (data[0] != 1)
> > +		return -ETIME;
> 
> Are you sure ? Normally I would expect ETIMEDOUT.
 
My understanding is that ETIME is meant for timer expiration whereas ETIMEDOUT
is meant for connection timeout errors. Is that correct? In this case, we are
not really waiting on the device to respond but instead are constantly polling
until the device responds with the desired value. However, I can understand an
argument for ETIMEDOUT here and can swtich to that if you think it is more
appropriate.


Thank you for your other notes. I will refactor as requested.

Grant
