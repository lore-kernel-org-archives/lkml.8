Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0877DC83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D54CC2083B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o+aSu9hE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgD2N5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 09:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727092AbgD2N5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 09:57:30 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5839CC03C1AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 06:57:30 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id t14so2627114wrw.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 06:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Xubq0W8h0VQR7GrKcadJsVgydCCLgntkdHWes3g5YKg=;
        b=o+aSu9hES/TiTzrSVF2wwe4BZlha56+G6d8ITUsVt3mFe5qrYLirh1aGjE630jygAC
         Lfmq5W8lZ2ddBFDjBobmngn5ZtLRxr7tuSJ6Wpusz+Uur7CgTCDIqu51MMlkr3K9T6r8
         +JIBEKIxJXJjWROppwbRxI42ZvAyFsb98nIML0GxTc8RPx7kr3Xg7UjOEt1ZFMyJXQEF
         53xEaq2i826Z7aHvk4hv7eNUjieQwGkGgoPy33oqXGMBHezatVVQnrGBZvLTNNRgSqf+
         +S9avRb7T1CQOIYiNIY6PiHRPoODOXEeTGsI+AtGPnmB1SRQqT/9LJHaCx5ECb/xNgAC
         IzWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Xubq0W8h0VQR7GrKcadJsVgydCCLgntkdHWes3g5YKg=;
        b=OIQJZOCJdHzHnE8HFa7CECeSPW4tmi+k3sBzNUJUlKboTVBRUNkRId4DvVAGCILwT4
         DBM008T3WrwP4g9O8JZgVJBQHs9TCLpakBoWuU8VdOfSPvRhOBLCXI5ur2NMnwdZLag+
         y1o3Oju/Y2S8X8AqqrWSJfo+1GOuWJHRuYWuvHRleEViwNQLyA34dblR0DGjUmI8HER2
         FXp1VnifydBOFSQ02CfI7LacodkJzpDmjSqdwoXXK6wA6BdymTaPxtR9oi0eMozxMV3B
         5AwYqsgJ4GoZOok1plNQCBOLsCCPOwbhDzV9WggiHh0CX5CFuSkCQL/P2ODVjhSMS9Kh
         EtkQ==
X-Gm-Message-State: AGi0PubcbK232/tmBgPy9Asq6pawbAbQFBc1GTFWtKpOSAkHtl5qayZq
        1u1X3RLxXVuxT/z3m2SdQvtrFDN+
X-Google-Smtp-Source: APiQypLPrtJ+atnNDscz/tgxXy5b4EphTdUCh00e70G3hPfAp39M7XimHzGCgjsdsisPb5NRH0XrfA==
X-Received: by 2002:adf:e541:: with SMTP id z1mr39020982wrm.218.1588168648977;
        Wed, 29 Apr 2020 06:57:28 -0700 (PDT)
Received: from akira-laptop.home ([2a01:cb19:8b28:7600:a0b9:1c6f:cfba:2b21])
        by smtp.gmail.com with ESMTPSA id l19sm7976140wmj.14.2020.04.29.06.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 06:57:28 -0700 (PDT)
Message-ID: <314e1f583d88d2173c7dfaced609b0841505f94f.camel@gmail.com>
Subject: _
From:   Akira shimahara <akira215corp@gmail.com>
To:     Greg KH <greg@kroah.com>
Cc:     zbr@ioremap.net, linux-kernel@vger.kernel.org
Date:   Wed, 29 Apr 2020 15:57:27 +0200
In-Reply-To: <20200429134655.GB2132814@kroah.com>
References: <20200429133204.140081-1-akira215corp@gmail.com>
         <20200429134655.GB2132814@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 29 avril 2020 à 15:46 +0200, Greg KH a écrit :
