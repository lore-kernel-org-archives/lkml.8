Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3AAC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:37:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB4B921741
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 08:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A3zxSatO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgIGIht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 04:37:49 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41481 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726978AbgIGIhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 04:37:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599467864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CwemuLnaus88lanH3mTsNYl/Jmg76UyntItU5/P7Zm8=;
        b=A3zxSatOqon85V+3bRoe46eFFTucVg2pVdQIkyM2z+aUHH1peP8/lS5rNXegBLQ/SdOCvY
        43YtGm+5eIe4X6wTAOWe/DvW3NVMtHclNJpQT/DobtsrbzVcgwEP2Qv8GYyZDQN8/RoTH0
        63IAQZ/gK9DcMuoQKYmcAYHVGhYgCzw=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-262-P6764oVwMhOhfOYobzLmiw-1; Mon, 07 Sep 2020 04:37:43 -0400
X-MC-Unique: P6764oVwMhOhfOYobzLmiw-1
Received: by mail-ej1-f72.google.com with SMTP id b23so5400062ejv.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 01:37:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=CwemuLnaus88lanH3mTsNYl/Jmg76UyntItU5/P7Zm8=;
        b=H+Vxq9+ATNBfUqOJslBMumcFFRsIAE7M2geqxW90qYXA9jW/DJ80O0U4otEvNwSlVU
         4UwZ9Sfp9LR6qM4O7Lea0eWbpHMIVp5ZyaepUKEd2lkhpuiLkWQuKuEReIM8q81x1w7i
         AFG5G7HyIjzpgzFEa+99h1kPgcoAeBsQnKEa2dZSD9+4e69W0R1IG9f+EhWKwH3lpmHy
         ET0qVgVZZDnc4ub5fqmpYcUHLfH619E8zidCAf0yVcC8lu56cwvr+L0216H1mYechACh
         g/CKMR/t1V9U4N0oiVcFAiZB8Ikkastr5PDcmupIR/eAyR57K7bMfo927Th/Nb10CnDx
         G7Vw==
X-Gm-Message-State: AOAM530pCfC3PuYKonr8i1mH+St03q4tRwXpP1i+8XI6NsTIKuxCcPWu
        Nn1boUwLOLxC4LkEPFIw7vk+1Oyd9d+6alsYz0ysZWSnwBAePx5f9t/30b8I39oZFvwrRLiRMPz
        sEG2MUi89ddMnCWcQKzldkXF6
X-Received: by 2002:a05:6402:1818:: with SMTP id g24mr9960754edy.332.1599467861376;
        Mon, 07 Sep 2020 01:37:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwf6ruoTyKjlZxj1US68c8E+buboCwNMLTONZ/RmwhCPXToown2lFoSSbIybdT0/0V32Hc4hQ==
X-Received: by 2002:a05:6402:1818:: with SMTP id g24mr9960745edy.332.1599467861195;
        Mon, 07 Sep 2020 01:37:41 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id w10sm14914491ejv.44.2020.09.07.01.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 01:37:40 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Tsirkin <mst@redhat.com>,
        Julia Suvorova <jsuvorov@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        linux-kernel@vger.kernel.org, Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH v2 0/3] KVM: x86: KVM_MEM_PCI_HOLE memory
In-Reply-To: <20200904160008.GA2206@sjchrist-ice>
References: <20200807141232.402895-1-vkuznets@redhat.com> <20200825212526.GC8235@xz-x1> <87eenlwoaa.fsf@vitty.brq.redhat.com> <20200901200021.GB3053@xz-x1> <877dtcpn9z.fsf@vitty.brq.redhat.com> <20200904061210.GA22435@sjchrist-ice> <20200904072905.vbkiq3h762fyzds6@sirius.home.kraxel.org> <20200904160008.GA2206@sjchrist-ice>
Date:   Mon, 07 Sep 2020 10:37:39 +0200
Message-ID: <874koanfsc.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> On Fri, Sep 04, 2020 at 09:29:05AM +0200, Gerd Hoffmann wrote:
>>   Hi,
>> 
>> > Unless I'm mistaken, microvm doesn't even support PCI, does it?
>> 
>> Correct, no pci support right now.
>> 
>> We could probably wire up ecam (arm/virt style) for pcie support, once
>> the acpi support for mictovm finally landed (we need acpi for that
>> because otherwise the kernel wouldn't find the pcie bus).
>> 
>> Question is whenever there is a good reason to do so.  Why would someone
>> prefer microvm with pcie support over q35?
>> 
>> > If all of the above is true, this can be handled by adding "pci=lastbus=0"
>> > as a guest kernel param to override its scanning of buses.  And couldn't
>> > that be done by QEMU's microvm_fix_kernel_cmdline() to make it transparent
>> > to the end user?
>> 
>> microvm_fix_kernel_cmdline() is a hack, not a solution.
>> 
>> Beside that I doubt this has much of an effect on microvm because
>> it doesn't support pcie in the first place.
>
> I am so confused.  Vitaly, can you clarify exactly what QEMU VM type this
> series is intended to help?  If this is for microvm, then why is the guest
> doing PCI scanning in the first place?  If it's for q35, why is the
> justification for microvm-like workloads?

I'm not exactly sure about the plans for particular machine types, the
intention was to use this for pcie in QEMU in general so whatever
machine type uses pcie will benefit. 

Now, it seems that we have a more sophisticated landscape. The
optimization will only make sense to speed up boot so all 'traditional'
VM types with 'traditional' firmware are out of
question. 'Container-like' VMs seem to avoid PCI for now, I'm not sure
if it's because they're in early stages of their development, because
they can get away without PCI or, actually, because of slowness at boot
(which we're trying to tackle with this feature). I'd definitely like to
hear more what people think about this.

>
> Either way, I think it makes sense explore other options before throwing
> something into KVM, e.g. modifying guest command line, adding a KVM hint,
> "fixing" QEMU, etc... 
>

Initially, this feature looked like a small and straitforward
(micro-)optimization to me: memory regions with 'PCI hole' semantics do
exist and we can speed up access to them. Ideally, I'd like to find
other 'constant memory' regions requiring fast access and come up with
an interface to create them in KVM but so far nothing interesting came
up...

-- 
Vitaly

