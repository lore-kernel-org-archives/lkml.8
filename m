Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E199C8300A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 11:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7647F2076D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 11:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vzx+jEIu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgD3LjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 07:39:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21962 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726127AbgD3LjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 07:39:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588246740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5XeH1zPtAudcspM1wJQFHJHuK3vCR4Jr/YYiBf3rewU=;
        b=Vzx+jEIuGuMxwN0s2WVcHuNgn9ebkqLf3BIbkmk3I7B91hsH1jKDBi1ibUfpKYSt67FdEp
        gwh2xZtmVmGjfHAM7UJ890MnSKIodrm3TZcJjKfT3R9/Q4vsWMWj43YuIVRKu3qDzMKKN2
        lhc6DfTSfwVsrieAYnsoCF7wxnW0oJo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-5yY41YYpP_eo7Ha0Qi2dMg-1; Thu, 30 Apr 2020 07:38:58 -0400
X-MC-Unique: 5yY41YYpP_eo7Ha0Qi2dMg-1
Received: by mail-wm1-f70.google.com with SMTP id h22so715795wml.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 04:38:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5XeH1zPtAudcspM1wJQFHJHuK3vCR4Jr/YYiBf3rewU=;
        b=MfJsFBGgufCMb7MFYw+9srRnEmwocEzLr83dotc1hlbF0HAWpRER1uHZn9RYpdNW7B
         G7rTv7Wum9yTue6hLPk8CqH+mcpgruwgwv1NCoU66SxNsBCpVKN+wjWtowV8GQv1OYVi
         kGWFxMiqeUUonPcyCC8zlPqcrY9KVqTOIS7dDuEKQv0HZy48ygQ9gC2IS2+C37av/PC1
         3LBDob3xgWo2CogT/pVTTTz8GuCm+nXev1lPme0DYMyX1pruvBXpYs9lqfgVWMtdMEk2
         Zv0r5QYWhyBnm68RQOvMP6BJwbmJ6o4zSKcQmcrOsdvrIPzoI26vFDlb865Bd0JYre1R
         wTXA==
X-Gm-Message-State: AGi0PubS3ytwifb8gmBQzNse7tHsBsRBe5/K9VtBq1okNxetjq7k7ffT
        mnMhW/qPhCllm2Qu+OkatXafCZ8G3IZmunzz2fHnX+minwKQlzQzYzio8r1j2yLlMoKgSbUXFte
        tdAXj5K+LKFrqcanT9qcwNfAP
X-Received: by 2002:a05:600c:20f:: with SMTP id 15mr2608841wmi.71.1588246737669;
        Thu, 30 Apr 2020 04:38:57 -0700 (PDT)
X-Google-Smtp-Source: APiQypIWUQGouBw/RA4IOXRL400gAdp6cpLXqBn3k1uo8PN7rELjejkXrBF6HPN93fNuSurU5FltdA==
X-Received: by 2002:a05:600c:20f:: with SMTP id 15mr2608811wmi.71.1588246737430;
        Thu, 30 Apr 2020 04:38:57 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ac19:d1fb:3f5f:d54f? ([2001:b07:6468:f312:ac19:d1fb:3f5f:d54f])
        by smtp.gmail.com with ESMTPSA id z18sm3494422wrw.41.2020.04.30.04.38.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 04:38:56 -0700 (PDT)
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
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d13f3c5c-33f5-375b-8582-fe37402777cb@redhat.com>
Date:   Thu, 30 Apr 2020 13:38:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <702b2eaa-e425-204e-e19d-649282bfe170@amazon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/04/20 13:21, Alexander Graf wrote:
>> Also, would you consider a mode where ne_load_image is not invoked and
>> the enclave starts in real mode at 0xffffff0?
> 
> Consider, sure. But I don't quite see any big benefit just yet. The
> current abstraction level for the booted payloads is much higher. That
> allows us to simplify the device model dramatically: There is no need to
> create a virtual flash region for example.

It doesn't have to be flash, it can be just ROM.

> In addition, by moving firmware into the trusted base, firmware can
> execute validation of the target image. If you make it all flat, how do
> you verify whether what you're booting is what you think you're booting?

So the issue would be that a firmware image provided by the parent could
be tampered with by something malicious running in the parent enclave?

Paolo

> So in a nutshell, for a PV virtual machine spawning interface, I think
> it would make sense to have memory fully owned by the parent. In the
> enclave world, I would rather not like to give the parent too much
> control over what memory actually means, outside of donating a bucket of
> it.

