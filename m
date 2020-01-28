Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54265C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 21:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1892C207FD
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 21:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KnDzVDoX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgA1V7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 16:59:41 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:45381 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbgA1V7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 16:59:40 -0500
Received: by mail-il1-f193.google.com with SMTP id p8so12107252iln.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 13:59:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5qE2yGDar/QO89ZtmbEwV0agYaFSTn6aRkOLzm6MdDM=;
        b=KnDzVDoX/735WRiNifi2vMkpwGbkqY73NCKHH2E7ldvV16oBi22WMClKG0mBbMlGoP
         agf6TI3e+yFWCxKVjYsWoadqbKcJ2Y/FWp0721tdhrwJ9PXevZB1t61oMCg4H7DpShbA
         LYf2DFWQTfn9Em0DZZweVfszDmmnGSE6SeLYTGeQmUpFn82c+4huguBLrWvgNi6giiSt
         QsCoreTxs1E/HkcMHUFTcbq1npKL2NMPCY0LbbqcqTFOxJ1H2r4KUJVu0CBREgM47dcx
         yeMKjAg704GP99/Z2dIS5/oePgycIA2fudk8NWYJzVtRWVJAYPhFH/QKET5c1O3ZRtAJ
         SaLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5qE2yGDar/QO89ZtmbEwV0agYaFSTn6aRkOLzm6MdDM=;
        b=Tu9uDIlQHpqztjub86O4QnLvllGGEMQf7vHv2XuVOHRVAhqPFZvAZOyV+9pmN9Dcni
         qIoxTYM8ZxXtwouPkxaYeTE9Dt6bQcFLdmK0u/eB+S1QvEKb/mSkw4P46M5ubMwfFpjT
         uiopmkatpTPZmqwtuPINHAltNHNJmbvbxAcTjn7sbGshds/u50sivYwUTTV/MTI4MfS8
         uCBacfDH3rsDoJOVreD43xrI/C0ybuN42s1WMH+vjdPv/XuUcqrkBykwUWjTKfoWTNg/
         1Av7jXaNFgaqZxBtHy2DBLgDr+US09+ANFmLQPLljk1cknDGSk226TIkEjhaWAVIHGKs
         pjjA==
X-Gm-Message-State: APjAAAVijAIcVzXVI8ajb2t38RizKFw9Y7EQ2WdyYxF8Xu47gqe+8YEQ
        t+yvjTmxoJ1T2htQlQ2MJubWD8GE2DKvnrNScHcwDw==
X-Google-Smtp-Source: APXvYqya8Ty/3A9imY+gRu5qeRRZ4MwOyuIOlPAzOz3kBJ9Jn7sXOuYGYnovYbSG1jsWbvYccvovJ3B1i4a9Sepp7QQ=
X-Received: by 2002:a92:8141:: with SMTP id e62mr21629924ild.119.1580248779692;
 Tue, 28 Jan 2020 13:59:39 -0800 (PST)
MIME-Version: 1.0
References: <20200127212256.194310-1-ehankland@google.com>
In-Reply-To: <20200127212256.194310-1-ehankland@google.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Tue, 28 Jan 2020 13:59:28 -0800
Message-ID: <CALMp9eRfeFFb6n22Uf4R2Pf8WW7BVLX_Vuf04WFwiMtrk14Y-Q@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: Fix perfctr WRMSR for running counters
To:     Eric Hankland <ehankland@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Peter Shier <pshier@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 1:23 PM Eric Hankland <ehankland@google.com> wrote:
>
> Correct the logic in intel_pmu_set_msr() for fixed and general purpose
> counters. This was recently changed to set pmc->counter without taking
> in to account the value of pmc_read_counter() which will be incorrect if
> the counter is currently running and non-zero; this changes back to the
> old logic which accounted for the value of currently running counters.
>
> Signed-off-by: Eric Hankland <ehankland@google.com>

Fixes: 2924b52117b2 ("KVM: x86/pmu: do not mask the value that is
written to fixed PMUs")

Reviewed-by: Jim Mattson <jmattson@google.com>
