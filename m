Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7011C54FCB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 17:20:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9841620700
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 17:20:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZNoAXQcB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbgDZRUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 13:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbgDZRUe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 13:20:34 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AE4C061A0F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 10:20:34 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id i10so17725286wrv.10
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 10:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=lxZo7u+Kt8cxDyv7UFpwAFZOw5Sz3XS5PN2qrMfEXyg=;
        b=ZNoAXQcBbskkRnxK97/IwpSB3VMVpultou3tOccT4Rbun5eKBty9RHdzgq4dkUg43I
         ka3OQLzqGINZ+mFP93p3CNg6Nbvywht0SV766qPdJCFlhK/X5xps+tl+Ccb3XTM1qSDH
         Ed5ZNOz9I99fH3y8DUzE/SnDdIqujhM8pMBh6tnTNRZtVRZz4GpyxG0kflKsSIpMCLCU
         b6lbXz+bv6gStWP0OUr4uVUPho8vgGj0jhMGpcVffDzAgThWn/V7HQwxWYeJ7NVCAyn8
         bnlRMWYn3PLGNU71C5pofdxl135ktoM6skD1uvJmvYT9f+lk4hUsqVsklaCLjTUALZzT
         Ka7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=lxZo7u+Kt8cxDyv7UFpwAFZOw5Sz3XS5PN2qrMfEXyg=;
        b=lLLRKcBNubkShfyagZhqVttcj+JtfzqWi5CLG0qL2NhAmYW5+cQGmzLeEPbgMYfKo1
         y085m3S3qWvQuRn1a6Kj+UbzCD0zBFNcHLMsbB2FOmJxxlk+UircJiAxtlDvcMgc0CmH
         SHtnbJZNw3/a1eL31r/d/5+N5S2GmH4VC+quHOCPPVNpE90/1VxHZzEFbkYyQ25I86Ut
         UwzU+ZTff6lESmzh12LgNQ3T/wGb1ZqH5tRiEl4BOdyqQgwChba+Tpibdr8Bu1WtO52i
         OWZifhQWgd2lJwPSLyfi0Gxcgo+V9hsU4jnxek+fEWknD1YhAHlrhMx8qk6KlJRL9g05
         lZNg==
X-Gm-Message-State: AGi0PuZIL+LN7HsoBpo7WbeEFlEzMSEn9hrugSGvbRTiRLCoQzbUZiK6
        9blVW/MBGeO5Ta6DsKUfWq4=
X-Google-Smtp-Source: APiQypIn2fPTbSkUogZeEmtVpx5qH9SOgm47/yalYqTdp5qed0nl3HNR0g60O1Q45jYMtb6Oyt7glg==
X-Received: by 2002:a5d:67cb:: with SMTP id n11mr22206437wrw.215.1587921632330;
        Sun, 26 Apr 2020 10:20:32 -0700 (PDT)
Received: from akira-laptop.home ([2a01:cb19:8b28:7600:a0b9:1c6f:cfba:2b21])
        by smtp.gmail.com with ESMTPSA id x6sm19100190wrg.58.2020.04.26.10.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2020 10:20:31 -0700 (PDT)
Message-ID: <97cc7047c5c3892c4a52a6a1fcc6ec948e0796ac.camel@gmail.com>
Subject: Re: [PATCH v2 1/2] Changes in w1_therm.c and adding w1_therm.h
From:   Akira shimahara <akira215corp@gmail.com>
To:     Greg KH <greg@kroah.com>
Cc:     zbr@ioremap.net, linux-kernel@vger.kernel.org
Date:   Sun, 26 Apr 2020 19:20:30 +0200
In-Reply-To: <20200426170901.GA2139089@kroah.com>
References: <20200423144116.GA7319@kroah.com>
         <20200425153141.247055-1-akira215corp@gmail.com>
         <20200426075141.GB2100063@kroah.com>
         <1b002fb8caf1755b89882fd7a3bbac1565959a6d.camel@gmail.com>
         <20200426170901.GA2139089@kroah.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le dimanche 26 avril 2020 à 19:09 +0200, Greg KH a écrit :
