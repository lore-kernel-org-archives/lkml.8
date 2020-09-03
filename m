Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D3DC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 17:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 187FC20709
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 17:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VJ/LoYWg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728525AbgICR6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 13:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728312AbgICR6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 13:58:12 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64EB8C061245
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 10:58:11 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id i4so3550508ota.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 10:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=R7ZL8pTZbj4JiHniG1B9lUVGN1DSqomiXYlNdiGH0zI=;
        b=VJ/LoYWgjxcPKdh3qVWyDDMIR2oPoCRxoVXtgB2kLRI3RdpBQrAHXT2TM0WA0Y+ns6
         hy7M151o0a/Z2WK5PFoc+5HzHc1J7u2M7jMZC3m1875Ew02+6wBINxncBe1uv8gpCKNs
         u8aXYBf1U91KlLHKBCkSdNIPPFFavY9fr3P6vVNGI936lxJxwLkLZ7oVbaplpMZmoRTD
         mGp4xT6Me1FA0RLIIOhaeoNYp6P3eYaU2366hHzgrmgM63DuZKcUmYp05uyWulSe7HYo
         usQnnU23yce9b8IwnyCODAnkJaeI/1o+khG9cN4rghPQtk5tZigaOLFWG6lbqaUhLF4u
         00kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=R7ZL8pTZbj4JiHniG1B9lUVGN1DSqomiXYlNdiGH0zI=;
        b=s9Xwj6Gsaf6jgV/rYaQa2rvaDoeO2u5mv4ZPJaMtQnCcJUQsbkeHbBw7m10SYtue9m
         XevKY60c3VbUVaJJ9vB6N5CEJNZN7cgRtRdzbVaUiyo8qug1PRhT2pPZ8LjQfPs2+Xak
         a18v5h3dYWqRHiC0jPAfVEtGNq8qlDP691EyvxxzShHDtNMPgDQFksPGilERa6UA2rB5
         SqdHRqBxh+4VNZZDO0G5wgmw7kLKc0lsmqdvUvM8SH8HIjc4woUjaOVWJfV3IzIQaz4j
         h7N+IeuayHX6dmTYhVRdnFp21Oj+3N3tP6X+x95oduRjLs06tfxgevD6IKmoZBGFRyml
         B3RQ==
X-Gm-Message-State: AOAM531zpHqmVZS5PIITCDxSJh+i+BiNx3afdpM2bkBY3okswVbjbR0n
        FBzY3EhG6+lldEOGyN3KO1OCd1b7czXHFF6h14Ttng==
X-Google-Smtp-Source: ABdhPJyFWBT9j5hFf9r5pcOgceu17AyR9gOLouFVVzWPvUtc/tAKFK4iiifRwJDL0FxA8g7h7oZ+5bsvB9YSHNT9BCU=
X-Received: by 2002:a05:6830:18ca:: with SMTP id v10mr2589170ote.295.1599155890126;
 Thu, 03 Sep 2020 10:58:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200903141122.72908-1-mgamal@redhat.com>
In-Reply-To: <20200903141122.72908-1-mgamal@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 3 Sep 2020 10:57:58 -0700
Message-ID: <CALMp9eTrc8_z3pKBtLVmbnMvC+KtzXMYbYTXZPPz5F0UWW8oNQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: VMX: Make smaller physical guest address space
 support user-configurable
To:     Mohammed Gamal <mgamal@redhat.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 3, 2020 at 7:12 AM Mohammed Gamal <mgamal@redhat.com> wrote:
>
> This patch exposes allow_smaller_maxphyaddr to the user as a module parameter.
>
> Since smaller physical address spaces are only supported on VMX, the parameter
> is only exposed in the kvm_intel module.
> Modifications to VMX page fault and EPT violation handling will depend on whether
> that parameter is enabled.
>
> Also disable support by default, and let the user decide if they want to enable
> it.
>
> Signed-off-by: Mohammed Gamal <mgamal@redhat.com>

I think a smaller guest physical address width *should* be allowed.
However, perhaps the pedantic adherence to the architectural
specification could be turned on or off per-VM? And, if we're going to
be pedantic, I think we should go all the way and get MOV-to-CR3
correct.

Does the typical guest care about whether or not setting any of the
bits 51:46 in a PFN results in a fault?
