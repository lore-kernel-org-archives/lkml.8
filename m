Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2D8CC3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 18:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FE41246A3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 18:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QVAWSRIe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgB1S1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 13:27:42 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46242 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725827AbgB1S1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 13:27:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582914461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mgCjytFydL/uH15zVn61kPfjhPIXAOWGcEvln1LjerY=;
        b=QVAWSRIeAs+U8n52zir4wnyRXU6pcI0U4oOhd1JpTcHN6B1tiWw6Ek70QlWmC4P9VbcuNx
        /oXIapXdmeB3xO3w048Du2AhI9sJtFWAykNcL//3BNSUVazn1B9trxa4s5tcMlAuASh6Q9
        L3hVCZo24fd0mVyvRLn02d+Eg6KAvms=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-18rAywRiOcqjJNFomStreQ-1; Fri, 28 Feb 2020 13:27:39 -0500
X-MC-Unique: 18rAywRiOcqjJNFomStreQ-1
Received: by mail-qv1-f71.google.com with SMTP id e10so3258711qvq.18
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 10:27:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mgCjytFydL/uH15zVn61kPfjhPIXAOWGcEvln1LjerY=;
        b=fGBc5FXILDqWAIDni5D2cI+Cr4sumxPLMV3w6zq/gsGz+c57GLTqUYYJrIF6aYxVeb
         3pYXH8VsUZ2Iq4Wlu5vRGT726rfCWl5O2bt+xC8NtsbpR72gbBLTW6+0Jmx69O0K9nRf
         KDNAnsgW9P5DCWrStJ1+34DnPmE3+vVTZlHONvLYhnKOwULmlJ8cSOLfPQ/obclRdaT/
         YhGw3nnMl8LKVQkYw7hfVLQfgPx/myILFxtP7k3gyChBFpduNzjGggmiS0t+hdcQftTt
         kP2+NUkG+rw75tqFCqDlVibSpgF0NxswkFA54BzUd00npGcAKxyPRto9CfyPv+a/rqoV
         Xgrg==
X-Gm-Message-State: APjAAAUIBQ0r81Ydst5ZF+LYRxcQS4bsuo9Yx9pdLZH+YHXxtkyJ+pIs
        mIz2jrf4bjTdJbk8NaD5+4yfCwNL4iUEONq+GUHdOOQTVrJqQP1H3bFTaKBQ/0J/uzccNE+0iUE
        /1xQg3kyJk7wEPDFmbcHfFsim
X-Received: by 2002:ac8:42de:: with SMTP id g30mr5355455qtm.195.1582914458703;
        Fri, 28 Feb 2020 10:27:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqxT1SKWdoUl2bnRQilz4wBtvIO/ikHK6qptKHrZBRPXEEKC5/BRZuiTYAm9dsQDLd+i9VpVDA==
X-Received: by 2002:ac8:42de:: with SMTP id g30mr5355443qtm.195.1582914458494;
        Fri, 28 Feb 2020 10:27:38 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id f13sm1030834qkm.42.2020.02.28.10.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 10:27:37 -0800 (PST)
Date:   Fri, 28 Feb 2020 13:27:36 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>, jianjay.zhou@huawei.com
Subject: Re: [PATCH] KVM: Remove unecessary asm/kvm_host.h includes
Message-ID: <20200228182736.GU180973@xz-x1>
References: <20200226155558.175021-1-peterx@redhat.com>
 <20200228180503.GH2329@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200228180503.GH2329@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 10:05:03AM -0800, Sean Christopherson wrote:
> s/unecessary/unnecessary
> 
> On Wed, Feb 26, 2020 at 10:55:58AM -0500, Peter Xu wrote:
> > linux/kvm_host.h and asm/kvm_host.h have a dependency in that the asm
> > header should be included first, then we can define arch-specific
> > macros in asm/ header and use "#ifndef" in linux/ header to define the
> > generic value of the macro.  One example is KVM_MAX_VCPU_ID.
> > 
> > Now in many C files we've got both the headers included, and
> > linux/kvm_host.h is included even earlier.  It's working only because
> > in linux/kvm_host.h we also included asm/kvm_host.h anyway so the
> > explicit inclusion of asm/kvm_host.h in the C files are meaningless.
> 
> I'd prefer to word this much more strongly, i.e. there is no "should"
> about it, including asm/kvm_host.h in linux/kvm_host.h is deliberate, 
> it's not serendipitous.
> 
> ```
> Remove includes of asm/kvm_host.h from files that already include
> linux/kvm_host.h to make it more obvious that there is no ordering issue
> between the two headers.  linux/kvm_host.h includes asm/kvm_host.h to
> pick up architecture specific settings, and this will never change, i.e.
> including asm/kvm_host.h after linux/kvm_host.h may seem problematic,
> but in practice is simply redundant.
> ```
> 
> As for the change itself, I'm indifferent.

Sure, I'll fix up these and repost.  Thanks,

-- 
Peter Xu

