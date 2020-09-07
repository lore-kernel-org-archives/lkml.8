Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FFEC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 10:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36458206D4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 10:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hROGf9MP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728909AbgIGKwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 06:52:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43884 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728589AbgIGKwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 06:52:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599475955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nZNYuBpQt9HKowq473qvyGL7V94PMK5k48wA1l6+SwU=;
        b=hROGf9MPYXNBlp3ui4i/gdPAobn6s3w5gsFSnf7k9q/ZTniCdPRPZ1GaE/nnPn31d3tah+
        ejcz9Ab6CNEuYrw7ALfrUH5WG1DxyFkcuokOO7eTIilTVYqdkFVZ6d7lnKv71GftV0WvEV
        8gSMA7g8AJHeb1VQA8qHbntKg3iYFe8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-Xf1A5T0CPRi6WJ5rYOHlzw-1; Mon, 07 Sep 2020 06:52:28 -0400
X-MC-Unique: Xf1A5T0CPRi6WJ5rYOHlzw-1
Received: by mail-wr1-f69.google.com with SMTP id k13so3999844wrw.16
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 03:52:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nZNYuBpQt9HKowq473qvyGL7V94PMK5k48wA1l6+SwU=;
        b=rXvRz7nHJDNbeV8nod4NzlnnWI1qO/SHm86z508BOoOtlV7VxlWPuYVJuDDlxMBmZ1
         PbEfrXOD0L8on5UKMGlOkyXRmIscEGE8woREo2HI2oTdvRZwm74ZtQoMyGQ3MKZm2GHS
         H1oyz5TPIS3q/gHiraKVtiDwnmSSmf4QW7tXkqp3WEH2eSAy9WSopA3M2CCjyMa05Xo1
         uJTdAkTl12kJPOkvtORYh0x+T8NOwkSnhcgcPfhd8luROQj4Ipv5FHDtho2egdUK+AIg
         4k+GJiIrWQnJ/MiYJTOvoB7iOlXQv4mR76R0Sb5nIuSdFnVGv73QqTh6LpgpClD1IYZ0
         LTAw==
X-Gm-Message-State: AOAM530b1N46AuuCptoQEeiyOj/k+BSXENxP9zQg0ZpmmfO7ydWYloCr
        yp6V9ifeuNXEDxHlGkikbE7ceYd74180rxm7eHPWzA+hVh/YcjPalPKOimiyap0dZX4Hnbt9Znz
        NijRFmmQ0y69CJiM7DCQPt2Qg
X-Received: by 2002:adf:e292:: with SMTP id v18mr2295013wri.256.1599475947654;
        Mon, 07 Sep 2020 03:52:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyG5yHsS/XQWDRSHn7G2xKTYdTMeb9QBkBBhYcA+QxqmG74U+oeLI7TfgtvmkrDWtQwwtMcjA==
X-Received: by 2002:adf:e292:: with SMTP id v18mr2294999wri.256.1599475947455;
        Mon, 07 Sep 2020 03:52:27 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
        by smtp.gmail.com with ESMTPSA id a74sm28019641wme.11.2020.09.07.03.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2020 03:52:25 -0700 (PDT)
Date:   Mon, 7 Sep 2020 06:52:17 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Julia Suvorova <jsuvorov@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Jones <drjones@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] KVM: x86: KVM_MEM_PCI_HOLE memory
Message-ID: <20200907065054-mutt-send-email-mst@kernel.org>
References: <20200807141232.402895-1-vkuznets@redhat.com>
 <20200825212526.GC8235@xz-x1>
 <87eenlwoaa.fsf@vitty.brq.redhat.com>
 <20200901200021.GB3053@xz-x1>
 <877dtcpn9z.fsf@vitty.brq.redhat.com>
 <20200904061210.GA22435@sjchrist-ice>
 <20200904072905.vbkiq3h762fyzds6@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904072905.vbkiq3h762fyzds6@sirius.home.kraxel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 09:29:05AM +0200, Gerd Hoffmann wrote:
>   Hi,
> 
> > Unless I'm mistaken, microvm doesn't even support PCI, does it?
> 
> Correct, no pci support right now.
> 
> We could probably wire up ecam (arm/virt style) for pcie support, once
> the acpi support for mictovm finally landed (we need acpi for that
> because otherwise the kernel wouldn't find the pcie bus).
> 
> Question is whenever there is a good reason to do so.  Why would someone
> prefer microvm with pcie support over q35?

The usual reasons to use pcie apply to microvm just the same.
E.g.: pass through of pcie devices?

> > If all of the above is true, this can be handled by adding "pci=lastbus=0"
> > as a guest kernel param to override its scanning of buses.  And couldn't
> > that be done by QEMU's microvm_fix_kernel_cmdline() to make it transparent
> > to the end user?
> 
> microvm_fix_kernel_cmdline() is a hack, not a solution.
> 
> Beside that I doubt this has much of an effect on microvm because
> it doesn't support pcie in the first place.
> 
> take care,
>   Gerd

