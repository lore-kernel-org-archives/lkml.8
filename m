Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58649C83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B9812074A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="XhtZBScq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PbpiuLZ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgD2Nq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 09:46:59 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:34537 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726830AbgD2Nq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 09:46:58 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 1A9B35C036F;
        Wed, 29 Apr 2020 09:46:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 29 Apr 2020 09:46:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=DbYv53qk6skeNdmOemkqgjZrTiF
        wQXjLrVbGiM/2ymY=; b=XhtZBScq8XSLgJ/F2GeiqdyXDOsOys8eq8s4x8pcSj5
        t3R9YdeSg5Y+hPdjXf+zqpXJ5L6PtgvNEJUuL3vRoDQhUldq74paPNuwTlsb8Wjy
        SF2mN12ib2XQnvvuXp5Teh4fC9fVAJ0og8o+RIjJPHTOgtUCvnVB9icmeeQhNRZo
        qf0M7NCIT8WkqUCNrifDPWk7CFdodrwdz6fYhxVwtnsfK3uWSE8LqfzBDofEMW8O
        SOXefNKuctY3prTuShdpGp7q/M/l5k5h21qg8Wb9GB2R9MWYXuCYF8L45JYn/e6i
        n/8J8GH5oa/iVfJ/JAeaCoQyBneH3zcV2sOopi0Pg6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=DbYv53
        qk6skeNdmOemkqgjZrTiFwQXjLrVbGiM/2ymY=; b=PbpiuLZ1vI/KRZHOL+j2Y0
        ZonInhU7BhG8hyTJeNitJ0LSzLqJshkgWDxHmWLrKjuq24A3mgLOaB7PDY6EhxCe
        V922tHGMephzoQCPbYr/2wyVg8acffiGH80RRORmqkL0r6wDf/ecHs6wjuGBiksM
        ddFeYqlMfS55M05Fb8DOSLKdavfqyNVYFE3McQbPQ5MWDLfiBeWboL6rmvxGO60U
        akg9mzsvH/14B7O+Uxx9Fzkx0hsrnCNc6gLSco3nZPv5oxRB+llwpRs7W2GMzF9P
        hc4iEce4NVQ30nFBcdFBsTR/hBRJZZzQHkRDR0Vr/41yqLpaB3fFFyj8KyOpNOUQ
        ==
X-ME-Sender: <xms:UIWpXhMsffPccFhInQq5Z0NSWT_7GeCS-6WSVC7g3XBFz4DhPhyq4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrieefgdeijecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeen
    ucggtffrrghtthgvrhhnpeevueehjefgfffgiedvudekvdektdelleelgefhleejieeuge
    egveeuuddukedvteenucfkphepkeefrdekiedrkeelrddutdejnecuvehluhhsthgvrhfu
    ihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrdgtoh
    hm
X-ME-Proxy: <xmx:UIWpXt_ECFOfdscTa5MkZsBx51jHnn0Nf5lgIKzHuy1SIwC6Y8fqag>
    <xmx:UIWpXqUrAr67DpBYnYHigjXVLmY365bjzED6epv5iYIRxjeOfvYntQ>
    <xmx:UIWpXveogEY3tcPcdLGLubSrj9BYq8gVgQYYtmu8QychpvLl5nk6jA>
    <xmx:UYWpXkgGlgMOSEJQWwgnXpz6_PW4Kx__7p_Qkg6wi6nq2LtfFsgLow>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 764303280064;
        Wed, 29 Apr 2020 09:46:56 -0400 (EDT)
