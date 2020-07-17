Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58557C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 19:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B4E62070E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 19:52:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbgGQTwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 15:52:19 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:45182 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728291AbgGQTwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 15:52:18 -0400
Received: from mail-pf1-f200.google.com ([209.85.210.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <alex.hung@canonical.com>)
        id 1jwWP1-0005bp-Ms
        for linux-kernel@vger.kernel.org; Fri, 17 Jul 2020 19:52:15 +0000
Received: by mail-pf1-f200.google.com with SMTP id h75so7573543pfe.23
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 12:52:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CAr/PZNCVVXHi2XM5sV5Vjv9LxoATUMG734KVRfdoVY=;
        b=lKK9o9oyF7jMl97si7IVE6wcaOuc8MHl8VFJrDpnOhZmMMA8my4fEaPItpajiII0Jt
         J1Y0kjPoZu9WMGACuD7J/7jSqvUyQM+pd0tCD2eT9/Iqra9Qic/f766IKVlr5etZPTuo
         3Du5Cl1KLWIqP/Bt9S4qw0HOKAmrLWxPJUEZdBNJmloaw60LtcByMX4KQjhvsrcoyRK1
         0IbfMZIax34wplypTu+Bp1CqcZ/wV67zFdoA1GFFui6RMxNecUKGKf+otrYNVA5EF3W1
         8D92Ig/3sKzRQNERxtxtmLeLUGZorK3hV5hNBrOxKLv8OTXOGZFqAIeIV/Sz6Enkyvch
         DkEg==
X-Gm-Message-State: AOAM530RHOnytfvre2HQC55Zg+VtvbxQnh9vkY5QqACJgDz5qpAs8pAs
        7JFvL64GL4oaJdyXruB/QZ/OQg4x6wKmXO9W3KAftjDHAebOkNuoFWD/VF/VxSDYe0V2cWKH42h
        x8n7VPRYlC/SirzUJfeN4nbtSHvKDU0LHWaqL49MYzg==
X-Received: by 2002:aa7:948c:: with SMTP id z12mr9462515pfk.47.1595015534157;
        Fri, 17 Jul 2020 12:52:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzF78FcXCHrTAzm5SmDiVs60gWF5qYGsvPUKF/R7mEJtjZqtf1yjMbW37ZZ3kS+Mkgqg35euA==
X-Received: by 2002:aa7:948c:: with SMTP id z12mr9462501pfk.47.1595015533842;
        Fri, 17 Jul 2020 12:52:13 -0700 (PDT)
Received: from [192.168.0.119] (d66-222-144-129.abhsia.telus.net. [66.222.144.129])
        by smtp.gmail.com with ESMTPSA id o23sm8923638pfd.126.2020.07.17.12.52.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2020 12:52:13 -0700 (PDT)
Subject: Re: [PATCH] RFC: ACPI / OSI: remove workarounds for hybrid graphics
 laptops
To:     Karol Herbst <kherbst@redhat.com>, linux-acpi@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lyude Paul <lyude@redhat.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        nouveau@lists.freedesktop.org
References: <20200717190547.648604-1-kherbst@redhat.com>
From:   Alex Hung <alex.hung@canonical.com>
Message-ID: <e7a8cb3a-e9f8-b78a-93f0-c09e5eb5ed10@canonical.com>
Date:   Fri, 17 Jul 2020 13:52:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200717190547.648604-1-kherbst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-17 1:05 p.m., Karol Herbst wrote:
> It's hard to figure out what systems are actually affected and right now I
> don't see a good way of removing those...
> 
> But I'd like to see thos getting removed and drivers fixed instead (which
> happened at least for nouveau).
> 
> And as mentioned before, I prefer people working on fixing issues instead
> of spending time to add firmware level workarounds which are hard to know
> to which systems they apply to, hard to remove and basically a big huge
> pain to work with.> In the end I have no idea how to even figure out what systems are affected
> and which not by this, so I have no idea how to even verify we can safely
> remove this (which just means those are impossible to remove unless we risk
> breaking systems, which again makes those supper annoying to deal with).
> 
> Also from the comments it's hard to get what those bits really do. Are they
> just preventing runtime pm or do the devices are powered down when booting?
> I am sure it's the former, still...
> 
> Please, don't do this again.
> 
> For now, those workaround prevent power savings on systems those workaround
> applies to, which might be any so those should get removed asap and if
> new issues arrise removing those please do a proper bug report and we can
> look into it and come up with a proper fix (and keep this patch out until
> we resolve all of those).
> 
> Signed-off-by: Karol Herbst <kherbst@redhat.com>
> CC: Alex Hung <alex.hung@canonical.com>
> CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> CC: Len Brown <lenb@kernel.org>
> CC: Lyude Paul <lyude@redhat.com>
> CC: linux-kernel@vger.kernel.org
> CC: dri-devel@lists.freedesktop.org
> CC: nouveau@lists.freedesktop.org
> ---
>  drivers/acpi/osi.c | 24 ------------------------
>  1 file changed, 24 deletions(-)
> 
> diff --git a/drivers/acpi/osi.c b/drivers/acpi/osi.c
> index 9f68538091384..d4405e1ca9b97 100644
> --- a/drivers/acpi/osi.c
> +++ b/drivers/acpi/osi.c
> @@ -44,30 +44,6 @@ osi_setup_entries[OSI_STRING_ENTRIES_MAX] __initdata = {
>  	{"Processor Device", true},
>  	{"3.0 _SCP Extensions", true},
>  	{"Processor Aggregator Device", true},
> -	/*
> -	 * Linux-Dell-Video is used by BIOS to disable RTD3 for NVidia graphics
> -	 * cards as RTD3 is not supported by drivers now.  Systems with NVidia
> -	 * cards will hang without RTD3 disabled.
> -	 *
> -	 * Once NVidia drivers officially support RTD3, this _OSI strings can
> -	 * be removed if both new and old graphics cards are supported.
> -	 */
> -	{"Linux-Dell-Video", true},
> -	/*
> -	 * Linux-Lenovo-NV-HDMI-Audio is used by BIOS to power on NVidia's HDMI
> -	 * audio device which is turned off for power-saving in Windows OS.
> -	 * This power management feature observed on some Lenovo Thinkpad
> -	 * systems which will not be able to output audio via HDMI without
> -	 * a BIOS workaround.
> -	 */
> -	{"Linux-Lenovo-NV-HDMI-Audio", true},
> -	/*
> -	 * Linux-HPI-Hybrid-Graphics is used by BIOS to enable dGPU to
> -	 * output video directly to external monitors on HP Inc. mobile
> -	 * workstations as Nvidia and AMD VGA drivers provide limited
> -	 * hybrid graphics supports.
> -	 */
> -	{"Linux-HPI-Hybrid-Graphics", true},
>  };
>  
>  static u32 acpi_osi_handler(acpi_string interface, u32 supported)
> 

The changes were discussed and tested a while ago, and no crashes were
observed. Thanks for solving PM issues in nouveau.

Acked-by: Alex Hung <alex.hung@canonical.com>
