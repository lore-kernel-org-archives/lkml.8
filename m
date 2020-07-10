Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A466C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 07:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD8ED2077D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 07:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dF3AbrPJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgGJHPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 03:15:38 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59033 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725966AbgGJHPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 03:15:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594365333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JBLK5CBk2nZNnzlnXGDcyKLYPLiIIdnLjccWhrFJFtQ=;
        b=dF3AbrPJCs+eAxYnsNg4mYA56rUTiQWWiF1M7/5Q24PEvueBejr1mp7jASoGoZNOuhma+r
        Hd6f9QVU/u56iwONR2HPdiWYqGoal2nh70Zn2R6K+sCSb/484a6QRav1V+FgaDEF503doE
        jKsY2VSYrWMTKmxQ0WK3sCI06Fphzpg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-27-SptwtkxbNRKEHy_p2C8BYA-1; Fri, 10 Jul 2020 03:15:31 -0400
X-MC-Unique: SptwtkxbNRKEHy_p2C8BYA-1
Received: by mail-wm1-f69.google.com with SMTP id y204so5575671wmd.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 00:15:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JBLK5CBk2nZNnzlnXGDcyKLYPLiIIdnLjccWhrFJFtQ=;
        b=FYoESRDkYosgAzZj92rX87IO86igSPbQErKZ0aD+ev/C267WZB8GFlf7v3Jqvc+WVd
         q8qHh0qHd/H9x97327sH8Ndwo3PezdOT99DrvNbc5T/eDQVJ+uQ4JdIynshbo+AVDfdw
         8G3iMvTq0LYRu/zdyIvL1FTVbRC0UNWRKto+HXgMjQdeIavzg7ygVr+nUfuRQVie/QK5
         YO92lLhauIex1rpWCbH5V6sNGUyrcANblM8DoW/X6u0ZAdnHTeElXZMKiwTisKihRv+R
         hDqBI7N2oelTnXphroaztmPbA1nUn8TeCKkaplATjZrr7yY25D1+Me6BAf5+BT+pmh3K
         yHMQ==
X-Gm-Message-State: AOAM531fPuy38OFiwLAo0FASJpR4lqrkVzLVPue/E+M42jhKGnCNbUXv
        Gi6I1EndkioMCwKJEiXMzSZ0Q2kyPCg/LZh3+3Ir2evg/pInFnnbJAUI8rLyZe3v3kywr/fEDlm
        ZfrumAA4sAMSiQ51Bd+upazMh
X-Received: by 2002:a1c:9650:: with SMTP id y77mr3688205wmd.101.1594365330842;
        Fri, 10 Jul 2020 00:15:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzLkZi5TShL/4z4VHn340jG1ycyGRH/hNP2ypKvwJnucrUd9Azxl5ktb84UOxWF5Uhkivwtrg==
X-Received: by 2002:a1c:9650:: with SMTP id y77mr3688190wmd.101.1594365330615;
        Fri, 10 Jul 2020 00:15:30 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9541:9439:cb0f:89c? ([2001:b07:6468:f312:9541:9439:cb0f:89c])
        by smtp.gmail.com with ESMTPSA id v18sm9533001wrv.49.2020.07.10.00.15.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 00:15:30 -0700 (PDT)
Subject: Re: [RFC PATCH 0/3] MIPS KVM related clean-ups
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Alexander Lobakin <alobakin@pm.me>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Huacai Chen <chenhc@lemote.com>,
        Jason Wang <jasowang@redhat.com>,
        Paul Burton <paulburton@kernel.org>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20200710063047.154611-1-jiaxun.yang@flygoat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b43cbc19-79d2-756e-b5eb-0a7e16d92e84@redhat.com>
Date:   Fri, 10 Jul 2020 09:15:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200710063047.154611-1-jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/20 08:30, Jiaxun Yang wrote:
> Retire some features that never worked in the real world.
> 
> Also I wonder if there are any actual user of TE KVM.
> Will Huacai or Alexsander take care relevant code?

Queued patches 2 and 3, thanks.  One is outside my maintenance area.

Paolo

> Thanks.
> 
> Jiaxun Yang (3):
>   MIPS: Retire kvm paravirt
>   MIPS: KVM: Limit Trap-and-Emulate to MIPS32R2 only
>   MIPS: KVM: Remove outdated README
> 
>  arch/mips/Kbuild.platforms                |   1 -
>  arch/mips/Kconfig                         |  20 +-
>  arch/mips/configs/mips_paravirt_defconfig |  98 ------
>  arch/mips/include/asm/Kbuild              |   1 +
>  arch/mips/include/asm/kvm_para.h          | 115 -------
>  arch/mips/include/uapi/asm/Kbuild         |   2 +
>  arch/mips/include/uapi/asm/kvm_para.h     |   5 -
>  arch/mips/kvm/00README.txt                |  31 --
>  arch/mips/kvm/Kconfig                     |   3 +-
>  arch/mips/paravirt/Kconfig                |   7 -
>  arch/mips/paravirt/Makefile               |  14 -
>  arch/mips/paravirt/Platform               |   7 -
>  arch/mips/paravirt/paravirt-irq.c         | 368 ----------------------
>  arch/mips/paravirt/paravirt-smp.c         | 145 ---------
>  arch/mips/paravirt/serial.c               |  39 ---
>  arch/mips/paravirt/setup.c                |  67 ----
>  arch/mips/pci/Makefile                    |   1 -
>  arch/mips/pci/pci-virtio-guest.c          | 131 --------
>  18 files changed, 6 insertions(+), 1049 deletions(-)
>  delete mode 100644 arch/mips/configs/mips_paravirt_defconfig
>  delete mode 100644 arch/mips/include/asm/kvm_para.h
>  delete mode 100644 arch/mips/include/uapi/asm/kvm_para.h
>  delete mode 100644 arch/mips/kvm/00README.txt
>  delete mode 100644 arch/mips/paravirt/Kconfig
>  delete mode 100644 arch/mips/paravirt/Makefile
>  delete mode 100644 arch/mips/paravirt/Platform
>  delete mode 100644 arch/mips/paravirt/paravirt-irq.c
>  delete mode 100644 arch/mips/paravirt/paravirt-smp.c
>  delete mode 100644 arch/mips/paravirt/serial.c
>  delete mode 100644 arch/mips/paravirt/setup.c
>  delete mode 100644 arch/mips/pci/pci-virtio-guest.c
> 

