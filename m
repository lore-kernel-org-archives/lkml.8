Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FF1C2D0EC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 22:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDBE220747
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 22:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D6KaMiKT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgDGWYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 18:24:02 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26200 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726530AbgDGWYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 18:24:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586298239;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jL2SlKj1gk+SXatVva+PLT8Nc9hxvdVqnXrq13Ge/nc=;
        b=D6KaMiKT4iUPhU+ga2XLbUmrj/y2PD9rXwg8cnKg9POkMNx5QjWYR1J+gVEuJVXoIoebJR
        aX83pgWiKAteyryV3TCPVYXmTmHWjcoX6gBvXw93fDjQO5HF+wiJY5gWTcqagZDbSMZ+/x
        XyTAtb6c9dohBitk1zZv7uRGiespzcg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-0m3YYY18PROXGzFbuNyGtA-1; Tue, 07 Apr 2020 18:23:56 -0400
X-MC-Unique: 0m3YYY18PROXGzFbuNyGtA-1
Received: by mail-wr1-f69.google.com with SMTP id w12so2913740wrl.23
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 15:23:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jL2SlKj1gk+SXatVva+PLT8Nc9hxvdVqnXrq13Ge/nc=;
        b=a0O5Y/z5YskuGLknlxeZiOZyF3IJLKg/3jb3SoFYTK21j8AIgWbO2bykABpGr4CidA
         +eNTUVeo0MNiHUXU2o7C09LAGoDa46EU2s/I19ixbqGTizVZLKRIVgTSy9zifkLK9pzv
         ufI9UVAvmZZv7O1u9PIzULdPspzdgnLLew3XvrfRDKXfXWWFvdgAJQZENLBO3FU1ir7w
         WzMBsbuNv9uaCpNIpXBGboMYzpaITida1xBJjPWcuuGuCwP1diZpJja9u43VSfjgUkRm
         Mfu7FwxF+ThF5peM9XWdsiXq6YRnzYsbqFvrXaa7ucBRjk4ExTs3y1mGELYwnsFzO21O
         nldA==
X-Gm-Message-State: AGi0PuZpE+gAxsZxzdrivHcc3ttds5JP5VxsNYxGaKbieZA5VM3fMSNG
        ATh2fiMEL0xL10SZHd2XbZTP2MOd+y/EmcsuGk3htaUOIJsQrRpyt5NVF5mj/1jUFIL/B/dchsO
        QU15zpEH0TKfKxbU+mbRKhjIb
X-Received: by 2002:adf:9168:: with SMTP id j95mr4723928wrj.145.1586298234906;
        Tue, 07 Apr 2020 15:23:54 -0700 (PDT)
X-Google-Smtp-Source: APiQypL4WQ5BTkhOmSbeGTJVlGkzsuoHwtVtlTLcOKyFI5IwdvkPb/QQ9R8igODcabSrxvjJdF+oNQ==
X-Received: by 2002:adf:9168:: with SMTP id j95mr4723914wrj.145.1586298234661;
        Tue, 07 Apr 2020 15:23:54 -0700 (PDT)
Received: from shalem.localdomain (2001-1c00-0c0c-fe00-7e79-4dac-39d0-9c14.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:7e79:4dac:39d0:9c14])
        by smtp.gmail.com with ESMTPSA id h81sm4565064wme.42.2020.04.07.15.23.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 15:23:54 -0700 (PDT)
Subject: Re: [PATCH] platform/x86: intel_int0002_vgpio: Only bind to the
 INT0002 dev when using s2idle
To:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Maxim Mikityanskiy <maxtram95@gmail.com>,
        "5 . 3+" <stable@vger.kernel.org>
References: <20200407213058.62870-1-hdegoede@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <cfd3171a-94fb-7382-28e1-a236cb6759cc@redhat.com>
Date:   Wed, 8 Apr 2020 00:23:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200407213058.62870-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I just realized that I should have added a cover letter to this
patch to discuss how to merge it.

Rafael has already queued up the
"[PATCH v3 2/2] platform/x86: intel_int0002_vgpio: Use acpi_register_wakeup_handler()"
in his tree. Looking at both patches the parts of the file the
touch are different enough that that should not be a problem though.

