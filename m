Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3D8C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 17:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5464B20637
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 17:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gwLvACi/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbgCORxs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 13:53:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53268 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728985AbgCORxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 13:53:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584294826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4sCAV6YPEIN4XPv5c8gxRua4pipL3WppoMnmoXzPK/Y=;
        b=gwLvACi/FapZ6/fjGzEYJhYtbAOvrPoqlx/QgHrk9cGpHR6SUrgjpe8DAWgAVKj0zRNRcM
        f33m3+DIQocwGRoPbsLTJSkc1gCr0HH7mrglrvooWHnqi0obKWwiJu7NuaWfbS6KlfLFD2
        aS7+xvWTv5goFLEicMZtdq3yLYh6ZjE=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-9PBbbQEiP66ti7Jz7OlvVw-1; Sun, 15 Mar 2020 13:53:44 -0400
X-MC-Unique: 9PBbbQEiP66ti7Jz7OlvVw-1
Received: by mail-io1-f71.google.com with SMTP id d16so10154775iop.17
        for <linux-kernel@vger.kernel.org>; Sun, 15 Mar 2020 10:53:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4sCAV6YPEIN4XPv5c8gxRua4pipL3WppoMnmoXzPK/Y=;
        b=opmVRA4susqzl5IA+npZAFPUQBsXbQnTRsAlDcpjT9lQeWV2/ONqif7TLOuU+XD6dx
         3AUH9XWoV+VtCnyY3B0DfcCnh00lVZZHmERKod7fV3P4AY4flGLjhT7fODr9+LR9IGpD
         cQ9+I4iNb1VBgFkP6Bp5SXu0hYPTzgoNJbUwp+ypGkKzp2dYAX+IFTa38cb8gk/ifZ0c
         bWHinvA5wtIW1BUl52o8QaQHuz9PYzyyq5Bt6vDqOPt3N2k02IF4C0QkLt6NjWPyxCcD
         Uhoxpecgpw8pePRIFjOt+QBCJdJhTSbbh1ZGVfcZnB7Bf8Wljh78yLGGRdAkR1kGFger
         4JYw==
X-Gm-Message-State: ANhLgQ0jZ+qqLE5lDuajy2yBeZJdgftPYXhm88ffcXwTwzCRvURPphOy
        uR+NMYVmUQ14dGj1sGPEXRZGglF8O2EIsfxyLN2ByQpUAMbn+9HzdB2f+BbVvDIFVInVqHptacp
        foPF8jyfHf6/G5nr0y9nUk+RYeDG56Xs+H4qXo+Tp
X-Received: by 2002:a05:6e02:685:: with SMTP id o5mr24142751ils.86.1584294824283;
        Sun, 15 Mar 2020 10:53:44 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vv5rfYob+x+SH8BDGDVnTOHAxWdTolLX/Uz7HHyi5g6stxSZI9yXG9waJeMX3XmVStg/i9g2MSrXdDSJkvVEns=
X-Received: by 2002:a05:6e02:685:: with SMTP id o5mr24142734ils.86.1584294824017;
 Sun, 15 Mar 2020 10:53:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200303233609.713348-1-jarkko.sakkinen@linux.intel.com>
 <20200303233609.713348-22-jarkko.sakkinen@linux.intel.com>
 <CAOASepPi4byhQ21hngsSx8tosCC-xa=y6r4j=pWo2MZGeyhi4Q@mail.gmail.com> <20200315012523.GC208715@linux.intel.com>
In-Reply-To: <20200315012523.GC208715@linux.intel.com>
From:   Nathaniel McCallum <npmccallum@redhat.com>
Date:   Sun, 15 Mar 2020 13:53:33 -0400
Message-ID: <CAOASepP9GeTEqs1DSfPiSm9ER0whj9qwSc46ZiNj_K4dMekOfQ@mail.gmail.com>
Subject: Re: [PATCH v28 21/22] x86/vdso: Implement a vDSO for Intel SGX
 enclave call
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@intel.com,
        "Christopherson, Sean J" <sean.j.christopherson@intel.com>,
        Neil Horman <nhorman@redhat.com>,
        "Huang, Haitao" <haitao.huang@intel.com>,
        andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
        "Svahn, Kai" <kai.svahn@intel.com>, bp@alien8.de,
        Josh Triplett <josh@joshtriplett.org>, luto@kernel.org,
        kai.huang@intel.com, David Rientjes <rientjes@google.com>,
        cedric.xing@intel.com, Patrick Uiterwijk <puiterwijk@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Jethro Beekman <jethro@fortanix.com>,
        Connor Kuehl <ckuehl@redhat.com>,
        Harald Hoyer <harald@redhat.com>,
        Lily Sturmann <lsturman@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 14, 2020 at 9:25 PM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Wed, Mar 11, 2020 at 01:30:07PM -0400, Nathaniel McCallum wrote:
> > Currently, the selftest has a wrapper around
> > __vdso_sgx_enter_enclave() which preserves all x86-64 ABI callee-saved
> > registers (CSRs), though it uses none of them. Then it calls this
> > function which uses %rbx but preserves none of the CSRs. Then it jumps
> > into an enclave which zeroes all these registers before returning.
> > Thus:
> >
> >   1. wrapper saves all CSRs
> >   2. wrapper repositions stack arguments
> >   3. __vdso_sgx_enter_enclave() modifies, but does not save %rbx
> >   4. selftest zeros all CSRs
> >   5. wrapper loads all CSRs
> >
> > I'd like to propose instead that the enclave be responsible for saving
> > and restoring CSRs. So instead of the above we have:
> >   1. __vdso_sgx_enter_enclave() saves %rbx
> >   2. enclave saves CSRs
> >   3. enclave loads CSRs
> >   4. __vdso_sgx_enter_enclave() loads %rbx
> >
> > I know that lots of other stuff happens during enclave transitions,
> > but at the very least we could reduce the number of instructions
> > through this critical path.
>
> What Jethro said and also that it is a good general principle to cut
> down the semantics of any vdso as minimal as possible.
>
> I.e. even if saving RBX would make somehow sense it *can* be left
> out without loss in terms of what can be done with the vDSO.

Please read the rest of the thread. Sean and I have hammered out some
sensible and effective changes.

