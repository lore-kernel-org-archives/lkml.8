Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025CAC2D0F7
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 16:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4727206CC
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 16:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ASZGgjTa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgELQj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 12:39:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbgELQj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 12:39:57 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F729C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 09:39:57 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id s10so14685556iog.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 09:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tP/faLZShTgp+fPnBxemdUnPXhPkkCPH8J5S52+7MLU=;
        b=ASZGgjTaWCMSfoQTN/jSdtkLyIHDiydjcLiip00K/ZanY8QgGXMuSEQxFzRkc6xg22
         vN10lF1UkQ3xHNxWZE+x4wCFZSfqSwDDQX40gypYG7ydUN9XOkkv5YOx12ejP4TKnBKd
         trbq9MJ+Gl/yyePs9oOHruIE6iRqZ7oYeboL6eA/Nk+5y8KxH+lxM9Gs51rikD7jTi/R
         IWy8qOaZYt9oGkITDvyTPw7TiDSAq7Hgh7+Ey2aihIbGZMcro93gz20zlzz/uCwmuczl
         Cjirkxj+RQgxmijs12eWPK+JnAEtKjolgIzcUf8ariiLeULaCscg+STnJn9w+w3oiXqY
         zB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tP/faLZShTgp+fPnBxemdUnPXhPkkCPH8J5S52+7MLU=;
        b=R5nQiS0iyBisuHyvWvaTGRji0AAQG5/+CeiN9Fa6W9v2AQ5mm41qQN+lqFdeBZoOZ0
         CGi59iviNxWWEScma4fmHWfybkcExWqdny5PT9bp5ZV/NFObEgEorKtk70GF3atBEPyF
         OGk7mqiAnCplytVpRyqiuVyS10Ij2NC4ZVldaZGWJmKMjfyUu01sZmMGn1l44K2hp86M
         RZMQ/m//NsCS6KpqbF4izztQEcOAbNp6iTTBnXVMWzyC3QZmAHp1iHOGPJuRECKdJAPf
         0CTogdA0mBIqye9MESX94ehnP4UCi+DqlBF68wyMYrNCA7ONx2nFyPeOfZADZOWSJW6S
         6gaw==
X-Gm-Message-State: AGi0PubAieZhgwIQTYYOwiANah9NpI10nAUbusyQDUDHnsOCMkm9hmsK
        J4gtHz4we7s3nZ3QoP+K2dfHZt4Q4RQjqmroA84Kaw==
X-Google-Smtp-Source: APiQypJ4SiTUd1EPl8BSHjrzsB/uekp7Rpjwcdx9bsqge9HnpqrfDoFAJtY3wySPH0ydPFr8uOgKqSjXeUI/bxAolpo=
X-Received: by 2002:a6b:1cc:: with SMTP id 195mr9820714iob.177.1589301596233;
 Tue, 12 May 2020 09:39:56 -0700 (PDT)
MIME-Version: 1.0
References: <158923982830.20128.14580309786525588408.stgit@naples-babu.amd.com>
 <158923998430.20128.2992701977443921714.stgit@naples-babu.amd.com>
In-Reply-To: <158923998430.20128.2992701977443921714.stgit@naples-babu.amd.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 12 May 2020 09:39:44 -0700
Message-ID: <CALMp9eSAnkrUaBgtDAu7CDM=-vh3Cb9fVikrfOt30K1EXCqmBw@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] KVM: x86: Move pkru save/restore to x86.c
To:     Babu Moger <babu.moger@amd.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        mchehab+samsung@kernel.org, changbin.du@intel.com,
        Nadav Amit <namit@vmware.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        yang.shi@linux.alibaba.com,
        Anthony Steinhauser <asteinhauser@google.com>,
        anshuman.khandual@arm.com, Jan Kiszka <jan.kiszka@siemens.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        steven.price@arm.com, rppt@linux.vnet.ibm.com, peterx@redhat.com,
        Dan Williams <dan.j.williams@intel.com>,
        Arjun Roy <arjunroy@google.com>, logang@deltatee.com,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>, justin.he@arm.com,
        robin.murphy@arm.com, ira.weiny@intel.com,
        Kees Cook <keescook@chromium.org>,
        Juergen Gross <jgross@suse.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        pawan.kumar.gupta@linux.intel.com,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        vineela.tummalapalli@intel.com, yamada.masahiro@socionext.com,
        sam@ravnborg.org, acme@redhat.com, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 4:33 PM Babu Moger <babu.moger@amd.com> wrote:
>
> MPK feature is supported by both VMX and SVM. So we can
> safely move pkru state save/restore to common code. Also
> move all the pkru data structure to kvm_vcpu_arch.
>
> Also fixes the problem Jim Mattson pointed and suggested below.
>
> "Though rdpkru and wrpkru are contingent upon CR4.PKE, the PKRU
> resource isn't. It can be read with XSAVE and written with XRSTOR.
> So, if we don't set the guest PKRU value here(kvm_load_guest_xsave_state),
> the guest can read the host value.
>
> In case of kvm_load_host_xsave_state, guest with CR4.PKE clear could
> potentially use XRSTOR to change the host PKRU value"
>
> Signed-off-by: Babu Moger <babu.moger@amd.com>

I would do the bugfix as a separate commit, to ease backporting it to
the stable branches.
