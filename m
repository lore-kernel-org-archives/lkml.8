Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBF6C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 09:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7BA12467E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 09:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XXSQ/cdP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727523AbgAWJPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 04:15:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40869 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726231AbgAWJPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 04:15:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579770946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=12B39Xg1ujbGmC2fcxyE3VvGdS8Z63MnFzgGD9DRUo4=;
        b=XXSQ/cdPU8jHlgBrjjXUSOPcDlP/QR6Qj/GdoKHrxtCA6VZJDwkMZnscm0xKsErvpsAqi4
        gHcIm85zqh+x6Pg1RjdspChAgxJJg1MdNIzzI+Q4v1rXpr6+mUppiSRywXjg0OWocnPD6u
        XtboBcCc78ZYXAppWB3JJIAET2zL78k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-HYB_OmAlNp-MaS-EUz2DLg-1; Thu, 23 Jan 2020 04:15:44 -0500
X-MC-Unique: HYB_OmAlNp-MaS-EUz2DLg-1
Received: by mail-wm1-f71.google.com with SMTP id b202so264304wmb.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 01:15:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=12B39Xg1ujbGmC2fcxyE3VvGdS8Z63MnFzgGD9DRUo4=;
        b=bfaGcmhPz2MhcRDJq4lXvKnUXc1rZ6R4K3lT4eziMEtc/0Ocbv2gpNVLgf7IDR1cBm
         qLFACq2NiHl2Ab2g+g5bMjXkh5JMtIB8ytb74/kwcilsQw3AM/ia0ShRM6h/U6q8Hjzm
         qtrMYid51deR7rSD5uT8zFJCD6YDB9TM1u1Z9tMczCVSN1p8csCZtHAFhMvpKcq8q56b
         i743X3aUqLI3SZguUlEK/JBZ39CRKmNNHBasCg/vFtSEVLNLCwXC7n4iWcw0bRK70Nl0
         BW1sIzaWrHEAFLIYp+IqztYIn6Js08snVc9j7TX5rCSasag5I//nwrgJjccgTsYiOPy8
         pRoQ==
X-Gm-Message-State: APjAAAW4pD7dCS+DmEZdu2mX4HoEFK47pcVHP5/sUeTd/H9FeqNpHCXb
        ZBGe/LM6C/fplTFj0Zb8oK9liiBP0/jUW7M4xMOg5M2lcfnm5S0FI5y3CDYwTzzXG7vbaxZily6
        FhQlANOdqiJZgiPf780VIgogw
X-Received: by 2002:a05:600c:290b:: with SMTP id i11mr3036726wmd.27.1579770943287;
        Thu, 23 Jan 2020 01:15:43 -0800 (PST)
X-Google-Smtp-Source: APXvYqwexsQSodRXMekzwFz0uAi8G31zz2yRchJWLCfe5ZB2s6Sa5TKDasgwMQb5tuntXRoVZkEIHA==
X-Received: by 2002:a05:600c:290b:: with SMTP id i11mr3036695wmd.27.1579770943050;
        Thu, 23 Jan 2020 01:15:43 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id b68sm1919858wme.6.2020.01.23.01.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 01:15:42 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     kvm@vger.kernel.org, Jim Mattson <jmattson@google.com>,
        linux-kernel@vger.kernel.org, Liran Alon <liran.alon@oracle.com>,
        Roman Kagan <rkagan@virtuozzo.com>
Subject: Re: [PATCH RFC 2/3] x86/kvm/hyper-v: move VMX controls sanitization out of nested_enable_evmcs()
In-Reply-To: <f15d9e98-25e9-2031-2db5-6aaa6c78c0eb@redhat.com>
References: <20200115171014.56405-1-vkuznets@redhat.com> <20200115171014.56405-3-vkuznets@redhat.com> <6c4bdb57-08fb-2c2d-9234-b7efffeb72ed@redhat.com> <20200122054724.GD18513@linux.intel.com> <9c126d75-225b-3b1b-d97a-bcec1f189e02@redhat.com> <87eevrsf3s.fsf@vitty.brq.redhat.com> <20200122155108.GA7201@linux.intel.com> <87blqvsbcy.fsf@vitty.brq.redhat.com> <f15d9e98-25e9-2031-2db5-6aaa6c78c0eb@redhat.com>
Date:   Thu, 23 Jan 2020 10:15:41 +0100
Message-ID: <87zheer0si.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 22/01/20 17:29, Vitaly Kuznetsov wrote:
>> Yes, in case we're back to the idea to filter things out in QEMU we can
>> do this. What I don't like is that every other userspace which decides
>> to enable eVMCS will have to perform the exact same surgery as in case
>> it sets allow_unsupported_controls=0 it'll have to know (hardcode) the
>> filtering (or KVM_SET_MSRS will fail) and in case it opts for
>> allow_unsupported_controls=1 Windows guests just won't boot without the
>> filtering.
>> 
>> It seems to be 1:1, eVMCSv1 requires the filter.
>
> Yes, that's the point.  It *is* a hack in KVM, but it is generally
> preferrable to have an easier API for userspace, if there's only one way
> to do it.
>
> Though we could be a bit more "surgical" and only remove
> SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES---thus minimizing the impact on
> non-eVMCS guests.  Vitaly, can you prepare a v2 that does that and adds
> a huge "hack alert" comment that explains the discussion?

Yes, sure. I'd like to do more testing to make sure filtering out
SECONDARY_EXEC_VIRTUALIZE_APIC_ACCESSES is enough for other Hyper-V
versions too (who knows how many bugs are there :-)

-- 
Vitaly