Date:   Wed, 29 Apr 2020 15:46:55 +0200
From:   Greg KH <greg@kroah.com>
To:     Akira Shimahara <akira215corp@gmail.com>
Cc:     zbr@ioremap.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] w1_therm: adding sysfs entry to check device power
Message-ID: <20200429134655.GB2132814@kroah.com>
References: <20200429133204.140081-1-akira215corp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429133204.140081-1-akira215corp@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 03:32:04PM +0200, Akira Shimahara wrote:
> Patch for enhacement of w1_therm module.
> Adding ext_power sysfs entry (RO). Return the power status of the device:
>  - 0: device parasite powered
>  - 1: device externally powered
>  - xx: xx is kernel error
> 
> Creating Documentation/ABI/testing/sysfs-driver-w1_therm for the old 
> driver sysfs and this new entry.
> 
> Signed-off-by: Akira Shimahara <akira215corp@gmail.com>
> ---
>  .../ABI/testing/sysfs-driver-w1_therm         | 29 ++++++
>  drivers/w1/slaves/w1_therm.c                  | 93 ++++++++++++++++++-
>  drivers/w1/slaves/w1_therm.h                  | 44 ++++++++-
>  3 files changed, 163 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-w1_therm
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-w1_therm b/Documentation/ABI/testing/sysfs-driver-w1_therm
> new file mode 100644
> index 0000000..9aaf625
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-driver-w1_therm
> @@ -0,0 +1,29 @@
> +What:		/sys/bus/w1/devices/.../ext_power
> +Date:		Apr 2020
> +Contact:	Akira Shimahara <akira215corp@gmail.com>
> +Description:
> +		(RO) return the power status by asking the device
> +			* `0`: device parasite powered
> +			* `1`: device externally powered
> +			* `-xx`: xx is kernel error when reading power status
> +Users:		any user space application which wants to communicate with
> +		w1_term device
> +
> +
> +What:		/sys/bus/w1/devices/.../w1_slave
> +Date:		Apr 2020
> +Contact:	Akira Shimahara <akira215corp@gmail.com>
> +Description:
> +		(RW) return the temperature in 1/1000 degC.
> +		*read*: return 2 lines with the hexa output data sent on the
> +		bus, return the CRC check and temperature in 1/1000 degC

the w1_slave file returns a temperature???

And sysfs is 1 value-per-file, not multiple lines.

And as this is a temperature, what's wrong with the iio interface that
handles temperature already?  Don't go making up new userspace apis when
we already have good ones today :)

> +		*write* :
> +			* `0` : save the 2 or 3 bytes to the device EEPROM
> +			(i.e. TH, TL and config register)
> +			* `9..12` : set the device resolution in RAM
> +			(if supported)

I don't understand these write values, how do they match up to a
temperature readin?

