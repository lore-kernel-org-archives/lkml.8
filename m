Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A73C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6275C22D00
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DDlDKTDb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbgHERHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728489AbgHERF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:05:58 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97400C06179E
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 10:05:54 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id v6so31401987iow.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 10:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fBJV0XruchpYgDI1qMU6kXVYMvuaojqcy/VM/BfhHS4=;
        b=DDlDKTDb/0WHPHlQszr8T/dicZ3JvB4fFR88fjW3PYNXn4Bd1sOBHkO14IfBQN8Kzh
         wW8hvZGObDj1LUEztpmRYNVUjkSGbX9qyi02lldsKk72wxUXVKWu5CWFbhAWtfQn4TMN
         63WibHCjsj6FWC078lkCBf7/E3a8z4dWQFw1y8Cugeyb89wnvH4FYd4FiEQDGXaUQZ5R
         hAx8fkejSXcWdQJTeHgHVzIFmTdNLFra23jvNnZDA8dVXvtPgm0wPyE8T5NteTKpHUnp
         7Vh0NuAPJbKmXEVGBtIJWc/WQ0DOUBfE5Wi4IsL0+v86q4+xHk7bbof7HBChNKrE0TEi
         BUvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fBJV0XruchpYgDI1qMU6kXVYMvuaojqcy/VM/BfhHS4=;
        b=oXraB0UsLiiyFeSzSXYOBKl6gW3rmZygI0zfQ9jXBM3K5cx34CXRey/OMA6yquvVlw
         3kZxHXI4zwSCmx9KaMwdFxoykSJSCYrdnpFYkBfF0G6pNR5N+Y0TF4qqalfhXhLy7W8G
         qncFhmBH3WogFlerNeNsS1zIm0QMz/ekA7Cfh9k1pieGe7TXrLsJqHiWg92HuU/eX6UN
         AGGP0ybGD6PtOU0OB8fX9lphR1ybJTo9U3qdKewXJi/Q5uQ7O8pz3cm8WpFVDQAZMQ4t
         JaaiE9+AV6+FfCdfPYbHHZ+aktmdJAue+bwY9lSETvLb2ZVcOY6UHsUEskDg1u10D5IL
         uMyw==
X-Gm-Message-State: AOAM532he2150l40S7BCfvoVk8qdNwgczdNfRGh7KmxpXbgZRdrhRtLX
        DIDfenXiH7uVlzYqLxub2uwFDJdslB23pj5W+F4LTQ==
X-Google-Smtp-Source: ABdhPJytYzCJbS45tauBAiUZxFGUgBBjr+Uns//aaQKG0bhrMyRYe2msAgYn/W/ZmBM7UHzdKHfygm67zRHOOqVWsNE=
X-Received: by 2002:a6b:c3cf:: with SMTP id t198mr4294638iof.164.1596647152347;
 Wed, 05 Aug 2020 10:05:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200728143741.2718593-1-vkuznets@redhat.com> <20200728143741.2718593-3-vkuznets@redhat.com>
In-Reply-To: <20200728143741.2718593-3-vkuznets@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 5 Aug 2020 10:05:40 -0700
Message-ID: <CALMp9eSWsvufDXMuTUR3Fmh91O7tHUaqpDbAoavSMc=prpcDzg@mail.gmail.com>
Subject: Re: [PATCH 2/3] KVM: x86: introduce KVM_MEM_PCI_HOLE memory
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Peter Xu <peterx@redhat.com>, Michael Tsirkin <mst@redhat.com>,
        Julia Suvorova <jsuvorov@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 7:38 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> PCIe config space can (depending on the configuration) be quite big but
> usually is sparsely populated. Guest may scan it by accessing individual
> device's page which, when device is missing, is supposed to have 'pci
> hole' semantics: reads return '0xff' and writes get discarded. Compared
> to the already existing KVM_MEM_READONLY, VMM doesn't need to allocate
> real memory and stuff it with '0xff'.

Note that the bus error semantics described should apply to *any*
unbacked guest physical addresses, not just addresses in the PCI hole.
(Typically, this also applies to the standard local APIC page
(0xfee00xxx) when the local APIC is either disabled or in x2APIC mode,
which is an area that kvm has had trouble with in the past.)
