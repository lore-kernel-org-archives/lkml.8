Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFFB6C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 06:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A822F20663
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 06:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GZrz1tIq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbgGOG3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 02:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbgGOG3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 02:29:40 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC1FC061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 23:29:39 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id a23so45835pfk.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 23:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Bci9otSHTII4KCyi0A2O1MteU5VBNvY7qi+UTqGXA1o=;
        b=GZrz1tIqj0Jgs96qFVeceHb0geWLoORZsn5qUHaVeDSgHs/A888g1O7F1KqweeFFff
         yBJbd/8HT6B0tToxwlPV9afTQqgEXZ8vnNOQA+kRZfNGyKfijzxoHIUEinseRPi7Ycck
         /xJgoU82fhe7Pyh26RIv6kdfOd1Cxmoraz0RhR9/jEdaqg9bGZMQZQDmwii2PK3OGKWl
         pJwT/9WVut2ec1XdsoYmH6B/O5V/seglxixmZjmSCOkMCoaD85NxK42f1bi0MxZwN3hM
         PKVUIDTuL2i11f6ktvPD/6RH9YCCENhcyH4lRFtetgn5yFOto0WDwiH8zdqfBhe4V+Ri
         BJyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Bci9otSHTII4KCyi0A2O1MteU5VBNvY7qi+UTqGXA1o=;
        b=HlyeP2ys7TXc33cv0YAWUlmzuCQpDI+epOPthGDu1dPPrPw5rwZgXRyBAg9bayHnpH
         sODp0iWVkXQWwOK9E7Q85T76gW3blQNE6YS2K39xen2Nb1/Jq9FZ0tvjQKUMdzSsADU8
         OuIBa2cDcHJzx5J6UJB+2dlg/tYxvcx6PSMULVocKgdFr1X9SS+bokjqiIrB6Hj7alwc
         +U+mCl88Els4JjxJEv9Vwky11GR9MP76UIbjlajZNXoWJk9ax3Nabfd82o22nYjBYndg
         IuxAJurs//U0+O48pNX8yDJs/mhhGnXLNDMDY8OWozyeeQaKhUHGeL1h8QqGZYONFQGH
         2dCg==
X-Gm-Message-State: AOAM533JEFpFYsB9NaTS9cG9kIhjy/jSLU1aJl+fikCjgQkxo4/xOmUf
        Syg/1wHKQfiyhesjOQlvjCk9Jg==
X-Google-Smtp-Source: ABdhPJzSxPc6Xvaaod/eRr9SAHT4RrUJF3ZCu1EIKwKXEnEuKIbWi//tAIfc458R1JV1lc458wBHFA==
X-Received: by 2002:a62:e203:: with SMTP id a3mr6967553pfi.295.1594794579329;
        Tue, 14 Jul 2020 23:29:39 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id az13sm882763pjb.34.2020.07.14.23.29.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Jul 2020 23:29:38 -0700 (PDT)
Date:   Wed, 15 Jul 2020 14:29:33 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] arm64: perf: Proper cap_user_time* support
Message-ID: <20200715062933.GA19269@leoy-ThinkPad-X240s>
References: <20200715020512.20991-1-leo.yan@linaro.org>
 <20200715051715.GA225020@debian-buster-darwi.lab.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715051715.GA225020@debian-buster-darwi.lab.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ahmed,

On Wed, Jul 15, 2020 at 07:17:15AM +0200, Ahmed S. Darwish wrote:
> On Wed, Jul 15, 2020 at 10:05:06AM +0800, Leo Yan wrote:
> ...
> >
> > In this version, there have two changes comparing to Peter's original
> > patch set [1]:
> >
> ...
> >
> > [1] https://lkml.org/lkml/2020/5/12/481
> >
> 
> Nitpick: please avoid using https://lkml.org:
> 
>   1) It's a non-official external service
>   2) The opaque URLs it uses drop the most important info for uniquely
>      identifying e-mails: the Message-Id.
> 
> Thus if the site one day goes down, and at times it did, the reference
> is almost gone forever.
> 
> Use "https://lkml.kernel.org/r/<message-id>". The link becomes:
> 
>   https://lkml.kernel.org/r/20200512124058.833263033@infradead.org

Thanks for sharing good practice, later will follow this fashion for
using links.

Thanks,
Leo
