Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B6CC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 10:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BFF2206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 10:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HoTrQxvc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgIAKhQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 06:37:16 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:47435 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725848AbgIAKgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 06:36:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598956605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AEINv34Fu2CdWohARgHW6X/rv0Y1PeRzDZvhyy6A9Hw=;
        b=HoTrQxvcHi1OEOdzfxI14tpuQCdDOcvLSJ6phrToeRFHXDQMYY/lkX5dZqN9pP/RxGCzv6
        9F8CAsXotDdXSzkRXqS8GUkHZDiWx/tOfsX+Ph3NjLlBVUh/zRUxGzgFwMUJPPzdV55+JX
        sGSc4csbWRHcByRjdDdRfwGnBYgh6vM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-xYCpb0hHMqODDjR1DAacTw-1; Tue, 01 Sep 2020 06:36:44 -0400
X-MC-Unique: xYCpb0hHMqODDjR1DAacTw-1
Received: by mail-wr1-f72.google.com with SMTP id m7so393710wrb.20
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 03:36:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=AEINv34Fu2CdWohARgHW6X/rv0Y1PeRzDZvhyy6A9Hw=;
        b=aQyNRNs8AfSbyv19ui/V/SqHqC73SeTUtEh2cobNJEQRY3hmihb45rbDg/50/00QmZ
         U6CMA1O0hhY+/Bd9lfhQOgR+KEElIgQhA48lCz6bx6A7CaIwsuSwZT0+VUSlt6UHrD+e
         jL8sU9sCB8LMHQav8eAbXD3bBsnW1BqK8qz8YM1vg04uMl9zOzdJ2vDr0KCE+aX9M0U2
         uMd+5hwcuIvYQ0PQ9kFCCKHhQvjOjzBZ0owaVRkT6jwRYinV5U9OfsV3rie3cxQyCJIO
         DW3lNQAPLgwhsFnL7R8lltFOlW+aQn+p5QBkm2ImUIhqZuuCxQpCCNyPLi7ihK+/Rc+R
         +vhQ==
X-Gm-Message-State: AOAM531NUzXwjdKZHg5PhxrVAjZ/ONUnsF4P0aS0urLXKE+CO/2FZLDo
        xdjsh2DZ4X6xo65ZKFfpUK63Rj0Pst6AXL3uEPeBfe592uJOR5qJdSGhuOjye5FUy1qWogyiWwJ
        dYjdiJitBoBJuDW/zi33Gnequ
X-Received: by 2002:adf:8b1d:: with SMTP id n29mr1078499wra.383.1598956602597;
        Tue, 01 Sep 2020 03:36:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy3p55BcW/B1gRIkaQp0176fOY3DHBYTFK/XSRZMR0fLQx7LPfXuDNXAxisUTOh0txmQK8fNw==
X-Received: by 2002:adf:8b1d:: with SMTP id n29mr1078479wra.383.1598956602379;
        Tue, 01 Sep 2020 03:36:42 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id w1sm1318093wmc.18.2020.09.01.03.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 03:36:41 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KVM: VMX: fix crash cleanup when KVM wasn't used
In-Reply-To: <20200825000920.GB15046@sjchrist-ice>
References: <20200401081348.1345307-1-vkuznets@redhat.com> <CALMp9eROXAOg_g=R8JRVfywY7uQXzBtVxKJYXq0dUcob-BfR-g@mail.gmail.com> <20200822034046.GE4769@sjchrist-ice> <CALMp9eRHh9KXO12k4GaoenSJazFnSaN68FTVxOGhE9Mxw-hf2A@mail.gmail.com> <CALMp9eS1HusEZvzLShuuuxQnReKgTtunsKLoy+2GMVJAaTrZ7A@mail.gmail.com> <20200825000920.GB15046@sjchrist-ice>
Date:   Tue, 01 Sep 2020 12:36:40 +0200
Message-ID: <87pn75wzpj.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> On Mon, Aug 24, 2020 at 03:45:26PM -0700, Jim Mattson wrote:
>> On Mon, Aug 24, 2020 at 11:57 AM Jim Mattson <jmattson@google.com> wrote:
>> >
>> > On Fri, Aug 21, 2020 at 8:40 PM Sean Christopherson
>> > <sean.j.christopherson@intel.com> wrote:
>> > > I agree the code is a mess (kvm_init() and kvm_exit() included), but I'm
>> > > pretty sure hardware_disable_nolock() is guaranteed to be a nop as it's
>> > > impossible for kvm_usage_count to be non-zero if vmx_init() hasn't
>> > > finished.
>> >
>> > Unless I'm missing something, there's no check for a non-zero
>> > kvm_usage_count on this path. There is such a check in
>> > hardware_disable_all_nolock(), but not in hardware_disable_nolock().
>> 
>> However, cpus_hardware_enabled shouldn't have any bits set, so
>> everything's fine. Nothing to see here, after all.
>
> Ugh, I forgot that hardware_disable_all_nolock() does a BUG_ON() instead of
> bailing on !kvm_usage_count.

But we can't hit this BUG_ON(), right? I'm failing to see how
hardware_disable_all_nolock() can be reached with kvm_usage_count==0.

-- 
Vitaly

