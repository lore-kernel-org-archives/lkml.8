Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C04CC54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 13:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3889E20724
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 13:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QhAYaITH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728325AbgDWNms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 09:42:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32652 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726224AbgDWNms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 09:42:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587649366;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s8mY2rn/o5PgRqmzsKGuM2heOpca4pruWT3S//ZWM58=;
        b=QhAYaITHBN2PJIjhej5rsLaPuqOJO6VADneb/CsZf5ao5zHV4PioI4LQN1dxCDlLfR/mt7
        lbTqB+AfkY4EDqXoQi16IET47wo9vgzzVRO0Mt4znwYlFbaGrAlAjaZBHhjE+c8lRq19r1
        zfWpvvqU6DQ5/6AKOj44fhBBmpea7pg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-OfvgsIWRNGCkuv9NxT3GTA-1; Thu, 23 Apr 2020 09:42:44 -0400
X-MC-Unique: OfvgsIWRNGCkuv9NxT3GTA-1
Received: by mail-wr1-f70.google.com with SMTP id f2so2875105wrm.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 06:42:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s8mY2rn/o5PgRqmzsKGuM2heOpca4pruWT3S//ZWM58=;
        b=rSGNupb2dfQHRFr6VuJFbOX5IWj84qfIJNyAXF3OxjXBFnKaARuvLwpgy2EzESSvbV
         TQKESq4NH7Fh23nIq69nervEEdKT7/YWUl8ETeuGgPaV5Izog/HRIY6wDZ5WWKLtCdCd
         ngUBrhFQ2Cv/QOnM4wnOAY14Yh5sYYSi95mVX9g0KTH4RI+zk6HWHM0RbsApLtCvXwCj
         Lm67Hf2+HzDZx7WMnkbq+l6aCy7pvNJwhyrO0JGcaT9p3PA1AyICfLY9hqR7fofad0hy
         SjkaKYxNM0IAg1nHzA6OoK6v6un5nbdIEFTemTd2xFcrTqYGqxfi8wyZodj5o4VG7/m9
         Cskw==
X-Gm-Message-State: AGi0PuZlu3Mf3RWiqvY5UhLKK37BlYo8KFIJ6sG6I4A68+iA6ql1z5p9
        Nf6IqPICv+SfK6ThZwWt1Y5Afv1QvYVo5LMUMz8C9Vz+HHtbbmXWDXpHy6d8jRmKvXK08hSmIMB
        EivqEweZ1WcznbMRePYvNpWmt
X-Received: by 2002:a1c:4e06:: with SMTP id g6mr4207892wmh.186.1587649363522;
        Thu, 23 Apr 2020 06:42:43 -0700 (PDT)
X-Google-Smtp-Source: APiQypJeG/VXq6ARfv2890od4ZJWB4JTV71/ar6c31Hg9pAVs35AePDHEEdIUg0k9R1thKyUDOc2hA==
X-Received: by 2002:a1c:4e06:: with SMTP id g6mr4207865wmh.186.1587649363165;
        Thu, 23 Apr 2020 06:42:43 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
        by smtp.gmail.com with ESMTPSA id v1sm3953028wrv.19.2020.04.23.06.42.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Apr 2020 06:42:42 -0700 (PDT)
Subject: Re: [PATCH v1 00/15] Add support for Nitro Enclaves
To:     "Paraschiv, Andra-Irina" <andraprs@amazon.com>,
        linux-kernel@vger.kernel.org
Cc:     Anthony Liguori <aliguori@amazon.com>,
        Benjamin Herrenschmidt <benh@amazon.com>,
        Colm MacCarthaigh <colmmacc@amazon.com>,
        Bjoern Doebel <doebel@amazon.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Frank van der Linden <fllinden@amazon.com>,
        Alexander Graf <graf@amazon.de>,
        Martin Pohlack <mpohlack@amazon.de>,
        Matt Wilson <msw@amazon.com>, Balbir Singh <sblbir@amazon.com>,
        Stewart Smith <trawets@amazon.com>,
        Uwe Dannowski <uwed@amazon.de>, kvm@vger.kernel.org,
        ne-devel-upstream@amazon.com
References: <20200421184150.68011-1-andraprs@amazon.com>
 <18406322-dc58-9b59-3f94-88e6b638fe65@redhat.com>
 <ff65b1ed-a980-9ddc-ebae-996869e87308@amazon.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2a4a15c5-7adb-c574-d558-7540b95e2139@redhat.com>
Date:   Thu, 23 Apr 2020 15:42:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <ff65b1ed-a980-9ddc-ebae-996869e87308@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/04/20 15:19, Paraschiv, Andra-Irina wrote:
> 2. The enclave itself - a VM running on the same host as the primary VM
> that spawned it.
> 
> The enclave VM has no persistent storage or network interface attached,
> it uses its own memory and CPUs + its virtio-vsock emulated device for
> communication with the primary VM.
> 
> The memory and CPUs are carved out of the primary VM, they are dedicated
> for the enclave. The Nitro hypervisor running on the host ensures memory
> and CPU isolation between the primary VM and the enclave VM.
> 
> These two components need to reflect the same state e.g. when the
> enclave abstraction process (1) is terminated, the enclave VM (2) is
> terminated as well.
> 
> With regard to the communication channel, the primary VM has its own
> emulated virtio-vsock PCI device. The enclave VM has its own emulated
> virtio-vsock device as well. This channel is used, for example, to fetch
> data in the enclave and then process it. An application that sets up the
> vsock socket and connects or listens, depending on the use case, is then
> developed to use this channel; this happens on both ends - primary VM
> and enclave VM.
> 
> Let me know if further clarifications are needed.

Thanks, this is all useful.  However can you please clarify the
low-level details here?

>> - the initial CPU state: CPL0 vs. CPL3, initial program counter, etc.
>> - the communication channel; does the enclave see the usual local APIC
>> and IOAPIC interfaces in order to get interrupts from virtio-vsock, and
>> where is the virtio-vsock device (virtio-mmio I suppose) placed in
>> memory?
>> - what the enclave is allowed to do: can it change privilege levels,
>> what happens if the enclave performs an access to nonexistent memory,
>> etc.
>> - whether there are special hypercall interfaces for the enclave

Thanks,

Paolo

