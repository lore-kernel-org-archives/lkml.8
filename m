Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CC2C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 16:11:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A168E2073E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 16:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A4t81eQE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbgCYQLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 12:11:52 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:50340 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725812AbgCYQLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 12:11:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585152710;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WK74JkL+kdH++Ab+Y2UEWtM7+ELlujDygy01aFZtgRs=;
        b=A4t81eQEbSyC0YiMyDUgRMjZQr+ofjbltiDHsnbPRR/4VcAQ3MVzCL2NyEs9ZR2sEsKHuV
        46S98c62GZReJnwZM2vBdFSOxn5oieseMYdZc29mrpIJUgNVqaFxsRj9Fu8blp7+D9Id3E
        HwCg92gGDzwfLEanuPd7ECVJDKI5mTA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-87-4j4WfSdhNKaDOq_1WYhz6A-1; Wed, 25 Mar 2020 12:11:47 -0400
X-MC-Unique: 4j4WfSdhNKaDOq_1WYhz6A-1
Received: by mail-wr1-f72.google.com with SMTP id y1so1365983wrn.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 09:11:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=WK74JkL+kdH++Ab+Y2UEWtM7+ELlujDygy01aFZtgRs=;
        b=a/MMyPxz41U0FOjMUuZIlJdEaB6pX41K6CxUoTaVQ0ckYams62yp3muLRUfOSC8Haq
         xXQGieCursEm+OEvKwxRBORDPWDhuAzG0Io+/KbT+xPToqHpi9QPETLTFa/yQzQXF3Li
         wymVYHlX9kYetkpiQEkFfORgSmJ66A6q0PZ9hOJAVdByuAWZOycg/g+kG+kHxlY7U40P
         y1n4fezGJgKr1eE1sIJwkebh3C4FxycCD49L+nGJBw0QnpSn8k8yEeMONXSXKvJNZqaZ
         h24v7FzjcluNYVyMc8XG+YHY/c9BDtGOJhc3ar1YXr7odc/6SpOLizHDZkJSLxKuZXuz
         h2zw==
X-Gm-Message-State: ANhLgQ3CZdUXO/nF62NiBq17enutwy6YyDbOZk/ShxJph8a/dBwlkJAv
        9mztO9PWlasJB5bLBfDECpljEvjM/lOrDui3AYxoKtfwf8fhelS5moc1Q1FO2CJZWrhhaZzE2BB
        wWs2L6CYIgsOvjtG8i/I8APRV
X-Received: by 2002:a1c:9e85:: with SMTP id h127mr3981643wme.145.1585152706092;
        Wed, 25 Mar 2020 09:11:46 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsYBX3PP2TE3uLGVZ5ua0iVAgFrVapbEo+dHcG+zgdrgx5u4qJ+y4Cikt03oJ6SuGqjHr8Abw==
X-Received: by 2002:a1c:9e85:: with SMTP id h127mr3981619wme.145.1585152705850;
        Wed, 25 Mar 2020 09:11:45 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id u5sm26527192wrq.85.2020.03.25.09.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 09:11:44 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Junaid Shahid <junaids@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        John Haxby <john.haxby@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v3 14/37] KVM: x86: Move "flush guest's TLB" logic to separate kvm_x86_ops hook
In-Reply-To: <20200325154810.GE14294@linux.intel.com>
References: <20200320212833.3507-1-sean.j.christopherson@intel.com> <20200320212833.3507-15-sean.j.christopherson@intel.com> <87369w7mxe.fsf@vitty.brq.redhat.com> <20200325154810.GE14294@linux.intel.com>
Date:   Wed, 25 Mar 2020 17:11:42 +0100
Message-ID: <87d0905s8x.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> On Wed, Mar 25, 2020 at 11:23:41AM +0100, Vitaly Kuznetsov wrote:
>> Sean Christopherson <sean.j.christopherson@intel.com> writes:
>> I *think* I've commented on the previous version that we also have
>> hyperv-style PV TLB flush and this will likely need to be switched to
>> tlb_flush_guest().
>
> Oh, you most definitely commented about HyperV's PV TLB flush, looking at
> that code is what led me down this rabbit hole :-)

Ah, I was just worried it's Groundhog Day all over again :-) And I
didn't see you touching hyperv.c 

-- 
Vitaly

