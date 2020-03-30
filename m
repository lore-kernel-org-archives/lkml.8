Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FEECC2D0F0
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 21:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64BB9206CC
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 21:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J45dZtK2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbgC3Vc6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 17:32:58 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:45909 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728754AbgC3Vc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 17:32:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585603975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6MH2PEZ2UCGNBdroKqcrjr4buAv1ci61sXu24hVxrP0=;
        b=J45dZtK2VE9IcnMDd/GBxlA3m/UrxIezaq/jKtlM+jUOuTcKr9urccKybkdtfcWwBBSypL
        9n64egyAjQbrDy+hc7vBN8CqzePCeUS/a/iMruteMdBrUH0iLW00bGtrOTbhB5rSOT8h8J
        y30cAp0BeSQjn76B+AEF9IqmnEJUF8Y=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-Ll1KKDgzPPyDeRX4XnlepA-1; Mon, 30 Mar 2020 17:32:50 -0400
X-MC-Unique: Ll1KKDgzPPyDeRX4XnlepA-1
Received: by mail-wr1-f71.google.com with SMTP id f15so12031809wrt.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 14:32:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6MH2PEZ2UCGNBdroKqcrjr4buAv1ci61sXu24hVxrP0=;
        b=N6SXxTrRQIlgZlIuneYlA1Z6SvPYGBAPv1yhNNgRQ1gzBw/ACmol5cuMRsIvai4wVA
         SYV8xEjH+9WgFUGLz5z1j0frGmR2/c7hzep+GfOnfcRk518uTNrdiLJ4Vf7sjdf9ZRgd
         DuJxgpxKnilobDfLjHncnnBKLwE9fNLqGMFPS14zNwYfOxkC5Inmmmyvw7DRBwi9mojC
         omlgWTZ23JIQDONFy1AzKdJCX2wLYj81up814ceprN5QeyVvhKNZi89pfaVSp0ltCnsE
         LhYQYGwdrntRMyfKxSc0T0zqLBYeqUoTWaI6WTHXfkibCMTP7xogFPJTQMScMfWe9rWI
         BmZQ==
X-Gm-Message-State: ANhLgQ2OQ9xXl/Ia0XkrN/JhVFJXuqCsUJqMfgg/Zc/8HLJj8bgQCLhC
        K7Pgd8+QCfMwfEdYOopvgh1bimFMhe7J9O8fFiWtPvSnNzDPEtOwaNH/iwIPoihZ7JgtJHyhyU3
        iVt9L0rqrGWZZXfiiYxwxV/Xi
X-Received: by 2002:a5d:6109:: with SMTP id v9mr17482950wrt.203.1585603968546;
        Mon, 30 Mar 2020 14:32:48 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvq1sRsnmZkQHsTrhozn1oQ4VTE5uwKFmrwFyUyydMsHQgFAYd/GlH3TA0vdk90t92KusM/Pw==
X-Received: by 2002:a5d:6109:: with SMTP id v9mr17482931wrt.203.1585603968322;
        Mon, 30 Mar 2020 14:32:48 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
        by smtp.gmail.com with ESMTPSA id r5sm1059011wmr.15.2020.03.30.14.32.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Mar 2020 14:32:47 -0700 (PDT)
Subject: Re: ACPI Video Driver creates backlight on desktop board
To:     Randy Dunlap <rdunlap@infradead.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <75866748-f574-ae50-6183-ef6892c935c5@molgen.mpg.de>
 <63956e11-46f2-72f4-c722-8fee2cbfbfa1@redhat.com>
 <9a934fe8-9279-094c-e589-9e439c000b04@infradead.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <3981bf9d-e721-628e-b88a-c75614a5cc64@redhat.com>
Date:   Mon, 30 Mar 2020 23:32:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <9a934fe8-9279-094c-e589-9e439c000b04@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/30/20 11:25 PM, Randy Dunlap wrote:
> On 3/30/20 1:51 PM, Hans de Goede wrote:
>> Hi,
>>
>> On 3/29/20 11:36 AM, Paul Menzel wrote:
>>> Dear Linux folks,
>>>
>>>
>>> On the MSI desktop board [1]
>>>
>>>       [    0.000000] DMI: Micro-Star International Co., Ltd. MS-7A37/B350M MORTAR (MS-7A37), BIOS 1.MR 12/02/2019
>>>
>>> with an AMD Ryzen 3 2200G with Radeon Vega Graphics, the ACPI Video Driver `video` is loaded and creates a backlight device.
>>>
>>>       $ readlink -f /sys/class/backlight/acpi_video0
>>>       /sys/devices/pci0000:00/0000:00:08.1/0000:26:00.0/backlight/acpi_video0
>>>
>>> I wonder what the driver is used for as the AMDGPU driver exists for the graphics device.
>>
>> Backlight on x86 hw is a bit of a mess, there is an ACPI standard for accessing it
>> and with older (Windows XP era) laptops that is the interface which usually works,
>> then there are a bunch of vendor specific SMBIOS or WMI backlight interfaces and
>> then there is the option of directly accessing the hardware as the amdgpu driver
>> is doing.
>>
>> We have a bunch of heuristics to avoid the acpi_video driver registering a
>> backlight interface when it should not, either because the direct hw access
>> should be used instead; or because there simply is no builtin LCD panel and thus
>> no backlight to control.
>>
>> These heuristics are failing on your board.
>>
>>> If it’s useful, is there a way to prevent the backlight interface from getting created?
>>
>> You can pass "acpi_backlight=ignore" on the kernel commandline to disable the
> 
> Hi Hans,
> Should that be "acpi_backlight=none"?  I don't see 'ignore' allowed here:
> 
> static void acpi_video_parse_cmdline(void)
> {
> 	if (!strcmp("vendor", acpi_video_backlight_string))
> 		acpi_backlight_cmdline = acpi_backlight_vendor;
> 	if (!strcmp("video", acpi_video_backlight_string))
> 		acpi_backlight_cmdline = acpi_backlight_video;
> 	if (!strcmp("native", acpi_video_backlight_string))
> 		acpi_backlight_cmdline = acpi_backlight_native;
> 	if (!strcmp("none", acpi_video_backlight_string))
> 		acpi_backlight_cmdline = acpi_backlight_none;
> }

Yes you are right that should be "acpi_backlight=none".

> and Documentation/admin-guide/kernel-parameters.txt could stand to be updated
> with a few of those options.

Ack, I've put this on my (much too long) TODO list. Feel free to
beat me to it.

Regards,

Hans




> 
> 
>> interface, this will stop e.g. gnome from showing a non working brightness
>> slider in its top right system menu.
>>
>> If this works you can make this permanent and avoid other users from having to
>> do the same thing by writing a patch adding a quirk for this like this one:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d21a91629f4b8e794fc4c0e0c17c85cedf1d806c
> 
> 

