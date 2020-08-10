Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232F3C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 23:17:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECA41206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 23:17:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G2WMPWEn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbgHJXRT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 19:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgHJXRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 19:17:19 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA418C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 16:17:18 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id j19so2255052oor.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 16:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oDXx5xJz1b+wcw5C/YeihMWCNkvCnSl6ZWGflH/Camk=;
        b=G2WMPWEnEgkIw8rUO76xQAEFBkE1B8TahPRJXZpA0yt9brxalzEaXGQ0isAPxwO9iL
         Ema06xXbSyN/MsFCpcnyGBHNYrNTGO1SboHfjBYbaONgXoSEEwOY/SgM9HYLrh4HY2E1
         8jsIMI1TPmSvy9HKsJ943JNmid7GT/yJzmPFS2P1+eHAumMNv/8wkuFlnpm29MFVDWwg
         0BoGzPjEhxhaXjom8490dHZSWwUed5trgNt+x3AnoG2BhoTl1sLhBBNYTP8LqSQ3AnDT
         j9kkK8Maa1QKY4Yq7H6nYdZNSxzNHWzlff3jrlK4Td/TXQ9hWuCg9t/RJjw95nZD4EAY
         8EQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oDXx5xJz1b+wcw5C/YeihMWCNkvCnSl6ZWGflH/Camk=;
        b=j9o0ZSYHnYrdIdrPt7Cs6jGGBJJVXqeNwuS629hHhi+VRANNIMAbysOSeTWZiVG+Bz
         FIwxEAemKMvkQHf4HBDB+9p8HBIO6GaNnnPASqVySnjAEQPUVw8QJV6753LphmTSkAyH
         rtaXaDDQyK0TizX83hFY6YWdjYlFod0xjdWw5n6ikYjQ+DvUR94XLCGKW61CvFRj0zyk
         Cw/wnzkytysLQKWhZoaD4HSMxj2LYv/nKYjKHafVK0jm8tkzclr9XCXnfj0EDBtHQhUO
         F68L+YrjpFZssoayikNpkcxvOGnAbeRfKqZw5lX9h/AHhMt+EmGATNsX23YrvTTBNkQZ
         hLlA==
X-Gm-Message-State: AOAM532gJ8qTXxio3oL/njyN8dEPdoIsvFSHl1DGKBZBiVEAcHtbUthG
        rUA3cpq3xCUXqxBZbNKOuHUX3IgAkyLHcZH/nU9Xqg==
X-Google-Smtp-Source: ABdhPJzvzcF7MszhID1v28AVOZi5aWdqtP6b/SmecyE0nDYFxNGBZOHaye1qL2jOOIvYdQSFoNObyXBOJTJ89w+wQyE=
X-Received: by 2002:a4a:3015:: with SMTP id q21mr2815185oof.55.1597101437923;
 Mon, 10 Aug 2020 16:17:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200807084841.7112-1-chenyi.qiang@intel.com> <20200807084841.7112-2-chenyi.qiang@intel.com>
In-Reply-To: <20200807084841.7112-2-chenyi.qiang@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 10 Aug 2020 16:17:06 -0700
Message-ID: <CALMp9eSse8jkSC2B=7s7jbtQ1gnOgZokuhDgeu3-E93pi+g+Xg@mail.gmail.com>
Subject: Re: [RFC 1/7] KVM: VMX: Introduce PKS VMCS fields
To:     Chenyi Qiang <chenyi.qiang@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 7, 2020 at 1:46 AM Chenyi Qiang <chenyi.qiang@intel.com> wrote:
>
> PKS(Protection Keys for Supervisor Pages) is a feature that extends the
> Protection Key architecture to support thread-specific permission
> restrictions on supervisor pages.
>
> A new PKS MSR(PKRS) is defined in kernel to support PKS, which holds a
> set of permissions associated with each protection domian.
>
> Two VMCS fields {HOST,GUEST}_IA32_PKRS are introduced in
> {host,guest}-state area to store the value of PKRS.
>
> Every VM exit saves PKRS into guest-state area.
> If VM_EXIT_LOAD_IA32_PKRS = 1, VM exit loads PKRS from the host-state
> area.
> If VM_ENTRY_LOAD_IA32_PKRS = 1, VM entry loads PKRS from the guest-state
> area.
>
> Signed-off-by: Chenyi Qiang <chenyi.qiang@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
