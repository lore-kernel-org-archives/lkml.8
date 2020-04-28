Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCAB8C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 22:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9B8E206D9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 22:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pnjpc69a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgD1WNu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 18:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726256AbgD1WNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 18:13:49 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C29C03C1AD
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 15:13:49 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id k23so61084ios.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 15:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nt1cm16K5Y36Xh/ags5IlFDGPPNWI9tqZabQEk0lerk=;
        b=Pnjpc69a03aDBq/qhh2OAOK7R1vgOqgfEJpswJa4LrY0v9Mh4scs+TIZeMJ0a6XMen
         LhdW4Q9sQnXEozRdiuE07iBai0lTC9DGkjZ/rl5ODoasbAjHr7+Fo18rj5zn7s+40gNz
         iAvuQe2iImsfmV+sc1Ksjpa0s9JUBBMGSVGq0564FHWLONLCkA+bl7Hjy0c89Dvw9pSY
         LVU2xYmjBErDnRx3hFdMNDEX1aSi7sffi2hbUCTOAHzDMdm1pKnLo86JPq3gPdZfZAqY
         CP7PHW4+A/cda9B40s2k9nWBNneJLIKMn+i7aY7Q4zJGS8399VEZVJjtKcNxd9cc6MX1
         kzqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nt1cm16K5Y36Xh/ags5IlFDGPPNWI9tqZabQEk0lerk=;
        b=ogW++vleImXORWkZn+ULthxMqLC4Dab+jdDrx6MAmIRZBw3jloca0Rt0AKuX0Zrq2H
         7kT8cGCmmxTUvwCVDio6VQ//kWaXmUYXIFnoxKTiIQpTdadxCUUjVgO9K8q4J9qqqupZ
         ou6IB0nw5dcLuQlF5tOr7QfThP3T0H4aNSwpm1UpkY0+aBot6cdQOBlQkDM+rOZQuOVn
         MAQ49BQKyX4A8nYXSe0XJcQ1IV3bg0IBTUT+V0bH0wN1sHcWaphwC5Dyz1ax/BPnh2qc
         hKQyc1TdNMZLVtfFGPfkvaQvPBKh5wSMwJZk6bT8+SehUXAjt3MCjFvLa5+hUW0dUOe8
         c69g==
X-Gm-Message-State: AGi0PuZxWDi1eXw00W2dpMRfNBRe44qZGlzyeWQs9EWbEmBR0S9duWNN
        JL7Unaj9vF87UuV+UpOI08mGgt7l1KfrujJZ26zB+A==
X-Google-Smtp-Source: APiQypKr1XjkmQooE/lzZ/u45HwY4nKIHKWQktaVIhq1vSY/3xMLN9btT4nz5s5h8EBpad7gV6FTGcaNJpohL6Cfzxg=
X-Received: by 2002:a05:6638:bd0:: with SMTP id g16mr27868146jad.48.1588112028205;
 Tue, 28 Apr 2020 15:13:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200423022550.15113-1-sean.j.christopherson@intel.com> <20200423022550.15113-14-sean.j.christopherson@intel.com>
In-Reply-To: <20200423022550.15113-14-sean.j.christopherson@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 28 Apr 2020 15:13:37 -0700
Message-ID: <CALMp9eQ0hpZ8MBmCCEXQHKFxyeFzRbJ3+OmaTe2cMwtkp2AKGA@mail.gmail.com>
Subject: Re: [PATCH 13/13] KVM: VMX: Use vmx_get_rflags() to query RFLAGS in vmx_interrupt_blocked()
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
> Use vmx_get_rflags() instead of manually reading vmcs.GUEST_RFLAGS when
> querying RFLAGS.IF so that multiple checks against interrupt blocking in
> a single run loop only require a single VMREAD.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
