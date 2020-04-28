Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5CBC83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 22:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E58D1206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 22:07:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KO6SmP63"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgD1WHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 18:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726272AbgD1WHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 18:07:50 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A94C03C1AD
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 15:07:50 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id c16so521686ilr.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 15:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tO+DbU6KByMbcPRw+6fwaWiCfeYN7nbol6e4reDVW4I=;
        b=KO6SmP63VTyTeoVjCJWFexYShARMTWk/xWvofiwo+kHGO9i/UDgHdyyCCoXkK4QH5l
         ZjT1dkx6I6kmN3S/hKj8qJ9eEDqbmeIL8Po8V0gxgReZgJ6c3LBUv3FMiZ3ofGbtnJJw
         eDZUCwiRljta71iiCpa4A+H2PO2athl9CEgH0UX8soxSGvvZUo1I89OmlyUQXN8S33KW
         Oph7WTf1SgbMsQBJGiy1esxg+6s2gw1w4AsWiTpwNFAxfH0phtZLPXk2dyYXiIh4f+v3
         sEll7nAgPDTmrwiBwjWMcbaHtVNYHOWYMHIxQJHuyow+P3uPA7awaSWg6BdysGz3NyCN
         sKdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tO+DbU6KByMbcPRw+6fwaWiCfeYN7nbol6e4reDVW4I=;
        b=uJV8A+cNuk0+Say2DD4lgVkeB965DdHfKg2PxVE/Nt0zCV36u0MQyV8TM/b3fjBFpQ
         Oue56WruimbAwBVtLVKNGD3BvlHHsrkPQ0Cw6sAi6bMIZz00U8TKOD4vn+ZF6L4Kzn4y
         X+gwSvkfCAlqbAJbXqbLDv8sfVVQarjlO5AgMxwDDgs3uwfrn2JTTu3VQMgp0ft4K8Ot
         VYg8oeTKkKhTFvk4emm1r2zg6YS51xNH5v2m2wEEV/nsOVpF/oRf5aiS2aBS2IX6YJV3
         FgyFMloEkWlS4+26CET6KQADOCvvYWbaU6uf/CSjav45sUY4zmpxXra41ibxKTC5hWzW
         Mrxw==
X-Gm-Message-State: AGi0PuYPXBSE+tBXPNCc/IRynRSSCZYXBD0FDjPYHHhT0HQCwdlkclTH
        iNDH9EEz4/NQVbIGxquSALIcv3EzPJQkLQmWkeIkUA==
X-Google-Smtp-Source: APiQypKs0cmslzkJ3/IcooJcMOg8zkJMwhBrgReyRcwYDpGk5UtUrhKE6RN9vlWUAMwJZzxOofrOHp1/2jrvavOGpIk=
X-Received: by 2002:a92:d186:: with SMTP id z6mr27561585ilz.119.1588111669486;
 Tue, 28 Apr 2020 15:07:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200423022550.15113-1-sean.j.christopherson@intel.com> <20200423022550.15113-12-sean.j.christopherson@intel.com>
In-Reply-To: <20200423022550.15113-12-sean.j.christopherson@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 28 Apr 2020 15:07:38 -0700
Message-ID: <CALMp9eQybxs+Zq66uAfVz3bc=571V7H8YVEhm7AuftpcZ5NLRw@mail.gmail.com>
Subject: Re: [PATCH 11/13] KVM: VMX: Use vmx_interrupt_blocked() directly from vmx_handle_exit()
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
> Use vmx_interrupt_blocked() instead of bouncing through
> vmx_interrupt_allowed() when handling edge cases in vmx_handle_exit().
> The nested_run_pending check in vmx_interrupt_allowed() should never
> evaluate true in the VM-Exit path.
>
> Hoist the WARN in handle_invalid_guest_state() up to vmx_handle_exit()
> to enforce the above assumption for the !enable_vnmi case, and to detect
> any other potential bugs with nested VM-Enter.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
