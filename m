Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3210C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8B502067C
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 14:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U+bLg7/p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbgIAO4A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 10:56:00 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38398 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726722AbgIALpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 07:45:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598960735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yGv9aCok1IeGKIVY6KcYSn/oV2Xh7pU2192TIGWPhWY=;
        b=U+bLg7/plf8bqyYiDgQTxj3lfKX48GfvJApusNKap56c+GmCWaRFHb2ZABDmH7QT5V1wRV
        J+0ULW8q69lBVnZqCQzbirEUPbrRid5qeKZAX2vqLUGcKiF5Hl3f82XS1Ic6Vx5w/8+BcI
        I41H/EiU1kul25+oq3uYgKwiCmVHOUU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-bODAAGApNPGXHSZwNcxUeQ-1; Tue, 01 Sep 2020 07:45:33 -0400
X-MC-Unique: bODAAGApNPGXHSZwNcxUeQ-1
Received: by mail-ed1-f72.google.com with SMTP id u11so412795eds.23
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 04:45:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yGv9aCok1IeGKIVY6KcYSn/oV2Xh7pU2192TIGWPhWY=;
        b=aIuzfd5C+byQfD5d5kNujTHKHHbUqb9KMc5B4tJD/RzMKXfwiaRKE9fehergOYJhQP
         o64LOj0dgBUUVjSuEJ5zsyjJhmzixxvnnOC8jq2MO1xgjegRdEeZ2ZXMZ1/szSBmKrLx
         2ZY7rrDTjwIBw/+A2Yp0LphBVj/Xyz2DoE3PP3qGJm/S7cmUI//0IxWhNZsIxdwkZTVl
         NjGG2L9KGR7MSwbSY/JqdEKpjWLuJCv8wwrhGmFbad0zm6dBTq76n26uzxEAsbldPZuQ
         /Gc8W4kmvwffduWkTXHwSwkT7mo+B0RPz7Am/6PFEqPTDTtJqA1TtwYlVPfAXCuX/ZvI
         VB8w==
X-Gm-Message-State: AOAM5334uMU/RYfyPkBNeVV6VT3fZpF7Za6yQVyu/XQR7MBeCiVBW2hX
        ZUv2VE9a3RumZRCmfRCsRessSbBUjTrLKQY8fQ37wJhctaaMTQAom0ImdZuTI2z9NMFJKIVSV4K
        9k9X0JPKzArUee6Lpf3A7taju
X-Received: by 2002:a17:906:1b55:: with SMTP id p21mr1153816ejg.457.1598960731397;
        Tue, 01 Sep 2020 04:45:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVTaBJJaBkvZCnjCuAe66WNSlg8wwohejOk7a1vFSwFFa97zVeBP3XtfvLiVX0TwWuW02k0g==
X-Received: by 2002:a17:906:1b55:: with SMTP id p21mr1153770ejg.457.1598960730617;
        Tue, 01 Sep 2020 04:45:30 -0700 (PDT)
Received: from x1.localdomain ([78.108.130.193])
        by smtp.gmail.com with ESMTPSA id n26sm838445ejz.89.2020.09.01.04.44.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 04:45:29 -0700 (PDT)
Subject: Re: [PATCH] Introduce support for Systems Management Driver over WMI
 for Dell Systems
To:     Divya Bharathi <divya27392@gmail.com>, dvhart@infradead.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Divya Bharathi <divya.bharathi@dell.com>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Prasanth KSR <prasanth.ksr@dell.com>
References: <20200730143122.10237-1-divya_bharathi@dell.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <9b0e8473-1582-eb02-70f4-0f25d09c720c@redhat.com>
Date:   Tue, 1 Sep 2020 13:41:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200730143122.10237-1-divya_bharathi@dell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

So as promised a third mail with a review focused some more on the code.

On 7/30/20 4:31 PM, Divya Bharathi wrote:
> From: Divya Bharathi <divya.bharathi@dell.com>
> 
> The Dell WMI Systems Management Driver provides a sysfs
> interface for systems management to enable BIOS configuration
> capability on certain Dell Systems.
> 
> This driver allows user to configure Dell systems with a
> uniform common interface. To facilitate this, the patch
> introduces a generic way for driver to be able to create
> configurable BIOS Attributes available in Setup (F2) screen.
> 
> Co-developed-by: Mario Limonciello <mario.limonciello@dell.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> Co-developed-by: Prasanth KSR <prasanth.ksr@dell.com>
> Signed-off-by: Prasanth KSR <prasanth.ksr@dell.com>
> Signed-off-by: Divya Bharathi <divya.bharathi@dell.com>
> ---
> NOTE: This patch series is intended to go on top of
> platform-drivers-x86 linux-next.
> 
>   .../testing/sysfs-platform-dell-wmi-sysman    | 201 ++++++
>   MAINTAINERS                                   |   9 +
>   drivers/platform/x86/Kconfig                  |  11 +
>   drivers/platform/x86/Makefile                 |   8 +
>   .../x86/dell-wmi-biosattr-interface.c         | 263 ++++++++
>   .../platform/x86/dell-wmi-enum-attributes.c   | 207 +++++++
>   .../platform/x86/dell-wmi-int-attributes.c    | 188 ++++++
>   .../x86/dell-wmi-passobj-attributes.c         | 161 +++++
>   .../x86/dell-wmi-passwordattr-interface.c     | 230 +++++++
>   .../platform/x86/dell-wmi-string-attributes.c | 170 ++++++
>   .../platform/x86/dell-wmi-sysman-attributes.c | 575 ++++++++++++++++++
>   .../platform/x86/dell-wmi-sysman-attributes.h | 125 ++++
>   12 files changed, 2148 insertions(+)
>   create mode 100644 Documentation/ABI/testing/sysfs-platform-dell-wmi-sysman
>   create mode 100644 drivers/platform/x86/dell-wmi-biosattr-interface.c
>   create mode 100644 drivers/platform/x86/dell-wmi-enum-attributes.c
>   create mode 100644 drivers/platform/x86/dell-wmi-int-attributes.c
>   create mode 100644 drivers/platform/x86/dell-wmi-passobj-attributes.c
>   create mode 100644 drivers/platform/x86/dell-wmi-passwordattr-interface.c
>   create mode 100644 drivers/platform/x86/dell-wmi-string-attributes.c
>   create mode 100644 drivers/platform/x86/dell-wmi-sysman-attributes.c
>   create mode 100644 drivers/platform/x86/dell-wmi-sysman-attributes.h
> 
> diff --git a/Documentation/ABI/testing/sysfs-platform-dell-wmi-sysman b/Documentation/ABI/testing/sysfs-platform-dell-wmi-sysman
> new file mode 100644
> index 000000000000..8ca3e502ed89
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-platform-dell-wmi-sysman
> @@ -0,0 +1,201 @@
> +What:		/sys/devices/platform/dell-wmi-sysman/attributes/
> +Date:		October 2020
> +KernelVersion:	5.9
> +Contact:	Divya Bharathi <Divya.Bharathi@Dell.com>,
> +		Mario Limonciello <mario.limonciello@dell.com>,
> +		Prasanth KSR <prasanth.ksr@dell.com>
> +Description:
> +		The Dell WMI Systems Management Driver provides a sysfs interface
> +		for systems management software to enable BIOS configuration
> +		capability on certain Dell systems. This directory exposes
> +		interfaces for interacting with BIOS attributes
> +
> +What:		/sys/devices/platform/dell-wmi-sysman/attributes/reset_bios
> +Date:		October 2020
> +KernelVersion:	5.9
> +Contact:	Divya Bharathi <Divya.Bharathi@Dell.com>,
> +		Mario Limonciello <mario.limonciello@dell.com>,
> +		Prasanth KSR <prasanth.ksr@dell.com>
> +Description:
> +		This attribute can be used to reset the BIOS Configuration.
> +		Specifically, it tells which type of reset BIOS configuration is being
> +		requested on the host.
> +
> +		Reading from it returns a list of supported options encoded as:
> +
> +			'builtinsafe' (Built in safe configuration profile)
> +			'lastknowngood' (Last known good saved configuration profile)
> +			'factory' (Default factory settings configuration profile)
> +			'custom' (Custom saved configuration profile)
> +
> +		The currently selected option is printed in square brackets as
> +		shown below:
> +
> +		# echo "factory" > sys/devices/platform/dell-wmi-sysman/attributes/reset_bios
> +
> +		# cat sys/devices/platform/dell-wmi-sysman/attributes/reset_bios
> +		# builtinsafe lastknowngood [factory] custom
> +
> +		Note that any changes to this attribute requires a reboot
> +		for changes to take effect.
> +
> +What:		/sys/devices/platform/dell-wmi-sysman/attributes/pending_reboot
> +Date:		October 2020
> +KernelVersion:	5.9
> +Contact:	Divya Bharathi <Divya.Bharathi@Dell.com>,
> +		Mario Limonciello <mario.limonciello@dell.com>,
> +		Prasanth KSR <prasanth.ksr@dell.com>
> +Description:
> +		A read-only attribute enumerating if a reboot is pending
> +		on any BIOS attribute change.
> +
> +			0:	No pending reboot
> +			1:	Pending reboot
> +
> +What:		/sys/devices/platform/dell-wmi-sysman/attributes/enumeration/<attr>/
> +Date:		October 2020
> +KernelVersion:	5.9
> +Contact:	Divya Bharathi <Divya.Bharathi@Dell.com>,
> +		Mario Limonciello <mario.limonciello@dell.com>,
> +		Prasanth KSR <prasanth.ksr@dell.com>
> +Description:
> +		This directory exposes interfaces for interaction with
> +		BIOS enumeration attributes.
> +
> +		Enumeration attributes are settings that accept set of
> +		pre-defined valid values.
> +
> +		current_value:	A file that can be read to obtain the current
> +		value of the <attr>
> +
> +		This file can also be written to in order to update
> +		the value of a <attr>
> +
> +		default_value:	A file that can be read to obtain the default
> +		value of the <attr>
> +
> +		display_name:	A file that can be read to obtain a user friendly
> +		description of the at <attr>
> +
> +		display_name_language_code:	A file that can be read to obtain
> +		the language code corresponding to the "display_name" of the <attr>
> +
> +		modifier:	A file that can be read to obtain attribute-level
> +		dependency rule which has to be met to configure <attr>
> +
> +		possible_value:	A file that can be read to obtain the possible
> +		value of the <attr>
> +
> +		value_modifier:	A file that can be read to obtain value-level
> +		dependency on a possible value which has to be met to configure <attr>
> +
> +What:		/sys/devices/platform/dell-wmi-sysman/attributes/integer/<attr>/
> +Date:		October 2020
> +KernelVersion:	5.9
> +Contact:	Divya Bharathi <Divya.Bharathi@Dell.com>,
> +		Mario Limonciello <mario.limonciello@dell.com>,
> +		Prasanth KSR <prasanth.ksr@dell.com>
> +Description:
> +		This directory exposes interfaces for interaction with
> +		BIOS integer attributes.
> +
> +		Integer attributes are settings that accept a range of
> +		numerical values for inputs. Each BIOS integer has a
> +		lower bound and an upper bound on the values that it can take.
> +
> +		current_value:	A file that can be read to obtain the current
> +		value of the <attr>
> +
> +		This file can also be written to in order to update
> +		the value of an <attr>.
> +
> +		default_value:	A file that can be read to obtain the default
> +		value of the <attr>
> +
> +		display_name:	A file that can be read to obtain a user friendly
> +		description of the at <attr>
> +
> +		display_name_language_code:	A file that can be read to obtain
> +		the language code corresponding to the "display_name" of the <attr>
> +
> +		lower_bound:	A file that can be read to obtain the lower
> +		bound value of the <attr>
> +
> +		modifier:	A file that can be read to obtain attribute-level
> +		dependency rule which has to be met to configure <attr>
> +
> +		scalar_increment:	A file that can be read to obtain the
> +		resolution of the incremental value this attribute accepts.
> +
> +		upper_bound:	A file that can be read to obtain the upper
> +		bound value of the <attr>
> +
> +What:		/sys/devices/platform/dell-wmi-sysman/attributes/string/<attr>/
> +Date:		October 2020
> +KernelVersion:	5.9
> +Contact:	Divya Bharathi <Divya.Bharathi@Dell.com>,
> +		Mario Limonciello <mario.limonciello@dell.com>,
> +		Prasanth KSR <prasanth.ksr@dell.com>
> +Description:
> +		This directory exposes interfaces for interaction with
> +		BIOS string attributes.
> +
> +		String attributes are settings that accept a string for an input.
> +		Each BIOS string is characterized by the minimum length of the string,
> +		the maximum length of the string, and the type of the string.
> +
> +		current_value:	A file that can be read to obtain the current
> +		value of the <attr>
> +
> +		This file can also be written to in order to update
> +		the value of an <attr>.
> +
> +		default_value:	A file that can be read to obtain the default
> +		value of the <attr>
> +
> +		display_name:	A file that can be read to obtain a user friendly
> +		description of the at <attr>
> +
> +		display_name_language_code:	A file that can be read to obtain
> +		the language code corresponding to the "display_name" of the <attr>
> +
> +		max_length:	A file that can be read to obtain the maximum
> +		length value of the <attr>
> +
> +		min_length:	A file that can be read to obtain the minimum
> +		length value of the <attr>
> +
> +		modifier:	A file that can be read to obtain attribute-level
> +		dependency rule which has to be met to configure <attr>
> +
> +What:		/sys/devices/platform/dell-wmi-sysman/attributes/password/<attr>/
> +Date:		October 2020
> +KernelVersion:	5.9
> +Contact:	Divya Bharathi <Divya.Bharathi@Dell.com>,
> +		Mario Limonciello <mario.limonciello@dell.com>,
> +		Prasanth KSR <prasanth.ksr@dell.com>
> +Description:
> +		This directory exposes interfaces for interaction with
> +		BIOS password attributes.
> +
> +		BIOS Admin password and System Password can be set, reset or cleared
> +		using these attributes.
> +
> +		An "Admin" password is used for preventing modification to the BIOS settings.
> +		A "System" password is required to boot a machine.
> +
> +		is_password_set:	A file that can be read
> +		to obtain flag to see if a password is set on <attr>
> +
> +		max_password_length:	A file that can be read to obtain the
> +		maximum length of the Password
> +
> +		min_password_length:	A file that can be read to obtain the
> +		minimum length of the Password
> +
> +		current_password: A write only value used for privileged access
> +		such as setting attributes when a system or admin password is set
> +		or resetting to a new password
> +
> +		new_password: A write only value that when used in tandem with
> +		current_password will reset a system or admin password.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e64cdde81851..176311d712db 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4879,6 +4879,15 @@ M:	Mario Limonciello <mario.limonciello@dell.com>
>   S:	Maintained
>   F:	drivers/platform/x86/dell-wmi-descriptor.c
>   
> +DELL WMI SYSMAN DRIVER
> +M:	Divya Bharathi <divya.bharathi@dell.com>
> +M:	Mario Limonciello <mario.limonciello@dell.com>
> +M:	Prasanth Ksr <prasanth.ksr@dell.com>
> +L:	platform-driver-x86@vger.kernel.org
> +S:	Maintained
> +F:	drivers/platform/x86/dell-wmi-*-attributes.*
> +F:	drivers/platform/x86/dell-wmi-*-interface.c
> +
>   DELL WMI NOTIFICATIONS DRIVER
>   M:	Matthew Garrett <mjg59@srcf.ucam.org>
>   M:	Pali Rohár <pali@kernel.org>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 0581a54cf562..de66373554c2 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -430,6 +430,17 @@ config DELL_WMI
>   	  To compile this driver as a module, choose M here: the module will
>   	  be called dell-wmi.
>   
> +config DELL_WMI_SYSMAN
> +	tristate "Dell WMI SYSMAN"
> +	depends on ACPI_WMI
> +	depends on DMI
> +	help
> +	  This driver allows changing BIOS settings on many Dell machines from
> +	  2018 and newer without the use of any additional software.
> +
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called dell-wmi-sysman.
> +
>   config DELL_WMI_DESCRIPTOR
>   	tristate
>   	depends on ACPI_WMI
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index 2b85852a1a87..bee03f1af28f 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -47,6 +47,14 @@ obj-$(CONFIG_DELL_WMI)			+= dell-wmi.o
>   obj-$(CONFIG_DELL_WMI_DESCRIPTOR)	+= dell-wmi-descriptor.o
>   obj-$(CONFIG_DELL_WMI_AIO)		+= dell-wmi-aio.o
>   obj-$(CONFIG_DELL_WMI_LED)		+= dell-wmi-led.o
> +obj-$(CONFIG_DELL_WMI_SYSMAN)  += dell-wmi-sysman.o
> +dell-wmi-sysman-objs := dell-wmi-sysman-attributes.o \
> +				 dell-wmi-enum-attributes.o \
> +				 dell-wmi-int-attributes.o \
> +				 dell-wmi-string-attributes.o \
> +				 dell-wmi-passobj-attributes.o \
> +				 dell-wmi-passwordattr-interface.o \
> +				 dell-wmi-biosattr-interface.o
>   
>   # Fujitsu
>   obj-$(CONFIG_AMILO_RFKILL)	+= amilo-rfkill.o
> diff --git a/drivers/platform/x86/dell-wmi-biosattr-interface.c b/drivers/platform/x86/dell-wmi-biosattr-interface.c
> new file mode 100644
> index 000000000000..decf124d4388
> --- /dev/null
> +++ b/drivers/platform/x86/dell-wmi-biosattr-interface.c
> @@ -0,0 +1,263 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Functions corresponding to SET methods under BIOS attributes interface GUID for use
> + * with dell-wmi-sysman
> + *
> + *  Copyright (c) 2020 Dell Inc.
> + */
> +
> +#include <linux/wmi.h>
> +#include "dell-wmi-sysman-attributes.h"
> +
> +#define SETDEFAULTVALUES_METHOD_ID					0x02
> +#define SETBIOSDEFAULTS_METHOD_ID					0x03
> +#define SETATTRIBUTE_METHOD_ID						0x04
> +
> +static DEFINE_MUTEX(call_mutex);
> +static DEFINE_MUTEX(list_mutex);

