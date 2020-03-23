Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B82A5C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 16:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 868432051A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 16:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hK+AE+H5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbgCWQYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 12:24:38 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:44399 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727318AbgCWQYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 12:24:38 -0400
Received: by mail-io1-f65.google.com with SMTP id v3so14711920iot.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 09:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=szMpm1YHgB+ek/GLf0Q9znil+A6chCIsHv9XnjC6wnU=;
        b=hK+AE+H5QEe79Ixitmvqv2R3HJWBBiY+uk5cy6vqPzyp6RRYzVKOY1yI6KN9ITyiDl
         rHVf7JZXS+6XiwgQCmg3Qk2K1zUoxMyRqBFZO3ShH1a3vIdyQ+6ui55W9Y1WgD3AV80G
         4FsIYQ8PNslp31hPnLuC/M29GplL1v6q7549yAHCOdLUNCM3bnev4A1n4NRGDqdRa545
         jBfx/r7xmzNAVda7gngzIjz/zjmlf8NcJIDD4XIh8IBejiDVjZiV5/uq3gvdYBdrCkwU
         ubfJWq5Vz0UltwxYBvtUqzhL7INCSnCsNez4NvSYbOz0WVZiGmzDeC8oHxHfnt+qkbHc
         A8Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=szMpm1YHgB+ek/GLf0Q9znil+A6chCIsHv9XnjC6wnU=;
        b=W/frVIw6/YO9qcqLx/eaKqXeZP8Be6v4nQOkgpdUQTUuLNYwxBa3d/PdOX/mEwWLPD
         eNjO52F1yfZdtufTG27AMxx9Kb7GqTMWzl6kl0YHoUcYvF7nA5xl7afYfr/SHVEXYZap
         HOULXgGwzDXQk+FV0P4KOIWvqzgxKM072cTOBywYLYo3Q2YSLqYMNxSu0AZo1jBUk3U9
         EZaIykriJaxmriBHwocJhFif+6Oz4+VbZti2mKtt/pxrfwWKozzef8d5PS15/PIQFgRN
         +D40aSeSBEDVq5TDaX6zLgdoMd4iRndqUqY4ChvwdD8HdpBtZSUMoWQ033bmtVTvfFHW
         X5NQ==
X-Gm-Message-State: ANhLgQ1WrUhC+UaV/aMPDNx2wRt0+urltz5PzW3nsiVJp4rehEpS7Ecb
        QBLcxfeTE3PoWZW1t/a6EojQXgqPwy30n6Dae0NQvA==
X-Google-Smtp-Source: ADFU+vus/6qIchDGH8hxBBNtI6zsWwfXLYMmjF5wwgd0drF19BSkmHMMb6n8O5PXjqQkAtnJaxYvTdHsE0KjN2GWnfE=
X-Received: by 2002:a6b:c408:: with SMTP id y8mr2864354ioa.12.1584980676836;
 Mon, 23 Mar 2020 09:24:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200320212833.3507-1-sean.j.christopherson@intel.com> <20200320212833.3507-4-sean.j.christopherson@intel.com>
In-Reply-To: <20200320212833.3507-4-sean.j.christopherson@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Mon, 23 Mar 2020 09:24:25 -0700
Message-ID: <CALMp9eR5Uu7nRDOS2nQHGzb+Gi6vjDEk1AmuiqkkGWFjKNG+sA@mail.gmail.com>
Subject: Re: [PATCH v3 03/37] KVM: nVMX: Invalidate all EPTP contexts when
 emulating INVEPT for L1
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>, kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ben Gardon <bgardon@google.com>,
        Junaid Shahid <junaids@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        John Haxby <john.haxby@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 2:29 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> Free all L2 (guest_mmu) roots when emulating INVEPT for L1.  Outstanding
> changes to the EPT tables managed by L1 need to be recognized, and
> relying on KVM to always flush L2's EPTP context on nested VM-Enter is
> dangerous.
>
> Similar to handle_invpcid(), rely on kvm_mmu_free_roots() to do a remote
> TLB flush if necessary, e.g. if L1 has never entered L2 then there is
> nothing to be done.
>
> Nuking all L2 roots is overkill for the single-context variant, but it's
> the safe and easy bet.  A more precise zap mechanism will be added in
> the future.  Add a TODO to call out that KVM only needs to invalidate
> affected contexts.
>
> Fixes: b119019847fbc ("kvm: nVMX: Remove unnecessary sync_roots from handle_invept")

The bug existed well before the commit indicated in the "Fixes" line.
