Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB35C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C68E20575
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 14:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hZq4KeEH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731464AbgCPOBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 10:01:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57202 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729456AbgCPOBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 10:01:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584367314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aj2KXeyFDH3IYVMv4TZ9mZAZkyhD8QEE0CToBGEvBf4=;
        b=hZq4KeEHST56H7MXptDA0ABD/IUUSxzInM28UGBRueGXIiO7HHD8OtIgGtmwMz5hm+Rolo
        sWdqjYTGFQ9heOt+dpjksT44cgKjUfdPaDTRSPaugh0qe8T2PZI4jsNtRlW+XRVL4XBXPJ
        H1YFwRMvOInSOX4pj4qDEQjyUgsn/5U=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-WUin5yEzOweQ14MeqkS2LQ-1; Mon, 16 Mar 2020 10:01:51 -0400
X-MC-Unique: WUin5yEzOweQ14MeqkS2LQ-1
Received: by mail-io1-f70.google.com with SMTP id d13so11601965ioo.23
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 07:01:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aj2KXeyFDH3IYVMv4TZ9mZAZkyhD8QEE0CToBGEvBf4=;
        b=FCeaDaaZvxZyZqELvN4zcF3HkvoVTVVy2bR3i4CubFAwYi/Qp0SGM/z0x9qNR1IC6J
         ociD0QTca8yb9WkXTx/9MFYUjcqjhuDGRI2PGojC7+WPsI4uwavid8vlLATGw7hbY1Hi
         6WNmRD3UbxtudgaQZiDVvCitEiK75etYpkZ6co1iVbplhee0IFe/fsNuTTCZPntWnBPs
         ZgWKPTiTZNXPp3rb/GzSvNcU/nNyFdDnqRinX5ZP9pO3CkBSapCyA1d2vSStQDU6SaX/
         vlp0dS3PdKp6cdiTQiu05gWkYrgHSRGnl8zs5t7Ui3dF0d0myXieg1WyfPmiopI6GMyo
         A6RQ==
X-Gm-Message-State: ANhLgQ3+578CaOs/bONBf40uZDDOGaqT8EFFhW+rwQOl4ToV4ElstYuA
        gMv8YtlYtilJr6cXNub26cPDaFu6yfNumiuYkpp4OX0lRKi+VoyZFN/lyPgoaT/ojLTAzNEpcDY
        5rvw6+ox5FVbwPlJtIdv+8NMO/bL7QTS2rm7448Zy
X-Received: by 2002:a92:41c7:: with SMTP id o190mr26917567ila.11.1584367309970;
        Mon, 16 Mar 2020 07:01:49 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvXN5mRtIF4p9gJ819bqSH04fLnfqGl/DkjD/ngzkHsCN4/wjuHbh30m5R1fHHGF5GB2Yag+lg/1nzJ0Til9jA=
X-Received: by 2002:a92:41c7:: with SMTP id o190mr26917528ila.11.1584367309610;
 Mon, 16 Mar 2020 07:01:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200303233609.713348-1-jarkko.sakkinen@linux.intel.com>
 <20200303233609.713348-22-jarkko.sakkinen@linux.intel.com>
 <CAOASepPi4byhQ21hngsSx8tosCC-xa=y6r4j=pWo2MZGeyhi4Q@mail.gmail.com>
 <20200315012523.GC208715@linux.intel.com> <CAOASepP9GeTEqs1DSfPiSm9ER0whj9qwSc46ZiNj_K4dMekOfQ@mail.gmail.com>
 <94ce05323c4de721c4a6347223885f2ad9f541af.camel@linux.intel.com>
In-Reply-To: <94ce05323c4de721c4a6347223885f2ad9f541af.camel@linux.intel.com>
From:   Nathaniel McCallum <npmccallum@redhat.com>
Date:   Mon, 16 Mar 2020 10:01:38 -0400
Message-ID: <CAOASepM1pp1emPwSdFcaRkZfFm6sNmwPCJH+iFMiaJpFjU0VxQ@mail.gmail.com>
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

On Mon, Mar 16, 2020 at 9:56 AM Jarkko Sakkinen
<jarkko.sakkinen@linux.intel.com> wrote:
>
> On Sun, 2020-03-15 at 13:53 -0400, Nathaniel McCallum wrote:
> > On Sat, Mar 14, 2020 at 9:25 PM Jarkko Sakkinen
> > <jarkko.sakkinen@linux.intel.com> wrote:
> > > On Wed, Mar 11, 2020 at 01:30:07PM -0400, Nathaniel McCallum wrote:
> > > > Currently, the selftest has a wrapper around
> > > > __vdso_sgx_enter_enclave() which preserves all x86-64 ABI callee-saved
> > > > registers (CSRs), though it uses none of them. Then it calls this
> > > > function which uses %rbx but preserves none of the CSRs. Then it jumps
> > > > into an enclave which zeroes all these registers before returning.
> > > > Thus:
> > > >
> > > >   1. wrapper saves all CSRs
> > > >   2. wrapper repositions stack arguments
> > > >   3. __vdso_sgx_enter_enclave() modifies, but does not save %rbx
> > > >   4. selftest zeros all CSRs
> > > >   5. wrapper loads all CSRs
> > > >
> > > > I'd like to propose instead that the enclave be responsible for saving
> > > > and restoring CSRs. So instead of the above we have:
> > > >   1. __vdso_sgx_enter_enclave() saves %rbx
> > > >   2. enclave saves CSRs
> > > >   3. enclave loads CSRs
> > > >   4. __vdso_sgx_enter_enclave() loads %rbx
> > > >
> > > > I know that lots of other stuff happens during enclave transitions,
> > > > but at the very least we could reduce the number of instructions
> > > > through this critical path.
> > >
> > > What Jethro said and also that it is a good general principle to cut
> > > down the semantics of any vdso as minimal as possible.
> > >
> > > I.e. even if saving RBX would make somehow sense it *can* be left
> > > out without loss in terms of what can be done with the vDSO.
> >
> > Please read the rest of the thread. Sean and I have hammered out some
> > sensible and effective changes.
>
> Have skimmed through that discussion but it comes down how much you get
> by obviously degrading some of the robustness. Complexity of the calling
> pattern is not something that should be emphasized as that is something
> that is anyway hidden inside the runtime.

My suggestions explicitly maintained robustness, and in fact increased
it. If you think we've lost capability, please speak with specificity
rather than in vague generalities. Under my suggestions we can:
1. call the vDSO from C
2. pass context to the handler
3. have additional stack manipulation options in the handler

The cost for this is a net 2 additional instructions. No existing
capability is lost.

