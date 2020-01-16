Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542DFC33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 08:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2700D2073A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 08:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ag+LGri+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731229AbgAPIi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 03:38:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55376 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727003AbgAPIi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 03:38:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579163908;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IXtSmPS0i6Qsp99yh//fgz82ZG06+bv6j5QX91/2YyA=;
        b=ag+LGri+lLDYHUGNGUm4wSWQJdFTAdE4g4qUEil9toltT9/7wvsi53c2tALoTTIpfYkjEf
        3YF1c5Q1Sf6NddRW6p1ZiCJrMD4BSVGnF6b+OMJlJUGUlE59mg8X8aeLvHOq4h5lOUBlBu
        83Q8X9JnP177K96yJOXlkUSIVv+8JY0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-72-fv8lU_O8PFCebhCmS2oC-w-1; Thu, 16 Jan 2020 03:38:27 -0500
X-MC-Unique: fv8lU_O8PFCebhCmS2oC-w-1
Received: by mail-wm1-f69.google.com with SMTP id l11so2097545wmi.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 00:38:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IXtSmPS0i6Qsp99yh//fgz82ZG06+bv6j5QX91/2YyA=;
        b=kYXxem6xGfJ3AgokdbUh2fTFyShoV0NPt4kqNlKaHf6fhwJDBl5hzs5oAyj5jW+R82
         iTeuualDRRcmlxCieu1FadoCU32kUuZQyZIM2NsbR9Mk8gr9fXC8JYl9Kzu+CyMTfrPr
         AfU+H8UvDQ5u3PJMS7Ok95uxUXZqHAJIi5FoeJMSVUqM14nIQ+VqXtJVdH87bZ3bROcU
         3X9aoPXU8xlfWeqkgzhJh5ZTBLyqyMkMpc6+OUG5mWRniCzrfV+dbDOzKodKuVXsSV3n
         bicppcNErMDUFOM+DnA/B9fAWypDq4X7KavFaON3g2T1HC/FMfz5c8Tv8NwBhD6nXoWc
         plng==
X-Gm-Message-State: APjAAAUOXfnHCqtijpsW6r1t5b1mHjjYH9IAp5CKYwBD0d2ewFYceOYS
        AJKdR8OW5Qkz/VZ9kAX+bilnTXI6se0NPD8pAydfIpgbj3NLlRVjbpVTC+HQJgIVPueUaM2ZByu
        SnW+47I+z4e6broduoUJmDMO8
X-Received: by 2002:a05:6000:118d:: with SMTP id g13mr2102069wrx.141.1579163905495;
        Thu, 16 Jan 2020 00:38:25 -0800 (PST)
X-Google-Smtp-Source: APXvYqwGO77Z98jPmNC+6Lx21D2RFFW5UOBHp3rIpKkBmINzKtpHw/Lyr1d04DYLp7eI2k9wrDOeaA==
X-Received: by 2002:a05:6000:118d:: with SMTP id g13mr2102044wrx.141.1579163905272;
        Thu, 16 Jan 2020 00:38:25 -0800 (PST)
Received: from redhat.com (bzq-79-179-85-180.red.bezeqint.net. [79.179.85.180])
        by smtp.gmail.com with ESMTPSA id y139sm2277799wmd.24.2020.01.16.00.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 00:38:24 -0800 (PST)
Date:   Thu, 16 Jan 2020 03:38:21 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christophe de Dinechin <dinechin@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yan Zhao <yan.y.zhao@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Kevin Kevin <kevin.tian@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Lei Cao <lei.cao@stratus.com>
Subject: Re: [PATCH v3 12/21] KVM: X86: Implement ring-based dirty memory
 tracking
Message-ID: <20200116033725-mutt-send-email-mst@kernel.org>
References: <20200109145729.32898-1-peterx@redhat.com>
 <20200109145729.32898-13-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109145729.32898-13-peterx@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 09:57:20AM -0500, Peter Xu wrote:
> +	/* If to map any writable page within dirty ring, fail it */
> +	if ((kvm_page_in_dirty_ring(vcpu->kvm, vma->vm_pgoff) ||
> +	     kvm_page_in_dirty_ring(vcpu->kvm, vma->vm_pgoff + pages - 1)) &&
> +	    vma->vm_flags & VM_WRITE)
> +		return -EINVAL;

Worth thinking about other flags. Do we want to force VM_SHARED?
Disable VM_EXEC?

