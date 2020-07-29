Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBE5C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 00:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B333C207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 00:09:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="At1MN+Fz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730516AbgG2AJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 20:09:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730219AbgG2AJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 20:09:58 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCB5C0619D2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 17:09:57 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id z3so7612797ilh.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 17:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NIt8V+0Ly8zCDHiK1shQ9ILtxkb0CmTmo030ThJYXRc=;
        b=At1MN+FzIe1tFpSFrYfVBPnrEMgocxF1GxQ6l661JXfQUSL09B22WGVDFknoRIDEIf
         tRG+xOoU3FZZZMnJGjfuPFPl8E3+qbBa1Vlm4WmIsAbjoTRHML/YfD3T/yXLluhZFamt
         03u7pLSnNw9w6hrsyoPycGKgrdJ8a0GfGb+EJqEpgT61mXDlTtQoyLi6YAldXQP6hk2d
         BEHoVxL9MInXNDCyKtRve/qoG6kRFZAXukmBRrpkKEederyrHc1E92VdClFR/zAuOXzL
         H82qr89vU69GvNOybrP5Hr/3yHj9zyTZjsAPIr9a735oJjC5eCGbhb+/saHV//RnJXPj
         cvpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NIt8V+0Ly8zCDHiK1shQ9ILtxkb0CmTmo030ThJYXRc=;
        b=VM+2/ylcbuNiAMXp9hGX3H5Sw5tX5Djo4S5xJaEE71gXxlOX2RdvjUguirvWdgxUFX
         ZQLR73c1k2AMxQVJMvEK6wRcSDwWXEvLu5J+3d9aEbTZZoVGcw/QBRpEa0zJEZAv56Ns
         H3a947OeG1lH6tOzrq8bnR4rG6Bj7B7fj2zCbEp2gkgY1Hp0sPHBUBNwV8+Tuh4ZduTO
         9ZfwLblgO1dMyCbIVSdtLGxJHnmfdfaBnYytbLbVu4nkS7MxsLyyQ+mV+JEdhfMvMU5p
         L15k2GZbMnDql1h0+82MEcypKt8zGPY4wTMT1JrxFA+N2RLeD4avCSvfck2jwHzeCWp4
         KV8Q==
X-Gm-Message-State: AOAM5337+S5sfrAKAW1ETUiqlCkKWV8oSgx2tfjlpAW1CA9DEyr2n6rJ
        gU1fPa4m1K9/Q/hnFJUjzR15lIx8HLXv5hUPEy4pLg==
X-Google-Smtp-Source: ABdhPJxyhD76VhGtYfRPQiK8bjnt1QDL1vQFerPzksCcZjDbHKglJfD/550b3SdXVkkWhSkJmPrnLJQ0xSN4XUuyCTk=
X-Received: by 2002:a92:790d:: with SMTP id u13mr25673361ilc.26.1595981396870;
 Tue, 28 Jul 2020 17:09:56 -0700 (PDT)
MIME-Version: 1.0
References: <159597929496.12744.14654593948763926416.stgit@bmoger-ubuntu>
In-Reply-To: <159597929496.12744.14654593948763926416.stgit@bmoger-ubuntu>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 28 Jul 2020 17:09:46 -0700
Message-ID: <CALMp9eTkGtk=baceQs7ATY6FU55+ubSfO9e71fzwiqO8oTH2vA@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] SVM cleanup and INVPCID support for the AMD guests
To:     Babu Moger <babu.moger@amd.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        kvm list <kvm@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 4:37 PM Babu Moger <babu.moger@amd.com> wrote:
>
> The following series adds the support for PCID/INVPCID on AMD guests.
> While doing it re-structured the vmcb_control_area data structure to
> combine all the intercept vectors into one 32 bit array. Makes it easy
> for future additions.
>
> INVPCID interceptions are added only when the guest is running with
> shadow page table enabled. In this case the hypervisor needs to handle
> the tlbflush based on the type of invpcid instruction.
>
> For the guests with nested page table (NPT) support, the INVPCID feature
> works as running it natively. KVM does not need to do any special handlin=
g.
>
> AMD documentation for INVPCID feature is available at "AMD64 Architecture
> Programmer=E2=80=99s Manual Volume 2: System Programming, Pub. 24593 Rev.=
 3.34(or later)"
>
> The documentation can be obtained at the links below:
> Link: https://www.amd.com/system/files/TechDocs/24593.pdf
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D206537

Very nice cleanup. Thanks for doing this!
