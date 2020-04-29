Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1843C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:20:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AC902087E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 13:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iHHFUAkL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbgD2NUI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 09:20:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59107 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726765AbgD2NUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 09:20:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588166406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n1dpe2R+BaXjYKU81tW2AJJKUbU2yVflRAds1OeIUQA=;
        b=iHHFUAkLq5QB2yfKJQkqRgitGRPq3wiJ+jPr+OnuDQNJKn8P5Hpp2B1U5Qj0Rw7q6ZjsjZ
        M5Byum0GiDjJ848USIO8bmH/eyKT9W2yDgk6JgeHlKqMRHBYP4WipVSj/UN2B1BodGsWOx
        OzoqqnW63oI5Xz70zn/UU3smN4NIOUA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-t_G2QUbCP4St_-gQsXLiFQ-1; Wed, 29 Apr 2020 09:20:03 -0400
X-MC-Unique: t_G2QUbCP4St_-gQsXLiFQ-1
Received: by mail-wm1-f72.google.com with SMTP id f81so948441wmf.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 06:20:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=n1dpe2R+BaXjYKU81tW2AJJKUbU2yVflRAds1OeIUQA=;
        b=e2mhB0267FAXU9N8Q49bhRdXl5yQvpO5o4TeO/tB4D0cgjHweRdzZ6DuvsuToq4jmg
         xEG2814eVVy/70UXOe85ox43UrDcveFoOBejtEJwafNcLGZ0SHTlV2RFydHiO+dNODEq
         u6RGbLKvLFE7Hod5//SQsyssMqXQkEEThgLdQUKwNP4vapDEBikvcHGIJQkQfXCkZhqf
         eiWe/5U1sgPfa4Ktopm2Zy9s4In2F1PppYBgOHXiwgPobwsmf22dpTbeXUwnHe7X7GWf
         x1TfZbj0TeyugGguLYdQXNdKbkdNYJUXexApAwKkJ4CncXYqNbhAqZC2/pm0WMMDqjca
         iXRQ==
X-Gm-Message-State: AGi0PuYHd7aXX9Ev5P8xQR35H3kUyc+opoyWplOc/jx+gEgXgn5Npaxc
        enIhWeqZ9K8xu3uztQB8laNYhJsGDelbDYyOgOcO90lHwwS+jhliwPR0EVrxVSEfW99hrAfGC7z
        JL59SAH+HWF6A9ctcgfCM5HxS
X-Received: by 2002:a5d:650b:: with SMTP id x11mr38608010wru.405.1588166402525;
        Wed, 29 Apr 2020 06:20:02 -0700 (PDT)
X-Google-Smtp-Source: APiQypLLm8qn1Tw91phFnLxp2Md4CBWIVFhkVC0MYgra0vAWcDzU06OmfmNuwnFvZRprLFRjLESqcA==
X-Received: by 2002:a5d:650b:: with SMTP id x11mr38607988wru.405.1588166402233;
        Wed, 29 Apr 2020 06:20:02 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
        by smtp.gmail.com with ESMTPSA id s14sm8221183wme.33.2020.04.29.06.20.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2020 06:20:01 -0700 (PDT)
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
 <fb0bfd95-4732-f3c6-4a59-7227cf50356c@redhat.com>
 <0a4c7a95-af86-270f-6770-0a283cec30df@amazon.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ad01ef35-9ee5-cf94-640c-4c26184946fa@redhat.com>
Date:   Wed, 29 Apr 2020 15:20:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <0a4c7a95-af86-270f-6770-0a283cec30df@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/04/20 17:07, Alexander Graf wrote:
>> So why not just start running the enclave at 0xfffffff0 in real mode?
>> Yes everybody hates it, but that's what OSes are written against.  In
>> the simplest example, the parent enclave can load bzImage and initrd at
>> 0x10000 and place firmware tables (MPTable and DMI) somewhere at
>> 0xf0000; the firmware would just be a few movs to segment registers
>> followed by a long jmp.
> 
> There is a bit of initial attestation flow in the enclave, so that
> you can be sure that the code that is running is actually what you wanted to
> run.

Can you explain this, since it's not documented?

>   vm = ne_create(vcpus = 4)
>   ne_set_memory(vm, hva, len)
>   ne_load_image(vm, addr, len)
>   ne_start(vm)
> 
> That way we would get the EIF loading into kernel space. "LOAD_IMAGE"
> would only be available in the time window between set_memory and start.
> It basically implements a memcpy(), but it would completely hide the
> hidden semantics of where an EIF has to go, so future device versions
> (or even other enclave implementers) could change the logic.
> 
> I think it also makes sense to just allocate those 4 ioctls from
> scratch. Paolo, would you still want to "donate" KVM ioctl space in that
> case?

Sure, that's not a problem.

Paolo

> Overall, the above should address most of the concerns you raised in
> this mail, right? It still requires copying, but at least we don't have
> to keep the copy in kernel space.

