Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC43C2BA1B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 19:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 110322075E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 19:44:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AlRqz4ZL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730135AbgDHTor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 15:44:47 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53970 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726795AbgDHTor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 15:44:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586375085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mYYuwLAboUvtz1WhP7yhVmIyNIoHfRUcQsmccBnO09E=;
        b=AlRqz4ZLCfT77TTOQwYYfWq0/Tj3uPR+j5Ovkx2d9Z9WOnkffGsqUBkWO2MS8O5GXfIxa3
        YArbJSzTO63xQIV+WKj/H2ZiEyLYEw+W8KREimMmFdZpOk4Kt1o/9T6JoIHvGbcoagmN1o
        Nzx0z2jzKOlAwDMODoxKdDUV6ewfMP8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-xWW0TEgYMK2xCORtS4aVFg-1; Wed, 08 Apr 2020 15:44:41 -0400
X-MC-Unique: xWW0TEgYMK2xCORtS4aVFg-1
Received: by mail-wm1-f69.google.com with SMTP id d134so954146wmd.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 12:44:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=mYYuwLAboUvtz1WhP7yhVmIyNIoHfRUcQsmccBnO09E=;
        b=cX/oBXH9FYP8kIGETnAROTcIj8deNHctRWD04uuPA1SBlvISkvMfT/XX+zv2gJbDvG
         Ogzm/AbnlhSIO/UVCwRDor3dHtuBIfIONWROfen0vZfzgTuoQL/A0FTEimOsgiuxD+YQ
         9zRwJV0XoM0Wv2x1k/QAaCF27G/BugL0Ca7BBEEyDp/5jAOu9penLCxSoYAWidAPtSEY
         HUCh0S4xzHcMUvVFZm/GaEnMm3HVKbU/qhVijzPtbJGAybV5CwyBDPoOPYkuKT/erQ6y
         yy3eRkuvTUPh4tliXRHIXsmkoKopq5hvdP9Iuykf4/ktXY/qPO5rIqiWfAsQ1/IDXw2t
         KOCQ==
X-Gm-Message-State: AGi0PuY1LqNVxSTokv85VuIYd5Q0J+XmNTuRJcG9CWoellyl44k0pe3q
        C+9DFQfB/ZIxcIfP9Vm9GH6NxpfnZCe29gtOBw02to/JfG+mAcq2JsZb5R9LAbmmuZwE6zrlSSo
        RU9Cl9xOkyc4qJsdOHBJOmlbe
X-Received: by 2002:a5d:66c4:: with SMTP id k4mr10871377wrw.53.1586375080349;
        Wed, 08 Apr 2020 12:44:40 -0700 (PDT)
X-Google-Smtp-Source: APiQypIlH1aPoYyskSLdulU2tyWq3L8x3JFlR6vFlGhIt4V5eB9TSlTUoLEINUgOmGMdu27vvjmcVQ==
X-Received: by 2002:a5d:66c4:: with SMTP id k4mr10871361wrw.53.1586375080112;
        Wed, 08 Apr 2020 12:44:40 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id u7sm724203wmg.41.2020.04.08.12.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 12:44:39 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        dzickus@redhat.com, dyoung@redhat.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [PATCH v2 0/3] KVM: VMX: Fix for kexec VMCLEAR and VMXON cleanup
In-Reply-To: <20200408151808.GS2402@MiWiFi-R3L-srv>
References: <20200321193751.24985-1-sean.j.christopherson@intel.com> <20200407110115.GA14381@MiWiFi-R3L-srv> <87r1wzlcwn.fsf@vitty.brq.redhat.com> <20200408151808.GS2402@MiWiFi-R3L-srv>
Date:   Wed, 08 Apr 2020 21:44:37 +0200
Message-ID: <87mu7l2256.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Baoquan He <bhe@redhat.com> writes:

> On 04/07/20 at 02:04pm, Vitaly Kuznetsov wrote:
>> Baoquan He <bhe@redhat.com> writes:
>> 
>> >
>> > The trace is here. 
>> >
>> > [  132.480817] RIP: 0010:crash_vmclear_local_loaded_vmcss+0x57/0xd0 [kvm_intel] 
>> 
>> This is a known bug,
>> 
>> https://lore.kernel.org/kvm/20200401081348.1345307-1-vkuznets@redhat.com/
>
> Thanks for telling, Vitaly.
>
> I tested your patch, it works.
>
> One thing is I noticed a warning message when your patch is applied. When
> I changed back to revert this patchset, didn't found this message. I didn't
> look into the detail of network core code and the kvm vmx code, maybe it's
> not relevant.
>
>
> [ 3708.629234] Type was not set for devlink port.
> [ 3708.629258] WARNING: CPU: 3 PID: 60 at net/core/devlink.c:7164 devlink_port_type_warn+0x11/0x20
> [ 3708.632328] Modules linked in: rfkill sunrpc intel_powerclamp coretemp kvm_intel kvm irqbypass intel_cstate iTCO_wdt hpwdt intel_uncore gpio_ich iTCO_vendor_support pcspkr ipmi_ssif hpilo lpc_ich ipmi_si ipmi_devintf ipmi_msghandler acpi_power_meter pcc_cpufreq i7core_edac ip_tables xfs libcrc32c radeon i2c_algo_bit drm_kms_helper cec ttm crc32c_intel serio_raw drm ata_generic pata_acpi mlx4_core bnx2 hpsa scsi_transport_sas
> [ 3708.640782] CPU: 3 PID: 60 Comm: kworker/3:1 Kdump: loaded Tainted: G          I       5.6.0+ #1
> [ 3708.642715] Hardware name: HP ProLiant DL380 G6, BIOS P62 08/16/2015
> [ 3708.644222] Workqueue: events devlink_port_type_warn
> [ 3708.645349] RIP: 0010:devlink_port_type_warn+0x11/0x20

What's in the patchset you're testing? Is it Sean's series + my patch,
or just my patch? In case it's the later I'm having hard times trying to
see how this can be related, but in case it's the former the fact that
we do stuff a little bit differently on kexec may actually be triggering
the issue above. I still think that it's not causing it, just
triggering.

-- 
Vitaly

