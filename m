Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF0EC35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 22:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C8DD21775
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 22:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XtU6R1g1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727309AbgBFWaI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 17:30:08 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:53192 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726543AbgBFWaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 17:30:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581028206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y9cBxEKgtYZ4SHZJ2KCZ291mafsQUmmbyOmTI5C6x9c=;
        b=XtU6R1g1DzR7pDkOvp+BNKtATHbXUm90+/6GQRFQ9uNmo8psreNAsY2ftxMiGhOS92tTCK
        FqguwxiD1MhiFn+CRt1r9PB391onsqLQdmK/iW/zXKIraySs/NP8xsLMIUIcxDY1chJMPP
        8eIvakGDCKnQ+J8Mo6ManhkTvzGnOY8=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-beDS3rP4NV21BYC19vvukA-1; Thu, 06 Feb 2020 17:30:05 -0500
X-MC-Unique: beDS3rP4NV21BYC19vvukA-1
Received: by mail-qt1-f197.google.com with SMTP id o18so260603qtt.19
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 14:30:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y9cBxEKgtYZ4SHZJ2KCZ291mafsQUmmbyOmTI5C6x9c=;
        b=PJFhrnwDWrYMHuPdfTnNtRw0MpLcXCb2TvDmx+wElprq4z1RiCgtsqEoCbNliDbijF
         3mNj6hHQLrodpg9r9qPKXw3VsHz578LsMlPfra3/67LDdfm7GpZdhWQ2MwVD3ZF5b8Gb
         DxWr4Y5JMn2tiITCT1Ha5IWXRz0FH5XeEZgLCc1V3pvv/1NoIlgP2XTDMIzfx5ek1LnO
         wkzRPdX9k0eqYIs/V/RvIjwxZ/VUssN+dkVt7H3GGqRcBmWrzheqXo6xDYlcvO9d7ND2
         O/53l/NBBGRHAj7paRkwusmpdqilQVkZoIwgsBb7fW2+Y6hbuIscZ3TsY7haw5y93YaU
         om+Q==
X-Gm-Message-State: APjAAAXTaOIM17s8DGcSX4e9BlaLNzYFsMnyGNRUpotnGqiu9jZ5+BPc
        a8R9IGiGgTAFjwCSVSkhql//8uIUvWP+ZBwv6SiHklk1dR7NtChdC7v0wQBsq/xL2tQCxj+35rg
        OOih8Q1Dv3VY28NZFFud7b6b9
X-Received: by 2002:a37:7884:: with SMTP id t126mr4700916qkc.288.1581028204600;
        Thu, 06 Feb 2020 14:30:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqzvEhS0XgXcsen5IJpPtTelaoRM0D8F8yYe4NbZxtsmBW+xmvTRWnxA6Vkem/WNxI4KksN37A==
X-Received: by 2002:a37:7884:: with SMTP id t126mr4700901qkc.288.1581028204379;
        Thu, 06 Feb 2020 14:30:04 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c8:32::2])
        by smtp.gmail.com with ESMTPSA id z185sm352349qkb.116.2020.02.06.14.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 14:30:03 -0800 (PST)
Date:   Thu, 6 Feb 2020 17:30:01 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-mips@vger.kernel.org, kvm@vger.kernel.org,
        kvm-ppc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        Christoffer Dall <christoffer.dall@arm.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH v5 19/19] KVM: selftests: Add test for
 KVM_SET_USER_MEMORY_REGION
Message-ID: <20200206223001.GJ700495@xz-x1>
References: <20200121223157.15263-1-sean.j.christopherson@intel.com>
 <20200121223157.15263-20-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200121223157.15263-20-sean.j.christopherson@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 02:31:57PM -0800, Sean Christopherson wrote:
> Add a KVM selftest to test moving the base gfn of a userspace memory
> region.  Although the basic concept of moving memory regions is not x86
> specific, the assumptions regarding large pages and MMIO shenanigans
> used to verify the correctness make this x86_64 only for the time being.
> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>

(I'm a bit curious why write 2 first before 1...)

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