> On Sun, Apr 26, 2020 at 02:36:52PM +0200, Akira shimahara wrote:
> > Le dimanche 26 avril 2020 à 09:51 +0200, Greg KH a écrit :
> > > On Sat, Apr 25, 2020 at 05:31:41PM +0200, Akira Shimahara wrote:
> > > > From: Akira SHIMAHARA <akira215corp@gmail.com>
> > > > 
> > > > Patch for enhacement of w1_therm module. Added features :
> > > >  - Bulk read : send one command for all the slaves
> > > >  		on the bus to trigger temperature conversion
> > > >  - Optimized conversion time regarding to device resolution
> > > >  - Dedicated sysfs entry for powering read,
> > > >  		resolution set/get, eeprom save/restore
> > > >  - Alarms settings and reading
> > > >  - Code optimization to mitigate bus traffic
> > > >  		(devices information are stored to avoid
> > > > 		interrogating each device every-time)
> > > > 
> > > > Following sysfs entry are added :
> > > >  - temperature (RO) : return the temperature in 1/1000°
> > > >  - ext_power (RO) : return the power status of the device
> > > >  - resolution (RW) : get or set the device resolution
> > > > (supported
> > > > devices)
> > > >  - eeprom (WO) :trigger a save or restore to/from device EEPROM
> > > >  - alarms (RW) : read or write TH and TL in the device RAM
> > > >  - therm_bulk_read (RW) : Attribute at master level to trigger
> > > >  		bulk read and to survey the progress of devices
> > > > conversions
> > > >  - w1_slave has been kept for compatibility
> > > > 
> > > > Main motivation was to improve temperature reading speed, which
> > > > depend
> > > > on resolution settings of devices. The module store the powwer
> > > > status and
> > > > the resolution of each device so that during reading operation,
> > > > no
> > > > transaction is required on the bus, which improve speed.
> > > > The hardware status is checked as soon as a new device is
> > > > detected, 
> > > > when a user change occurred, or when the corresponding sys file
> > > > is 
> > > > accessed by user.
> > > > 
> > > > The bulk read allow to trigger convserion of all devices on the
> > > > bus
> > > > at
> > > > the same time. It will apply a strong pull up on the line if at
> > > > least
> > > > one device required it. The duration of the pull up is the max
> > > > time
> > > > required by a device on the line.
> > > > 
> > > > Please let me know any feedback you have on this patch.
> > > > 
> > > > Thanks ahead,
> > > > 
> > > > Signed-off-by: Akira Shimahara <akira215corp@gmail.com>
> > > > ---
> > > > Changes in v2:
> > > >  - Adding documentation in Documentatin/ABI/testing/sysfs-
> > > > driver-
> > > > w1_therm
> > > >  - Updating existing documentation in
> > > > Documentation/w1/slaves/w1_therm.rst
> > > > 
> > > >  drivers/w1/slaves/w1_therm.c | 1406
> > > > ++++++++++++++++++++++++++--
> > > > ------
> > > >  drivers/w1/slaves/w1_therm.h |  386 ++++++++++
> > > >  2 files changed, 1470 insertions(+), 322 deletions(-)
> > > >  create mode 100644 drivers/w1/slaves/w1_therm.h
> > > 
> > > No documentation files are added here :(
> > > 
> > 
> > It's in the PATCH 2/2 included in the previous mail. You want me to
> > merge in one commit ?. I thought it was easier for you to keep a
> > track
> > of the v1.
> 
> What previous mail?  I don't see a patch 2/2 here, did you not cc:
> me?
> 
> thanks,
> 
> greg kh

I'm so sorry Greg, I made a mistake. Please find hereby the patch 2/2.
Let me know if you want me to merge into 1 commit.

Thanks,

Akira SHIMAHARA

From 084addf560b771b54c2f977904f2139f818ecca7 Mon Sep 17 00:00:00 2001
From: Akira SHIMAHARA <akira215corp@gmail.com>
Date: Sat, 25 Apr 2020 16:30:45 +0200
Subject: [PATCH v2 2/2] w1_therm documentation

* updating w1_therm.rst documentation

* adding sysfs-driver-w1_therm documentation

Signed-off-by: Akira Shimahara <akira215corp@gmail.com>
---
Changes in v2:
 - Adding documentation in Documentatin/ABI/testing/sysfs-driver-
w1_therm
 - Updating existing documentation in
Documentation/w1/slaves/w1_therm.rst

 .../ABI/testing/sysfs-driver-w1_therm         | 115 ++++++++++++++++++
 Documentation/w1/slaves/w1_therm.rst          |  52 ++++++--
 2 files changed, 157 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-w1_therm

diff --git a/Documentation/ABI/testing/sysfs-driver-w1_therm
b/Documentation/ABI/testing/sysfs-driver-w1_therm
new file mode 100644
index 0000000000000..e18261189684c
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-w1_therm
@@ -0,0 +1,115 @@
+What:		/sys/bus/w1/devices/.../alarms
+Date:		Apr 2020
+Contact:	Akira Shimahara <akira215corp@gmail.com>
+Description:
+		(RW) read or write TH and TL (Temperature High an Low)
alarms.
+		Values shall be space separated and in the device range
+		(typical -55 degC to 125 degC). Values are integer as
they
+		are store in a 8bit register in the device.
+		Lowest value is automatically put to TL.
+		Once set, alarms could be search at master level, refer
to
+		Documentation/w1/w1_generic.rst for detailed
information
+Users:		any user space application which wants to communicate
with
+		w1_term device
+
+
+What:		/sys/bus/w1/devices/.../eeprom
+Date:		Apr 2020
+Contact:	Akira Shimahara <akira215corp@gmail.com>
+Description:
+		(WO) writing that file will either trigger a save of
the
+		device data to its embedded EEPROM, either restore data
+		embedded in device EEPROM. Be aware that devices
support
+		limited EEPROM writing cycles (typical 50k)
+			* `save`: save device RAM to EEPROM
+			* `restore`: restore EEPROM data in device RAM
+Users:		any user space application which wants to communicate
with
+		w1_term device
+
+
+What:		/sys/bus/w1/devices/.../ext_power
+Date:		Apr 2020
+Contact:	Akira Shimahara <akira215corp@gmail.com>
+Description:
+		(RO) return the power status by asking the device
+			* `0`: device parasite powered
+			* `1`: device externally powered
+			* `-xx`: xx is kernel error when reading power
status
+Users:		any user space application which wants to communicate
with
+		w1_term device
+
+
+What:		/sys/bus/w1/devices/.../resolution
+Date:		Apr 2020
+Contact:	Akira Shimahara <akira215corp@gmail.com>
+Description:
+		(RW) get or set the device resolution (on supported
devices,
+		if not, this entry is not present). Note that the
resolution
+		will be changed only in device RAM, so it will be
cleared when
+		power is lost. Trigger a `save` to EEPROM command to
keep
+		values after power-on. Read or write are :
+			* `9..12`: device resolution in bit
+			or resolution to set in bit
+			* `-xx`: xx is kernel error when reading the
resolution
+			* Anything else: do nothing
+Users:		any user space application which wants to communicate
with
+		w1_term device
+
+
+What:		/sys/bus/w1/devices/.../temperature
+Date:		Apr 2020
+Contact:	Akira Shimahara <akira215corp@gmail.com>
+Description:
+		(RO) return the temperature in 1/1000 degC.
+			* If a bulk read has been triggered, it will
directly
+			return the temperature computed when the bulk
read
+			occurred, if available. If not yet available,
nothing
+			is returned (a debug kernel message is sent),
you
+			should retry later on.
+			* If no bulk read has been triggered, it will
trigger
+			a conversion and send the result. Note that the
+			conversion duration depend on the resolution
(if
+			device support this feature). It takes 94ms in
9bits
+			resolution, 750ms for 12bits.
+Users:		any user space application which wants to communicate
with
+		w1_term device
+
+
+What:		/sys/bus/w1/devices/.../w1_slave
+Date:		Apr 2020
+Contact:	Akira Shimahara <akira215corp@gmail.com>
+Description:
+		(RW) return the temperature in 1/1000 degC.
+		*read*: return 2 lines with the hexa output data sent
on the
+		bus, return the CRC check and temperature in 1/1000
degC
+		*write* :
+			* `0` : save the 2 or 3 bytes to the device
EEPROM
+			(i.e. TH, TL and config register)
+			* `9..12` : set the device resolution in RAM
+			(if supported)
+			* Anything else: do nothing
+		refer to Documentation/w1/slaves/w1_therm.rst for
detailed
+		information.
+Users:		any user space application which wants to communicate
with
+		w1_term device
+
+
+What:		/sys/bus/w1/devices/w1_bus_masterXX/therm_bulk_read
+Date:		Apr 2020
+Contact:	Akira Shimahara <akira215corp@gmail.com>
+Description:
+		(RW) return the temperature in 1/1000 degC.
+		*read*:
+			* `-1`: conversion in progress on at least 1
sensor
+			* `1` :	conversion complete but at least one
sensor
+				value has not been read yet
+			* `0` :	no bulk operation. Reading temperature
will
+				trigger a conversion on each device
+		*write*: `trigger`: trigger a bulk read on all
supporting
+			devices on the bus
+		Note that if a bulk read is sent but one sensor is not
read
+		immediately, the next access to temperature on this
device
+		will return the temperature measured at the time of
issue
+		of the bulk read command (not the current temperature).
+Users:		any user space application which wants to communicate
with
+		w1_term device
diff --git a/Documentation/w1/slaves/w1_therm.rst
b/Documentation/w1/slaves/w1_therm.rst
index 90531c340a07a..06eaff1a05c08 100644
--- a/Documentation/w1/slaves/w1_therm.rst
+++ b/Documentation/w1/slaves/w1_therm.rst
@@ -26,20 +26,31 @@ W1_THERM_DS1825		0x3B
 W1_THERM_DS28EA00	0x42
 ====================	====
 
-Support is provided through the sysfs w1_slave file.  Each open and
+Support is provided through the sysfs w1_slave file. Each open and
 read sequence will initiate a temperature conversion then provide two
-lines of ASCII output.  The first line contains the nine hex bytes
+lines of ASCII output. The first line contains the nine hex bytes
 read along with a calculated crc value and YES or NO if it matched.
-If the crc matched the returned values are retained.  The second line
+If the crc matched the returned values are retained. The second line
 displays the retained values along with a temperature in millidegrees
 Centigrade after t=.
 
-Parasite powered devices are limited to one slave performing a
-temperature conversion at a time.  If none of the devices are parasite
-powered it would be possible to convert all the devices at the same
-time and then go back to read individual sensors.  That isn't
-currently supported.  The driver also doesn't support reduced
-precision (which would also reduce the conversion time) when reading
values.
+Alternatively, temperature can be read using temperature sysfs, it
+return only temperature in millidegrees Centigrade.
+
+A bulk read of all devices on the bus could be done writing 'trigger'
+in the therm_bulk_read sysfs entry at w1_bus_master level. This will
+sent the convert command on all devices on the bus, and if parasite
+powered devices are detected on the bus (and strong pullup is enable
+in the module), it will drive the line high during the longer
conversion
+time required by parasited powered device on the line. Reading
+therm_bulk_read will return 0 if no bulk conversion pending,
+-1 if at least one sensor still in conversion, 1 if conversion is
complete
+but at least one sensor value has not been read yet. Result
temperature is
+then accessed by reading the temperature sysfs entry of each device,
which
+may return empty if conversion is still in progress. Note that if a
bulk
+read is sent but one sensor is not read immediately, the next access
to
+temperature on this device will return the temperature measured at the
+time of issue of the bulk read command (not the current temperature).
 
 Writing a value between 9 and 12 to the sysfs w1_slave file will
change the
 precision of the sensor for the next readings. This value is in
(volatile)
@@ -49,6 +60,27 @@ To store the current precision configuration into
EEPROM, the value 0
 has to be written to the sysfs w1_slave file. Since the EEPROM has a
limited
 amount of writes (>50k), this command should be used wisely.
 
+Alternatively, resolution can be set or read (value from 9 to 12)
using the
+dedicated resolution sysfs entry on each device. This sysfs entry is
not
+present for devices not supporting this feature. Driver will adjust
the
+correct conversion time for each device regarding to its resolution
setting.
+In particular, strong pullup will be applied if required during the
conversion
+duration.
+
+The write-only sysfs entry eeprom is an alternative for EEPROM
operations:
+  * `save`: will save device RAM to EEPROM
+  * `restore`: will restore EEPROM data in device RAM.
+
+ext_power syfs entry allow tho check the power status of each device.
+  * `0`: device parasite powered
+  * `1`: device externally powered
+
+sysfs alarms allow read or write TH and TL (Temperature High an Low)
alarms.
+Values shall be space separated and in the device range (typical -55
degC
+to 125 degC). Values are integer as they are store in a 8bit register
in
+the device. Lowest value is automatically put to TL.Once set, alarms
could
+be search at master level.
+
 The module parameter strong_pullup can be set to 0 to disable the
 strong pullup, 1 to enable autodetection or 2 to force strong pullup.
 In case of autodetection, the driver will use the "READ POWER SUPPLY"
@@ -71,4 +103,4 @@ detection algorithm.  This feature allows you to
determine the physical
 location of the chip in the 1-wire bus without needing pre-existing
 knowledge of the bus ordering.  Support is provided through the sysfs
 w1_seq file.  The file will contain a single line with an integer
value
-representing the device index in the bus starting at 0.
+representing the device index in the bus starting at 0.
\ No newline at end of file

