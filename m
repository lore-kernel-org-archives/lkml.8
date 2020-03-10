Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326AAC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 17:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0499421927
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 17:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jC2v5tmm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbgCJRX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 13:23:56 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:36706 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgCJRX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 13:23:56 -0400
Received: by mail-il1-f195.google.com with SMTP id h3so1439787ils.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 10:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bpKs3XJUi+EzrxrD69z2rWEMUDijI2aX+JxbzZCOheM=;
        b=jC2v5tmmuEnmUgDs+1o340Pp6muc2ypEpD8eaP6r2cPOyHT0UQ2PlIn/QtNGxkE4+8
         cASs91MnMeo8ZYxW2c5PAIkJ0SDlxhG3iJTSsvPlU5s080/QYJohXagrGCH/GzpvvT98
         WHcXWwupWcsc+f8H82YAAoIrwBgVLBphe07lLJBYJ8HdcmX9XBOxeechO/XaWNXYi8YE
         Aa0OUiQKyYWYwEQds8gPprxAGBjI+WvtYntOAB9plQyYyp/YDkhYYJzjDXUGcvMxQWsD
         cxjeiHchLTmwjy7F8sJse27h8pR8rUkqcBaVeAUD8fgXZC+ckz7ZSMd/nZ5nPvp6jypt
         Kg3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bpKs3XJUi+EzrxrD69z2rWEMUDijI2aX+JxbzZCOheM=;
        b=VTmHF+ODJ9Bt3Td4Hgup8wabyAXMhx1GbMFhK7QhYNhyhi0O2CUDZtqLtTsPVgRs84
         8gT+EThPkLsK56/74TAtkZ8xSsq3F0A6bLRII4fg5+EuJBE6rOF9u3ee0AfyKly/l9Oh
         PrEDuXyhD3UFBPcHeQjEP72mpmQ8dSo0o744y//0FEyhrvTijzlxlMTZOQ491Lv8kM5U
         o+lDC1x4CHy2Ncz6xn7o5e43FxU2ixk/Eviyre8OJ/ycXDinyXRuxi0s48S5h7yQqdLR
         RxMfzRmecPfSwpaZV2D0b+ubbM1qOEC076dhWkeUJG7rgR60mdQo52H+d/vQndQS3mt0
         ebsQ==
X-Gm-Message-State: ANhLgQ07u8JB+UHjt7trltws+r30ef1EkE3xdAwzPv6aHP9Poi7AHCgf
        55hzrtYdoiCI4oBu4HH+c02uOkhdHaq7/IAWCSx4BXXr
X-Google-Smtp-Source: ADFU+vsdimCS3ju3X6q4TFVr0q8tJXbwYngqSmKvAnDqE7FFDwCj2Y7m2zWw0oFBeuLMLbJXXOmYlKV7766rSe/gNpI=
X-Received: by 2002:a92:3c04:: with SMTP id j4mr12290505ila.108.1583861035356;
 Tue, 10 Mar 2020 10:23:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200305013437.8578-1-sean.j.christopherson@intel.com>
 <20200305013437.8578-5-sean.j.christopherson@intel.com> <CALMp9eRRWZ54kzMXdTqRCy2KmaUAq+HVVVzbxJNVdgktg65XCA@mail.gmail.com>
 <20200305192532.GN11500@linux.intel.com> <CALMp9eRxdGj0DL0_g-an0YC+gTMcWcSk7=md=k4-8S0Zcankbg@mail.gmail.com>
 <20200305215149.GS11500@linux.intel.com> <5567edf6-a04c-5810-8ed5-78a0db14b202@redhat.com>
 <20200310171017.GC9305@linux.intel.com>
In-Reply-To: <20200310171017.GC9305@linux.intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 10 Mar 2020 10:23:44 -0700
Message-ID: <CALMp9eRjOd3=+koxGus=V0CLvz3wg-A1soa9Z4rvXhedQzCHcA@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] KVM: x86: Fix CPUID range checks for Hypervisor
 and Centaur classes
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Pu Wen <puwen@hygon.cn>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 10:10 AM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> On Fri, Mar 06, 2020 at 10:03:37AM +0100, Paolo Bonzini wrote:
> > On 05/03/20 22:51, Sean Christopherson wrote:
> > >> Ah. So cross-vendor CPUID specifications are not supported?
> > > Cross-vendor CPUID is sort of allowed?  E.g. this plays nice with creating
> > > a Centaur CPU on an Intel platform.  My interpretation of GET_SUPPORTED...
> > > is that KVM won't prevent enumerating what you want in CPUID, but it only
> > > promises to correctly support select leafs.
> >
> > But in practice does this change anything?  If the vendor is not Centaur
> > it's unlikely that there is a 0xc0000000 leaf.  The 0x80000000 bound is
> > certainly not going to be at 0xc0000000 or beyond, and likewise to 0xc0000000
> > bound is not going to be at 0xd0000000 or beyond.  So I'm not sure if
> > anything is lost from this simplification:
>
> Probably not?  But in the unlikely scenario that Intel wants to add a CPUID
> leaf above 0xc0000000, I don't want to have to explain that it might cause
> problems for KVM guests because I added code to emulate (alleged) Centaur
> behavior for virtual Intel CPUs.

And there is some precedent for that, with the 0x20000000 leaves.
