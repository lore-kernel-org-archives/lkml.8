Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2972C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 04:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F6E720733
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 04:27:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMLmQy0h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbgC2E1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 00:27:01 -0400
Received: from mail-lf1-f42.google.com ([209.85.167.42]:38113 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgC2E1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 00:27:01 -0400
Received: by mail-lf1-f42.google.com with SMTP id c5so11148749lfp.5
        for <linux-kernel@vger.kernel.org>; Sat, 28 Mar 2020 21:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DKuqxQAQBeNQgytSbEVjMMvxTA8MJGsKh7TmTVm7ZJc=;
        b=IMLmQy0h7+NFb4TXAkQcgd5on9TbLSHa1cyg2ahHZKjC/WRq2IKlflcbs3dcRxp+zS
         60UnnDISwHmvPiq87KC1rTcw/rf5tkr7aMNLqB1AHPPmd3zlbggc+ntKn7x9+fYXtQgX
         moHi1zsj/w4aqUsBGOYeOLDVLiO/bv9ccMsR+Y8hpbzAYnThZXjnZhOf4Bc5f1VNGKbT
         wg48wn3HjXZ9AZdPANGQN64mmv4pE3hAgLlFByuFZUXUidiMcdUnop/ZpF9+xXG0jeLP
         5VEK0Y0sW7azSdRpzGGu+I5rPT8ruFv5iznzZCVXVByXR06R2uKeWu+PIhGGs5eh8DZr
         8ORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DKuqxQAQBeNQgytSbEVjMMvxTA8MJGsKh7TmTVm7ZJc=;
        b=gqNi7yg4mQHx9vOZKrQX/kmk5fdx/fYcHWvMnaXw6Hj/nFYYLAf00b2NCfibxbFWRQ
         DPEBwDp30VfTQCGoMQkqe5kmSS6dPq462//uVqFujaI38bisnO8uZl2JnHANx0t9GpDb
         /CraYwOMbEf4ZPde5W45cbcqXUIagrZeE5HTZXXDVtoMNfIl/WifAePa8Z0t4y2C0fKQ
         bBLIUTAnQWv/NfELI9rTDvWiUSL70kWsos2GU0PnCG0Oh4pFlR2R3QVCM9HLQoKw5M1H
         PLWZcoQnjKtNKfRKPO+8f4lB1nE3cetFWEkfs8a9iq4EDzF6kJaOeNyrrHfsUPMvx4eE
         G/kA==
X-Gm-Message-State: AGi0PuYUsiI153Hda5paUeDE7E6A90ABbhoIQ3cLGKeLTTir5tiQAiyn
        j25np32ot3Wq7u2TBVX+cLvSZoAJCaAFQVQounw=
X-Google-Smtp-Source: APiQypIGauvW1Q31v5Y/4O3X0ow7r2dOeJqgNLLWJlBdJ44AGF74HGkgEB4uww9f74C9kIuLFnzdNny5o9M5vHHloZ8=
X-Received: by 2002:ac2:48b3:: with SMTP id u19mr4229181lfg.84.1585456018710;
 Sat, 28 Mar 2020 21:26:58 -0700 (PDT)
MIME-Version: 1.0
References: <1585140388-61802-1-git-send-email-aubrey.li@intel.com> <20200328132325.GC11705@shao2-debian>
In-Reply-To: <20200328132325.GC11705@shao2-debian>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Sun, 29 Mar 2020 12:26:41 +0800
Message-ID: <CAERHkrukPEO_sCiOS_YWnVPvFrHUbL10oov6hd_UVZ9PdvchkQ@mail.gmail.com>
Subject: Re: [sched/fair] 59901cb452: netperf.Throughput_Mbps -27.3% regression
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Aubrey Li <aubrey.li@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>, dietmar.eggemann@arm.com,
        Steven Rostedt <rostedt@goodmis.org>, bsegall@google.com,
        mgorman@suse.de,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Aubrey Li <aubrey.li@linux.intel.com>, lkp@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 28, 2020 at 9:24 PM kernel test robot <rong.a.chen@intel.com> wrote:
>
> Greeting,
>
> FYI, we noticed a -27.3% regression of netperf.Throughput_Mbps due to commit:
>
>
> commit: 59901cb4520c44bfce81f523bc61e7284a931ad1 ("[PATCH] sched/fair: Don't pull task if local group is more loaded than busiest group")

Thanks for the report, Robot, ;-)

This patch is abandoned, and replaced by another one:

- [PATCH] sched/fair: Fix negative imbalance in imbalance calculation

Thanks,
-Aubrey
