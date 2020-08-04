Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC9B6C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 21:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D58A020842
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 21:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFd5qQ8t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgHDVbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 17:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727773AbgHDVbv (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 17:31:51 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC913C06174A
        for <Linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 14:31:50 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d188so15372225pfd.2
        for <Linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 14:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W3QS3vREL+OGPzaf7RIBdYaJjzMFsT+3SjNXgpLt9fk=;
        b=mFd5qQ8tzzrkgBfDYCuVTkNO0cPUkZsSmxxNqWq2CEkZhOrKXHPHPi3Q+7lzeO4p3e
         ghXJkQySD5yLmVvD8r7XINHDU10rIvTeenJ3F/KFKSUmslpaG9Re1QTO2JYnvz+hKnAn
         SmJ0pzmLK43qypzPhgSoOeajmMSCsZ3fctfac/m7m2AagE3KtL0Hv4HTyzl0P+Y6ZXXd
         74Oe84MEiP+N0Uf9AezgRySv3yP+5mr/z+HNhYXbO5GNdHtaR2tSeAUuyS997XW3IT35
         RztOtlbI6tUbh1LIvWN2TotikdOF2wyLuCfeOfKlusWxStfCI8+++v2k2RRkYjTUG8CN
         Emgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W3QS3vREL+OGPzaf7RIBdYaJjzMFsT+3SjNXgpLt9fk=;
        b=uKJwdeEUVlkXNbPuM5ghDM73jLBsDF6EyuySP3xzDA30PP7AzX2FFaTkTvQB2j7UKn
         hbK6fbtaYtLAcH0U7ErTcoxLRd97GTcTl8GKdMgBiY/8g5ld9OC032y1AbJfbnjDltiK
         FpGDODgzhOur62SsyivmDIMiMVPlX9kG8SrvZJyzaVLaNaJF9yuIdyKwixPK5cRriU/G
         EtlfosCyOV5eJZv3wUJmLfRvcE+S9Xbzv0wfQ13skPsgolFk0cHzczvlE/9ae+Txm4S6
         eRZ39fHKOr0m1E1YhOsyE9gFvqPX0F2D2ZgPN5uBbGnARvz2curjf/D/Rbp3pBbIaXQQ
         dc2Q==
X-Gm-Message-State: AOAM53298SX8vGG4qlb+aaBps/W0ICVYyygdvipTXGQr5ZVBi+ilgWgj
        0UdRI0J+ParDB5J3IwhGeLdIUmDE7ji2WD/tXZs=
X-Google-Smtp-Source: ABdhPJwFeCkMcjMhQqvCSSgjISfdBtS7rg85aGYVXZgDDt63FvLxsEln6mbIAVxdOmTGePYGDRv+Vr1sIEcK1wJZy6c=
X-Received: by 2002:a05:6a00:1488:: with SMTP id v8mr315828pfu.275.1596576710558;
 Tue, 04 Aug 2020 14:31:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200731025617.16243-1-yao.jin@linux.intel.com>
In-Reply-To: <20200731025617.16243-1-yao.jin@linux.intel.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Tue, 4 Aug 2020 14:31:39 -0700
Message-ID: <CAMo8BfJBsU4xvUZe8HEJ=t8cYRh4RpQBqdustYRovjk4FUYsQg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] Missing instruction_pointer_set() instances
To:     Jin Yao <yao.jin@linux.intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        jolsa@kernel.org, LKML <Linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>, kan.liang@intel.com,
        yao.jin@intel.com, alexander.shishkin@linux.intel.com,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 7:59 PM Jin Yao <yao.jin@linux.intel.com> wrote:
>
> There is a potential security issue that perf kernel samples
> may be leaked even though kernel sampling is disabled. For fixing
> the potential leakage, the idea is to use instruction_pointer_set
> to set invalid ip address in leaked perf samples in some cases.
>
> But instruction_pointer_set is missing on some architectures.
> Define instruction_pointer_set for these architectures.
>
> Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> ---
>  arch/alpha/include/asm/ptrace.h  | 6 ++++++
>  arch/arc/include/asm/ptrace.h    | 6 ++++++
>  arch/nds32/include/asm/ptrace.h  | 7 +++++++
>  arch/xtensa/include/asm/ptrace.h | 6 ++++++
>  4 files changed, 25 insertions(+)

For xtensa:
Acked-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max
