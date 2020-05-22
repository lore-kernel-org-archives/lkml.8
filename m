Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DA22C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 10:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAE35206C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 10:14:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S1svQmb7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729688AbgEVKOk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 06:14:40 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37453 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729408AbgEVKOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 06:14:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590142474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FOU53/GKhFSDCFEqcsdErGmhyqCkF6RPDSEV44rw+e0=;
        b=S1svQmb7GbeElQZWCweru8nj3EaeQNQaWhwbbDm1Je6LbCOFIjvG+FAhRBlKqO69Zo/ApS
        2uPfqIht6edm52pDuWqMDlyhv0Kvry2IlNRlH4dVQDHyZrnWyaS4pSKQKBnnQFyF4K4i47
        xWqEqiA1ZTvxie3hjVvK2dKdIGtUebo=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-rgnwcaO-OR--Qhh4H6OJSw-1; Fri, 22 May 2020 06:14:32 -0400
X-MC-Unique: rgnwcaO-OR--Qhh4H6OJSw-1
Received: by mail-ej1-f70.google.com with SMTP id s13so4356105ejc.18
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 03:14:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FOU53/GKhFSDCFEqcsdErGmhyqCkF6RPDSEV44rw+e0=;
        b=toIrih+oIVT50mDiMuW3QqkJRe7RtJ/VM4oUZwySTVHs3jX00sKgUrRi8bfot/O8RA
         pIirBLg0GzTo25Eic6BVidHNMlxtb7kE3A2D2rzdL5PxGI1nwA6+dGZdNrPRrtdCTi1d
         PMcisJkuFb3GAE5vbjzIM8vUS+S5YdnQPqeyJBLZ8UQdl6952eSFVMODq8hSCYtx83UF
         9hL2rttV5uKDRCREXjSPl+BSUWxTDqzZTn107yd3RACu3Ai7l96GzZXyJW9qWC2s0nwD
         1xF/JHx4gR4kNfhDGVbh2Nan6Xp4Ao6c0jQJnQImE4I6wBT0LsKk3OhasmPseozF08sw
         MSdA==
X-Gm-Message-State: AOAM530i6BPuMWmG5wmwJlBaWdTQLmI577WJRO7u9WeEWPUPhmBqYxYb
        6HmMhgvpzqQk5jqtUZOs5NmsIyNBBdvdHosp4BzX1XqwuGgEI9urRUqtfKaZwCFYQWqgUxHzCKQ
        7XfesTlcDtaZYFSOGZ/4ymRV7
X-Received: by 2002:a05:6402:6c1:: with SMTP id n1mr2369037edy.199.1590142471174;
        Fri, 22 May 2020 03:14:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwfC34MCbCH6URcwA7zYGRshQKEBRWb6nEZHBKVgIxEDOg1wtlGa9fvkmr/88CXVhHVgbeeAw==
X-Received: by 2002:a05:6402:6c1:: with SMTP id n1mr2369020edy.199.1590142470804;
        Fri, 22 May 2020 03:14:30 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id fi9sm7342293ejb.5.2020.05.22.03.14.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 May 2020 03:14:29 -0700 (PDT)
Subject: Re: [PATCH] platform/x86: asus_wmi: Reserve more space for struct
 bias_args
To:     Chris Chiu <chiu@endlessm.com>, dvhart@infradead.org,
        andy@infradead.org, gregkh@linuxfoundation.org,
        gayatri.kammela@intel.com, mika.westerberg@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@endlessm.com
References: <20200522074424.54264-1-chiu@endlessm.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <370d5f70-cb37-3ac8-7a7e-97f215b0ad8a@redhat.com>
Date:   Fri, 22 May 2020 12:14:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200522074424.54264-1-chiu@endlessm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/22/20 9:44 AM, Chris Chiu wrote:
> On the ASUS laptop UX325JA/UX425JA, most of the media keys are not
> working due to the ASUS WMI driver fails to be loaded. The ACPI error
> as follows leads to the failure of asus_wmi_evaluate_method.
>    ACPI BIOS Error (bug): AE_AML_BUFFER_LIMIT, Field [IIA3] at bit offset/length 96/32 exceeds size of target Buffer (96 bits) (20200326/dsopcode-203)
>    No Local Variables are initialized for Method [WMNB]
>    ACPI Error: Aborting method \_SB.ATKD.WMNB due to previous error (AE_AML_BUFFER_LIMIT) (20200326/psparse-531)
> 
> The DSDT for the WMNB part shows that 5 DWORD required for local
> variables and the 3rd variable IIA3 hit the buffer limit.
> 
> Method (WMNB, 3, Serialized)
> { ..
>      CreateDWordField (Arg2, Zero, IIA0)
>      CreateDWordField (Arg2, 0x04, IIA1)
>      CreateDWordField (Arg2, 0x08, IIA2)
>      CreateDWordField (Arg2, 0x0C, IIA3)
>      CreateDWordField (Arg2, 0x10, IIA4)
>      Local0 = (Arg1 & 0xFFFFFFFF)
>      If ((Local0 == 0x54494E49))
>    ..
> }
> 
> The limitation is determined by the input acpi_buffer size passed
> to the wmi_evaluate_method. Since the struct bios_args is the data
> structure used as input buffer by default for all ASUS WMI calls,
> the size needs to be expanded to fix the problem.
> 
> Signed-off-by: Chris Chiu <chiu@endlessm.com>

Thank you, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>   drivers/platform/x86/asus-wmi.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index bb7c529d7d16..cd212ee210e2 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -116,6 +116,8 @@ struct bios_args {
>   	u32 arg0;
>   	u32 arg1;
>   	u32 arg2; /* At least TUF Gaming series uses 3 dword input buffer. */
> +	u32 arg4;
> +	u32 arg5;
>   } __packed;
>   
>   /*
> 

