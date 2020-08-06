Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEDF7C433EA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:13:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09FEC22DFA
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:13:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cEoQlBQE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbgHFJWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 05:22:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59218 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729128AbgHFJUC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 05:20:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596705599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qbng0KIuhjnrRqPApXRDER8ey72aYykcRLaK9qO7KvA=;
        b=cEoQlBQEuqu+qCJvvxQttxVJScTJXz19QmuG29oAhVIiZESCVvIfHPT+4/zb9KMBnse6lQ
        RH0nCF4bcz5tZREwAz7At8ycBx9+vsrCtw+3qCWj5aMuIoxtpemKWEHl4IX4XxfpTg9X0B
        uR6Ij5yZiIc7K9CIDtucwRsPgzQW2AE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-MweavDV1P1Kqq0QdmHwjGA-1; Thu, 06 Aug 2020 05:19:58 -0400
X-MC-Unique: MweavDV1P1Kqq0QdmHwjGA-1
Received: by mail-ej1-f71.google.com with SMTP id y10so18403534ejd.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 02:19:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Qbng0KIuhjnrRqPApXRDER8ey72aYykcRLaK9qO7KvA=;
        b=SfiwPJCPPTzQbDp9vMdM7EqYoWQpis6DWXz3CmlhwnKK66rYTzlZaVv7Y60Uc09RHJ
         QWNGNNiVABuryUrcHzWnHQsHgTf+T1csLGj7E9QpiX0czNEi32I1ipApRmt5DtfOHfT2
         BzOEHTnBhdhU0AmnE6vMTOeImnotaZOApF/iYDzyL6U6rDzfMjeQ4n/2UAhBZW//OOli
         1pbeDVFe8dx1B0RdrBRllVDGWnkjpjEzscTchiEYQnG3Tft6TfJIpvlA8clqGnXf1xQs
         A2Upoo4+Std6SCPD1baxpOFcKQvR7j3zCfQBMTZA2Xn41VTP9zSoyCyTf6vTif+t2l/b
         /GPQ==
X-Gm-Message-State: AOAM532fznKM/UVeQvgnn/7SKHbIeuVlnkLsgU8X+3uj8s86lq3F4Fg5
        bhlYMP5LjqzCt3kCaGMrZBYHPlHdjgsf+UBShR+pepE0sarpigFSjgUlgY2wNaKJdIPQaCYcNMC
        hDVE0E+Yc198nqgGZ7eu8QNqC
X-Received: by 2002:a17:906:c1c3:: with SMTP id bw3mr3607430ejb.8.1596705596998;
        Thu, 06 Aug 2020 02:19:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxuRhDEaObKZG/m3SESq3Y56+cff+sBnsRhNDN/4SkNQ35QaOrvvNAQiLpZKC54ekRuuLKNEA==
X-Received: by 2002:a17:906:c1c3:: with SMTP id bw3mr3607421ejb.8.1596705596800;
        Thu, 06 Aug 2020 02:19:56 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id i9sm3312397ejb.48.2020.08.06.02.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 02:19:56 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Peter Xu <peterx@redhat.com>,
        Julia Suvorova <jsuvorov@redhat.com>,
        Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] KVM: x86: KVM_MEM_PCI_HOLE memory
In-Reply-To: <20200805201851-mutt-send-email-mst@kernel.org>
References: <20200728143741.2718593-1-vkuznets@redhat.com> <20200805201851-mutt-send-email-mst@kernel.org>
Date:   Thu, 06 Aug 2020 11:19:55 +0200
Message-ID: <873650p1vo.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Tue, Jul 28, 2020 at 04:37:38PM +0200, Vitaly Kuznetsov wrote:
>> This is a continuation of "[PATCH RFC 0/5] KVM: x86: KVM_MEM_ALLONES
>> memory" work: 
>> https://lore.kernel.org/kvm/20200514180540.52407-1-vkuznets@redhat.com/
>> and pairs with Julia's "x86/PCI: Use MMCONFIG by default for KVM guests":
>> https://lore.kernel.org/linux-pci/20200722001513.298315-1-jusual@redhat.com/
>> 
>> PCIe config space can (depending on the configuration) be quite big but
>> usually is sparsely populated. Guest may scan it by accessing individual
>> device's page which, when device is missing, is supposed to have 'pci
>> hole' semantics: reads return '0xff' and writes get discarded.
>> 
>> When testing Linux kernel boot with QEMU q35 VM and direct kernel boot
>> I observed 8193 accesses to PCI hole memory. When such exit is handled
>> in KVM without exiting to userspace, it takes roughly 0.000001 sec.
>> Handling the same exit in userspace is six times slower (0.000006 sec) so
>> the overal; difference is 0.04 sec. This may be significant for 'microvm'
>> ideas.
>> 
>> Note, the same speed can already be achieved by using KVM_MEM_READONLY
>> but doing this would require allocating real memory for all missing
>> devices and e.g. 8192 pages gives us 32mb. This will have to be allocated
>> for each guest separately and for 'microvm' use-cases this is likely
>> a no-go.
>> 
>> Introduce special KVM_MEM_PCI_HOLE memory: userspace doesn't need to
>> back it with real memory, all reads from it are handled inside KVM and
>> return '0xff'. Writes still go to userspace but these should be extremely
>> rare.
>> 
>> The original 'KVM_MEM_ALLONES' idea had additional optimizations: KVM
>> was mapping all 'PCI hole' pages to a single read-only page stuffed with
>> 0xff. This is omitted in this submission as the benefits are unclear:
>> KVM will have to allocate SPTEs (either on demand or aggressively) and
>> this also consumes time/memory.
>
> Curious about this: if we do it aggressively on the 1st fault,
> how long does it take to allocate 256 huge page SPTEs?
> And the amount of memory seems pretty small then, right?

Right, this could work but we'll need a 2M region (one per KVM host of
course) filled with 0xff-s instead of a single 4k page.

Generally, I'd like to reach an agreement on whether this feature (and
the corresponding Julia's patch addding PV feature bit) is worthy. In
case it is (meaning it gets merged in this simplest form), we can
suggest further improvements. It would also help if firmware (SeaBIOS,
OVMF) would start recognizing the PV feature bit too, this way we'll be
seeing even bigger improvement and this may or may not be a deal-breaker
when it comes to the 'aggressive PTE mapping' idea.

-- 
Vitaly

