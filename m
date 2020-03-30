Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F37AC2D0F0
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 20:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED5B8206CC
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 20:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RA3/bv5T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728530AbgC3UvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 16:51:13 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:56631 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728385AbgC3UvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 16:51:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585601472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=odm2BtAQUnUT8zj+digzS3rtXLQBUeiDF1C1EBhIhHQ=;
        b=RA3/bv5TQr8HDE7WyyarHnuCUM4koFDpCep1i4vDRDdt9buYx/m8zjjFpMoxpEIsBFJq9O
        +i+fhstPGhiBW2xPo2yzvYRNOX9Uv3EqnOH5Tkt31weNwJHL2rnt6/DHEMSpGNYZf9gpGb
        BZGLBA9nDAQxqJFZ3BJAtMsaC2oYvLA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-174-ALQCKq1iOoWd3jt9UrvFgw-1; Mon, 30 Mar 2020 16:51:04 -0400
X-MC-Unique: ALQCKq1iOoWd3jt9UrvFgw-1
Received: by mail-wr1-f71.google.com with SMTP id c8so10015046wru.20
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 13:51:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=odm2BtAQUnUT8zj+digzS3rtXLQBUeiDF1C1EBhIhHQ=;
        b=Y0NkqtnQUA3NUvCV/S5xxKQCpDfBE2gKy/W3XN68SZd4BQ8hsl0phWNgd2m3Qnu9rU
         fX7OTNMHMZoskYAEbpJe2/jxPu4BHUVmFkXwRmQ6hDZyGv+kZEva1S6mY7Vq1ZFavi/G
         Lka+l2xRlKROunM6JjYd8S/xVwC7B86N9kWnIRXvAXGWXnOcT89ZaBuJJkPOkmxTyvF/
         9ib290LWuTKvgVbuqVS1zMjiCoOHaJIqxeH3u6YmNPdZ0fqeinZo76WVXyYFak+Uvy8E
         oZniYaxm0HVUA16VsmkVpPjacpQ65I/m7ygTSZ+0QzASyZvWRM6G6A33BF9OaVObu4yj
         CUCQ==
X-Gm-Message-State: ANhLgQ1CZchJoXtPeqlqkyeMxCzge+F8wWC7fVghqEpmrbo44KMvJFPe
        nTlNyGdJ8Mea3/kroCOTKTDRWre0xAwlZOOen+F/qvLmXZRg1sXMPdR+iUGg0L8kNB5fLkYKNO/
        ncvPc/54V08v3OUZxrZTf/qAP
X-Received: by 2002:adf:bb4c:: with SMTP id x12mr16140812wrg.137.1585601462961;
        Mon, 30 Mar 2020 13:51:02 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsivJs4jCKEDqtzyiapgH6FhTN+YcSjT2DE+4y/sRoMwbXGG618EuuJZHiMOPUt0GsirQs3Yw==
X-Received: by 2002:adf:bb4c:: with SMTP id x12mr16140799wrg.137.1585601462755;
        Mon, 30 Mar 2020 13:51:02 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
        by smtp.gmail.com with ESMTPSA id g128sm916407wmf.27.2020.03.30.13.51.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2020 13:51:02 -0700 (PDT)
Subject: Re: ACPI Video Driver creates backlight on desktop board
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <75866748-f574-ae50-6183-ef6892c935c5@molgen.mpg.de>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <63956e11-46f2-72f4-c722-8fee2cbfbfa1@redhat.com>
Date:   Mon, 30 Mar 2020 22:51:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <75866748-f574-ae50-6183-ef6892c935c5@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/29/20 11:36 AM, Paul Menzel wrote:
> Dear Linux folks,
> 
> 
> On the MSI desktop board [1]
> 
>      [    0.000000] DMI: Micro-Star International Co., Ltd. MS-7A37/B350M MORTAR (MS-7A37), BIOS 1.MR 12/02/2019
> 
> with an AMD Ryzen 3 2200G with Radeon Vega Graphics, the ACPI Video Driver `video` is loaded and creates a backlight device.
> 
>      $ readlink -f /sys/class/backlight/acpi_video0
>      /sys/devices/pci0000:00/0000:00:08.1/0000:26:00.0/backlight/acpi_video0
> 
> I wonder what the driver is used for as the AMDGPU driver exists for the graphics device.

Backlight on x86 hw is a bit of a mess, there is an ACPI standard for accessing it
and with older (Windows XP era) laptops that is the interface which usually works,
then there are a bunch of vendor specific SMBIOS or WMI backlight interfaces and
then there is the option of directly accessing the hardware as the amdgpu driver
is doing.

We have a bunch of heuristics to avoid the acpi_video driver registering a
backlight interface when it should not, either because the direct hw access
should be used instead; or because there simply is no builtin LCD panel and thus
no backlight to control.

These heuristics are failing on your board.

> If it’s useful, is there a way to prevent the backlight interface from getting created?

You can pass "acpi_backlight=ignore" on the kernel commandline to disable the
interface, this will stop e.g. gnome from showing a non working brightness
slider in its top right system menu.

If this works you can make this permanent and avoid other users from having to
do the same thing by writing a patch adding a quirk for this like this one:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d21a91629f4b8e794fc4c0e0c17c85cedf1d806c

Regards,

Hans