These are defined multiple times in almost all of the files, if the purpose is to
allow only 1 WMI call at a time then their should be only 1 define of the call_mutex.

> +
> +struct wmi_interface_priv {
> +	struct list_head list;
> +	struct wmi_device *wdev;
> +	struct device *child;
> +	bool pending_changes;
> +};
> +static LIST_HEAD(interface_list);

You use a list here; and also in drivers/platform/x86/dell-wmi-passwordattr-interface.c
but you only every use the first entry of the list.

Looking at the structure of the driver I think that it would be best to do the following:

1) Use a single global struct which contains the data from the
struct wmi_interface_priv from both dell-wmi-biosattr-interface.c and
dell-wmi-passwordattr-interface.c including separate wdev pointers for both
and add a single shared call_mutex to this struct

2) Have the dell_wmi_bios_attr_set_interface_probe() functions each set their
own wdev pointer in the global struct

3) Have drivers/platform/x86/dell-wmi-sysman-attributes.c 's init_dell_bios_attrib_wmi
function first register the 2 wmi drivers and then check that both wdev pointers are
set in the global struct to make sure both GUID's were found and the driver did successfully
bound and move the platform_device (to be replaced with a class-dev) registration
to the very end of init_dell_bios_attrib_wmi, so that sysfs files do not become
available before the wdev pointers are both set (which I think is currently possinble).

This refactoring will allow the removing of all the list_mutex-s and the 2 LIST_HEAD(interface_list)
declarations; and it will also replace all the separate call_mutex locks with a single shared
lock in the global shared data struct.

I believe that this + the suggested API changes will result in enough refactoring
(assuming that you agree) that a further detailed code review does not make a whole
lot of sense right now.

So first please address my current review remarks (or explain why you believe
that things should be kept as is); and then we will see from there.

Regards,

Hans




