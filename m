Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6190EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 11:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33CC120721
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 11:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SToWnglh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbgEULME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 07:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728442AbgEULMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 07:12:03 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD1AC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 04:12:03 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id g25so5149558otp.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 04:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/oL7dAuaA62cBm7hAceUJOjBRK5rQp19BMPlUMceggo=;
        b=SToWnglhZFHvnkT5/QNB9fD0tbAajvPdZlwXz6KPsdo/KGF1m3FaV81CqJ7COejDH5
         SgQz+SsmWca/W8+dH6L4/gJ4Nn7g3CwY4ryAG34oCjXK6LyQ+e0lQCguuqlEXqgZ5TCg
         5uGe5G/TO0/HcaHwthRzAs/fGY4s0fGofRlnp/LsPk4m4E7XPe/Ui+zzzsl2Lecr4s7+
         iTASy+6lSY3Fe2pCtEzVkFWVeJKdhMf6syN776cTBZs6fVTnJBvXbMYd9mzNSJFLkCpO
         VNq0LY+Vl8P/Yl73hrtKEckDQLqSJO7bqMhXj+KFMeFIh1wzrY9Yc+qmYJ1VzyXdclFS
         c1xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/oL7dAuaA62cBm7hAceUJOjBRK5rQp19BMPlUMceggo=;
        b=tOv0gFZuLMte/XxBz92hSlnV1UaAMjdwHAyb7+2MrmaMSbrmmaURzY6TiPCISfH7Km
         Bv1537qTgNrKWq9MT9ucgoAkkMdby1KLpxyjT1Bup0Wn1+QX6rKV7t5l3YO95r9XgDhO
         72VDxlw/BJ0nWz4+ZBJfnUUoSMFTY9ri+dk1y9acAUC1QyXYHyNt3hV9ITnOgi5P6TVd
         WZL6BpfDnFCvvinHU8VoGglX7OBGdZpw1YtnQa5uVjgwzdZFL2pLwCPsKuJOBKlEUMSc
         K8ooDEJw65LX3ebPnFJ/RFjp6u7Nr38MaS1GsW7R7CwG73pJvfOwckKRppxPDt89aer4
         t7lA==
X-Gm-Message-State: AOAM53003Gs106Ttq0Gp3q0L+3HKA90xoSJrxchmZQdanbz60J1qmeJP
        e5Yhx43Utlmxz5eDpqEqHYwvk7VTPSMNklK1v+mIhw==
X-Google-Smtp-Source: ABdhPJw17uyBMC0m3w1yjaRSVBfBWWlyDtoOJjc5+l8DV6nFfRiiRN1W5A8VLsLHUTfZAiwI9X8jJpRHAyXlXGyaTA4=
X-Received: by 2002:a9d:27a3:: with SMTP id c32mr7112271otb.233.1590059522704;
 Thu, 21 May 2020 04:12:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200515150338.190344-1-elver@google.com>
In-Reply-To: <20200515150338.190344-1-elver@google.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 21 May 2020 13:11:50 +0200
Message-ID: <CANpmjNP2GsUuHAfvBa6qhnAe1W=1Zo=0i2eB09V7GAdtRSjVfg@mail.gmail.com>
Subject: Re: [PATCH -tip 00/10] Fix KCSAN for new ONCE (require Clang 11)
To:     Marco Elver <elver@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 May 2020 at 17:03, Marco Elver <elver@google.com> wrote:
>
> This patch series is the conclusion to [1], where we determined that due
> to various interactions with no_sanitize attributes and the new
> {READ,WRITE}_ONCE(), KCSAN will require Clang 11 or later. Other
> sanitizers are largely untouched, and only KCSAN now has a hard
> dependency on Clang 11. To test, a recent Clang development version will
> suffice [2]. While a little inconvenient for now, it is hoped that in
> future we may be able to fix GCC and re-enable GCC support.
>
> The patch "kcsan: Restrict supported compilers" contains a detailed list
> of requirements that led to this decision.
>
> Most of the patches are related to KCSAN, however, the first patch also
> includes an UBSAN related fix and is a dependency for the remaining
> ones. The last 2 patches clean up the attributes by moving them to the
> right place, and fix KASAN's way of defining __no_kasan_or_inline,
> making it consistent with KCSAN.
>
> The series has been tested by running kcsan-test several times and
> completed successfully.
>
> [1] https://lkml.kernel.org/r/CANpmjNOGFqhtDa9wWpXs2kztQsSozbwsuMO5BqqW0c0g0zGfSA@mail.gmail.com
> [2] https://github.com/llvm/llvm-project
>


Superseded by v2:
https://lkml.kernel.org/r/20200521110854.114437-1-elver@google.com
