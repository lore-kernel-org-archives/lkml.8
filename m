Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D80CC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 16:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FDE02071E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 16:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FTBX6Mgg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbgAWQQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 11:16:15 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27146 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726605AbgAWQQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 11:16:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579796173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EIV/YyjsNHKvzfLLRkCsSAhXa/8ugLsBC1Uq238ttpo=;
        b=FTBX6Mgggjswr7tcR6NC3OKAuxF4g1fgj1vD3uKHwU8F/plG4bX8xBB12YJIEWGYXL7gJp
        oEqYtlmnSOkZ1eW2u339EYemj+Hs2ryGbO/FAD8cn/hkSdnlxEeT2KS7raTxVqhufR9b2i
        y7T2MsIwntFy/ojnpY+e64OY0DBf6pw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-302-22RGiMdpMsO3OeeOSU5W-w-1; Thu, 23 Jan 2020 11:16:08 -0500
X-MC-Unique: 22RGiMdpMsO3OeeOSU5W-w-1
Received: by mail-wr1-f69.google.com with SMTP id t3so2002290wrm.23
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 08:16:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=EIV/YyjsNHKvzfLLRkCsSAhXa/8ugLsBC1Uq238ttpo=;
        b=nhyGE1U9eYmVjjGaM39q/sLiEF9cCir3p8H/RawuQ5Y5cynsvCFPwz9jquHmYmAnsk
         yqNi1hSYIBSYKIXrrctB9xaSFl/VFMgBmyuuQ5+S7Kq9gzEgwpcSgFRobIimjhR+MNZ5
         EifTDel3SZCem0zUdjsQD+R53tZ4mVRq53cpGrffYyUhBrgLUNeeYg238rQ7lzLylU9t
         uSlDu+9N29fmmpVzmiG2dyWTxvdlBApnJhKd23TqyoZJ6WmFgKYkJsGryEII8nNCLnNa
         LwTo9pfb2XtQWkoK7JR+Rnh/d86efbCWNMmZQYszaBP3rb/vtUEMoNqw8BPxTi5USshu
         CI2A==
X-Gm-Message-State: APjAAAUCEEVr5CNDDIXcqpa8NTWBTogYgM40/BkrrGofcruiP7jZwKJ7
        Zq079COOeQIqDVF7pTlhHMYpDVpzwoZRlT3ZCi+V2bBW874E4BZBzxIKPUq3OQiRXZVmMoDQZOi
        ANPr/Bi8EJFgcELT21Ea+Mr2R
X-Received: by 2002:a7b:c3d8:: with SMTP id t24mr4902873wmj.175.1579796167373;
        Thu, 23 Jan 2020 08:16:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqzVie/mIIlbsyC2TD4OU1SdHGQkoaSGWQtEsx5eV8zH3zTTSAH+2bwHeH80HjHcBrDABuEkxw==
X-Received: by 2002:a7b:c3d8:: with SMTP id t24mr4902864wmj.175.1579796167187;
        Thu, 23 Jan 2020 08:16:07 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b8fe:679e:87eb:c059? ([2001:b07:6468:f312:b8fe:679e:87eb:c059])
        by smtp.gmail.com with ESMTPSA id w19sm3056765wmc.22.2020.01.23.08.16.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jan 2020 08:16:06 -0800 (PST)
Subject: Re: [RESEND] Atomic switch of MSR_IA32_UMWAIT_CONTROL
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Tao Xu <tao3.xu@intel.com>, Jingqi Liu <jingqi.liu@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200123154526.GC13178@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c8371569-78f5-24bc-d4c0-2c7f8f3c1f14@redhat.com>
Date:   Thu, 23 Jan 2020 17:16:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200123154526.GC13178@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/20 16:45, Sean Christopherson wrote:
> cc'ing KVM and LKML this time...
> 
> Why does KVM use the atomic load/store lists to load MSR_IA32_UMWAIT_CONTROL
> on VM-Enter/VM-Exit?  Unless the host kernel is doing UWMAIT, which it
> really shouldn't and AFAICT doesn't, isn't it better to use the shared MSR
> mechanism to load the host value only when returning to userspace, and
> reload the guest value on demand?

Just laziness I guess.

Paolo

