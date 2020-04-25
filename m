Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC93C54FCB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 16:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5612F2071E
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 16:05:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DKJoCL5v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbgDYQFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 12:05:36 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31765 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726112AbgDYQFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 12:05:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587830733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xrOeXcOZqBMJ5lhnZJFD0uuCM8TXUygNv7A1BN4CiBk=;
        b=DKJoCL5vlVmJIfmBnEIShQ6mLc9XvTzR6SKKa22smTuXDgSQnV2cBaCL93Zsw4y7xs1/DS
        e2ySnBRRRXKsP39Folxk7KPpm90tGkvYWGEmMSsazmbztmzYoQfRHCwhLO4G1z2EVfU8qW
        9kXMLrOIbDTsHHGi0RkUd47U4Tn5WQU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-G5qncL3wN66ZV9_PWRadWg-1; Sat, 25 Apr 2020 12:05:32 -0400
X-MC-Unique: G5qncL3wN66ZV9_PWRadWg-1
Received: by mail-wm1-f69.google.com with SMTP id f17so6096643wmm.5
        for <linux-kernel@vger.kernel.org>; Sat, 25 Apr 2020 09:05:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xrOeXcOZqBMJ5lhnZJFD0uuCM8TXUygNv7A1BN4CiBk=;
        b=WYM/XG1UQzW0Dr9qooYc1dJla+ioTMVmP0kNI8v27WB6tI2OzKzfRq9LvBlIpuwQIA
         DhhgD47xMVSprYwa0qrKT+IcZNgBpD6+jznDgbAdpg8Umo0NvpUq7aBdDE0m2gy7gySc
         3MCXRBEpgW2XqSW9xLzJe4rX1K96P5WW1fB9gGEHu0tkLy3tyX4eUUjwajoaNqoI1ayF
         1O1QoKa3M1Kx0EWEzQobfzxle8UiRHuQqqknMcKs4vJFNg5Aj2NLlJKxbbAzAEtU8ETR
         8QhEuUECCXhakNE+IHOD0wU5DtijfOa8hHZiHkx+fKYrZ3HOgimXkgaS5tO83MxEh/gU
         OKUQ==
X-Gm-Message-State: AGi0PuZ/59VOv42z6fPIltiHMmp1LaruVutDuwTGpU9UB4lHMlSeWud4
        4B0JsKPuLquZn73De9xIUeaa4hWApKIg1giygckaeH5q/oBp5tgRh43NQvYTLO770RfTN7Yz2+5
        ZUnZM8BJEA3ZpJbpy+AzG/Jrd
X-Received: by 2002:a5d:6b8a:: with SMTP id n10mr17218851wrx.36.1587830729828;
        Sat, 25 Apr 2020 09:05:29 -0700 (PDT)
X-Google-Smtp-Source: APiQypLfb7IDIlJ1JC8QHKTgwWwjqVDic7ZRsRsH21HBmi+SnjB+9o/XXBreOEhEP/5q3L1PKRPDeg==
X-Received: by 2002:a5d:6b8a:: with SMTP id n10mr17218823wrx.36.1587830729566;
        Sat, 25 Apr 2020 09:05:29 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
        by smtp.gmail.com with ESMTPSA id v131sm7961138wmb.19.2020.04.25.09.05.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Apr 2020 09:05:28 -0700 (PDT)
Subject: Re: [PATCH v1 00/15] Add support for Nitro Enclaves
To:     Alexander Graf <graf@amazon.com>,
        "Paraschiv, Andra-Irina" <andraprs@amazon.com>,
        linux-kernel@vger.kernel.org
Cc:     Anthony Liguori <aliguori@amazon.com>,
        Benjamin Herrenschmidt <benh@amazon.com>,
        Colm MacCarthaigh <colmmacc@amazon.com>,
        Bjoern Doebel <doebel@amazon.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Frank van der Linden <fllinden@amazon.com>,
        Martin Pohlack <mpohlack@amazon.de>,
        Matt Wilson <msw@amazon.com>, Balbir Singh <sblbir@amazon.com>,
        Stewart Smith <trawets@amazon.com>,
        Uwe Dannowski <uwed@amazon.de>, kvm@vger.kernel.org,
        ne-devel-upstream@amazon.com
