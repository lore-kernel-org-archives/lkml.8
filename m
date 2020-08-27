Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10FAAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 08:50:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D64712177B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 08:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e3zZxERI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgH0IuY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 04:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgH0IuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 04:50:24 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6E7C061264;
        Thu, 27 Aug 2020 01:50:24 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id m34so2851439pgl.11;
        Thu, 27 Aug 2020 01:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HrNuCDj4eeY3Gt0lR5aH+iOHvrk1h2wIReFPr2GJWg8=;
        b=e3zZxERIuuUx3PGrF81pU/4X+c2wV6hZMC1+ZOMXUSoGRCbvjFxMIKK/iZooSZ9qTa
         B2adxyQx8HkVHhbWr2iYrTaIXV0mVhPpeDR1uhaHulGi7zcPuUN5XnjW29aHcgdnyFT+
         ll6/mOu2f4OKWvGP38xp9pmti9U6KqMngr+XHLct87tqig1YnXLMe6kzJpWcYykgfqjb
         IH6R0F6hTdnZ5I33Bth2YfAk3weoG/CzrA1XE/HcyvOWnAmTXAdU+lHPR/+yU0BIKxiG
         T2ZFbHNdGYvhomWyTKTcYwJoiMxRbrozZSjgPsg8AOAaBeLhHtuiZGxOc6Nf6FNX0mkS
         jidw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HrNuCDj4eeY3Gt0lR5aH+iOHvrk1h2wIReFPr2GJWg8=;
        b=YxMs+F+XuHCBTVMyDyeYaSf2OntKQd8OFjJbA+24BYeEazCIHD2Cp2x+zgXRxUoa0b
         jd1iEYh2veNa8JtdCWbghBBhvUEzhTc+LvF7tj4htmrx6uD6G3JT7ZVv9bP1xBa+haHd
         oIWb5ooxL84fZQJYri6EmPPnzCvljT+3lNUuILNkoV51726rxdB07RJ1qDqZD9HWX9NZ
         gvjbo7A/gcPf4SU/WAXbOuJgV0lRc5GXIRxkSGggwaefvBfrII9gzKx7QUQ5r6JkzpjP
         yTk2YNjmXfMTxGMBUQr8l1t3iIrTkVuKq8vsEbYC+R3FWQlN0xuMcviBp6ZFskWonhqL
         pVCA==
X-Gm-Message-State: AOAM531IR4bXjjkC5R1Mmxowpj1xpWpr6GwfnKDozdwYfbSAFsMUMkLu
        4zXM0EMImJpHaZ42r6RybjEMUItgvmZ62pRv/C1EUVk8OR7tKg==
X-Google-Smtp-Source: ABdhPJwaxPlgvM3l0aEl6pPRV5nMux3/djL0qCuROkyJLN2bzDOwRCsRKSuXRFAFxKGbVqMawBQUdolbAsHi0l4x9fk=
X-Received: by 2002:a17:902:8208:: with SMTP id x8mr4039738pln.65.1598518223339;
 Thu, 27 Aug 2020 01:50:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200825133216.9163-1-valentin.schneider@arm.com> <159851487090.20229.14835640470330793284.tip-bot2@tip-bot2>
In-Reply-To: <159851487090.20229.14835640470330793284.tip-bot2@tip-bot2>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 27 Aug 2020 11:50:07 +0300
Message-ID: <CAHp75VfJumPP=wKuU=OjFB11RUhPp0_5_+ogupQLFeEWKfbybA@mail.gmail.com>
Subject: Re: [tip: sched/core] sched/topology: Move sd_flag_debug out of linux/sched/topology.h
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     linux-tip-commits@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 10:57 AM tip-bot2 for Valentin Schneider
<tip-bot2@linutronix.de> wrote:
>
> The following commit has been merged into the sched/core branch of tip:

> Fixes: b6e862f38672 ("sched/topology: Define and assign sched_domain flag metadata")
> Reported-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Link: https://lkml.kernel.org/r/20200825133216.9163-1-valentin.schneider@arm.com

Hmm... I'm wondering if this bot is aware of tags given afterwards in
the thread?

-- 
With Best Regards,
Andy Shevchenko
