Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 423F9C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 18:07:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1688520716
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 18:07:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NEY++R9I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgCESHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 13:07:53 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:34760 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbgCESHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 13:07:53 -0500
Received: by mail-io1-f68.google.com with SMTP id z190so7510403iof.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 10:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wW0Vx9wAf9kliO11TUHuTABMuWhBJDP4gg7/87y3NTQ=;
        b=NEY++R9ID9WS4I+fJ6Wg6e22O+l026S/CxdI/U1mjEbaF7OiSLpkwNvhHLkJllqF8t
         qY2CQTvNuNJiCzWwNGOb5psE2vGDjwZTQ899XbI9eum14ung4gUCbN5RoNVWW00zKGok
         ifSV/8Ka5hp1CSKKn5q8Ld8KFT//0ha9lzFX28cF+JdEU/FfmgRBpt8i8sqTbCtPc7Co
         oVIeaYLJWVvx+4QHZrX+vMOc5zDx4DobLWKeRiujdotmEQ/l9Fu9QivIgDgis6kvQyPn
         fcMfIisFGw4g4AkEU2nN6hLQuYizcvNGD24FcbzZvE3MlzkZr6rdPVaEkk8WrYWkPyht
         wF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wW0Vx9wAf9kliO11TUHuTABMuWhBJDP4gg7/87y3NTQ=;
        b=cVzLNAtDKzbIzqlIy8UzbY6/e93GtGSQKRvo8Ewwl1waZBi3FdXejUwUBYJV4EDEft
         zifSDMk7k+rM7aAGGS+Xml3O1UmAs4UwDofPov3+tv/69G75fnxFCIy4iQA28zR4c7Db
         Rnxo+AnInKcSrrAye6uoNNBSBXYjGtlBj1Y2GdA15FE2KXsVfo490ZgTTGzjJ0bSLFG9
         tsaYp61OOgpKJ74N8OZhU07ejMhP2/ObsGuUyvgN0g+xegFMAFp7Rf7G9JAm1dhvelig
         1iybYKry07l683v9x+poOp2Jrdr7e4sYPSOj6bcYJ9YLykWsC/ctAwJ6t+SEK382+sdP
         aqgA==
X-Gm-Message-State: ANhLgQ0l1lA4IKhDGSlE4N2Jn3TjssumO62Ax0QzQdVk8HPquTsSCQEo
        Nm+aQ60ael/XUY/iQAKS1WQl3qF9t0TAuiTocd2JKw==
X-Google-Smtp-Source: ADFU+vvN1q9pRd3JcvfRB56xAOLPFAk6RGPNot5ql5bO1pky7Paw8JYj0wH8F367GJ4Lza8zjqveixVAXn0z33UerZw=
X-Received: by 2002:a02:cf0f:: with SMTP id q15mr9049550jar.48.1583431672070;
 Thu, 05 Mar 2020 10:07:52 -0800 (PST)
MIME-Version: 1.0
References: <20200305013437.8578-1-sean.j.christopherson@intel.com> <20200305013437.8578-3-sean.j.christopherson@intel.com>
In-Reply-To: <20200305013437.8578-3-sean.j.christopherson@intel.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 5 Mar 2020 10:07:41 -0800
Message-ID: <CALMp9eQ0=2MYHOezMZ31TMQCBc6s=nZWF7PWJ8F0DzTAvwSmOQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] KVM: x86: Add helpers to perform CPUID-based guest
 vendor check
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

On Wed, Mar 4, 2020 at 5:34 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> Add helpers to provide CPUID-based guest vendor checks, i.e. to do the
> ugly register comparisons.  Use the new helpers to check for an AMD
> guest vendor in guest_cpuid_is_amd() as well as in the existing emulator
> flows.
>
> Using the new helpers fixes a _very_ theoretical bug where
> guest_cpuid_is_amd() would get a false positive on a non-AMD virtual CPU
> with a vendor string beginning with "Auth" due to the previous logic
> only checking EBX.  It also fixes a marginally less theoretically bug
> where guest_cpuid_is_amd() would incorrectly return false for a guest
> CPU with "AMDisbetter!" as its vendor string.
>
> Fixes: a0c0feb57992c ("KVM: x86: reserve bit 8 of non-leaf PDPEs and PML4Es in 64-bit mode on AMD")
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