References: <20200421184150.68011-1-andraprs@amazon.com>
 <18406322-dc58-9b59-3f94-88e6b638fe65@redhat.com>
 <ff65b1ed-a980-9ddc-ebae-996869e87308@amazon.com>
 <2a4a15c5-7adb-c574-d558-7540b95e2139@redhat.com>
 <1ee5958d-e13e-5175-faf7-a1074bd9846d@amazon.com>
 <f560aed3-a241-acbd-6d3b-d0c831234235@redhat.com>
 <80489572-72a1-dbe7-5306-60799711dae0@amazon.com>
 <0467ce02-92f3-8456-2727-c4905c98c307@redhat.com>
 <5f8de7da-9d5c-0115-04b5-9f08be0b34b0@amazon.com>
 <095e3e9d-c9e5-61d0-cdfc-2bb099f02932@redhat.com>
 <602565db-d9a6-149a-0e1a-fe9c14a90ce7@amazon.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fb0bfd95-4732-f3c6-4a59-7227cf50356c@redhat.com>
Date:   Sat, 25 Apr 2020 18:05:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <602565db-d9a6-149a-0e1a-fe9c14a90ce7@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/20 21:11, Alexander Graf wrote:
> What I was saying above is that maybe code is easier to transfer that
> than a .txt file that gets lost somewhere in the Documentation directory
> :).

whynotboth.jpg :D

>>> To answer the question though, the target file is in a newly invented
>>> file format called "EIF" and it needs to be loaded at offset 0x800000 of
>>> the address space donated to the enclave.
>>
>> What is this EIF?
> 
> It's just a very dumb container format that has a trivial header, a
> section with the bzImage and one to many sections of initramfs.
> 
> As mentioned earlier in this thread, it really is just "-kernel" and
> "-initrd", packed into a single binary for transmission to the host.

Okay, got it.  So, correct me if this is wrong, the information that is
needed to boot the enclave is:

* the kernel, in bzImage format

* the initrd

* a consecutive amount of memory, to be mapped with
KVM_SET_USER_MEMORY_REGION

Off list, Alex and I discussed having a struct that points to kernel and
initrd off enclave memory, and have the driver build EIF at the
appropriate point in enclave memory (the 8 MiB ofset that you mentioned).

This however has two disadvantages:

1) having the kernel and initrd loaded by the parent VM in enclave
memory has the advantage that you save memory outside the enclave memory
for something that is only needed inside the enclave

2) it is less extensible (what if you want to use PVH in the future for
example) and puts in the driver policy that should be in userspace.


So why not just start running the enclave at 0xfffffff0 in real mode?
Yes everybody hates it, but that's what OSes are written against.  In
the simplest example, the parent enclave can load bzImage and initrd at
0x10000 and place firmware tables (MPTable and DMI) somewhere at
0xf0000; the firmware would just be a few movs to segment registers
followed by a long jmp.

If you want to keep EIF, we measured in QEMU that there is no measurable
difference between loading the kernel in the host and doing it in the
guest, so Amazon could provide an EIF loader stub at 0xfffffff0 for
backwards compatibility.

>> Again, I cannot provide a sensible review without explaining how to use
>> all this.  I understand that Amazon needs to do part of the design
>> behind closed doors, but this seems to have the resulted in issues that
>> reminds me of Intel's SGX misadventures. If Amazon has designed NE in a
>> way that is incompatible with open standards, it's up to Amazon to fix
> 
> Oh, if there's anything that conflicts with open standards here, I would
> love to hear it immediately. I do not believe in security by obscurity  :).

That's great to hear!

Paolo

