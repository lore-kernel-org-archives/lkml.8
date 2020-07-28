Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E7AC433FC
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 06:22:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1B7C20759
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 06:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OYXjOsSN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728172AbgG1GWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 02:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726944AbgG1GWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 02:22:34 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA6CC0619D6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 23:22:33 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id gc9so10945307pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 23:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CRQ3SY13fKgFuQBuWwIXpmK8jrUTuVHeJrYZMW46Jls=;
        b=OYXjOsSNp9DOGylUrC0LHHlTYi2ODrqorK03mlCeDzJm05uwYAozu9nfFdy+N3ZuS0
         wO0B/v5eE+c7SbWXJatUfKYJCir7akBsjC3G/QQ5nHFTvZwBPf4hTHC0VIhJclDE2ryo
         v+uvCFkHeqmzoAEBB7BSLmBLceZAQGVwFnbyNZwj/x3ld6kN5apGSeTGQjWBaPaZG5t9
         l8dNRoFqXyjTRwEVhajOMQrFJEJJZeL6pd6uTEW3Q8UP/q1L7GE+WSOBFJ/5Fava0wPI
         x3HCveEuHZmr7T/FqCIJpiAKTs3vTQ88FbGIleN+YKowD485T79+haeFMoXWGfqwjcK/
         7WIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CRQ3SY13fKgFuQBuWwIXpmK8jrUTuVHeJrYZMW46Jls=;
        b=fbHhy8j1R84GZ3kCwK7qXeEajueLrpFEBm9b1lQLzuaIx7GycnMSpPvDKid3zuAxW4
         SPaFceV7Rrf2YzjqJsHUkoGfqmIzwNBKJegpHwAC5p73DmRMKKvczJU0I4Eq38dHaEVg
         GHiGwQQU9rRUSiOCYe6KryZS6kZ5DrjvDN0acBuC7O9C9CMWUF0W2lOzQU3ndT81+iiA
         CbNVH6u0Ov6iz0dXv+Q0Bq/Bh0R1WiL12ylGld7sGIV0SZd4Z3RPuslHnZaXaF9JflQA
         aNY5TPhuauMkFhEZmf5cCOWquTWd8JDehwwGtU686TGhEGjyQ3QcC5ZgUqhFpX7pKSAI
         hFcA==
X-Gm-Message-State: AOAM533kUAgMHE6j1Ui8wctkgH7xA5cLndGm/U/nDldSSm+O7MQVxC/L
        aNoQbTpEJOqxKGFSPMj9Nkf6wg==
X-Google-Smtp-Source: ABdhPJzTDtaY7juL2jL12tXcUAzpFPROaks5fcO1q/YYTsUflH+8Bu5uRR2lb6cK7oytaYb8/dZaOw==
X-Received: by 2002:a17:90a:764c:: with SMTP id s12mr2842004pjl.201.1595917353146;
        Mon, 27 Jul 2020 23:22:33 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id 204sm17246447pfx.3.2020.07.27.23.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 23:22:32 -0700 (PDT)
Date:   Mon, 27 Jul 2020 23:19:00 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Evan Green <evgreen@chromium.org>
Cc:     Sibi Sankar <sibis@codeaurora.org>, Andy Gross <agross@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-remoteproc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ohad Ben Cohen <ohad@wizery.com>, rohitkr@codeaurora.org,
        stable@vger.kernel.org, linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH 1/2] remoteproc: qcom: q6v5: Update running state before
 requesting stop
Message-ID: <20200728061900.GD349841@builder.lan>
References: <20200602163257.26978-1-sibis@codeaurora.org>
 <CAE=gft7sbh_S_GiRohtMmdMN9JzQhG0m3bUerwrmzhjmXucGKw@mail.gmail.com>
 <6392c800b0be1cbabb8a241cf518ab4b@codeaurora.org>
 <CAE=gft4v1iHAPJS13fLBXgjt8ZRhD7q894zF_7JvK9QbiTbwhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE=gft4v1iHAPJS13fLBXgjt8ZRhD7q894zF_7JvK9QbiTbwhA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 03 Jun 15:33 PDT 2020, Evan Green wrote:

> On Tue, Jun 2, 2020 at 10:29 PM Sibi Sankar <sibis@codeaurora.org> wrote:
> >
> > Evan,
> > Thanks for taking time to review
> > the series.
> >
> > On 2020-06-02 23:14, Evan Green wrote:
> > > On Tue, Jun 2, 2020 at 9:33 AM Sibi Sankar <sibis@codeaurora.org>
> > > wrote:
> > >>
> > >> Sometimes the stop triggers a watchdog rather than a stop-ack. Update
> > >> the running state to false on requesting stop to skip the watchdog
> > >> instead.
> > >>
> > >> Error Logs:
> > >> $ echo stop > /sys/class/remoteproc/remoteproc0/state
> > >> ipa 1e40000.ipa: received modem stopping event
> > >> remoteproc-modem: watchdog received: sys_m_smsm_mpss.c:291:APPS force
> > >> stop
> > >> qcom-q6v5-mss 4080000.remoteproc-modem: port failed halt
> > >> ipa 1e40000.ipa: received modem offline event
> > >> remoteproc0: stopped remote processor 4080000.remoteproc-modem
> > >>
> > >> Fixes: 3b415c8fb263 ("remoteproc: q6v5: Extract common resource
> > >> handling")
> > >> Cc: stable@vger.kernel.org
> > >> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> > >> ---
> > >
> > > Are you sure you want to tolerate this behavior from MSS? This is a
> > > graceful shutdown, modem shouldn't have a problem completing the
> > > proper handshake. If they do, isn't that a bug on the modem side?
> >
> > The graceful shutdown is achieved
> > though sysmon (enabled using
> > CONFIG_QCOM_SYSMON). When sysmon is
> > enabled we get a shutdown-ack when we
> > try to stop the modem, post which
> > request stop is a basically a nop.
> > Request stop is done to force stop
> > the modem during failure cases (like
> > rmtfs is not running and so on) and
> > we do want to mask the wdog that we get
> > during this scenario ( The locking
> > already prevents the servicing of the
> > wdog during shutdown, the check just
> > prevents the scheduling of crash handler
> > and err messages associated with it).
> > Also this check was always present and
> > was missed during common q6v5 resource
> > helper migration, hence the unused
> > running state in mss driver.
> 
> So you're saying that the intention of the ->running check already in
> q6v5_wdog_interrupt() was to allow either the stop-ack or wdog
> interrupt to complete the stop. This patch just fixes a regression
> introduced during the refactor.
> This patch seems ok to me then. It still sort of seems like a bug that
> the modem responds arbitrarily in one of two ways, even to a "harsh"
> shutdown request.
> 

I think the patch properly fixes this regression, but I share your
concern about the fact that we omit an entire category of
shutdown-related crashes from being reported.

The problem I presume with the current behavior is that the shutdown
will race against the crash handler - which might boot the remoteproc up
again while the shutdown is progressing.

So I'm okay with this fix for the immediate problem, but think it would
be nice if we could report the issue appropriately and then finalize the
shutdown.

> I wasn't aware of QCOM_SYSMON. Reading it now, It seems like kind of a
> lot... do I really need all this? Can I get by with just remoteproc
> stops?

It used to be that we set one bit in shared memory and sent an
interrupt and the modem would set another bit and interrupt us back when
it was done shutting down...

> Anyway, for this patch:
> 
> Reviewed-by: Evan Green <evgreen@chromium.org>

Thanks,
Bjorn
