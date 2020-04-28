Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D688EC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E04720730
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jzYQ2rTc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726431AbgD1Vmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726272AbgD1Vmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 17:42:44 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4425CC03C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 14:42:44 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id z2so24982701iol.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 14:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rfmlo41ts2i7Zcv0kqVybUxAnbR3sTlhoiDkLxdhqcM=;
        b=jzYQ2rTc5iGSeW867YpgJb0e0aw2v+lG7u1PpshHvK+b6XV/dUh6YTFnf/tFVjoHSL
         BU4n4+hcpwwPAURGSbzgxuxkjBKwGmDDH8fhJ6Noim6yF2Ko55IlWL3GaMHWQIEE85z8
         stYWqfldjztBG7VdjBUxgxmYYt7ch8ZcywOPIpqIy8JW+yYySgvhJYT/a2dBQLTPNYo6
         TtGt6ctYXhojzWnBpNIFQzBu/3qfIkUvqHKv/BAXbgbmwYbakHDJ4C2IA1PvjgV2JQK5
         3zqvrwVubOUgBRTJ59l1iaxH/JjFjMKorIeIuTq3Oo0trW8vjEUnPKDt2enyUWMjCT9R
         lGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rfmlo41ts2i7Zcv0kqVybUxAnbR3sTlhoiDkLxdhqcM=;
        b=qz/a30Zz4+wQyNrHDB/vJs86KPWdNEruvXdyhAduM5XuyAG8a4IX3nxXouV4AtYxij
         nzGBdu7yikWIILKzC9adUBbQBPbgf8xehs2+1B46x7Vi21r0kq7Oqg00vR3RPdqo0SU7
         poiUCobRj1iXa2FkywisXnsDNpogDW6vpynF3Iik3MIWlKaC/cDE9wIpl1mNl+s/74RD
         wfnVt0otNOwjNg8EH4HHXVtHKKaFV0PL9NWVhjGYXOfhcgkginCVCk9jqkB5SjWFfiWt
         fHyhEnkP9bml2ZfbEtqE9QHkmPE5H0VVb8U2TCMNNzfUQtk+9UqkYJMGPvDAisptHa3M
         mZ+Q==
X-Gm-Message-State: AGi0PuYDTLBCtSIRZa92PX2oMPD7v9fZvAo3QJPJuN4LfM+0VExboapD
        6RamjK3q/OHZMI3DmqiNEVNOBGHDxgCaC4iYV+XBtw==
X-Google-Smtp-Source: APiQypK7/mohAHqrxGWpCG7N79ayXvDCuEmqwdOh2T1wVp1srOrMpFaJDheHtIywUbwKQ4GJrCnqek9FIrXvz7vYYDc=
X-Received: by 2002:a05:6638:bd0:: with SMTP id g16mr27759289jad.48.1588110163502;
 Tue, 28 Apr 2020 14:42:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200423022550.15113-1-sean.j.christopherson@intel.com> <20200423022550.15113-5-sean.j.christopherson@intel.com>
In-Reply-To: <20200423022550.15113-5-sean.j.christopherson@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 28 Apr 2020 14:42:32 -0700
Message-ID: <CALMp9eRPfvsx+uu4RFbDiLrL4pY9_NiZkivWqUi8gUSAMHv-ZA@mail.gmail.com>
Subject: Re: [PATCH 04/13] KVM: x86: Make return for {interrupt_nmi}_allowed()
 a bool instead of int
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Oliver Upton <oupton@google.com>,
        Peter Shier <pshier@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 7:26 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> Return an actual bool for kvm_x86_ops' {interrupt_nmi}_allowed() hook to
> better reflect the return semantics, and to avoid creating an even
> bigger mess when the related VMX code is refactored in upcoming patches.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
