Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D9AFC35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 22:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4037214AF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 22:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XYYIerHF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbgBEWpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 17:45:21 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37951 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727456AbgBEWpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 17:45:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580942719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qhu3K4UfMyr9rLuPVrEXyLiBiRw+0bLNH6EYh61xjr4=;
        b=XYYIerHForgEJm1bmnDiaCU8X52LECPVfk5BEnHr8pgT2ETQiFlrNX2vmrVeE517TV/aNA
        7Bc8b2ZMF7yFm5KeCy0JZK97GYECGWUu+836UnwYkEoYZx1ZHrwLsQVZcU3Jr0hZu3mZd/
        BidUPuYtBCvqSpFmAEsmvZYBKKF0ndM=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-vydQWdGGOleAHeeW_64COQ-1; Wed, 05 Feb 2020 17:45:17 -0500
X-MC-Unique: vydQWdGGOleAHeeW_64COQ-1
Received: by mail-qv1-f72.google.com with SMTP id p3so2484496qvt.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 14:45:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Qhu3K4UfMyr9rLuPVrEXyLiBiRw+0bLNH6EYh61xjr4=;
        b=EZ68MP17LeQfteF1uYZSpgEF88xhtrqGuiare+E9/BZoUJvKXOgV3gSygQ/VSxFPqs
         rujcEZpo8b5ZO0fyLX2dLTXUPXSV5ctFyyubHFSLFKZWJaiLQH3JHjW3O/LbtVoSnq+N
         k3YUQHjOo5zykOKjv1QuKAVBBVEhH6BCZyy0lVoEnONrhj8NpXxF8TBD2jsoApJtyjIt
         956CdDIg+UdNn93QrI+C6mB/GX0QG7gj4zTrb+fEVjfZFLCrOjkf5PqN8hbkg/lzVy/F
         Jt3uiuGWceDWuMdEP3DR7VFdHk91tuPX15uXxUR17OZUMnNwVBstcj7aelZfVxl/PzCs
         imWg==
X-Gm-Message-State: APjAAAVWtCY0l3L0iOFucca0Bs3M4toOOOYN6Gc92SaprKnoxqT4aCdS
        QEWyWbAfZrnAFnO/GmOy6wFe9Wabu+hc8rSh79mveM86B/2owZFaQ5gSt558IDsOdWB4xSGcEEW
        yNCW2Mo1hvXMIMAiwwt0feWIn
X-Received: by 2002:a05:620a:1654:: with SMTP id c20mr61836qko.116.1580942717359;
        Wed, 05 Feb 2020 14:45:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqyAvhOweFr4KXXnP5Mb9+7dhUBLh1Z13T+81iDjtWqZt6EK3UE5xX8DXWaSS5tvfd+S4d7C7g==
X-Received: by 2002:a05:620a:1654:: with SMTP id c20mr61812qko.116.1580942717130;
        Wed, 05 Feb 2020 14:45:17 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c8:32::2])
        by smtp.gmail.com with ESMTPSA id x22sm615496qtq.30.2020.02.05.14.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 14:45:16 -0800 (PST)
Date:   Wed, 5 Feb 2020 17:45:13 -0500
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
Subject: Re: [PATCH v5 06/19] KVM: Drop kvm_arch_create_memslot()
Message-ID: <20200205224513.GH387680@xz-x1>
References: <20200121223157.15263-1-sean.j.christopherson@intel.com>
 <20200121223157.15263-7-sean.j.christopherson@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200121223157.15263-7-sean.j.christopherson@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 02:31:44PM -0800, Sean Christopherson wrote:
> Remove kvm_arch_create_memslot() now that all arch implementations are
> effectively nops.  Removing kvm_arch_create_memslot() eliminates the
> possibility for arch specific code to allocate memory prior to setting
> a memslot, which sets the stage for simplifying kvm_free_memslot().
> 
> Cc: Janosch Frank <frankja@linux.ibm.com>
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