> On Wed, Apr 29, 2020 at 03:32:04PM +0200, Akira Shimahara wrote:
> > Patch for enhacement of w1_therm module.
> > Adding ext_power sysfs entry (RO). Return the power status of the
> > device:
> >  - 0: device parasite powered
> >  - 1: device externally powered
> >  - xx: xx is kernel error
> > 
> > Creating Documentation/ABI/testing/sysfs-driver-w1_therm for the
> > old 
> > driver sysfs and this new entry.
> > 
> > Signed-off-by: Akira Shimahara <akira215corp@gmail.com>
> > ---
> >  .../ABI/testing/sysfs-driver-w1_therm         | 29 ++++++
> >  drivers/w1/slaves/w1_therm.c                  | 93
> > ++++++++++++++++++-
> >  drivers/w1/slaves/w1_therm.h                  | 44 ++++++++-
> >  3 files changed, 163 insertions(+), 3 deletions(-)
> >  create mode 100644 Documentation/ABI/testing/sysfs-driver-w1_therm
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-driver-w1_therm
> > b/Documentation/ABI/testing/sysfs-driver-w1_therm
> > new file mode 100644
> > index 0000000..9aaf625
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-driver-w1_therm
> > @@ -0,0 +1,29 @@
> > +What:		/sys/bus/w1/devices/.../ext_power
> > +Date:		Apr 2020
> > +Contact:	Akira Shimahara <akira215corp@gmail.com>
> > +Description:
> > +		(RO) return the power status by asking the device
> > +			* `0`: device parasite powered
> > +			* `1`: device externally powered
> > +			* `-xx`: xx is kernel error when reading power
> > status
> > +Users:		any user space application which wants to
> > communicate with
> > +		w1_term device
> > +
> > +
> > +What:		/sys/bus/w1/devices/.../w1_slave
> > +Date:		Apr 2020
> > +Contact:	Akira Shimahara <akira215corp@gmail.com>
> > +Description:
> > +		(RW) return the temperature in 1/1000 degC.
> > +		*read*: return 2 lines with the hexa output data sent
> > on the
> > +		bus, return the CRC check and temperature in 1/1000
> > degC
> 
> the w1_slave file returns a temperature???
> 
> And sysfs is 1 value-per-file, not multiple lines.
> 
> And as this is a temperature, what's wrong with the iio interface
> that
> handles temperature already?  Don't go making up new userspace apis
> when
> we already have good ones today :)

Yes the existing syfs w1_slave return 2 lines, user application 
catch normally only the temperature. We keep it as many userspace
application are already based on this output, but to ease user
to catch the only purpose of these devices (temperature sensors),
we added on entry which return only the temperature (avoiding
string parsing ,... on both side i.e. driver and user app).

> 
> > +		*write* :
> > +			* `0` : save the 2 or 3 bytes to the device
> > EEPROM
> > +			(i.e. TH, TL and config register)
> > +			* `9..12` : set the device resolution in RAM
> > +			(if supported)
> 
> I don't understand these write values, how do they match up to a
> temperature readin?

This is the previous implementation, and yes, it was not very clear.
These value are not connected to temperature reading. The sysfs 
entry was used to enter user value to device RAM, in 2 registers:
if 0 it trigger a save to the device EEPROM, if the value is between
9 and 12, it stores in the resolution register of the device.
In the next patches, we add more sysfs entries to separate things.

