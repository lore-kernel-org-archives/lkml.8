Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20D11C8300C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 11:58:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0B352078D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 11:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QjdzC+xT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbgD3L6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 07:58:22 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44424 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726413AbgD3L6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 07:58:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588247900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PwkVlLlTF6QMPUlS0NrS9fdfO5mc8bH+SjES/5fPWp0=;
        b=QjdzC+xT2f1d+EnrxUgCZILGUiCMQrwuqMVA4t8vQLwIqi61JF55x7Qha1IdEWuK6D9N47
        5JxWVcK7tv0DinU4Q4y3oj4b3ZQ8DTDkBB/v2ByRV7Kffw+94q/FigFFfvL9LjbWeuZo5N
        Pz0IqbyIXolsbRdq5+5jn/UXt3LD+0A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-Pkh3iidcPvajLB6mGZCJgQ-1; Thu, 30 Apr 2020 07:58:18 -0400
X-MC-Unique: Pkh3iidcPvajLB6mGZCJgQ-1
Received: by mail-wr1-f71.google.com with SMTP id q10so3740087wrv.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 04:58:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PwkVlLlTF6QMPUlS0NrS9fdfO5mc8bH+SjES/5fPWp0=;
        b=TOLE8SSN3/KfjYWZzxWCkGGy6EQFNuLXiZrd/7paPtUfLFRIk5qCVwnJwQKViJdGot
         SslvYeKrwdC4v87yqHKnrgpln94l8bBw7ZwVkQhxHdPHuFjjdffwrPDvgbnLbbaozNvz
         3OLXgZ1SSpY6PL4W2l76N06OSOhGvi24fnRWabeVHW9AluZbmb/Eqr2vR03criRbaG45
         PdDOAMHKwOUVefJSuO4sL/SNDKuAvfziacATrmByiXbt/I2pSSmzDRcQPaFg3tcpVIA4
         rjJN/g6t7zeo7FT/1n01AwbPmwh0PfjbYc1cK+9Pd8eUsa6hv3Ejhspeee8ePjJss9iF
         SJ/g==
X-Gm-Message-State: AGi0Pua4VmACtDZ5UkXXjL7G+fBzzDJD/lmz8aG9/L4ylAqMCfNzWNEw
        PpJ3M9lbYlomfaQ0ERJGgFPl8c+aYB5XX17UcWl8TnesCX/8tvr+GCqyiEQNMk7eakbLPypEhcd
        X7iitJvFl0U/1VZTptoc2Q2tH
X-Received: by 2002:adf:ce0d:: with SMTP id p13mr3952868wrn.66.1588247897407;
        Thu, 30 Apr 2020 04:58:17 -0700 (PDT)
X-Google-Smtp-Source: APiQypJed6abco1HDellE1WqxYwYzBLnxa31uFxiz2O4UjVM2SCevc5wILN+RctADRgeJ3od8ZOhzw==
X-Received: by 2002:adf:ce0d:: with SMTP id p13mr3952839wrn.66.1588247897133;
        Thu, 30 Apr 2020 04:58:17 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ac19:d1fb:3f5f:d54f? ([2001:b07:6468:f312:ac19:d1fb:3f5f:d54f])
        by smtp.gmail.com with ESMTPSA id b12sm4006595wro.18.2020.04.30.04.58.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 04:58:16 -0700 (PDT)
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
 <0c919928-00ed-beda-e984-35f7b6ca42fb@redhat.com>
 <702b2eaa-e425-204e-e19d-649282bfe170@amazon.com>
 <d13f3c5c-33f5-375b-8582-fe37402777cb@redhat.com>
 <d4091c63-6df6-8980-72c6-282cc553527e@amazon.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <bed6e250-9de5-d719-623b-b72db78ebcb9@redhat.com>
Date:   Thu, 30 Apr 2020 13:58:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <d4091c63-6df6-8980-72c6-282cc553527e@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/04/20 13:47, Alexander Graf wrote:
>>
>> So the issue would be that a firmware image provided by the parent could
>> be tampered with by something malicious running in the parent enclave?
> 
> You have to have a root of trust somewhere. That root then checks and
> attests everything it runs. What exactly would you attest for with a
> flat address space model?
> 
> So the issue is that the enclave code can not trust its own integrity if
> it doesn't have anything at a higher level attesting it. The way this is
> usually solved on bare metal systems is that you trust your CPU which
> then checks the firmware integrity (Boot Guard). Where would you put
> that check in a VM model?

In the enclave device driver, I would just limit the attestation to the
firmware image

So yeah it wouldn't be a mode where ne_load_image is not invoked and
the enclave starts in real mode at 0xffffff0.  You would still need
"load image" functionality.

> How close would it be to a normal VM then? And
> if it's not, what's the point of sticking to such terrible legacy boot
> paths?

The point is that there's already two plausible loaders for the kernel
(bzImage and ELF), so I'd like to decouple the loader and the image.

Paolo

