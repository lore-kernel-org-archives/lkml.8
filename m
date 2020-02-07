Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DD4C352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 09:08:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F4B021741
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 09:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gtKDvf/5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgBGJIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 04:08:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50695 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726417AbgBGJIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 04:08:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581066533;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vwqq6UkPRy0m2wWurqdxwHhAqRvptisJI/4Mk62bZu0=;
        b=gtKDvf/5S24PWwi/r1bOhEr02/MmzXELeVXD2FAIZB0A1hPNPpDCXBgBQVliOl0icMKDES
        ZQ7kJnvrFkYye8Oe4TogGJ6ufUmJEfuiduNOKbyx++OoNDHgpnEe8l+YqRW7oo/L49h8OJ
        o+Asa9CBSXKKylPMKtZa/gaz5vkUOgU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-XWiXUKhQOXqJN9SHzqWhUA-1; Fri, 07 Feb 2020 04:08:49 -0500
X-MC-Unique: XWiXUKhQOXqJN9SHzqWhUA-1
Received: by mail-wr1-f72.google.com with SMTP id f10so927260wro.14
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 01:08:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Vwqq6UkPRy0m2wWurqdxwHhAqRvptisJI/4Mk62bZu0=;
        b=Izmu3IfIG1g6fSxwWApUF8bFya3OzPa2vCNmPUqAFkcIx2834KaNM/13qyiFiFKQjO
         FoX1W9Fi52tS/jEqedmxbvOm+C+stfwrJnGOYdgEbWZl5o94VHxRzI2+q3P+zAXIEk9B
         Agh1n6T6/YfgRt9soCZ5baCwB1eFr/vd6pUOaAJJJ0rpZgAmPqy1ekI32M3KTlonOlHU
         xV/ZMK54hrV69roJ7kPX4Wpk4NoZdCbNc+EpdbHg2EXOiSte2clAK6v8R11vfrY4RNF/
         Ddzrgu+aJrxLiY+0QPavtRK/zRy1D6jHCNMIpCdm3Q7o4HforN1Pe55vxaKDoO83xEyi
         tu4A==
X-Gm-Message-State: APjAAAUAkYWzF4MU7lIRGsfNMmv0SJUIJb6x1jMcUCFGvoJqd4HV95cQ
        jq63+NpcJaK0SLnC2mqI/jJYQGs4DdYB6Nkx6aCC02gQU+WUE+VMU03ggHn+M5p3Ja9sfqvo8jl
        zv7+cKE2tZDoCi7iE6+Pur81p
X-Received: by 2002:adf:e550:: with SMTP id z16mr3605808wrm.5.1581066528540;
        Fri, 07 Feb 2020 01:08:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqxS7NU/AK8OFWXcmEpnR0rOnuMo0hO1VFe1OHOo6u4Q1IgKjpWDlOrdnfcJUaJLg8zDQuLVrQ==
X-Received: by 2002:adf:e550:: with SMTP id z16mr3605794wrm.5.1581066528350;
        Fri, 07 Feb 2020 01:08:48 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id 11sm2804255wmb.14.2020.02.07.01.08.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 01:08:47 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linmiaohe <linmiaohe@huawei.com>
Cc:     "pbonzini\@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar\@redhat.com" <rkrcmar@redhat.com>,
        "sean.j.christopherson\@intel.com" <sean.j.christopherson@intel.com>,
        "wanpengli\@tencent.com" <wanpengli@tencent.com>,
        "jmattson\@google.com" <jmattson@google.com>,
        "joro\@8bytes.org" <joro@8bytes.org>,
        "tglx\@linutronix.de" <tglx@linutronix.de>,
        "mingo\@redhat.com" <mingo@redhat.com>,
        "bp\@alien8.de" <bp@alien8.de>, "hpa\@zytor.com" <hpa@zytor.com>,
        "kvm\@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86\@kernel.org" <x86@kernel.org>
Subject: Re: [Question] some questions about vmx
In-Reply-To: <736f8beabe2046fdab0631f28f9d2b1f@huawei.com>
References: <736f8beabe2046fdab0631f28f9d2b1f@huawei.com>
Date:   Fri, 07 Feb 2020 10:08:46 +0100
Message-ID: <87eev6g3xd.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linmiaohe <linmiaohe@huawei.com> writes:

> Hi:
> Vitaly Kuznetsov <vkuznets@redhat.com> writes:
>>linmiaohe <linmiaohe@huawei.com> writes:
>>
>>> About nWMX.
>>> When nested_vmx_handle_enlightened_vmptrld() return 0, it do not 
>>> inject any exception or set rflags to Indicate VMLAUNCH instruction 
>>> failed and skip this instruction. This would cause nested_vmx_run() 
>>
>>Yes, it seems it can. 
>>
>>nested_vmx_handle_enlightened_vmptrld() has two possible places where it can fail:
>>
>>kvm_vcpu_map() -- meaning that the guest passed some invalid GPA.
>>revision id check -- meaning that the supplied eVMCS is unsupported/garbage.
>>
>>I think the right behavior would be to nested_vmx_failInvalid() in both these cases. We can also check what genuing Hyper-V does.
>>
>
> Many thanks for your reply. I think this would be a problem too. And would you like to fix this potential problem? I have no idea
> how to fix this correctly...

Yes,

let me check what happens on Hyper-V and I'll send a patch. The problem
should not be that severe as it only affect misbehaving L1 hypervisors.

-- 
Vitaly