> +
> +static inline struct wmi_interface_priv *get_first_interface_priv(void)
> +{
> +	return list_first_entry_or_null(&interface_list,
> +					struct wmi_interface_priv,
> +					list);
> +}
> +
> +static int call_biosattributes_interface(struct wmi_device *wdev, char *in_args, size_t size,
> +					int method_id)
> +{
> +	struct acpi_buffer output = {ACPI_ALLOCATE_BUFFER, NULL};
> +	struct acpi_buffer input;
> +	union acpi_object *obj;
> +	acpi_status status;
> +	int ret = -EIO;
> +
> +	input.length =  (acpi_size) size;
> +	input.pointer = in_args;
> +	status = wmidev_evaluate_method(wdev, 0, method_id, &input, &output);
> +	if (ACPI_FAILURE(status))
> +		return -EIO;
> +	obj = (union acpi_object *)output.pointer;
> +	if (obj->type == ACPI_TYPE_INTEGER)
> +		ret = obj->integer.value;
> +
> +	kfree(output.pointer);
> +	kobject_uevent(&wdev->dev.kobj, KOBJ_CHANGE);
> +	return map_wmi_error(ret);
> +}
> +
> +/**
> + * get_pending_changes() - Fetch if any changes are pending
> + *
> + * Checks if any changes have been written that will be changed
> + * after a system reboot
> + **/
> +bool get_pending_changes(void)
> +{
> +	struct wmi_interface_priv *priv;
> +
> +	priv = get_first_interface_priv();
> +	if (priv)
> +		return priv->pending_changes;
> +	return 0;
> +}
> +
> +/**
> + * set_attribute() - Update an attribute value
> + * @a_name: The attribute name
> + * @a_value: The attribute value
> + *
> + * Sets an attribute to new value
> + **/
> +int set_attribute(const char *a_name, const char *a_value)
> +{
> +	int ret = -1;
> +	int i;
> +	u8 *name_len, *value_len;
> +	char *current_password, *attribute_name, *attribute_value;
> +	size_t security_area_size;
> +	size_t string_area_size;
> +	size_t buffer_size;
> +	struct wmi_interface_priv *priv;
> +	char *buffer;
> +
> +	/* look up if user set a password for the requests */
> +	current_password = get_current_password("Admin");
> +	if (!current_password)
> +		return -ENODEV;

Can we instead of passing "Admin" and "System" to this function
just have 2 separate get_current_admin_password and get_current_system_password
helpers and then drop the error handling ?

> +
> +	/* password is set */
> +	if (strlen(current_password) > 0)
> +		security_area_size = (sizeof(u32) * 2) + strlen(current_password) +
> +					strlen(current_password) % 2;
> +	/* password not set */
> +	else
> +		security_area_size = sizeof(u32) * 2;

Since you are using more then 1 line here please use {} around the state-ments,
also please put the /* password not set */ after the else:

		...
	} else { /* password not set */
		...

> +	string_area_size = (strlen(a_name) + strlen(a_value))*2;
> +	buffer_size = security_area_size + string_area_size + sizeof(u16) * 2;
> +
> +	buffer = kzalloc(buffer_size, GFP_KERNEL);
> +	if (!buffer)
> +		return -ENOMEM;
> +
> +	/* build security area */
> +	if (strlen(current_password) > 0)
> +		populate_security_buffer(buffer, current_password);
> +
> +	name_len = buffer + security_area_size;
> +	attribute_name = name_len + sizeof(u16);
> +	value_len = attribute_name + strlen(a_name)*2;
> +	attribute_value = value_len + sizeof(u16);
> +
> +	/* turn into UTF16 strings, no NULL terminator */
> +	*name_len = strlen(a_name)*2;
> +	*value_len = strlen(a_value)*2;
> +	for (i = 0; i < strlen(a_name); i++)
> +		attribute_name[i*2] = a_name[i];
> +	for (i = 0; i < strlen(a_value); i++)
> +		attribute_value[i*2] = a_value[i];

This assumes the incoming string is ASCII only and won't
work when the incoming string is UTF-8. It is probably
better to use the utf8s_to_utf16s() helper from the nls
code, this will mean adding a dependency on CONFIG_NLS
which typically is used for filesystem code, but I think
that that will be fine.

> +
> +	mutex_lock(&call_mutex);
> +	priv = get_first_interface_priv();
> +	if (!priv) {
> +		ret = -ENODEV;
> +		pr_err(DRIVER_NAME ": no WMI backend bound");
> +		goto out_set_attribute;
> +	}
> +
> +	ret = call_biosattributes_interface(priv->wdev, buffer, buffer_size,
> +						SETATTRIBUTE_METHOD_ID);
> +	if (ret == -EOPNOTSUPP)
> +		dev_err(&priv->wdev->dev, "admin password must be configured");
> +	else if (ret == -EACCES)
> +		dev_err(&priv->wdev->dev, "invalid password");
> +
> +	priv->pending_changes = 1;
> +out_set_attribute:
> +	kfree(buffer);
> +	mutex_unlock(&call_mutex);
> +
> +	return ret;
> +}
> +
> +/**
> + * set_bios_defaults() - Resets BIOS defaults
> + * @deftype: the type of BIOS value reset to issue.
> + *
> + * Resets BIOS defaults
> + **/
> +int set_bios_defaults(u8 deftype)
> +{
> +	int ret = -1;
> +	u8 *defaultType;
> +	char *current_password, *buffer;
> +	size_t security_area_size;
> +	size_t integer_area_size = sizeof(u8);
> +	size_t buffer_size;
> +	struct wmi_interface_priv *priv;
> +
> +	/* look up if user set a password for the requests */
> +	current_password = get_current_password("Admin");
> +	if (!current_password)
> +		return -ENODEV;
> +
> +	/* password is set */
> +	if (strlen(current_password) > 0)
> +		security_area_size = (sizeof(u32) * 2) + strlen(current_password) +
> +					strlen(current_password) % 2;
> +	/* password not set */
> +	else
> +		security_area_size = sizeof(u32) * 2;
> +
> +	buffer_size = security_area_size + integer_area_size;
> +	buffer = kzalloc(buffer_size, GFP_KERNEL);
> +	if (!buffer)
> +		return -ENOMEM;
> +
> +	/* build security area */
> +	if (strlen(current_password) > 0)
> +		populate_security_buffer(buffer, current_password);
> +
> +	mutex_lock(&call_mutex);
> +	priv = get_first_interface_priv();
> +	if (!priv) {
> +		ret = -ENODEV;
> +		pr_err(DRIVER_NAME ": no WMI backend bound");
> +		goto out_bios_defaults;
> +	}
> +
> +	defaultType = buffer + security_area_size;
> +	*defaultType = deftype;
> +
> +	ret = call_biosattributes_interface(priv->wdev, buffer, buffer_size,
> +						SETBIOSDEFAULTS_METHOD_ID);
> +	if (ret)
> +		dev_err(&priv->wdev->dev, "reset BIOS defaults failed: %d", ret);
> +	priv->pending_changes = 1;
> +out_bios_defaults:
> +	kfree(buffer);
> +	mutex_unlock(&call_mutex);
> +
> +	return ret;
> +}
> +
> +static int dell_wmi_bios_attr_set_interface_probe(struct wmi_device *wdev, const void *context)
> +{
> +	struct wmi_interface_priv *priv;
> +
> +	priv = devm_kzalloc(&wdev->dev, sizeof(struct wmi_interface_priv),
> +			    GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +	priv->wdev = wdev;
> +	dev_set_drvdata(&wdev->dev, priv);
> +	mutex_lock(&list_mutex);
> +	list_add_tail(&priv->list, &interface_list);
> +	mutex_unlock(&list_mutex);
> +	return 0;
> +}
> +
> +static int dell_wmi_bios_attr_set_interface_remove(struct wmi_device *wdev)
> +{
> +	struct wmi_interface_priv *priv = dev_get_drvdata(&wdev->dev);
> +
> +	mutex_lock(&call_mutex);
> +	mutex_lock(&list_mutex);
> +	list_del(&priv->list);
> +	mutex_unlock(&list_mutex);
> +	mutex_unlock(&call_mutex);
> +	return 0;
> +}
> +
> +static const struct wmi_device_id dell_wmi_bios_attr_set_interface_id_table[] = {
> +	{ .guid_string = DELL_WMI_BIOS_ATTRIBUTES_INTERFACE_GUID },
> +	{ },
> +};
> +static struct wmi_driver dell_wmi_bios_attr_set_interface_driver = {
> +	.driver = {
> +		.name = DRIVER_NAME"-set"
> +	},
> +	.probe = dell_wmi_bios_attr_set_interface_probe,
> +	.remove = dell_wmi_bios_attr_set_interface_remove,
> +	.id_table = dell_wmi_bios_attr_set_interface_id_table,
> +};
> +
> +int init_dell_wmi_bios_attr_set_interface(void)
> +{
> +	return wmi_driver_register(&dell_wmi_bios_attr_set_interface_driver);
> +}
> +
> +void exit_dell_wmi_bios_attr_set_interface(void)
> +{
> +	wmi_driver_unregister(&dell_wmi_bios_attr_set_interface_driver);
> +}
> +
> +MODULE_DEVICE_TABLE(wmi, dell_wmi_bios_attr_set_interface_id_table);
> diff --git a/drivers/platform/x86/dell-wmi-enum-attributes.c b/drivers/platform/x86/dell-wmi-enum-attributes.c
> new file mode 100644
> index 000000000000..a2d8ae291d5c
> --- /dev/null
> +++ b/drivers/platform/x86/dell-wmi-enum-attributes.c
> @@ -0,0 +1,207 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Functions corresponding to enumeration type attributes under BIOS Enumeration GUID for use
> + * with dell-wmi-sysman
> + *
> + *  Copyright (c) 2020 Dell Inc.
> + */
> +
> +#include "dell-wmi-sysman-attributes.h"
> +
> +static DEFINE_MUTEX(call_mutex);
> +static DEFINE_MUTEX(list_mutex);
> +
> +/* kept variable names same as in sysfs file name for sysfs_show macro definition */
> +struct enumeration_data {
> +	char attribute_name[MAX_BUFF];
> +	char display_name_language_code[MAX_BUFF];
> +	char display_name[MAX_BUFF];
> +	char default_value[MAX_BUFF];
> +	char current_value[MAX_BUFF];
> +	char modifier[MAX_BUFF];
> +	int value_modifier_count;
> +	char value_modifier[MAX_BUFF];
> +	int possible_value_count;
> +	char possible_value[MAX_BUFF];
> +};
> +
> +static struct enumeration_data *enumeration_data;
> +static int enumeration_instances_count;
> +get_instance_id(enumeration);
> +
> +static ssize_t current_value_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
> +{
> +	int instance_id;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +	instance_id = get_enumeration_instance_id(kobj);
> +	if (instance_id >= 0) {
> +		union acpi_object *obj;
> +
> +		obj = get_wmiobj_pointer(instance_id, DELL_WMI_BIOS_ENUMERATION_ATTRIBUTE_GUID);
> +		if (!obj)
> +			return -AE_ERROR;
> +		strncpy_attr(enumeration_data[instance_id].current_value,
> +		       obj->package.elements[CURRENT_VAL].string.pointer);
> +		kfree(obj);
> +		return sprintf(buf, "%s\n", enumeration_data[instance_id].current_value);
> +	}
> +	return -EIO;
> +}
> +
> +/**
> + * validate_enumeration_input() - Validate input of current_value against possible values
> + * @instance_id: The instance on which input is validated
> + * @buf: Input value
> + **/
> +int validate_enumeration_input(int instance_id, const char *buf)
> +{
> +	int ret = -EINVAL;
> +	char *options, *tmp, *p;
> +
> +	options = tmp = kstrdup((enumeration_data[instance_id].possible_value), GFP_KERNEL);
> +	if (!options)
> +		return -ENOMEM;
> +
> +	while ((p = strsep(&options, ";")) != NULL) {
> +		if (!*p)
> +			continue;
> +		if (!strncasecmp(p, buf, strlen(p))) {
> +			ret = 0;
> +			break;
> +		}
> +	}
> +
> +	kfree(tmp);
> +	return ret;
> +}
> +
> +attribute_s_property_show(display_name_language_code, enumeration);
> +static struct kobj_attribute displ_langcode =
> +		__ATTR_RO(display_name_language_code);
> +
> +attribute_s_property_show(display_name, enumeration);
> +struct kobj_attribute displ_name =
> +		__ATTR_RO(display_name);
> +
> +attribute_s_property_show(default_value, enumeration);
> +struct kobj_attribute default_val =
> +		__ATTR_RO(default_value);
> +
> +attribute_property_store(current_value, enumeration);
> +struct kobj_attribute current_val =
> +		__ATTR_RW(current_value);
> +
> +attribute_s_property_show(modifier, enumeration);
> +struct kobj_attribute modifier =
> +		__ATTR_RO(modifier);
> +
> +attribute_s_property_show(value_modifier, enumeration);
> +struct kobj_attribute value_modfr =
> +		__ATTR_RO(value_modifier);
> +
> +attribute_s_property_show(possible_value, enumeration);
> +struct kobj_attribute poss_val =
> +		__ATTR_RO(possible_value);
> +
> +static struct attribute *enumeration_attrs[] = {
> +	&displ_langcode.attr,
> +	&displ_name.attr,
> +	&default_val.attr,
> +	&current_val.attr,
> +	&modifier.attr,
> +	&value_modfr.attr,
> +	&poss_val.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group enumeration_attr_group = {
> +	.attrs = enumeration_attrs,
> +};
> +
> +int alloc_enum_data(void)
> +{
> +	int ret = 0;
> +
> +	enumeration_instances_count = get_instance_count(DELL_WMI_BIOS_ENUMERATION_ATTRIBUTE_GUID);
> +	enumeration_data = kzalloc((sizeof(struct enumeration_data) * enumeration_instances_count),
> +					GFP_KERNEL);
> +	if (!enumeration_data)
> +		ret = -ENOMEM;
> +	return ret;
> +}
> +
> +/**
> + * populate_enum_data() - Populate all properties of an instance under enumeration attribute
> + * @enumeration_obj: ACPI object with enumeration data
> + * @instance_id: The instance to enumerate
> + * @attr_name_kobj: The parent kernel object
> + **/
> +int populate_enum_data(union acpi_object *enumeration_obj, int instance_id,
> +			struct kobject *attr_name_kobj)
> +{
> +	int i, next_obj;
> +	int retval = sysfs_create_group(attr_name_kobj, &enumeration_attr_group);
> +
> +	if (retval)
> +		goto out;
> +
> +	mutex_lock(&call_mutex);
> +	strncpy_attr(enumeration_data[instance_id].attribute_name,
> +		enumeration_obj[ATTR_NAME].string.pointer);
> +	strncpy_attr(enumeration_data[instance_id].display_name_language_code,
> +		enumeration_obj[DISPL_NAME_LANG_CODE].string.pointer);
> +	strncpy_attr(enumeration_data[instance_id].display_name,
> +		enumeration_obj[DISPLAY_NAME].string.pointer);
> +	strncpy_attr(enumeration_data[instance_id].default_value,
> +		enumeration_obj[DEFAULT_VAL].string.pointer);
> +	strncpy_attr(enumeration_data[instance_id].current_value,
> +		enumeration_obj[CURRENT_VAL].string.pointer);
> +	strncpy_attr(enumeration_data[instance_id].modifier,
> +		enumeration_obj[MODIFIER].string.pointer);
> +
> +	next_obj = MODIFIER + 1;
> +
> +	enumeration_data[instance_id].value_modifier_count =
> +		(uintptr_t)enumeration_obj[next_obj].string.pointer;
> +
> +	for (i = 0; i < enumeration_data[instance_id].value_modifier_count; i++) {
> +		strcat(enumeration_data[instance_id].value_modifier,
> +			enumeration_obj[++next_obj].string.pointer);
> +		strcat(enumeration_data[instance_id].value_modifier, ";");
> +	}
> +
> +	enumeration_data[instance_id].possible_value_count =
> +		(uintptr_t) enumeration_obj[++next_obj].string.pointer;
> +
> +	for (i = 0; i < enumeration_data[instance_id].possible_value_count; i++) {
> +		strcat(enumeration_data[instance_id].possible_value,
> +			enumeration_obj[++next_obj].string.pointer);
> +		strcat(enumeration_data[instance_id].possible_value, ";");
> +	}
> +	mutex_unlock(&call_mutex);
> +
> +out:
> +	return retval;
> +}
> +
> +/**
> + * exit_enum_attributes() - Clear all attribute data
> + * @kset: The kset to free
> + *
> + * Clears all data allocated for this group of attributes
> + **/
> +void exit_enum_attributes(struct kset *kset)
> +{
> +	struct kobject *pos, *next;
> +
> +	mutex_lock(&list_mutex);
> +	list_for_each_entry_safe(pos, next, &kset->list, entry) {
> +		sysfs_remove_group(pos, &enumeration_attr_group);
> +	}
> +	mutex_unlock(&list_mutex);
> +	mutex_lock(&call_mutex);
> +	kfree(enumeration_data);
> +	mutex_unlock(&call_mutex);
> +}
> diff --git a/drivers/platform/x86/dell-wmi-int-attributes.c b/drivers/platform/x86/dell-wmi-int-attributes.c
> new file mode 100644
> index 000000000000..222971be2b48
> --- /dev/null
> +++ b/drivers/platform/x86/dell-wmi-int-attributes.c
> @@ -0,0 +1,188 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Functions corresponding to integer type attributes under BIOS Integer GUID for use with
> + * dell-wmi-sysman
> + *
> + *  Copyright (c) 2020 Dell Inc.
> + */
> +
> +#include "dell-wmi-sysman-attributes.h"
> +
> +static DEFINE_MUTEX(call_mutex);
> +static DEFINE_MUTEX(list_mutex);
> +
> +enum int_properties {LOWER_BOUND = 6, UPPER_BOUND, SCALAR_INCR};
> +
> +/* kept variable names same as in sysfs file name for sysfs_show macro definition */
> +struct integer_data {
> +	char attribute_name[MAX_BUFF];
> +	char display_name_language_code[MAX_BUFF];
> +	char display_name[MAX_BUFF];
> +	int default_value;
> +	int current_value;
> +	char modifier[MAX_BUFF];
> +	int lower_bound;
> +	int upper_bound;
> +	int scalar_increment;
> +};
> +
> +static struct integer_data *integer_data;
> +static int integer_instances_count;
> +get_instance_id(integer);
> +
> +static ssize_t current_value_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
> +{
> +	int instance_id;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +	instance_id = get_integer_instance_id(kobj);
> +	if (instance_id >= 0) {
> +		union acpi_object *obj;
> +
> +		obj = get_wmiobj_pointer(instance_id, DELL_WMI_BIOS_INTEGER_ATTRIBUTE_GUID);
> +		if (!obj)
> +			return -AE_ERROR;
> +		integer_data[instance_id].current_value =
> +			(uintptr_t)obj->package.elements[CURRENT_VAL].string.pointer;
> +		kfree(obj);
> +		return sprintf(buf, "%d\n", integer_data[instance_id].current_value);
> +	}
> +	return -EIO;
> +}
> +
> +/**
> + * validate_integer_input() - Validate input of current_value against lower and upper bound
> + * @instance_id: The instance on which input is validated
> + * @buf: Input value
> + **/
> +int validate_integer_input(int instance_id, const char *buf)
> +{
> +	int in_val;
> +	int ret = -EINVAL;
> +
> +	if (kstrtoint(buf, 0, &in_val))
> +		return -EINVAL;
> +	if ((in_val >= integer_data[instance_id].lower_bound) &&
> +	(in_val <= integer_data[instance_id].upper_bound))
> +		ret = 0;
> +
> +	return ret;
> +}
> +
> +attribute_s_property_show(display_name_language_code, integer);
> +static struct kobj_attribute integer_displ_langcode =
> +	__ATTR_RO(display_name_language_code);
> +
> +attribute_s_property_show(display_name, integer);
> +struct kobj_attribute integer_displ_name =
> +	__ATTR_RO(display_name);
> +
> +attribute_n_property_show(default_value, integer);
> +struct kobj_attribute integer_default_val =
> +	__ATTR_RO(default_value);
> +
> +attribute_property_store(current_value, integer);
> +struct kobj_attribute integer_current_val =
> +	__ATTR_RW(current_value);
> +
> +attribute_s_property_show(modifier, integer);
> +struct kobj_attribute integer_modifier =
> +	__ATTR_RO(modifier);
> +
> +attribute_n_property_show(lower_bound, integer);
> +struct kobj_attribute integer_lower_bound =
> +	__ATTR_RO(lower_bound);
> +
> +attribute_n_property_show(upper_bound, integer);
> +struct kobj_attribute integer_upper_bound =
> +	__ATTR_RO(upper_bound);
> +
> +attribute_n_property_show(scalar_increment, integer);
> +struct kobj_attribute integer_scalar_increment =
> +	__ATTR_RO(scalar_increment);
> +
> +static struct attribute *integer_attrs[] = {
> +	&integer_displ_langcode.attr,
> +	&integer_displ_name.attr,
> +	&integer_default_val.attr,
> +	&integer_current_val.attr,
> +	&integer_modifier.attr,
> +	&integer_lower_bound.attr,
> +	&integer_upper_bound.attr,
> +	&integer_scalar_increment.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group integer_attr_group = {
> +	.attrs = integer_attrs,
> +};
> +
> +int alloc_int_data(void)
> +{
> +	int ret = 0;
> +
> +	integer_instances_count = get_instance_count(DELL_WMI_BIOS_INTEGER_ATTRIBUTE_GUID);
> +	integer_data = kzalloc((sizeof(struct integer_data) * integer_instances_count), GFP_KERNEL);
> +	if (!integer_data)
> +		ret = -ENOMEM;
> +	return ret;
> +}
> +
> +/**
> + * populate_enum_data() - Populate all properties of an instance under integer attribute
> + * @integer_obj: ACPI object with integer data
> + * @instance_id: The instance to enumerate
> + * @attr_name_kobj: The parent kernel object
> + **/
> +int populate_int_data(union acpi_object *integer_obj, int instance_id,
> +			struct kobject *attr_name_kobj)
> +{
> +	int retval = sysfs_create_group(attr_name_kobj, &integer_attr_group);
> +
> +	if (retval)
> +		goto out;
> +
> +	mutex_lock(&call_mutex);
> +	strncpy_attr(integer_data[instance_id].attribute_name,
> +		integer_obj[ATTR_NAME].string.pointer);
> +	strncpy_attr(integer_data[instance_id].display_name_language_code,
> +		integer_obj[DISPL_NAME_LANG_CODE].string.pointer);
> +	strncpy_attr(integer_data[instance_id].display_name,
> +		integer_obj[DISPLAY_NAME].string.pointer);
> +	integer_data[instance_id].default_value =
> +		(uintptr_t)integer_obj[DEFAULT_VAL].string.pointer;
> +	integer_data[instance_id].current_value =
> +		(uintptr_t)integer_obj[CURRENT_VAL].string.pointer;
> +	strncpy_attr(integer_data[instance_id].modifier, integer_obj[MODIFIER].string.pointer);
> +	integer_data[instance_id].lower_bound =
> +		(uintptr_t)integer_obj[LOWER_BOUND].string.pointer;
> +	integer_data[instance_id].upper_bound =
> +		(uintptr_t)integer_obj[UPPER_BOUND].string.pointer;
> +	integer_data[instance_id].scalar_increment =
> +		(uintptr_t)integer_obj[SCALAR_INCR].string.pointer;
> +	mutex_unlock(&call_mutex);
> +
> +out:
> +	return retval;
> +}
> +
> +/**
> + * exit_int_attributes() - Clear all attribute data
> + * @kset: The kset to free
> + *
> + * Clears all data allocated for this group of attributes
> + **/
> +void exit_int_attributes(struct kset *kset)
> +{
> +	struct kobject *pos, *next;
> +
> +	mutex_lock(&list_mutex);
> +	list_for_each_entry_safe(pos, next, &kset->list, entry) {
> +		sysfs_remove_group(pos, &integer_attr_group);
> +	}
> +	mutex_unlock(&list_mutex);
> +	mutex_lock(&call_mutex);
> +	kfree(integer_data);
> +	mutex_unlock(&call_mutex);
> +}
> diff --git a/drivers/platform/x86/dell-wmi-passobj-attributes.c b/drivers/platform/x86/dell-wmi-passobj-attributes.c
> new file mode 100644
> index 000000000000..d430ecf2387b
> --- /dev/null
> +++ b/drivers/platform/x86/dell-wmi-passobj-attributes.c
> @@ -0,0 +1,161 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Functions corresponding to password object type attributes under BIOS Password Object GUID for
> + * use with dell-wmi-sysman
> + *
> + *  Copyright (c) 2020 Dell Inc.
> + */
> +
> +#include "dell-wmi-sysman-attributes.h"
> +
> +static DEFINE_MUTEX(call_mutex);
> +static DEFINE_MUTEX(list_mutex);
> +
> +enum po_properties {IS_PASS_SET = 1, MIN_PASS_LEN, MAX_PASS_LEN};
> +
> +/* kept variable names same as in sysfs file name for sysfs_show macro definition */
> +struct po_data {
> +	char attribute_name[MAX_BUFF];
> +	int is_password_set;
> +	int min_password_length;
> +	int max_password_length;
> +};
> +
> +static struct po_data *po_data;
> +static int po_instances_count;
> +get_instance_id(po);
> +
> +static ssize_t is_password_set_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
> +{
> +	int instance_id = get_po_instance_id(kobj);
> +
> +	if (instance_id >= 0) {
> +		union acpi_object *obj;
> +
> +		obj = get_wmiobj_pointer(instance_id, DELL_WMI_BIOS_PASSOBJ_ATTRIBUTE_GUID);
> +		if (!obj)
> +			return -AE_ERROR;
> +		po_data[instance_id].is_password_set =
> +			(uintptr_t)obj->package.elements[IS_PASS_SET].string.pointer;
> +		kfree(obj);
> +		return sprintf(buf, "%d\n", po_data[instance_id].is_password_set);
> +	}
> +	return -EIO;
> +}
> +
> +struct kobj_attribute po_is_pass_set =
> +		__ATTR_RO(is_password_set);
> +
> +static ssize_t current_password_store(struct kobject *kobj,
> +				      struct kobj_attribute *attr,
> +				      const char *buf, size_t count)
> +{
> +	char *p = memchr(buf, '\n', count);
> +	int ret;
> +
> +	if (p != NULL)
> +		*p = '\0';
> +	if (strlen(buf) > MAX_BUFF)
> +		return -EINVAL;
> +
> +	ret = set_current_password(kobj->name, buf);
> +	return ret ? ret : count;
> +}
> +
> +struct kobj_attribute po_current_password =
> +		__ATTR_WO(current_password);
> +
> +static ssize_t new_password_store(struct kobject *kobj,
> +				  struct kobj_attribute *attr,
> +				  const char *buf, size_t count)
> +{
> +	char *p = memchr(buf, '\n', count);
> +	int ret;
> +
> +	if (p != NULL)
> +		*p = '\0';
> +	if (strlen(buf) > MAX_BUFF)
> +		return -EINVAL;
> +
> +	ret = set_new_password(kobj->name, buf);
> +	return ret ? ret : count;
> +}
> +
> +struct kobj_attribute po_new_password =
> +		__ATTR_WO(new_password);
> +
> +attribute_n_property_show(min_password_length, po);
> +struct kobj_attribute po_min_pass_length =
> +		__ATTR_RO(min_password_length);
> +
> +attribute_n_property_show(max_password_length, po);
> +struct kobj_attribute po_max_pass_length =
> +		__ATTR_RO(max_password_length);
> +
> +static struct attribute *po_attrs[] = {
> +	&po_is_pass_set.attr,
> +	&po_min_pass_length.attr,
> +	&po_max_pass_length.attr,
> +	&po_current_password.attr,
> +	&po_new_password.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group po_attr_group = {
> +	.attrs = po_attrs,
> +};
> +
> +int alloc_po_data(void)
> +{
> +	int ret = 0;
> +
> +	po_instances_count = get_instance_count(DELL_WMI_BIOS_PASSOBJ_ATTRIBUTE_GUID);
> +	po_data = kzalloc((sizeof(struct po_data) * po_instances_count), GFP_KERNEL);
> +	if (!po_data)
> +		ret = -ENOMEM;
> +	return ret;
> +}
> +
> +/**
> + * populate_po_data() - Populate all properties of an instance under password object attribute
> + * @po_obj: ACPI object with password object data
> + * @instance_id: The instance to enumerate
> + * @attr_name_kobj: The parent kernel object
> + **/
> +int populate_po_data(union acpi_object *po_obj, int instance_id, struct kobject *attr_name_kobj)
> +{
> +	int retval = sysfs_create_group(attr_name_kobj, &po_attr_group);
> +
> +	if (retval)
> +		goto out;
> +
> +	mutex_lock(&call_mutex);
> +	strncpy_attr(po_data[instance_id].attribute_name, po_obj[ATTR_NAME].string.pointer);
> +	po_data[instance_id].is_password_set = (uintptr_t)po_obj[IS_PASS_SET].string.pointer;
> +	po_data[instance_id].min_password_length = (uintptr_t)po_obj[MIN_PASS_LEN].string.pointer;
> +	po_data[instance_id].max_password_length = (uintptr_t) po_obj[MAX_PASS_LEN].string.pointer;
> +	mutex_unlock(&call_mutex);
> +
> +out:
> +	return retval;
> +}
> +
> +/**
> + * exit_po_attributes() - Clear all attribute data
> + * @kset: The kset to free
> + *
> + * Clears all data allocated for this group of attributes
> + **/
> +void exit_po_attributes(struct kset *kset)
> +{
> +	struct kobject *pos, *next;
> +
> +	mutex_lock(&list_mutex);
> +	list_for_each_entry_safe(pos, next, &kset->list, entry) {
> +		sysfs_remove_group(pos, &po_attr_group);
> +	}
> +	mutex_unlock(&list_mutex);
> +	mutex_lock(&call_mutex);
> +	kfree(po_data);
> +	mutex_unlock(&call_mutex);
> +}
> diff --git a/drivers/platform/x86/dell-wmi-passwordattr-interface.c b/drivers/platform/x86/dell-wmi-passwordattr-interface.c
> new file mode 100644
> index 000000000000..9d7ac36e232f
> --- /dev/null
> +++ b/drivers/platform/x86/dell-wmi-passwordattr-interface.c
> @@ -0,0 +1,230 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Functions corresponding to SET password methods under BIOS attributes interface GUID
> + *
> + *  Copyright (c) 2020 Dell Inc.
> + */
> +
> +#include <linux/wmi.h>
> +#include "dell-wmi-sysman-attributes.h"
> +
> +static DEFINE_MUTEX(call_mutex);
> +static DEFINE_MUTEX(list_mutex);
> +
> +struct wmi_interface_priv {
> +	struct list_head list;
> +	struct wmi_device *wdev;
> +	struct device *child;
> +	char current_admin_password[MAX_BUFF];
> +	char current_system_password[MAX_BUFF];
> +};
> +static LIST_HEAD(interface_list);
> +
> +static inline struct wmi_interface_priv *get_first_interface_priv(void)
> +{
> +	return list_first_entry_or_null(&interface_list,
> +					struct wmi_interface_priv,
> +					list);
> +}
> +
> +static int call_password_interface(struct wmi_device *wdev, char *in_args, size_t size)
> +{
> +	struct acpi_buffer output = {ACPI_ALLOCATE_BUFFER, NULL};
> +	struct acpi_buffer input;
> +	union acpi_object *obj;
> +	acpi_status status;
> +	int ret = -EIO;
> +
> +	input.length =  (acpi_size) size;
> +	input.pointer = in_args;
> +	status = wmidev_evaluate_method(wdev, 0, 1, &input, &output);
> +	if (ACPI_FAILURE(status))
> +		return -EIO;
> +	obj = (union acpi_object *)output.pointer;
> +	if (obj->type == ACPI_TYPE_INTEGER)
> +		ret = obj->integer.value;
> +
> +	kfree(output.pointer);
> +	kobject_uevent(&wdev->dev.kobj, KOBJ_CHANGE);
> +	return map_wmi_error(ret);
> +}
> +
> +/**
> + * get_current_password() - Get the current stored password value
> + * @password_type: The type of password to store
> + **/
> +char *get_current_password(const char *password_type)
> +{
> +	struct wmi_interface_priv *priv = get_first_interface_priv();
> +
> +	if (!priv) {
> +		pr_err(DRIVER_NAME ": no WMI backend bound");
> +		return NULL;
> +	}
> +	if (strcmp(password_type, "Admin") == 0)
> +		return priv->current_admin_password;
> +	if (strcmp(password_type, "System") == 0)
> +		return priv->current_system_password;
> +	dev_err(&priv->wdev->dev, "unknown password type %s", password_type);
> +	return NULL;
> +}
> +
> +/**
> + * set_current_password() - Store current password
> + * @password_type: The type of password to store
> + * @current: The current value
> + *
> + * Sets the current value of the password.
> + * This is used for:
> + *  - Resetting password
> + *  - Basis for any functions requiring password to execute
> + **/
> +int set_current_password(const char *password_type, const char *cur)
> +{
> +	char *current_password = get_current_password(password_type);
> +
> +	if (!current_password)
> +		return -ENODEV;
> +	strncpy(current_password, cur, (strlen(cur) + 1));
> +	return 0;
> +}
> +
> +/**
> + * set_new_password() - Sets a system admin password
> + * @password_type: The type of password to set
> + * @new: The new password
> + *
> + * Sets the password using plaintext interface
> + **/
> +int set_new_password(const char *password_type, const char *new)
> +{
> +	int ret = -1;
> +	int i;
> +	u8 *type_len, *old_len, *new_len;
> +	char *current_password, *type_value, *old_value, *new_value;
> +	size_t security_area_size;
> +	size_t string_area_size;
> +	size_t buffer_size;
> +	struct wmi_interface_priv *priv;
> +	char *buffer;
> +
> +	mutex_lock(&call_mutex);
> +	priv = get_first_interface_priv();
> +	if (!priv) {
> +		ret = -ENODEV;
> +		pr_err(DRIVER_NAME ": no WMI backend bound");
> +		goto out_close_mutex;
> +	}
> +	current_password = get_current_password(password_type);
> +	if (!current_password) {
> +		ret = -ENODEV;
> +		goto out_close_mutex;
> +	}
> +	/* password is set */
> +	if (strlen(current_password) > 0)
> +		security_area_size = (sizeof(u32) * 2) + strlen(current_password) +
> +					strlen(current_password) % 2;
> +	/* password not set */
> +	else
> +		security_area_size = sizeof(u32) * 2;
> +	string_area_size = (strlen(password_type) + strlen(current_password) + strlen(new))*2;
> +	buffer_size = security_area_size + string_area_size + sizeof(u16) * 3;
> +
> +	buffer = kzalloc(buffer_size, GFP_KERNEL);
> +
> +	if (!buffer) {
> +		ret = -ENOMEM;
> +		goto out_close_mutex;
> +	}
> +
> +	/* build security area */
> +	if (strlen(current_password) > 0)
> +		populate_security_buffer(buffer, current_password);
> +
> +	type_len = buffer + security_area_size;
> +	type_value = type_len + sizeof(u16);
> +	old_len = type_value + strlen(password_type)*2;
> +	old_value = old_len + sizeof(u16);
> +	new_len = old_value + strlen(current_password)*2;
> +	new_value = new_len + sizeof(u16);
> +
> +	/* turn into UTF16 strings, no NULL terminator */
> +	*type_len = strlen(password_type)*2;
> +	*old_len = strlen(current_password)*2;
> +	*new_len = strlen(new)*2;
> +	for (i = 0; i < strlen(password_type); i++)
> +		type_value[i*2] = password_type[i];
> +	for (i = 0; i < strlen(current_password); i++)
> +		old_value[i*2] = current_password[i];
> +	for (i = 0; i < strlen(new); i++)
> +		new_value[i*2] = new[i];
> +
> +	ret = call_password_interface(priv->wdev, buffer, buffer_size);
> +	/* update current password so commands work after reset */
> +	if (!ret)
> +		ret = set_current_password(password_type, new);
> +	/* explain to user the detailed failure reason */
> +	else if (ret == -EOPNOTSUPP)
> +		dev_err(&priv->wdev->dev, "admin password must be configured");
> +	else if (ret == -EACCES)
> +		dev_err(&priv->wdev->dev, "invalid password");
> +	kfree(buffer);
> +
> +out_close_mutex:
> +	mutex_unlock(&call_mutex);
> +
> +	return ret;
> +}
> +
> +static int dell_wmi_bios_attr_pass_interface_probe(struct wmi_device *wdev, const void *context)
> +{
> +	struct wmi_interface_priv *priv;
> +
> +	priv = devm_kzalloc(&wdev->dev, sizeof(struct wmi_interface_priv),
> +			    GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +	priv->wdev = wdev;
> +	dev_set_drvdata(&wdev->dev, priv);
> +	mutex_lock(&list_mutex);
> +	list_add_tail(&priv->list, &interface_list);
> +	mutex_unlock(&list_mutex);
> +	return 0;
> +}
> +
> +static int dell_wmi_bios_attr_pass_interface_remove(struct wmi_device *wdev)
> +{
> +	struct wmi_interface_priv *priv = dev_get_drvdata(&wdev->dev);
> +
> +	mutex_lock(&call_mutex);
> +	mutex_lock(&list_mutex);
> +	list_del(&priv->list);
> +	mutex_unlock(&list_mutex);
> +	mutex_unlock(&call_mutex);
> +	return 0;
> +}
> +
> +static const struct wmi_device_id dell_wmi_bios_attr_pass_interface_id_table[] = {
> +	{ .guid_string = DELL_WMI_BIOS_PASSWORD_INTERFACE_GUID },
> +	{ },
> +};
> +static struct wmi_driver dell_wmi_bios_attr_pass_interface_driver = {
> +	.driver = {
> +		.name = DRIVER_NAME"-password"
> +	},
> +	.probe = dell_wmi_bios_attr_pass_interface_probe,
> +	.remove = dell_wmi_bios_attr_pass_interface_remove,
> +	.id_table = dell_wmi_bios_attr_pass_interface_id_table,
> +};
> +
> +int init_dell_wmi_bios_attr_pass_interface(void)
> +{
> +	return wmi_driver_register(&dell_wmi_bios_attr_pass_interface_driver);
> +}
> +
> +void exit_dell_wmi_bios_attr_pass_interface(void)
> +{
> +	wmi_driver_unregister(&dell_wmi_bios_attr_pass_interface_driver);
> +}
> +
> +MODULE_DEVICE_TABLE(wmi, dell_wmi_bios_attr_pass_interface_id_table);
> diff --git a/drivers/platform/x86/dell-wmi-string-attributes.c b/drivers/platform/x86/dell-wmi-string-attributes.c
> new file mode 100644
> index 000000000000..562d09055dd1
> --- /dev/null
> +++ b/drivers/platform/x86/dell-wmi-string-attributes.c
> @@ -0,0 +1,170 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Functions corresponding to string type attributes under BIOS String GUID for use with
> + * dell-wmi-sysman
> + *
> + *  Copyright (c) 2020 Dell Inc.
> + */
> +
> +#include "dell-wmi-sysman-attributes.h"
> +
> +static DEFINE_MUTEX(call_mutex);
> +static DEFINE_MUTEX(list_mutex);
> +
> +enum string_properties {MIN_LEN = 6, MAX_LEN};
> +
> +/* kept variable names same as in sysfs file name for sysfs_show macro definition */
> +struct str_data {
> +	char attribute_name[MAX_BUFF];
> +	char display_name_language_code[MAX_BUFF];
> +	char display_name[MAX_BUFF];
> +	char default_value[MAX_BUFF];
> +	char current_value[MAX_BUFF];
> +	char modifier[MAX_BUFF];
> +	int min_length;
> +	int max_length;
> +};
> +
> +static struct str_data *str_data;
> +static int str_instances_count;
> +get_instance_id(str);
> +
> +static ssize_t current_value_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
> +{
> +	int instance_id;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +	instance_id = get_str_instance_id(kobj);
> +	if (instance_id >= 0) {
> +		union acpi_object *obj;
> +
> +		obj = get_wmiobj_pointer(instance_id, DELL_WMI_BIOS_STRING_ATTRIBUTE_GUID);
> +		if (!obj)
> +			return -AE_ERROR;
> +		strncpy_attr(str_data[instance_id].current_value,
> +			obj->package.elements[CURRENT_VAL].string.pointer);
> +		kfree(obj);
> +		return sprintf(buf, "%s\n", str_data[instance_id].current_value);
> +	}
> +	return -EIO;
> +}
> +
> +/**
> + * validate_str_input() - Validate input of current_value against min and max lengths
> + * @instance_id: The instance on which input is validated
> + * @buf: Input value
> + **/
> +int validate_str_input(int instance_id, const char *buf)
> +{
> +	int in_len = strlen(buf);
> +
> +	if ((in_len >= str_data[instance_id].min_length) &&
> +	(in_len <= str_data[instance_id].max_length))
> +		return 0;
> +
> +	return -EINVAL;
> +}
> +
> +attribute_s_property_show(display_name_language_code, str);
> +static struct kobj_attribute str_displ_langcode =
> +		__ATTR_RO(display_name_language_code);
> +
> +attribute_s_property_show(display_name, str);
> +struct kobj_attribute str_displ_name =
> +		__ATTR_RO(display_name);
> +
> +attribute_s_property_show(default_value, str);
> +struct kobj_attribute str_default_val =
> +		__ATTR_RO(default_value);
> +
> +attribute_property_store(current_value, str);
> +struct kobj_attribute str_current_val =
> +		__ATTR_RW(current_value);
> +
> +attribute_s_property_show(modifier, str);
> +struct kobj_attribute str_modifier =
> +		__ATTR_RO(modifier);
> +
> +attribute_n_property_show(min_length, str);
> +struct kobj_attribute str_min_length =
> +		__ATTR_RO(min_length);
> +
> +attribute_n_property_show(max_length, str);
> +struct kobj_attribute str_max_length =
> +		__ATTR_RO(max_length);
> +
> +static struct attribute *str_attrs[] = {
> +	&str_displ_langcode.attr,
> +	&str_displ_name.attr,
> +	&str_default_val.attr,
> +	&str_current_val.attr,
> +	&str_modifier.attr,
> +	&str_min_length.attr,
> +	&str_max_length.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group str_attr_group = {
> +	.attrs = str_attrs,
> +};
> +
> +int alloc_str_data(void)
> +{
> +	int ret = 0;
> +
> +	str_instances_count = get_instance_count(DELL_WMI_BIOS_STRING_ATTRIBUTE_GUID);
> +	str_data = kzalloc((sizeof(struct str_data) * str_instances_count), GFP_KERNEL);
> +	if (!str_data)
> +		ret = -ENOMEM;
> +	return ret;
> +}
> +
> +/**
> + * populate_enum_data() - Populate all properties of an instance under string attribute
> + * @str_obj: ACPI object with integer data
> + * @instance_id: The instance to enumerate
> + * @attr_name_kobj: The parent kernel object
> + **/
> +int populate_str_data(union acpi_object *str_obj, int instance_id, struct kobject *attr_name_kobj)
> +{
> +	int retval = sysfs_create_group(attr_name_kobj, &str_attr_group);
> +
> +	if (retval)
> +		goto out;
> +
> +	mutex_lock(&call_mutex);
> +	strncpy_attr(str_data[instance_id].attribute_name, str_obj[ATTR_NAME].string.pointer);
> +	strncpy_attr(str_data[instance_id].display_name_language_code,
> +		str_obj[DISPL_NAME_LANG_CODE].string.pointer);
> +	strncpy_attr(str_data[instance_id].display_name, str_obj[DISPLAY_NAME].string.pointer);
> +	strncpy_attr(str_data[instance_id].default_value, str_obj[DEFAULT_VAL].string.pointer);
> +	strncpy_attr(str_data[instance_id].current_value, str_obj[CURRENT_VAL].string.pointer);
> +	strncpy_attr(str_data[instance_id].modifier, str_obj[MODIFIER].string.pointer);
> +	str_data[instance_id].min_length = (uintptr_t)str_obj[MIN_LEN].string.pointer;
> +	str_data[instance_id].max_length = (uintptr_t) str_obj[MAX_LEN].string.pointer;
> +	mutex_unlock(&call_mutex);
> +
> +out:
> +	return retval;
> +}
> +
> +/**
> + * exit_str_attributes() - Clear all attribute data
> + * @kset: The kset to free
> + *
> + * Clears all data allocated for this group of attributes
> + **/
> +void exit_str_attributes(struct kset *kset)
> +{
> +	struct kobject *pos, *next;
> +
> +	mutex_lock(&list_mutex);
> +	list_for_each_entry_safe(pos, next, &kset->list, entry) {
> +		sysfs_remove_group(pos, &str_attr_group);
> +	}
> +	mutex_unlock(&list_mutex);
> +	mutex_lock(&call_mutex);
> +	kfree(str_data);
> +	mutex_unlock(&call_mutex);
> +}
> diff --git a/drivers/platform/x86/dell-wmi-sysman-attributes.c b/drivers/platform/x86/dell-wmi-sysman-attributes.c
> new file mode 100644
> index 000000000000..485545ab6c8b
> --- /dev/null
> +++ b/drivers/platform/x86/dell-wmi-sysman-attributes.c
> @@ -0,0 +1,575 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Common methods for use with dell-wmi-sysman
> + *
> + *  Copyright (c) 2020 Dell Inc.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/dmi.h>
> +#include <linux/wmi.h>
> +#include "dell-wmi-sysman-attributes.h"
> +
> +static DEFINE_MUTEX(call_mutex);
> +static DEFINE_MUTEX(list_mutex);
> +
> +#define MAX_TYPES  4
> +
> +static struct platform_device *platform_device;
> +
> +static struct platform_driver platform_driver = {
> +	.driver = {
> +		.name = DRIVER_NAME,
> +	},
> +};
> +
> +/* attribute directory under platform dev */
> +struct kset *main_dir_kset;
> +/* subtypes of attributes */
> +struct kset *type_dir_kset[MAX_TYPES];
> +
> +/* reset bios to defaults */
> +static const char * const reset_types[] = {"builtinsafe", "lastknowngood", "factory", "custom"};
> +static int reset_option = -1;
> +
> +/**
> + * populate_security_buffer() - builds a security buffer for authentication scheme
> + * @buffer: the buffer to populate
> + * @authentication: the authentication content
> + *
> + * Currently only supported type is PLAIN TEXT
> + **/
> +void populate_security_buffer(char *buffer, char *authentication)
> +{
> +	u32 *sectype = (u32 *) buffer;
> +	u32 *seclen = sectype + 1;
> +	char *auth = buffer + sizeof(u32)*2;
> +	/* plain text */
> +	*sectype = 1;
> +	*seclen = strlen(authentication);
> +	strncpy(auth, authentication, *seclen);
> +}
> +
> +/**
> + * map_wmi_error() - map errors from WMI methods to kernel error codes
> + **/
> +int map_wmi_error(int error_code)
> +{
> +	switch (error_code) {
> +	case 0:
> +		/* success */
> +		return 0;
> +	case 1:
> +		/* failed */
> +		return -EIO;
> +	case 2:
> +		/* invalid parameter */
> +		return -EINVAL;
> +	case 3:
> +		/* access denied */
> +		return -EACCES;
> +	case 4:
> +		/* not supported */
> +		return -EOPNOTSUPP;
> +	case 5:
> +		/* memory error */
> +		return -ENOMEM;
> +	case 6:
> +		/* protocol error */
> +		return -EPROTO;
> +	}
> +	/* unspecified error */
> +	return -EIO;
> +}
> +
> +/**
> + * reset_bios_show() - sysfs implementaton for read reset_bios
> + * @kobj: Kernel object for this attribute
> + * @attr: Kernel object attribute
> + * @buf: The buffer to display to userspace
> + **/
> +static ssize_t reset_bios_show(struct kobject *kobj, struct kobj_attribute *attr, char *buf)
> +{
> +	int i;
> +	char *start = buf;
> +
> +	for (i = 0; i < MAX_TYPES; i++) {
> +		if (i == reset_option)
> +			buf += sprintf(buf, "[%s] ", reset_types[i]);
> +		else
> +			buf += sprintf(buf, "%s ", reset_types[i]);
> +	}
> +	buf += sprintf(buf, "\n");
> +	return buf-start;
> +}
> +
> +/**
> + * reset_bios_store() - sysfs implementaton for write reset_bios
> + * @kobj: Kernel object for this attribute
> + * @attr: Kernel object attribute
> + * @buf: The buffer from userspace
> + * @count: the size of the buffer from userspace
> + **/
> +static ssize_t reset_bios_store(struct kobject *kobj,
> +				struct kobj_attribute *attr, const char *buf, size_t count)
> +{
> +	int len, ret, i;
> +	int type = -1;
> +	char *p;
> +
> +	p = memchr(buf, '\n', count);
> +	if (p != NULL)
> +		*p = '\0';
> +	len = p ? p - buf : count;
> +
> +	for (i = 0; i < MAX_TYPES; i++) {
> +		if (len == strlen(reset_types[i])
> +		    && !strncmp(buf, reset_types[i], len)) {
> +			type = i;
> +			break;
> +		}
> +	}
> +
> +	if (type < 0 || type >= MAX_TYPES) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	ret = set_bios_defaults(type);
> +	dev_dbg(&platform_device->dev, "reset all attributes request type %d: %d", type, ret);
> +	if (ret) {
> +		ret = -EINVAL;
> +	} else {
> +		reset_option = type;
> +		ret = count;
> +	}
> +
> +out:
> +	return ret;
> +}
> +
> +/**
> + * pending_reboot_show() - sysfs implementaton for read pending_reboot
> + * @kobj: Kernel object for this attribute
> + * @attr: Kernel object attribute
> + * @buf: The buffer to display to userspace
> + *
> + * Stores default value as 0
> + * When current_value is changed this attribute is set to 1 to notify reboot may be required
> + **/
> +static ssize_t pending_reboot_show(struct kobject *kobj, struct kobj_attribute *attr,
> +						char *buf)
> +{
> +	return sprintf(buf, "%d\n", get_pending_changes());
> +}
> +
> +static struct kobj_attribute reset_bios = __ATTR_RW(reset_bios);
> +static struct kobj_attribute pending_reboot = __ATTR_RO(pending_reboot);
> +
> +
> +/**
> + * create_reset_bios() - Creates reset_bios and pending_reboot attributes
> + **/
> +static int create_reset_bios(void)
> +{
> +	int ret = sysfs_create_file(&main_dir_kset->kobj, &reset_bios.attr);
> +
> +	if (ret) {
> +		dev_dbg(&platform_device->dev, "could not create reset_bios file");
> +		return ret;
> +	}
> +
> +	ret = sysfs_create_file(&main_dir_kset->kobj, &pending_reboot.attr);
> +	if (ret) {
> +		dev_dbg(&platform_device->dev, "could not create changing_pending_reboot file");
> +		sysfs_remove_file(&main_dir_kset->kobj, &reset_bios.attr);
> +	}
> +	return ret;
> +}
> +
> +static void release_reset_bios_data(void)
> +{
> +	sysfs_remove_file(&main_dir_kset->kobj, &reset_bios.attr);
> +	sysfs_remove_file(&main_dir_kset->kobj, &pending_reboot.attr);
> +}
> +
> +static ssize_t kobj_attr_show(struct kobject *kobj, struct attribute *attr,
> +			      char *buf)
> +{
> +	struct kobj_attribute *kattr;
> +	ssize_t ret = -EIO;
> +
> +	kattr = container_of(attr, struct kobj_attribute, attr);
> +	if (kattr->show)
> +		ret = kattr->show(kobj, kattr, buf);
> +	return ret;
> +}
> +
> +static ssize_t kobj_attr_store(struct kobject *kobj, struct attribute *attr,
> +			       const char *buf, size_t count)
> +{
> +	struct kobj_attribute *kattr;
> +	ssize_t ret = -EIO;
> +
> +	kattr = container_of(attr, struct kobj_attribute, attr);
> +	if (kattr->store)
> +		ret = kattr->store(kobj, kattr, buf, count);
> +	return ret;
> +}
> +
> +const struct sysfs_ops kobj_sysfs_ops = {
> +	.show	= kobj_attr_show,
> +	.store	= kobj_attr_store,
> +};
> +
> +static void attr_name_release(struct kobject *kobj)
> +{
> +	kfree(kobj);
> +}
> +
> +static struct kobj_type attr_name_ktype = {
> +	.release	= attr_name_release,
> +	.sysfs_ops	= &kobj_sysfs_ops,
> +};
> +
> +/**
> + * strncpy_attr - Copy a length-limited, NULL-terminated string with bound checks
> + * @dest: Where to copy the string to
> + * @src: Where to copy the string from
> + **/
> +void strncpy_attr(char *dest, char *src)
> +{
> +	size_t len = strlen(src) + 1;
> +
> +	if (len > 1 && len < MAX_BUFF)
> +		strncpy(dest, src, len);
> +}
> +
> +/**
> + * get_wmiobj_pointer() - Get Content of WMI block for particular instance
> + * @instance_id: WMI instance ID
> + * @guid_string: WMI GUID (in str form)
> + *
> + * Fetches the content for WMI block (instance_id) under GUID (guid_string)
> + * Caller must kfree the return
> + **/
> +union acpi_object *get_wmiobj_pointer(int instance_id, const char *guid_string)
> +{
> +	acpi_status status;
> +	struct acpi_buffer out = { ACPI_ALLOCATE_BUFFER, NULL };
> +
> +	status = wmi_query_block(guid_string, instance_id, &out);
> +
> +	return ACPI_SUCCESS(status) ? (union acpi_object *)out.pointer : NULL;
> +}
> +
> +/**
> + * get_instance_count() - Compute total number of instances under guid_string
> + * @guid_string: WMI GUID (in string form)
> + **/
> +int get_instance_count(const char *guid_string)
> +{
> +	int i = 0;
> +	union acpi_object *wmi_obj = NULL;
> +
> +	do {
> +		kfree(wmi_obj);
> +		wmi_obj = get_wmiobj_pointer(i, guid_string);
> +		i++;
> +	} while (wmi_obj);
> +
> +	return (i-1);
> +}
> +
> +/**
> + * alloc_attributes_data() - Allocate attributes data for a particular type
> + * @attr_type: Attribute type to allocate
> + **/
> +static int alloc_attributes_data(int attr_type)
> +{
> +	int retval = 0;
> +	char *type[MAX_TYPES] = {"enumeration", "integer", "string", "password"};
> +
> +	type_dir_kset[attr_type] = kset_create_and_add(type[attr_type], NULL, &main_dir_kset->kobj);
> +	if (!type_dir_kset[attr_type])
> +		goto err_bios_attr;
> +
> +	switch (attr_type) {
> +	case ENUM:
> +		retval = alloc_enum_data();
> +		break;
> +	case INT:
> +		retval = alloc_int_data();
> +		break;
> +	case STR:
> +		retval = alloc_str_data();
> +		break;
> +	case PO:
> +		retval = alloc_po_data();
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	goto out;
> +
> +err_bios_attr:
> +	kset_unregister(main_dir_kset);
> +
> +out:
> +	return retval;
> +}
> +
> +/**
> + * destroy_attribute_objs() - Free a kset of kobjects
> + * @kset: The kset to destroy
> + *
> + * Fress kobjects created for each attribute_name under attribute type kset
> + **/
> +static void destroy_attribute_objs(struct kset *kset)
> +{
> +	struct kobject *pos, *next;
> +
> +	mutex_lock(&list_mutex);
> +	list_for_each_entry_safe(pos, next, &kset->list, entry) {
> +		kobject_put(pos);
> +	}
> +	mutex_unlock(&list_mutex);
> +}
> +
> +/**
> + * release_attributes_data() - Clean-up all sysfs directories and files created
> + **/
> +static void release_attributes_data(void)
> +{
> +	release_reset_bios_data();
> +
> +	exit_enum_attributes(type_dir_kset[ENUM]);
> +	exit_int_attributes(type_dir_kset[INT]);
> +	exit_str_attributes(type_dir_kset[STR]);
> +	exit_po_attributes(type_dir_kset[PO]);
> +
> +	mutex_lock(&call_mutex);
> +	if (main_dir_kset) {
> +		int i;
> +
> +		/* unregister all 4 types ENUM,INT,STR and PO */
> +		for (i = ENUM; i <= PO; i++) {
> +			destroy_attribute_objs(type_dir_kset[i]);
> +			kset_unregister(type_dir_kset[i]);
> +		}
> +		kset_unregister(main_dir_kset);
> +	}
> +	mutex_unlock(&call_mutex);
> +}
> +
> +/**
> + * init_bios_attributes() - Initialize all attributes for a type
> + * @attr_type: The attribute type to initialize
> + * @guid: The WMI GUID associated with this type to initialize
> + *
> + * Initialiaze all 4 types of attributes enumeration, integer, string and password object.
> + * Populates each attrbute typ's respective properties under sysfs files
> + **/
> +static int init_bios_attributes(int attr_type, const char *guid)
> +{
> +	union acpi_object *obj = NULL;
> +	union acpi_object *elements;
> +	int retval = 0;
> +	int instance_id = 0;
> +	struct kobject *attr_name_kobj; //individual attribute names
> +
> +	retval = alloc_attributes_data(attr_type);
> +	if (retval)
> +		return retval;
> +	obj = get_wmiobj_pointer(instance_id, guid);
> +	if (!obj)
> +		return -ENODEV;
> +	elements = obj->package.elements;
> +
> +	while (elements) {
> +		/* sanity checking */
> +		if (strlen(elements[ATTR_NAME].string.pointer) == 0) {
> +			dev_dbg(&platform_device->dev, "empty attribute found");
> +			goto nextobj;
> +		}
> +		if (kset_find_obj(type_dir_kset[attr_type], elements[ATTR_NAME].string.pointer)) {
> +			dev_dbg(&platform_device->dev, "duplicate attribute name found - %s",
> +				elements[ATTR_NAME].string.pointer);
> +			goto nextobj;
> +		}
> +
> +		/* build attribute */
> +		attr_name_kobj = kzalloc(sizeof(*attr_name_kobj), GFP_KERNEL);
> +		if (!attr_name_kobj)
> +			goto err_attr_init;
> +
> +		attr_name_kobj->kset = type_dir_kset[attr_type];
> +
> +		retval = kobject_init_and_add(attr_name_kobj, &attr_name_ktype, NULL, "%s",
> +						elements[ATTR_NAME].string.pointer);
> +		if (retval) {
> +			kobject_put(attr_name_kobj);
> +			goto err_attr_init;
> +		}
> +
> +		/* enumerate all of this attribute */
> +		switch (attr_type) {
> +		case ENUM:
> +			retval = populate_enum_data(elements, instance_id, attr_name_kobj);
> +			break;
> +		case INT:
> +			retval = populate_int_data(elements, instance_id, attr_name_kobj);
> +			break;
> +		case STR:
> +			retval = populate_str_data(elements, instance_id, attr_name_kobj);
> +			break;
> +		case PO:
> +			retval = populate_po_data(elements, instance_id, attr_name_kobj);
> +			break;
> +		default:
> +			break;
> +		}
> +
> +		if (retval) {
> +			dev_dbg(&platform_device->dev, "failed to populate %s",
> +				elements[ATTR_NAME].string.pointer);
> +			goto err_attr_init;
> +		}
> +
> +nextobj:
> +		kfree(obj);
> +		instance_id++;
> +		obj = get_wmiobj_pointer(instance_id, guid);
> +		elements = obj ? obj->package.elements : NULL;
> +	}
> +
> +	goto out;
> +
> +err_attr_init:
> +	release_attributes_data();
> +	kfree(obj);
> +out:
> +	return retval;
> +}
> +
> +static int __init init_dell_bios_attrib_wmi(void)
> +{
> +	int ret = 0;
> +
> +	if (!dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "Dell System", NULL) &&
> +	    !dmi_find_device(DMI_DEV_TYPE_OEM_STRING, "www.dell.com", NULL)) {
> +		pr_err("Unable to run on non-Dell system\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = platform_driver_register(&platform_driver);
> +	if (ret)
> +		goto fail_platform_driver;
> +
> +	platform_device = platform_device_alloc(DRIVER_NAME, -1);
> +	if (!platform_device) {
> +		ret = -ENOMEM;
> +		goto fail_platform_device_alloc;
> +	}
> +
> +	ret = platform_device_add(platform_device);
> +	if (ret)
> +		goto fail_platform_device_add;
> +
> +	main_dir_kset = kset_create_and_add("attributes", NULL, &platform_device->dev.kobj);
> +	if (!main_dir_kset) {
> +		ret = -ENOMEM;
> +		goto fail_platform_device_add;
> +	}
> +
> +	ret = init_dell_wmi_bios_attr_set_interface();
> +	if (ret) {
> +		dev_dbg(&platform_device->dev, "failed to initialize set interface");
> +		goto fail_kset;
> +	}
> +
> +	ret = init_dell_wmi_bios_attr_pass_interface();
> +	if (ret) {
> +		dev_dbg(&platform_device->dev, "failed to initialize pass interface");
> +		goto fail_set_interface;
> +	}
> +
> +	ret = create_reset_bios();
> +	if (ret) {
> +		dev_dbg(&platform_device->dev, "could not create reset BIOS attribute");
> +		goto fail_pass_interface;
> +	}
> +
> +	ret = init_bios_attributes(ENUM, DELL_WMI_BIOS_ENUMERATION_ATTRIBUTE_GUID);
> +	if (ret) {
> +		dev_dbg(&platform_device->dev, "failed to populate enumeration type attributes");
> +		goto fail_create_group;
> +	}
> +
> +	ret = init_bios_attributes(INT, DELL_WMI_BIOS_INTEGER_ATTRIBUTE_GUID);
> +	if (ret) {
> +		dev_dbg(&platform_device->dev, "failed to populate integer type attributes");
> +		goto fail_create_group;
> +	}
> +
> +	ret = init_bios_attributes(STR, DELL_WMI_BIOS_STRING_ATTRIBUTE_GUID);
> +	if (ret) {
> +		dev_dbg(&platform_device->dev, "failed to populate string type attributes");
> +		goto fail_create_group;
> +	}
> +
> +	ret = init_bios_attributes(PO, DELL_WMI_BIOS_PASSOBJ_ATTRIBUTE_GUID);
> +	if (ret) {
> +		dev_dbg(&platform_device->dev, "failed to populate pass object type attributes");
> +		goto fail_create_group;
> +	}
> +
> +	return 0;
> +
> +fail_create_group:
> +	release_attributes_data();
> +	platform_device_del(platform_device);
> +
> +fail_pass_interface:
> +	exit_dell_wmi_bios_attr_pass_interface();
> +
> +fail_set_interface:
> +	exit_dell_wmi_bios_attr_set_interface();
> +
> +fail_kset:
> +	kset_unregister(main_dir_kset);
> +
> +fail_platform_device_add:
> +	platform_device_put(platform_device);
> +
> +fail_platform_device_alloc:
> +	platform_driver_unregister(&platform_driver);
> +
> +fail_platform_driver:
> +	return ret;
> +}
> +
> +static void __exit exit_dell_bios_attrib_wmi(void)
> +{
> +	release_attributes_data();
> +	mutex_lock(&call_mutex);
> +	exit_dell_wmi_bios_attr_set_interface();
> +	exit_dell_wmi_bios_attr_pass_interface();
> +	if (platform_device) {
> +		platform_device_unregister(platform_device);
> +		platform_driver_unregister(&platform_driver);
> +	}
> +	mutex_unlock(&call_mutex);
> +}
> +
> +module_init(init_dell_bios_attrib_wmi);
> +module_exit(exit_dell_bios_attrib_wmi);
> +
> +MODULE_AUTHOR("Mario Limonciello <mario.limonciello@dell.com>");
> +MODULE_AUTHOR("Prasanth Ksr <prasanth.ksr@dell.com>");
> +MODULE_AUTHOR("Divya Bharathi <divya.bharathi@dell.com>");
> +MODULE_DESCRIPTION("Dell platform setting control interface");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/platform/x86/dell-wmi-sysman-attributes.h b/drivers/platform/x86/dell-wmi-sysman-attributes.h
> new file mode 100644
> index 000000000000..bb5053b91ec7
> --- /dev/null
> +++ b/drivers/platform/x86/dell-wmi-sysman-attributes.h
> @@ -0,0 +1,125 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + * Definitions for kernel modules using Dell WMI System Management Driver
> + *
> + *  Copyright (c) 2020 Dell Inc.
> + */
> +
> +#ifndef _DELL_WMI_BIOS_ATTR_H_
> +#define _DELL_WMI_BIOS_ATTR_H_
> +
> +#include <linux/wmi.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/platform_device.h>
> +#include <linux/capability.h>
> +
> +#define DRIVER_NAME					"dell-wmi-sysman"
> +#define MAX_BUFF  512
> +
> +#define DELL_WMI_BIOS_ENUMERATION_ATTRIBUTE_GUID	"F1DDEE52-063C-4784-A11E-8A06684B9BF5"
> +#define DELL_WMI_BIOS_INTEGER_ATTRIBUTE_GUID		"F1DDEE52-063C-4784-A11E-8A06684B9BFA"
> +#define DELL_WMI_BIOS_STRING_ATTRIBUTE_GUID		"F1DDEE52-063C-4784-A11E-8A06684B9BF9"
> +#define DELL_WMI_BIOS_PASSOBJ_ATTRIBUTE_GUID		"0894B8D6-44A6-4719-97D7-6AD24108BFD4"
> +#define DELL_WMI_BIOS_ATTRIBUTES_INTERFACE_GUID		"F1DDEE52-063C-4784-A11E-8A06684B9BF4"
> +#define DELL_WMI_BIOS_PASSWORD_INTERFACE_GUID		"70FE8229-D03B-4214-A1C6-1F884B1A892A"
> +
> +enum { ENUM, INT, STR, PO };
> +
> +enum {
> +	ATTR_NAME,
> +	DISPL_NAME_LANG_CODE,
> +	DISPLAY_NAME,
> +	DEFAULT_VAL,
> +	CURRENT_VAL,
> +	MODIFIER
> +};
> +
> +#define get_instance_id(type)							\
> +int get_##type##_instance_id(struct kobject *kobj)				\
> +{										\
> +	int i;									\
> +	for (i = 0; i <= type##_instances_count; i++) {				\
> +		if (!(strcmp(kobj->name, type##_data[i].attribute_name)))	\
> +			return i;						\
> +	}									\
> +	return -EIO;								\
> +}
> +
> +#define attribute_s_property_show(name, type)					\
> +static ssize_t name##_show(struct kobject *kobj, struct kobj_attribute *attr,	\
> +			   char *buf)						\
> +{										\
> +	int i = get_##type##_instance_id(kobj);					\
> +	if (i >= 0)								\
> +		return sprintf(buf, "%s\n", type##_data[i].name);		\
> +	return 0;								\
> +}
> +
> +#define attribute_n_property_show(name, type)					\
> +static ssize_t name##_show(struct kobject *kobj, struct kobj_attribute *attr,	\
> +			   char *buf)						\
> +{										\
> +	int i = get_##type##_instance_id(kobj);					\
> +	if (i >= 0)								\
> +		return sprintf(buf, "%d\n", type##_data[i].name);		\
> +	return 0;								\
> +}
> +
> +#define attribute_property_store(curr_val, type)				\
> +static ssize_t curr_val##_store(struct kobject *kobj,				\
> +				struct kobj_attribute *attr,			\
> +				const char *buf, size_t count)			\
> +{										\
> +	char *p = memchr(buf, '\n', count);					\
> +	int ret = -EIO;								\
> +	int i;									\
> +										\
> +	if (p != NULL)								\
> +		*p = '\0';							\
> +	i = get_##type##_instance_id(kobj);					\
> +	if (i >= 0)								\
> +		ret = validate_##type##_input(i, buf);				\
> +	if (!ret)								\
> +		ret = set_attribute(kobj->name, buf);				\
> +	return ret ? ret : count;						\
> +}
> +
> +union acpi_object *get_wmiobj_pointer(int instance_id, const char *guid_string);
> +int get_instance_count(const char *guid_string);
> +void strncpy_attr(char *dest, char *src);
> +
> +int populate_enum_data(union acpi_object *enumeration_obj, int instance_id,
> +			struct kobject *attr_name_kobj);
> +int alloc_enum_data(void);
> +void exit_enum_attributes(struct kset *kset);
> +
> +int populate_int_data(union acpi_object *integer_obj, int instance_id,
> +			struct kobject *attr_name_kobj);
> +int alloc_int_data(void);
> +void exit_int_attributes(struct kset *kset);
> +
> +int populate_str_data(union acpi_object *str_obj, int instance_id, struct kobject *attr_name_kobj);
> +int alloc_str_data(void);
> +void exit_str_attributes(struct kset *kset);
> +
> +int populate_po_data(union acpi_object *po_obj, int instance_id, struct kobject *attr_name_kobj);
> +int alloc_po_data(void);
> +void exit_po_attributes(struct kset *kset);
> +
> +int set_attribute(const char *a_name, const char *a_value);
> +int set_bios_defaults(u8 defType);
> +
> +void exit_dell_wmi_bios_attr_set_interface(void);
> +int init_dell_wmi_bios_attr_set_interface(void);
> +bool get_pending_changes(void);
> +int map_wmi_error(int error_code);
> +void populate_security_buffer(char *buffer, char *authentication);
> +
> +char *get_current_password(const char *password_type);
> +int set_current_password(const char *password_type, const char *cur);
> +int set_new_password(const char *password_type, const char *new);
> +int init_dell_wmi_bios_attr_pass_interface(void);
> +void exit_dell_wmi_bios_attr_pass_interface(void);
> +
> +#endif
> 