> +			* Anything else: do nothing
> +		refer to Documentation/w1/slaves/w1_therm.rst for detailed
> +		information.
> +Users:		any user space application which wants to communicate with
> +		w1_term device
> \ No newline at end of file
> diff --git a/drivers/w1/slaves/w1_therm.c b/drivers/w1/slaves/w1_therm.c
> index 6245950..a530853 100644
> --- a/drivers/w1/slaves/w1_therm.c
> +++ b/drivers/w1/slaves/w1_therm.c
> @@ -39,12 +39,14 @@ module_param_named(strong_pullup, w1_strong_pullup, int, 0);
>  
>  static struct attribute *w1_therm_attrs[] = {
>  	&dev_attr_w1_slave.attr,
> +	&dev_attr_ext_power.attr,
>  	NULL,
>  };
>  
>  static struct attribute *w1_ds28ea00_attrs[] = {
>  	&dev_attr_w1_slave.attr,
>  	&dev_attr_w1_seq.attr,
> +	&dev_attr_ext_power.attr,
>  	NULL,
>  };
>  
> @@ -294,6 +296,26 @@ static inline int w1_DS18S20_convert_temp(u8 rom[9])
>  	return t;
>  }
>  
> +/*------------------------ Helpers Functions----------------------------*/
> +
> +static inline bool bus_mutex_lock(struct mutex *lock)
> +{
> +	int max_trying = W1_THERM_MAX_TRY;
> +	/* try to acquire the mutex, if not, sleep retry_delay before retry) */

Please use scripts/checkpatch.pl on your patches, it should have asked
you to put an empty line after the int definition.



> +	while (mutex_lock_interruptible(lock) != 0 && max_trying > 0) {
> +		unsigned long sleep_rem;
> +
> +		sleep_rem = msleep_interruptible(W1_THERM_RETRY_DELAY);
> +		if (!sleep_rem)
> +			max_trying--;
> +	}
> +
> +	if (!max_trying)
> +		return false;	/* Didn't acquire the bus mutex */
> +
> +	return true;
> +}
> +
>  /*-------------------------Interface Functions------------------------------*/
>  static int w1_therm_add_slave(struct w1_slave *sl)
>  {
> @@ -302,6 +324,16 @@ static int w1_therm_add_slave(struct w1_slave *sl)
>  	if (!sl->family_data)
>  		return -ENOMEM;
>  	atomic_set(THERM_REFCNT(sl->family_data), 1);
> +
> +	/* Getting the power mode of the device {external, parasite}*/
> +	SLAVE_POWERMODE(sl) = read_powermode(sl);
> +
> +	if (SLAVE_POWERMODE(sl) < 0) {
> +		/* no error returned as device has been added */
> +		dev_warn(&sl->dev,
> +			"%s: Device has been added, but power_mode may be corrupted. err=%d\n",
> +			 __func__, SLAVE_POWERMODE(sl));
> +	}
>  	return 0;
>  }
>  
> @@ -512,6 +544,43 @@ error:
>  	return ret;
>  }
>  
> +static int read_powermode(struct w1_slave *sl)
> +{
> +	struct w1_master *dev_master = sl->master;
> +	int max_trying = W1_THERM_MAX_TRY;
> +	int  ret = -ENODEV;
> +
> +	if (!sl->family_data)
> +		goto error;
> +
> +	/* prevent the slave from going away in sleep */
> +	atomic_inc(THERM_REFCNT(sl->family_data));
> +
> +	if (!bus_mutex_lock(&dev_master->bus_mutex)) {
> +		ret = -EAGAIN;	// Didn't acquire the mutex
> +		goto dec_refcnt;
> +	}
> +
> +	while ((max_trying--) && (ret < 0)) {
> +		/* safe version to select slave */
> +		if (!reset_select_slave(sl)) {
> +			w1_write_8(dev_master, W1_READ_PSUPPLY);
> +			/* Read only one bit,
> +			 * 1 is externally powered,
> +			 * 0 is parasite powered
> +			 */
> +			ret = w1_touch_bit(dev_master, 1);
> +			/* ret should be either 1 either 0 */
> +		}
> +	}
> +	mutex_unlock(&dev_master->bus_mutex);
> +
> +dec_refcnt:
> +	atomic_dec(THERM_REFCNT(sl->family_data));
> +error:
> +	return ret;
> +}
> +
>  /*------------------------Interface sysfs--------------------------*/
>  
>  static ssize_t w1_slave_show(struct device *device,
> @@ -565,13 +634,35 @@ static ssize_t w1_slave_store(struct device *device,
>  				ret = w1_therm_families[i].eeprom(device);
>  			else
>  				ret = w1_therm_families[i].precision(device,
> -								val);
> +									val);
>  			break;
>  		}
>  	}
>  	return ret ? : size;
>  }
>  
> +static ssize_t ext_power_show(struct device *device,
> +	struct device_attribute *attr, char *buf)
> +{
> +	struct w1_slave *sl = dev_to_w1_slave(device);
> +
> +	if (!sl->family_data) {
> +		dev_info(device,
> +			"%s: Device not supported by the driver\n", __func__);
> +		return 0;  /* No device family */
> +	}
> +
> +	/* Getting the power mode of the device {external, parasite}*/
> +	SLAVE_POWERMODE(sl) = read_powermode(sl);
> +
> +	if (SLAVE_POWERMODE(sl) < 0) {
> +		dev_dbg(device,
> +			"%s: Power_mode may be corrupted. err=%d\n",
> +			__func__, SLAVE_POWERMODE(sl));
> +	}
> +	return sprintf(buf, "%d\n", SLAVE_POWERMODE(sl));
> +}
> +
>  #if IS_REACHABLE(CONFIG_HWMON)
>  static int w1_read_temp(struct device *device, u32 attr, int channel,
>  			long *val)
> diff --git a/drivers/w1/slaves/w1_therm.h b/drivers/w1/slaves/w1_therm.h
> index b73af0b..2f975a4 100644
> --- a/drivers/w1/slaves/w1_therm.h
> +++ b/drivers/w1/slaves/w1_therm.h
> @@ -25,6 +25,12 @@
>  #include <linux/mutex.h>
>  #include <linux/w1.h>
>  
> +/*----------------------------------Defines---------------------------------*/

No real need for this, we can see defines just fine :)

thanks,

greg k-h
