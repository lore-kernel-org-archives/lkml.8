Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C5EC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 00:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A0C02076E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 00:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KYuNfQWU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730282AbgG2ACg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 20:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730119AbgG2ACf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 20:02:35 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79732C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 17:02:35 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id d18so22708637ion.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 17:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BysJeb3iQD5vGPtfIq4YN/NdeUFzN5qXc6Nj007yDgY=;
        b=KYuNfQWUvhero7fgC1nxKXVhzoZXAdiQlBMDENFrmySZLwslRvGkVqsN1JrS5PBW2i
         GYse/5I9omCMOE8bYAYz+ffQpz4PrdLxuKfyEs/MOuMZvppHfhizZ6PZ527VAP6vvlsQ
         XZ2ib5mZnf7621v96nwP5AXioRD9tsIs3B5T0jkLqg/4pqvqdr03VvHHg02oZYmQqjfa
         BUTa/le0+qXZ7O0kJou4+l57zvPrnRI2eTRyG7ude8A86HyQxp/SdlIPGDcz/JK9Cv+H
         Z2/Vqf0YGElj/7BE/huc2eCEAVQDyDg7vSV2oCXj7zQay1nsm7C8qvU81MIgiRsvYA4l
         4Hqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BysJeb3iQD5vGPtfIq4YN/NdeUFzN5qXc6Nj007yDgY=;
        b=th9svC+xlTVVRbQm9sVE/hF6T4yc8fMcbs5hOeTX6fdpYSnfcY3SpgtyfNPKnDqy85
         Aapz9wZIaAKbYHWul1gVkRjRdh0QzsBN71I25NqGQU7EXDMdvpWb0t4w/h/jYl+TOkYo
         X880bcVCYjyX0THpGa4Ny7jKzGZ3U9ozjKr0wGvPuY2jnHuKGU5pVFR7ugIbOubZk4MS
         15uNSHhezitVEd6gonIzGyXpFhnVgxIGuK3WZCM6ZgkBnRXugngIuHKXgKSjO0z/g3LE
         l7JmQerkAMtkd8M5sLAAohooiFiyOyiXeWrzp9XN+2uPV2XMcAENgP0PVh4E+/g6M/YC
         YqXQ==
X-Gm-Message-State: AOAM533fTce+epenqxNEUN6k/rZoOheTAAOw20YtYgZF5UxqGqsaPpAx
        uotAs5DK3qbwx3fy7zzk6O7B99wQl5b4MPTbmEmlUA==
X-Google-Smtp-Source: ABdhPJzoW6X8J7Se9DegIA8iSwEkK+p8RiSH15MOOKLa7qwtDBxfbi0pP0OJQF6u2lxbV7D+YQtNAv0cYgpJb+viEHA=
X-Received: by 2002:a05:6638:1685:: with SMTP id f5mr11856670jat.48.1595980954633;
 Tue, 28 Jul 2020 17:02:34 -0700 (PDT)
MIME-Version: 1.0
References: <159597929496.12744.14654593948763926416.stgit@bmoger-ubuntu> <159597951369.12744.9730595628680359060.stgit@bmoger-ubuntu>
In-Reply-To: <159597951369.12744.9730595628680359060.stgit@bmoger-ubuntu>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 28 Jul 2020 17:02:23 -0700
Message-ID: <CALMp9eQvQ4D3t0uaqY_S1nKS6bt2DPUgKScBL3ODiUFLxd2LFw@mail.gmail.com>
Subject: Re: [PATCH v3 07/11] KVM: nSVM: Cleanup nested_state data structure
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 4:38 PM Babu Moger <babu.moger@amd.com> wrote:
>
> host_intercept_exceptions is not used anywhere. Clean it up.
>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
