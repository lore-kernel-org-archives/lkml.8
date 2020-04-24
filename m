Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1219BC54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 16:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA1B32071E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 16:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WbH8cdbD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbgDXQ17 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 12:27:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46269 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726908AbgDXQ15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 12:27:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587745676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sqa2zwpSHX/aXBjtwrDIW+4Ig2oY54LeCCkYHCPqKQY=;
        b=WbH8cdbDGB8rTyog55Tt3rseHuLDUFPR9n8tS6YfkOc2ixsDOIdS3si6OTuwF79l3l1LcJ
        ab4P4HtAS3XAvcK4B2Iw+uHEzLyMXU8mFB/eM6SulqgJ+j8c0fEHT6/JiHeFRjkDf+sAtL
        PQYHQ80TaiFerQhsgQ7TtNJovtwTnfc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-sRlwYJKmP8ObAq_ruuZ2yA-1; Fri, 24 Apr 2020 12:27:54 -0400
X-MC-Unique: sRlwYJKmP8ObAq_ruuZ2yA-1
Received: by mail-wm1-f69.google.com with SMTP id h184so4044873wmf.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 09:27:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Sqa2zwpSHX/aXBjtwrDIW+4Ig2oY54LeCCkYHCPqKQY=;
        b=cZRoerR5hizambH29biRPA6rs/fSzrWULGSE6fuboC1AB3mJX4sRBADf2rN64fFA9T
         pG+99cVYv02ijnt2BKVBUUv7SyBtCYF3k93WbYFkTKd4r2vi5AgYZTC7TEzJqSZAy7MH
         Q5JQclV9MrND8xROXFdl2jmNCDJGC1n/xtGGtAgFxtHfwQXGZiYOjnuLr8XrsENf9MiS
         SWj9VU52DSW22RJUMJUdw9asoz5/A7DFEa6bFizGRwAA2nz6XpOQO/3FVU6FHst+PN7q
         FO8fHyOsBg9qclZgkMjc0Sj13CRFkD76OqTzkeZX7r8ZiKyv7+VSc+YsKu8Y94UwDVoh
         7SZQ==
X-Gm-Message-State: AGi0Pub1JA5nTrMyi0DqkxV59fmyExGMrDaI1+GgtxLaErADAWzoScqc
        z5sPAgSZ+iHsjYB37QshKvEUwnGIeXQF0x5xxoCbsvCM4980bItghnL/wkow2MgualNFh8cVhls
        XtYHAZSBsT3zPU0yTJOWvkLzp
X-Received: by 2002:adf:f1c6:: with SMTP id z6mr4968449wro.361.1587745670674;
        Fri, 24 Apr 2020 09:27:50 -0700 (PDT)
X-Google-Smtp-Source: APiQypIHstS4mrgHIDeQ+fTnoYDfe+UHEdeBZBtwXAhvHQPJTVKOCiAjlm0h5Fan95TAEh8l+gYMmg==
X-Received: by 2002:adf:f1c6:: with SMTP id z6mr4968408wro.361.1587745670416;
        Fri, 24 Apr 2020 09:27:50 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
        by smtp.gmail.com with ESMTPSA id y10sm3443488wma.5.2020.04.24.09.27.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2020 09:27:49 -0700 (PDT)
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
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <095e3e9d-c9e5-61d0-cdfc-2bb099f02932@redhat.com>
Date:   Fri, 24 Apr 2020 18:27:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <5f8de7da-9d5c-0115-04b5-9f08be0b34b0@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/20 14:56, Alexander Graf wrote:
> Yes, that part is not documented in the patch set, correct. I would
> personally just make an example user space binary the documentation for
> now. Later we will publish a proper device specification outside of the
> Linux ecosystem which will describe the register layout and image
> loading semantics in verbatim, so that other OSs can implement the
> driver too.

But this is not part of the device specification, it's part of the child
enclave view.  And in my opinion, understanding the way the child
enclave is programmed is very important to understand if Linux should at
all support this new device.

> To answer the question though, the target file is in a newly invented
> file format called "EIF" and it needs to be loaded at offset 0x800000 of
> the address space donated to the enclave.

What is this EIF?

* a new Linux kernel format?  If so, are there patches in flight to
compile Linux in this new format (and I would be surprised if they were
accepted, since we already have PVH as a standard way to boot
uncompressed Linux kernels)?

* a userspace binary (the CPL3 that Andra was referring to)?  In that
case what is the rationale to prefer it over a statically linked ELF binary?

* something completely different like WebAssembly?

Again, I cannot provide a sensible review without explaining how to use
all this.  I understand that Amazon needs to do part of the design
behind closed doors, but this seems to have the resulted in issues that
reminds me of Intel's SGX misadventures. If Amazon has designed NE in a
way that is incompatible with open standards, it's up to Amazon to fix
it for the patches to be accepted.  I'm very saddened to have to say
this, because I do love the idea.

Thanks,

Paolo