So I guess this can go through platform/x86 as usual, or
(assuming everyone is ok with the change itself) alternatively
Rafael can take it to make sure there will be no conflicts?

Regards,

Hans


On 07-04-2020 23:30, Hans de Goede wrote:
> Commit 871f1f2bcb01 ("platform/x86: intel_int0002_vgpio: Only implement
> irq_set_wake on Bay Trail") stopped passing irq_set_wake requests on to
> the parents IRQ because this was breaking suspend (causing immediate
> wakeups) on an Asus E202SA.
> 
> This workaround for this issue is mostly fine, on most Cherry Trail
> devices where we need the INT0002 device for wakeups by e.g. USB kbds,
> the parent IRQ is shared with the ACPI SCI and that is marked as wakeup
> anyways.
> 
> But not on all devices, specifically on a Medion Akoya E1239T there is
> no SCI at all, and because the irq_set_wake request is not passed on to
> the parent IRQ, wake up by the builtin USB kbd does not work here.
> 
> So the workaround for the Asus E202SA immediate wake problem is causing
> problems elsewhere; and in hindsight it is not the correct fix,
> the Asus E202SA uses Airmont CPU cores, but this does not mean it is a
> Cherry Trail based device, Brasswell uses Airmont CPU cores too and this
> actually is a Braswell device.
> 
> Most (all?) Braswell devices use classic S3 mode suspend rather then
> s2idle suspend and in this case directly dealing with PME events as
> the INT0002 driver does likely is not the best idea, so that this is
> causing issues is not surprising.
> 
> Replace the workaround of not passing irq_set_wake requests on to the
> parents IRQ, by not binding to the INT0002 device when s2idle is not used.
> This fixes USB kbd wakeups not working on some Cherry Trail devices,
> while still avoiding mucking with the wakeup flags on the Asus E202SA
> (and other Brasswell devices).
> 
> Cc: Maxim Mikityanskiy <maxtram95@gmail.com>
> Cc: 5.3+ <stable@vger.kernel.org> # 5.3+
> Fixes: 871f1f2bcb01 ("platform/x86: intel_int0002_vgpio: Only implement irq_set_wake on Bay Trail")
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>   drivers/platform/x86/intel_int0002_vgpio.c | 18 +++++-------------
>   1 file changed, 5 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel_int0002_vgpio.c b/drivers/platform/x86/intel_int0002_vgpio.c
> index 55f088f535e2..e8bec72d3823 100644
> --- a/drivers/platform/x86/intel_int0002_vgpio.c
> +++ b/drivers/platform/x86/intel_int0002_vgpio.c
> @@ -143,21 +143,9 @@ static struct irq_chip int0002_byt_irqchip = {
>   	.irq_set_wake		= int0002_irq_set_wake,
>   };
>   
> -static struct irq_chip int0002_cht_irqchip = {
> -	.name			= DRV_NAME,
> -	.irq_ack		= int0002_irq_ack,
> -	.irq_mask		= int0002_irq_mask,
> -	.irq_unmask		= int0002_irq_unmask,
> -	/*
> -	 * No set_wake, on CHT the IRQ is typically shared with the ACPI SCI
> -	 * and we don't want to mess with the ACPI SCI irq settings.
> -	 */
> -	.flags			= IRQCHIP_SKIP_SET_WAKE,
> -};
> -
>   static const struct x86_cpu_id int0002_cpu_ids[] = {
>   	INTEL_CPU_FAM6(ATOM_SILVERMONT, int0002_byt_irqchip),	/* Valleyview, Bay Trail  */
> -	INTEL_CPU_FAM6(ATOM_AIRMONT, int0002_cht_irqchip),	/* Braswell, Cherry Trail */
> +	INTEL_CPU_FAM6(ATOM_AIRMONT, int0002_byt_irqchip),	/* Braswell, Cherry Trail */
>   	{}
>   };
>   
> @@ -181,6 +169,10 @@ static int int0002_probe(struct platform_device *pdev)
>   	if (!cpu_id)
>   		return -ENODEV;
>   
> +	/* We only need to directly deal with PMEs when using s2idle */
> +	if (!pm_suspend_default_s2idle())
> +		return -ENODEV;
> +
>   	irq = platform_get_irq(pdev, 0);
>   	if (irq < 0)
>   		return irq;
> 

