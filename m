Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91112C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 20:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6651720885
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 20:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Sot0iVxS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728550AbgHTUwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 16:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727074AbgHTUwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 16:52:16 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BC1C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 13:52:15 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id u63so3095244oie.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 13:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FFg+jFmtOnyHlScqARdOHpvmudoSnqaQBg5KCeRa9UQ=;
        b=Sot0iVxSbuwVCve9v8QZv0lD2QM3MOxOl7KaOfewuGZDmolNdBIN7EQvQ7bTJMGlrJ
         q3HrH+JdFgxknsJMrQeND2akyErRnHIoq62wfpoXoySbe9dvqSDLOt3vXQ6ACgGiRCs8
         rR80UK/DbV1zI5JhxQcse1CoRao5fbW7EYBriilVFryfXCgWXlrf+a+owiU4BgWiiDrc
         nBnNJiDbXKVWrM5Zh3aLCUzTwdP1pi9EN4Y7Zswa9zrqyqjXlb14ohFMUlEr91wUg9yt
         znwAN4npy2kfSXL2Td3kPAsfXCazr9ToqpO+dgR//rKCRC5keTh3pLE+4XXQi1oaf5SP
         C/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FFg+jFmtOnyHlScqARdOHpvmudoSnqaQBg5KCeRa9UQ=;
        b=PnarKAXp8atTTEZUAzVi9AwV6VP8NxhOou2du6uz6FqL27hS5OaSvRbQX3+s5u1HVV
         yu63VEY/qb4xWaGRl3xl/khDPHuczck3xeXo9c6+4vKNYGNe8uEx0PkeKylLkMdS4L4J
         9vAXqMQXzvrzlHcV/Wbw42xVbhI5PukFCw/w7MoTE4Z3AsWEm+lzPswMHdnWl4HtBe12
         L2KISJe79ORrFEoSyhLyTobsgdE0JzJGmkaGmQaICOZHuOb3zowWGb/uSqlihUZtmj5t
         VCcRx+6BoeFVreBdHMqk6nHYTN9t5mZv30YY2+AXd1lUbWfaZQXs/O77jbG/q9ikJfTm
         cnZw==
X-Gm-Message-State: AOAM533r04k6l7MP0mdT+1c4cH9c67SYe2/HJYNwbl0dt9SbScL9pTZ5
        tpqAIyKnKc0xYbAr5jT7/jpIN3DNjAbNJuyi+mjboA==
X-Google-Smtp-Source: ABdhPJy2aO1SL1t0M+h2xAvPXa9rCV7M+MQaUATKbbFZWbdBB38MDHybjeRJoqtv8x9PM9oAG0488c4xvxRJZPRbDCA=
X-Received: by 2002:aca:670b:: with SMTP id z11mr157629oix.6.1597956734635;
 Thu, 20 Aug 2020 13:52:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200820133339.372823-1-mlevitsk@redhat.com> <20200820133339.372823-2-mlevitsk@redhat.com>
In-Reply-To: <20200820133339.372823-2-mlevitsk@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 20 Aug 2020 13:52:03 -0700
Message-ID: <CALMp9eRzB-NXa_QAJXr1JSkkGYTc7MzzfEOcBa9-+Cu1sc13ow@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] KVM: SVM: rename a variable in the svm_create_vcpu
To:     Maxim Levitsky <mlevitsk@redhat.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Wanpeng Li <wanpengli@tencent.com>,
        Borislav Petkov <bp@alien8.de>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 6:33 AM Maxim Levitsky <mlevitsk@redhat.com> wrote:
>
> The 'page' is to hold the vcpu's vmcb so name it as such to
> avoid confusion.
>
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
