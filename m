Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D37AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 20:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70FBC2177B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 20:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h35Sp8BE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbgHFUP7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 16:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725875AbgHFUP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 16:15:59 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A917C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 13:15:58 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id l64so39376294qkb.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 13:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z5BaX90LdW8Ugx54ddA3KoziTH/PsAA8tFDwiMrbnR8=;
        b=h35Sp8BEgVxDlpWym/cQDqC4zseWQpiWdcfic5rVu1+3HpzGdKAeQGbagPrCRlkBKx
         7BMR5dsAGTbm/KvFxdORSZ4SwErxkTluAWtQIVmJmv1vPKSWOw2zKya/kpKjJGw1bfis
         oq/GYvo44pMAk3bLZT7xeexIRN5NYpjMf32iiSgGOUJ4Jz40CAVQmSTWWwTFWf0c1GQJ
         MZlwfp4WKJ0iWSTN4ua7uIngbzICK/dUIxzZN6y3Q4FuadADXkBP+K8AcbENRmGNdSdY
         neh4s3xk1Fs7HJeLqHFMOMdvS2D3/bS9KTtc5xiaBcK9aDYpHCG+6ngpGQ0d/0FDBmgd
         iiKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z5BaX90LdW8Ugx54ddA3KoziTH/PsAA8tFDwiMrbnR8=;
        b=f9DGjiJ4KNP+JcgDMHznHnxEMU16c2e3bEdSO+dOoXoVuJl4uWLBu0u5DUj5LOyeKw
         jc7l8O3TDE6TWq2Mf08fEHJeP2ygT3H7LzOFpzfaGCMfV4qN0R4EDLztolXWkdZILfLq
         nyzcxbPDm/XkD/xbNUlqGm7dW6J4Vc/F07BhMbqC2c3SLkq5zWz27OcCNVzUStmbUQZO
         uRFT/RXJ+zO9er3jyC2QUm1cKnln8FEQWU9lmamsYeRKnBbCLYjCqJ7dl5UxhIpf05VA
         6EuGzUhbeRAw7ze5N7k9kweVIe9ZEIqI9FaKiVTBp8Z23UukNXDJC90q+mM1j4kRBveV
         YHNg==
X-Gm-Message-State: AOAM5302LipwCIrkmrMApW9OSJP8kxtZdHcI2NV0ss13ZV9658QyFeca
        AAJQJaLc5xzBzm8yrNmBEKF5bqfAJD4Tpd1O72o=
X-Google-Smtp-Source: ABdhPJwSfeFtVLjjuWu43jt9dVPk/qZN6CoHRswsFXANDqtxyDrzZufWflt9mHDnqAa1Yh69p4Nz07aZufBWpHGp3/A=
X-Received: by 2002:a37:a44:: with SMTP id 65mr10479172qkk.370.1596744957954;
 Thu, 06 Aug 2020 13:15:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200601091231.3794350-1-chengzhihao1@huawei.com>
 <CAFLxGvwLSvYsQ+OPi85VS8aQ2uge_JqQRD2C8h=XMORvCej3Sw@mail.gmail.com>
 <211afcd0-d5b3-5ac0-1fd1-dc789634a858@huawei.com> <CAFLxGvwRDfB4mqxJhOLwWvoZ3yzpVY-kuAiovYLf8T7WwJqaTg@mail.gmail.com>
 <9caa4860-975c-70bb-c8b9-737d1db9ead4@huawei.com> <CAFLxGvycs7DNu5o5QY1WwTPfS6cTTykTh-91n9TQZ7yP_ADr4A@mail.gmail.com>
 <2086f822-e67a-43e4-76d8-5339eaccd3ac@huawei.com>
In-Reply-To: <2086f822-e67a-43e4-76d8-5339eaccd3ac@huawei.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Thu, 6 Aug 2020 22:15:46 +0200
Message-ID: <CAFLxGvzwoC1GcjJOfwpc8V5LD79=8XiJaNV2HjOm8EdQcCbp+w@mail.gmail.com>
Subject: Re: [PATCH] ubi: check kthread_should_stop() after the setting of
 task state
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     linux-mtd@lists.infradead.org, LKML <linux-kernel@vger.kernel.org>,
        Richard Weinberger <richard@nod.at>,
        "zhangyi (F)" <yi.zhang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 5, 2020 at 4:23 AM Zhihao Cheng <chengzhihao1@huawei.com> wrote:
> Er, I can't get the point. I can list two possible situations, did I
> miss other situations?

Yes. You keep ignoring the case I brought up.

Let's start from scratch, maybe I miss something.
So I'm sorry for being persistent.

The ubi thread can be reduced to a loop like this one:
1. for (;;) {
2.      if (kthread_should_stop())
3.              break;
4.
5.      if ( /* no work pending*/ ){
6.              set_current_state(TASK_INTERRUPTIBLE);
7.              schedule();
8.              continue;
9.      }
10.
11.     do_work();
12. }

syzcaller found a case where stopping the thread did not work.
If another task tries to stop the thread while no work is pending and
the program counter in the thread
is between lines 5 and 6, the kthread_stop() instruction has no effect.
It has no effect because the thread sets the thread state to
interruptible sleep and then schedules away.

This is a common anti-pattern in the Linux kernel, sadly.

Do you agree with me so far or do you think syzcaller found a different issue?

Your patch changes the loop as follows:
1. for (;;) {
2.      if (kthread_should_stop())
3.              break;
4.
5.      if ( /* no work pending*/ ){
6.              set_current_state(TASK_INTERRUPTIBLE);
7.
8.              if (kthread_should_stop()) {
9.                      set_current_state(TASK_RUNNING);
10.                     break;
11.             }
12.
13.             schedule();
14.             continue;
15.     }
16.
17.     do_work();
18. }

That way there is a higher chance that the thread sees the stop flag
and gracefully terminates, I fully agree on that.
But it does not completely solve the problem.
If kthread_stop() happens while the program counter of the ubi thread
is at line 12, the stop flag is still missed
and we end up in interruptible sleep just like before.

So, to solve the problem entirely I suggest changing schedule() to
schedule_timeout() and let the thread wake up
periodically.

-- 
Thanks,
//richard
