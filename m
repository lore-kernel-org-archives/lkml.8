Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0C4C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F8A2206DB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fd0wyKyx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbgBKMUp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 07:20:45 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51623 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727723AbgBKMUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 07:20:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581423643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7YKK5qbTJbzv97NbN+A209f4bfVu66ItLSv9H/GvglE=;
        b=fd0wyKyxlAoUNs3lDu6I+zzMfVdiyEMzPe5aECSjyvnGMk4Ogf+roqiorYhMTkOlgcWXUB
        Twr/IfnSOTzy8RxO62CPvvNPt5gfFlgJkdFjW0O3VRX7jnGI4B326SUKVgC78njICpFS9L
        FuXI2rJVjZggTBQWO1kJ8yi/S3HrluM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-Ncv58HfqOZKpbfuzZjFfuQ-1; Tue, 11 Feb 2020 07:20:42 -0500
X-MC-Unique: Ncv58HfqOZKpbfuzZjFfuQ-1
Received: by mail-wr1-f70.google.com with SMTP id r1so2726493wrc.15
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 04:20:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7YKK5qbTJbzv97NbN+A209f4bfVu66ItLSv9H/GvglE=;
        b=kZz74HJYzmJjGL36MEmEfAl7SSTY7uqNYwNUph+cptBT1jSMcwQZ1PZ6pGM2OWRepn
         MKlSytTPTcJ7s16XDBc8P1Mywd9vm2qpBNbL7jw65scPh0b2qxBs7fKOg6ijcIbYoKaE
         xD4k8Nu1KEzbk4+TcVwAUd3U14GaB27ZQOsJD4pBekrCuhR8CrlnorJAPAbIa5DyIQmh
         Fl+hjQfdd/qJMdnxUiXhtlSsw8nT814CIgBAOnrD/7ff0tobDz3S4gGSy8Hs6JB9exWC
         EAdE+WhPSmWwuBHI/2r3L8z5xFAUDxP53oyEabUJ5jjJWY2DDcTgaB8eHCBsHFW5tF8O
         eg0Q==
X-Gm-Message-State: APjAAAVjrp0lx734uQ1tNvT0MsbQEQI1kRJhTfxjfyfrwxLHvc7UYpIy
        eKqDTSJxCQBSm6icY4/eOv7SHVzd7A9G0Q9JiCwRwxWVvPOJOltFym9Wy85gJJNW+HVA6C/5p8H
        vk6JFW30FPP5PfHwbNzMFpAzz
X-Received: by 2002:a5d:410e:: with SMTP id l14mr7962942wrp.238.1581423641077;
        Tue, 11 Feb 2020 04:20:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqzYmEhFeabc16XxIDsU9tj29ediGktcdItP3SRO0jeU74xVa2TtLyGXriu2B1irqx6mHAIwzA==
X-Received: by 2002:a5d:410e:: with SMTP id l14mr7962927wrp.238.1581423640836;
        Tue, 11 Feb 2020 04:20:40 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:bd91:9700:295f:3b1e? ([2001:b07:6468:f312:bd91:9700:295f:3b1e])
        by smtp.gmail.com with ESMTPSA id g17sm5123721wru.13.2020.02.11.04.20.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2020 04:20:40 -0800 (PST)
Subject: Re: [PATCH v2 3/6] kvm: x86: Emulate split-lock access as a write
To:     Xiaoyao Li <xiaoyao.li@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@amacapital.net>
Cc:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Laight <David.Laight@aculab.com>
References: <20200203151608.28053-1-xiaoyao.li@intel.com>
 <20200203151608.28053-4-xiaoyao.li@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <95d29a81-62d5-f5b6-0eb6-9d002c0bba23@redhat.com>
Date:   Tue, 11 Feb 2020 13:20:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200203151608.28053-4-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/02/20 16:16, Xiaoyao Li wrote:
> A sane guest should never tigger emulation on a split-lock access, but
> it cannot prevent malicous guest from doing this. So just emulating the
> access as a write if it's a split-lock access to avoid malicous guest
> polluting the kernel log.

Saying that anything doing a split lock access is malicious makes little
sense.

Split lock detection is essentially a debugging feature, there's a
reason why the MSR is called "TEST_CTL".  So you don't want to make the
corresponding behavior wrong.  Just kill the guest with a
KVM_INTERNAL_ERROR userspace exit so people will notice quickly and
either disable the feature or see if they can fix the guest.

Paolo