> 
> > +			* Anything else: do nothing
> > +		refer to Documentation/w1/slaves/w1_therm.rst for
> > detailed
> > +		information.
> > +Users:		any user space application which wants to
> > communicate with
> > +		w1_term device
> > \ No newline at end of file
> > diff --git a/drivers/w1/slaves/w1_therm.c
> > b/drivers/w1/slaves/w1_therm.c
> > index 6245950..a530853 100644
> > --- a/drivers/w1/slaves/w1_therm.c
> > +++ b/drivers/w1/slaves/w1_therm.c
> > @@ -39,12 +39,14 @@ module_param_named(strong_pullup,
> > w1_strong_pullup, int, 0);
> >  
> >  static struct attribute *w1_therm_attrs[] = {
> >  	&dev_attr_w1_slave.attr,
> > +	&dev_attr_ext_power.attr,
> >  	NULL,
> >  };
> >  
> >  static struct attribute *w1_ds28ea00_attrs[] = {
> >  	&dev_attr_w1_slave.attr,
> >  	&dev_attr_w1_seq.attr,
> > +	&dev_attr_ext_power.attr,
> >  	NULL,
> >  };
> >  
> > @@ -294,6 +296,26 @@ static inline int w1_DS18S20_convert_temp(u8
> > rom[9])
> >  	return t;
> >  }
> >  
> > +/*------------------------ Helpers Functions--------------------
> > --------*/
> > +
> > +static inline bool bus_mutex_lock(struct mutex *lock)
> > +{
> > +	int max_trying = W1_THERM_MAX_TRY;
> > +	/* try to acquire the mutex, if not, sleep retry_delay before
> > retry) */
> 
> Please use scripts/checkpatch.pl on your patches, it should have
> asked
> you to put an empty line after the int definition.
> 
I used it, no warning on this line but I will add
> 
> 
> > +	while (mutex_lock_interruptible(lock) != 0 && max_trying > 0) {
> > +		unsigned long sleep_rem;
> > +
> > +		sleep_rem = msleep_interruptible(W1_THERM_RETRY_DELAY);
> > +		if (!sleep_rem)
> > +			max_trying--;
> > +	}
> > +
> > +	if (!max_trying)
> > +		return false;	/* Didn't acquire the bus mutex */
> > +
> > +	return true;
> > +}
> > +
> >  /*-------------------------Interface Functions------------------
> > ------------*/
> >  static int w1_therm_add_slave(struct w1_slave *sl)
> >  {
> > @@ -302,6 +324,16 @@ static int w1_therm_add_slave(struct w1_slave
> > *sl)
> >  	if (!sl->family_data)
> >  		return -ENOMEM;
> >  	atomic_set(THERM_REFCNT(sl->family_data), 1);
> > +
> > +	/* Getting the power mode of the device {external, parasite}*/
> > +	SLAVE_POWERMODE(sl) = read_powermode(sl);
> > +
> > +	if (SLAVE_POWERMODE(sl) < 0) {
> > +		/* no error returned as device has been added */
> > +		dev_warn(&sl->dev,
> > +			"%s: Device has been added, but power_mode may
> > be corrupted. err=%d\n",
> > +			 __func__, SLAVE_POWERMODE(sl));
> > +	}
> >  	return 0;
> >  }
> >  
> > @@ -512,6 +544,43 @@ error:
> >  	return ret;
> >  }
> >  
> > +static int read_powermode(struct w1_slave *sl)
> > +{
> > +	struct w1_master *dev_master = sl->master;
> > +	int max_trying = W1_THERM_MAX_TRY;
> > +	int  ret = -ENODEV;
> > +
> > +	if (!sl->family_data)
> > +		goto error;
> > +
> > +	/* prevent the slave from going away in sleep */
> > +	atomic_inc(THERM_REFCNT(sl->family_data));
> > +
> > +	if (!bus_mutex_lock(&dev_master->bus_mutex)) {
> > +		ret = -EAGAIN;	// Didn't acquire the mutex
> > +		goto dec_refcnt;
> > +	}
> > +
> > +	while ((max_trying--) && (ret < 0)) {
> > +		/* safe version to select slave */
> > +		if (!reset_select_slave(sl)) {
> > +			w1_write_8(dev_master, W1_READ_PSUPPLY);
> > +			/* Read only one bit,
> > +			 * 1 is externally powered,
> > +			 * 0 is parasite powered
> > +			 */
> > +			ret = w1_touch_bit(dev_master, 1);
> > +			/* ret should be either 1 either 0 */
> > +		}
> > +	}
> > +	mutex_unlock(&dev_master->bus_mutex);
> > +
> > +dec_refcnt:
> > +	atomic_dec(THERM_REFCNT(sl->family_data));
> > +error:
> > +	return ret;
> > +}
> > +
> >  /*------------------------Interface sysfs-------------------------
> > -*/
> >  
> >  static ssize_t w1_slave_show(struct device *device,
> > @@ -565,13 +634,35 @@ static ssize_t w1_slave_store(struct device
> > *device,
> >  				ret =
> > w1_therm_families[i].eeprom(device);
> >  			else
> >  				ret =
> > w1_therm_families[i].precision(device,
> > -								val);
> > +									
> > val);
> >  			break;
> >  		}
> >  	}
> >  	return ret ? : size;
> >  }
> >  
> > +static ssize_t ext_power_show(struct device *device,
> > +	struct device_attribute *attr, char *buf)
> > +{
> > +	struct w1_slave *sl = dev_to_w1_slave(device);
> > +
> > +	if (!sl->family_data) {
> > +		dev_info(device,
> > +			"%s: Device not supported by the driver\n",
> > __func__);
> > +		return 0;  /* No device family */
> > +	}
> > +
> > +	/* Getting the power mode of the device {external, parasite}*/
> > +	SLAVE_POWERMODE(sl) = read_powermode(sl);
> > +
> > +	if (SLAVE_POWERMODE(sl) < 0) {
> > +		dev_dbg(device,
> > +			"%s: Power_mode may be corrupted. err=%d\n",
> > +			__func__, SLAVE_POWERMODE(sl));
> > +	}
> > +	return sprintf(buf, "%d\n", SLAVE_POWERMODE(sl));
> > +}
> > +
> >  #if IS_REACHABLE(CONFIG_HWMON)
> >  static int w1_read_temp(struct device *device, u32 attr, int
> > channel,
> >  			long *val)
> > diff --git a/drivers/w1/slaves/w1_therm.h
> > b/drivers/w1/slaves/w1_therm.h
> > index b73af0b..2f975a4 100644
> > --- a/drivers/w1/slaves/w1_therm.h
> > +++ b/drivers/w1/slaves/w1_therm.h
> > @@ -25,6 +25,12 @@
> >  #include <linux/mutex.h>
> >  #include <linux/w1.h>
> >  
> > +/*----------------------------------Defines-----------------------
> > ----------*/
> 
> No real need for this, we can see defines just fine :)
> 
Well noted
> thanks,
> 
> greg k-h

