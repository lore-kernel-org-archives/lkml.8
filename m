Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D5CC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 22:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D54F420656
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 22:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oT1aUzp1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgG2WZe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 18:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbgG2WZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 18:25:34 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF1CC061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 15:25:33 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id k23so26206657iom.10
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 15:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OQix/zi4zcvd/1V7gOM1KOXd4VNs5uUsD1lxq267omk=;
        b=oT1aUzp1Cir3SIhEKVPCMyczX6Log3jJ7mmwHY7j0ylzXfZ5lrcA7yqpK7cj+g5o+f
         BZMIHKb/fiN/31wb9sLVPD0NTUoN7fC8D1VqvcmJAB72MsTmNoF/boxmI1SGyAfVetAA
         yQV7muOMvPv1VPhdDzEaMZJcwVkr3w4BrlteFkLHdqcF59LcCwfNRXViQFFkIA7WL5v5
         CCLM3IFKXpZet4mPOQykBg8CrhOiTBrx4Ad+OIIY/cpRiuZG3VlH1lgz9aWQWd55BQdg
         A2GX2MTSW9QdjsS8oFLJhgI1c5uppJtRRKzoz7L2lOptiiQDDpHB70ej1UIVM8Zg3NQV
         g4ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OQix/zi4zcvd/1V7gOM1KOXd4VNs5uUsD1lxq267omk=;
        b=YWZYCYgQbusHNFVLE+m1OqMxwxZ+qWcq668RmzxeQvDR+CWQK3B5EwLZQwl41cuF0y
         7SINeRL0FXdNGWqPkv6sVJMzy1WGA3uJ3EvcsHqq4mfvowF6CNuMLWOsvfRnnGxlkodr
         mR2oIqJlHs2e460BlK9mtzjwhizHph7muy50cwvFSd097MoRUFhX7i2A7z5KQ9Gqa0k6
         0LB4mMYGxHSfTQoO+VUlX2LLOTXtBQOowHeKHCjFlXMM4qg6CIjVwnUNDWyvjS5aYdxq
         vFCeDr1Zq/PdLj1jDMpcALm97+elSxEtZsDndNiUxjNrzEY0AbQd/sxglz9xKwmpFhLB
         liVQ==
X-Gm-Message-State: AOAM5300jKWR5dfuDNp+lekWRn4rcmosO6gYJ1HXYYcBMlkijGz3tnQH
        Sq5KxLDODt8G0Y6XPpTedBqtp/j2DRJndGl+aOUAqg==
X-Google-Smtp-Source: ABdhPJw5CPuJri7GLgSp032H+EdTGOED3fpS21Kngu5E8Ar7I8+zuLM/XzSkDyl9zW6btwwI0Y6z0glEGB52/kl00+Y=
X-Received: by 2002:a02:394c:: with SMTP id w12mr266083jae.18.1596061533081;
 Wed, 29 Jul 2020 15:25:33 -0700 (PDT)
MIME-Version: 1.0
References: <159597929496.12744.14654593948763926416.stgit@bmoger-ubuntu> <159597953280.12744.625668493094858788.stgit@bmoger-ubuntu>
In-Reply-To: <159597953280.12744.625668493094858788.stgit@bmoger-ubuntu>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 29 Jul 2020 15:25:22 -0700
Message-ID: <CALMp9eS+u_NS6PCB5pqGoeCad0Q04pMpfy0f74Af1LOWZA6Xhg@mail.gmail.com>
Subject: Re: [PATCH v3 10/11] KVM: X86: Move handling of INVPCID types to x86
To:     Babu Moger <babu.moger@amd.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        kvm list <kvm@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 4:38 PM Babu Moger <babu.moger@amd.com> wrote:
>
> INVPCID instruction handling is mostly same across both VMX and
> SVM. So, move the code to common x86.c.
>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
