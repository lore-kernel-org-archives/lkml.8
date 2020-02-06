Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFD5C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 12:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D16020730
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 12:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ElX4uVDH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbgBFMJE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 07:09:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52293 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727111AbgBFMJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 07:09:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580990942;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E0dTUFkCATPXVv287UdMap2gGam4zjJ6lvZcBnT8osI=;
        b=ElX4uVDHHPqAMBa8hVyKF048pADsMrhExmmplOphx9HtW/at+8DJBpDw+DD6zjkTooI9Xq
        K0D4k3rQkMCQff5R/0R1HmNfy1C5PmiXyOnUz8oscXoGctY+o7tpCUpsCqzH4mjmYdrVEO
        YcgEMNSi173ugTgoe8+IW3t+oq2TrNE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-ofFmDTLPMXOlRutpQcwiHA-1; Thu, 06 Feb 2020 07:08:57 -0500
X-MC-Unique: ofFmDTLPMXOlRutpQcwiHA-1
Received: by mail-wm1-f70.google.com with SMTP id d4so2541242wmd.7
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 04:08:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=E0dTUFkCATPXVv287UdMap2gGam4zjJ6lvZcBnT8osI=;
        b=XL2YcOvyUgRsIbJKJWoS7smRJGbQX6JVmf6ABv4dH9ovEhXMLkh1wqip6/Bq/ErHTe
         0Oc0F/PddebeISxXavAZIvwTCDgB8xcYBhADtMVE1bIxQwOjW8fLJKnjjHninA6dKWee
         vWTZOV9NlLyqOjih8rSYy4++f0zJQZoJZgkm/tY82t5hRVI6SjSlhZ4pnVKXj0DR8MIY
         l6pxkD0qGMHD/UL0u2L3U0mmR+JIbD82mmL30TQeWuswD5QYlbfZUmLnp2y5GvpGOv2J
         EIBqxnIWcwTHPuy9ZiNM5sO5Tq9eBqkcNsE5hm5heVnRII1CnWRWILyLFmBytYr42ZAq
         9dNw==
X-Gm-Message-State: APjAAAWnXtZjb2VEQkudC4J9dB8eOhexDsMF3pSACdmB57/9M9dD2ScU
        XVfS08GVZ6U5SmWXVONeTd0rABQ90R0tjeEOjE5NGmThUp64XXIpeJBxaXWyMrQAtrKxdhlNlmo
        u3mYpjwBzfUrItnPr62gMwycq
X-Received: by 2002:a1c:7317:: with SMTP id d23mr4362677wmb.165.1580990936357;
        Thu, 06 Feb 2020 04:08:56 -0800 (PST)
X-Google-Smtp-Source: APXvYqxbbMXe8FHfJITDoTG5ycCef7EyduSOW9ahh6f1qWfindtlKQK2JEURiiqEWYgbRJ/1F6WOSw==
X-Received: by 2002:a1c:7317:: with SMTP id d23mr4362665wmb.165.1580990936162;
        Thu, 06 Feb 2020 04:08:56 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id a22sm3490157wmd.20.2020.02.06.04.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 04:08:55 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 04/26] KVM: x86: Add a kvm_x86_ops hook to query virtualized MSR support
In-Reply-To: <20200205170209.GH4877@linux.intel.com>
References: <20200129234640.8147-1-sean.j.christopherson@intel.com> <20200129234640.8147-5-sean.j.christopherson@intel.com> <87eev9ksqy.fsf@vitty.brq.redhat.com> <20200205145923.GC4877@linux.intel.com> <8736bpkqif.fsf@vitty.brq.redhat.com> <20200205153508.GD4877@linux.intel.com> <87tv45j7nf.fsf@vitty.brq.redhat.com> <20200205170209.GH4877@linux.intel.com>
Date:   Thu, 06 Feb 2020 13:08:54 +0100
Message-ID: <871rr7hq95.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> On Wed, Feb 05, 2020 at 05:55:32PM +0100, Vitaly Kuznetsov wrote:
>> Sean Christopherson <sean.j.christopherson@intel.com> writes:
>> > I dug deeper into the CPUID crud after posting this series because I really
>> > didn't like the end result for vendor-specific leafs, and ended up coming
>> > up with (IMO) a much more elegant solution.
>> >
>> > https://lkml.kernel.org/r/20200201185218.24473-1-sean.j.christopherson@intel.com/
>> >
>> > or on patchwork
>> >
>> > https://patchwork.kernel.org/cover/11361361/
>> >
>> 
>> Thanks, I saw it. I tried applying it to kvm/next earlier today but
>> failed. Do you by any chance have a git branch somewhere? I'll try to
>> review it and test at least AMD stuff (if AMD people don't beat me to it
>> of course).
>
> Have you tried kvm/queue?  I'm pretty sure I based the code on kvm/queue.
> If that doesn't work, I'll push a tag to my github repo.

My bad, kvm/queue worked like a charm!

>
> This is exactly why I usually note the base for large series.  *sigh*

Pull requests, anyone? :-)

-- 
Vitaly

