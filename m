Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1531DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8F152072C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 13:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RmJEJ+YJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbgEUNm1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 09:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbgEUNm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 09:42:26 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD9BC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 06:42:25 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id v17so5562916ote.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 06:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YoQqHLS3kIB+JIi63PFAQDhXvHkeSj8OSM1KtqfRClU=;
        b=RmJEJ+YJx2Zq1KlQDqG6F64QGJnSxBZdOyrHlROISiRs3R+lQS77Bcai1UznZO/4qn
         g1V9wjATqmNG8c+rxMXSZG4ZnYd19eV/65Ptd3xnrdKVC52eVqlInNc6s3cGiuqqEqgg
         j0iXNFNHNoWuQ6q2yam8+hrWx43WqymOqm+ABTJxfb4Jo2dD4fB/mfLykppmHAcKvP7A
         Wd/X4tWqptXFjjVFfHkRBcwrvXeIS9hWC+wfUmaJfrpxIdxtP1FKNI9AKNwxmhYTc4m4
         VnURrejXfaQSaZT+KlknmhlYe4CB8Y5vvABsQfUHBkx7CpeRcxcdogdPHrQ4raQdU2f5
         u/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YoQqHLS3kIB+JIi63PFAQDhXvHkeSj8OSM1KtqfRClU=;
        b=MLAYJhrAVJIsJpYfDH5mIlOCn65UnCET4bun71iS4EnoZO8M6Ou9vW+97s5S119ZDX
         QGcdQe/85r044vRNP2bu1Vq1I0FCFOGMvYhZPb//7rdo4ctGVfnDzuH936cy22Jwb05D
         qfpP7zzsPCMcj/NeESld2Z8gVZG7Z6fNpHghf83eCQSqJx1YQj4ey5ZbBzkeJY3kzU03
         DmB0M5RD394UtlUb2tT956AhZfXdfgE8XE+sqJPkOF8xqxx/xdL4unbCMmkfp5tPx/VG
         osMx0Rm0dYtG1TkBZLhdzOiqPFnjOlidV10wbJQBodvOugKF2+5Ih7O2FMKNHja1OBsq
         p7Kg==
X-Gm-Message-State: AOAM530equwYgns7J2AT3UjZxmauC8P16JGN9beEg2cmCd8H2ZLOoK0m
        KYXWA5fGp5EhLcQ7D269aNIOukN2Ud/hkoGChRCxNw==
X-Google-Smtp-Source: ABdhPJxq2dvaLGm9768QLKM2BJTDGnKjmhEPActsl3HvDshutfqw+EtRAotjQcd8H/ieA2Nl6yddAVvI+nfRbd2ofkI=
X-Received: by 2002:a9d:27a3:: with SMTP id c32mr7617241otb.233.1590068544404;
 Thu, 21 May 2020 06:42:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200521110854.114437-1-elver@google.com> <20200521133626.GD6608@willie-the-truck>
In-Reply-To: <20200521133626.GD6608@willie-the-truck>
From:   Marco Elver <elver@google.com>
Date:   Thu, 21 May 2020 15:42:12 +0200
Message-ID: <CANpmjNMf7JRG4P1Ab2qsCy4Yw6vw2WC7yCgqUSBBOsBQdc_5bQ@mail.gmail.com>
Subject: Re: [PATCH -tip v2 00/11] Fix KCSAN for new ONCE (require Clang 11)
To:     Will Deacon <will@kernel.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Borislav Petkov <bp@alien8.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 May 2020 at 15:36, Will Deacon <will@kernel.org> wrote:
>
> On Thu, May 21, 2020 at 01:08:43PM +0200, Marco Elver wrote:
> > This patch series is the conclusion to [1], where we determined that due
> > to various interactions with no_sanitize attributes and the new
> > {READ,WRITE}_ONCE(), KCSAN will require Clang 11 or later. Other
> > sanitizers are largely untouched, and only KCSAN now has a hard
> > dependency on Clang 11. To test, a recent Clang development version will
> > suffice [2]. While a little inconvenient for now, it is hoped that in
> > future we may be able to fix GCC and re-enable GCC support.
> >
> > The patch "kcsan: Restrict supported compilers" contains a detailed list
> > of requirements that led to this decision.
> >
> > Most of the patches are related to KCSAN, however, the first patch also
> > includes an UBSAN related fix and is a dependency for the remaining
> > ones. The last 2 patches clean up the attributes by moving them to the
> > right place, and fix KASAN's way of defining __no_kasan_or_inline,
> > making it consistent with KCSAN.
> >
> > The series has been tested by running kcsan-test several times and
> > completed successfully.
>
> I've left a few minor comments, but the only one that probably needs a bit
> of thought is using data_race() with const non-scalar expressions, since I
> think that's now prohibited by these changes. We don't have too many
> data_race() users yet, so probably not a big deal, but worth bearing in
> mind.

If you don't mind, I'll do a v3 with that fixed.

> Other than that,
>
> Acked-by: Will Deacon <will@kernel.org>

Thank you!

-- Marco

> Thanks!
>
> Will
