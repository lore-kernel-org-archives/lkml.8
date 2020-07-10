Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A65C433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EF2E20657
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B6/Y2AU3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbgGJQbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 12:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbgGJQbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 12:31:07 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24006C08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 09:31:07 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id e64so6632879iof.12
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 09:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L5x+RXQcTKt3brgLCNXmzu/Q4sL3Ui6tQW0Y7yTVLkY=;
        b=B6/Y2AU3K+d29kPJXoL4LW3xcHmtRXC6hGouqLD94eTzfrcaV3Fglva7FhbL4FBWcn
         7CNit1lq96RQZfb339mk7OObuhLv9SvsOopZ5KKDqxtyUP5OkUl3So/xWJuSYxFPAnD0
         M+cC9gw93b5yvVZkCiPNJBcka2dTkqqMjjpN1B8/fJ/d2uYNUOhQbv2l2wjmIHMZJiV7
         JKgQOz8OPcH4mfjfFUrRPX+wgE/dFIBA7R+ynDnnOb99sDUc/8fY2mu0lZJMQGXNi5SM
         mdf35MSYI92URNmkPnr9bRMUTfCVa5SC6EUlRv+V61BsDiSWajXEiDX+k1gstuu/tsOB
         p2hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L5x+RXQcTKt3brgLCNXmzu/Q4sL3Ui6tQW0Y7yTVLkY=;
        b=QPwBIma8SuHGY/0Y/nU19x+U56gYBqg9gXOPCF7uZzxT1xwkDmFAKhCUYHjyxuKY+s
         CMQhajcOkGLMgmpVBdiv8CSi9OGVkRst2AA/+otUkWNfTsEy9iwbSdFMRMKmRyWoi91n
         HuJ6d4iD03GalScophooIBoMJLpvLE/BIu1cdJwzXB3L5Voeqq75+wQdAHPGOnhU+bNy
         wCu5XQHUY6hgZqT5CU3q72CN/u0785ArL9XwMaPA0VcNM11XNQqpcl7iu12qyIH5aQbg
         GJesM/Xfi61Yh0OXnbvjn5zUzhI4rysLtUTxYsZuRR0H8IbrGlvdOvddnrHQYaNhmrHv
         l2aw==
X-Gm-Message-State: AOAM5324SZuJ36ABayv/FJ7grnZLxYqCNz/sNEcmnV8dd+9X4JC0OJfK
        FgE8vwsEtljDyqkmk2v6iGYQZwJmIe/XUrqRXsrc2KZs
X-Google-Smtp-Source: ABdhPJz4f+wmTdCN8HsvGt2xu/V0GtBoahjoaJjauggHLbwoRMsmtNf5nAOu00p52lQl8ZVL2r2qaIf0UU+lXGLR09U=
X-Received: by 2002:a5e:c311:: with SMTP id a17mr18924402iok.12.1594398666301;
 Fri, 10 Jul 2020 09:31:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200710154811.418214-1-mgamal@redhat.com>
In-Reply-To: <20200710154811.418214-1-mgamal@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 10 Jul 2020 09:30:55 -0700
Message-ID: <CALMp9eRfZ50iyrED0-LU75VWhHu_kVoB2Qw55VzEFzZ=0QCGow@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] KVM: Support guest MAXPHYADDR < host MAXPHYADDR
To:     Mohammed Gamal <mgamal@redhat.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 8:48 AM Mohammed Gamal <mgamal@redhat.com> wrote:
>
> When EPT is enabled, KVM does not really look at guest physical
> address size. Address bits above maximum physical memory size are reserved.
> Because KVM does not look at these guest physical addresses, it currently
> effectively supports guest physical address sizes equal to the host.
>
> This can be problem when having a mixed setup of machines with 5-level page
> tables and machines with 4-level page tables, as live migration can change
> MAXPHYADDR while the guest runs, which can theoretically introduce bugs.

Huh? Changing MAXPHYADDR while the guest runs should be illegal. Or
have I missed some peculiarity of LA57 that makes MAXPHYADDR a dynamic
CPUID information field?

> In this patch series we add checks on guest physical addresses in EPT
> violation/misconfig and NPF vmexits and if needed inject the proper
> page faults in the guest.
>
> A more subtle issue is when the host MAXPHYADDR is larger than that of the
> guest. Page faults caused by reserved bits on the guest won't cause an EPT
> violation/NPF and hence we also check guest MAXPHYADDR and add PFERR_RSVD_MASK
> error code to the page fault if needed.
