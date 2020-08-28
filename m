Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DEBC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 01:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C98292080C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 01:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLdxudYx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbgH1Bre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 21:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgH1Bre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 21:47:34 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD3EC061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 18:47:33 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id i10so7982989iow.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 18:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=AuxkTqVq7yF2cLR6HeqahnZopzaHgO8OPP4mjEB1p/k=;
        b=GLdxudYxuX5p+TNa7JS4FgT5uMgErInKbyQZB1xutuVR2NHk1HZYmmryETZBzecVNp
         I2ljZ1cCBvj5YM4cL6vV4hnNam1SnrMwBhetZmRWBblkqoBu6ACcgah8k4dzxEHXYcsq
         AI71BKAR7IK0YsKKd6cDbYqzqjdr6/ITYp5/eZCnpJhXwDGgoUejU+uoPxPnGY9HcTH8
         XM1hUyuQ9+zZkVWwGjlr9c0HhpMqbXEk6tLXjX9A4ey4DenAOaHmeQ7MUC7M4u1U0wPm
         h21W7EZizpgAFAQ0OlVgQm3wj//E7mzuUG/BSnFNnFni6QYVuCaTxjNebuGyjBoKhkJo
         5FyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=AuxkTqVq7yF2cLR6HeqahnZopzaHgO8OPP4mjEB1p/k=;
        b=sn4xmG8nenGaSO1OgesFQbjzWXtT9VT7nbQJgfgI1i9KXmlrHyfwnWdp6Nyj92nQB2
         nddknpKNHx4tnuOa5ZWwerY37jBBQNSHKmD/H3MIo2a0d1jtN8yEyfb4TF7L+eoEJSuv
         AVlg3Uhq5qv4XZFgRCBI33DAIe7TzYJMjMWcnAoz8/QZqQDjOMw1nrUo7lpY+YGIlDM2
         8tUAqeMflR46MgVC71G1JAwL2UdUSdoZHm0eS8uXPjFTj9Vx+v0ZVwI9H8gRB3r/dm3v
         ImKe95gJOH//+6c/tf274ZYHUlf0JCtqMUOiYcvrXpuPIRgwylLUVkSbjIiUpPWBDMW3
         q9nA==
X-Gm-Message-State: AOAM531Cnf9nl4JppUPYZqHP5D/eAUmC+qQ3LiTxaT9mOq+zpcr+IQgz
        8Fu+REb/0bH+byTkOmaIv3emFPrBJ7zuji8bs3xDQeRyd7TzQA==
X-Google-Smtp-Source: ABdhPJz/kTdNDr+k3ctFy9T/6wEZ0TPwKT7SzyAEjqIQV/8de3t5ZpyvOh5FGwxqkUnonVB2QyohRA+FgWoQafGOq6Y=
X-Received: by 2002:a05:6638:d95:: with SMTP id l21mr21601365jaj.98.1598579253019;
 Thu, 27 Aug 2020 18:47:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200824101825.4106-1-jiangshanlai@gmail.com>
In-Reply-To: <20200824101825.4106-1-jiangshanlai@gmail.com>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Fri, 28 Aug 2020 09:47:22 +0800
Message-ID: <CAJhGHyDuS27+uPbqvc3Bn4aY_ncUAQo4AA_tRDZXQms-Y=r6LQ@mail.gmail.com>
Subject: Re: [PATCH] kvm x86/mmu: use KVM_REQ_MMU_SYNC to sync when needed
To:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping @Sean Christopherson

On Mon, Aug 24, 2020 at 5:18 PM Lai Jiangshan <jiangshanlai@gmail.com> wrote:
>
> From: Lai Jiangshan <laijs@linux.alibaba.com>
>
> 8c8560b83390("KVM: x86/mmu: Use KVM_REQ_TLB_FLUSH_CURRENT for MMU specific flushes)
> changed it without giving any reason in the changelog.
>
> In theory, the syncing is needed, and need to be fixed by reverting
> this part of change.
>
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 4e03841f053d..9a93de921f2b 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -2468,7 +2468,7 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struct kvm_vcpu *vcpu,
>                 }
>
>                 if (sp->unsync_children)
> -                       kvm_make_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu);
> +                       kvm_make_request(KVM_REQ_MMU_SYNC, vcpu);
>
>                 __clear_sp_write_flooding_count(sp);
>
> --
> 2.19.1.6.gb485710b
>
