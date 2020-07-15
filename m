Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CE8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3591C20720
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 15:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D+ARyC/t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgGOPdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 11:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgGOPdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 11:33:05 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406E8C08C5DB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:33:05 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id y2so2689460ioy.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3/pQdYS/Dnr1ymTJv+NidFC3OUFb+e6KKsxPQ2Yv67c=;
        b=D+ARyC/tT0EwkUI5QwGS/MpuvZHZQhZw1IIn9yTvTJ5PzNgdV+xJ/09woYE+QgKfHA
         3nKvtPRUFo91vGrZFgb7mNort2mz0DapQl970UQKuba9mYudg7ARczsPYKbSKJCaUpjV
         Fk258LRS73Px4xEW/TA2kMUJauSKvIMglEiugBR3zKo6W0D9aC9EuWP2GjQJG2tjFoEe
         eQ8PL+1KiRVDerhisAHsmoPZOjTS70z873MicFxWmtGOZMhK53rzReWy5Qxwx8kNikp9
         je9dzKqFAQF7ri/Pfuvj7yOzlwqQ2ayWa1kC/nuMJuJ0pZfEGNGuIebCrCAdEa4smsTu
         3i3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3/pQdYS/Dnr1ymTJv+NidFC3OUFb+e6KKsxPQ2Yv67c=;
        b=Jdw6eaW7c+Z9V19Is0K7TpfjMnNRZAgpE0eA1tNi5WzX3JDLj5amWtpN8QTHvPVety
         5j0CLQ+d40SEYXIMSrw67ZZ/pNl4TIBiJ7N/M8aAykx/QhrmfSsWUepTGsIKPvK0rMW8
         kYjBt0C7RWRiuErS0NgDjVUBLnMljTBOOjMDXUQ8F4eOJdtsIyXNLj4ujVgaNm97Jund
         PdvnOTAkScei7c/+0qzQw5gJLFtNlpj+uOpk0ir4q4gBz3isHkmBim/HBDzo4zCJSv7i
         X2tW9LrS6NJ9SMAyFWPPgeebA74msM0qZAWzWcmgVaHvuaOWzfS4jCBSBFvv8AjxYkK8
         GSXA==
X-Gm-Message-State: AOAM531ZKw1LFjq+PB+TBpMf3Mh3rYVSnhjEgFVOd3IlcPqP4vjRd1ym
        71E1rPWc5qcSWPXCogabDtvNmABX077VE/XvrEaYLQ==
X-Google-Smtp-Source: ABdhPJweq1N6tkof3wjCwSMgBSSq0jgPksYVht/5VHBVayPqCWUxP7gIsxMCn/l6df4OcdQzXCWR0gv5qPFEFEpUW1E=
X-Received: by 2002:a6b:5c0a:: with SMTP id z10mr10587243ioh.131.1594827184561;
 Wed, 15 Jul 2020 08:33:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200714200445.1427257-1-mathieu.poirier@linaro.org> <1cde5c1d5d9047149c93e031c5093492@SFHDAG3NODE1.st.com>
In-Reply-To: <1cde5c1d5d9047149c93e031c5093492@SFHDAG3NODE1.st.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 15 Jul 2020 09:32:53 -0600
Message-ID: <CANLsYkyWLowSk1Zq7oWUzgsF=7FDVwe6XDgA6foWyX0VQwTE4g@mail.gmail.com>
Subject: Re: [PATCH v6 00/11] remoteproc: stm32: Add support for attaching to M4
To:     Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Cc:     "ohad@wizery.com" <ohad@wizery.com>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Loic PALLARDY <loic.pallardy@st.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jul 2020 at 00:51, Arnaud POULIQUEN <arnaud.pouliquen@st.com> wrote:
>
> Hi Mathieu
>
> > -----Original Message-----
> > From: Mathieu Poirier <mathieu.poirier@linaro.org>
> > Sent: mardi 14 juillet 2020 22:05
> > To: ohad@wizery.com; bjorn.andersson@linaro.org; Loic PALLARDY
> > <loic.pallardy@st.com>; Arnaud POULIQUEN <arnaud.pouliquen@st.com>;
> > mcoquelin.stm32@gmail.com; Alexandre TORGUE
> > <alexandre.torgue@st.com>
> > Cc: linux-remoteproc@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> > stm32@st-md-mailman.stormreply.com
> > Subject: [PATCH v6 00/11] remoteproc: stm32: Add support for attaching to
> > M4
> >
> > This set applies on top of [1] and refactors the STM32 platform code in order
> > to attach to the M4 remote processor when it has been started by the boot
> > loader.
> >
> > New to V6:
> > 1) Removed extra newline in patch 06.
> > 2) Re-worked title and changelog of patch 08 to better reflect
> >    what is done by the patch.
> >
> > Tested on ST's mp157c development board.
>
> I don' t know if you don't see  it on last  version or if you prefer that I review your update first... so for the series

Ah yes, my apologies on that - I misread the comment you left me in
00/11 of the V5 set.

>
> Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
>
> Thanks,
> Arnaud
>
> >
> > Thanks,
> > Mathieu
> >
> > [1].https://patchwork.kernel.org/project/linux-
> > remoteproc/list/?series=318275
> >
> > Mathieu Poirier (11):
> >   remoteproc: stm32: Decouple rproc from memory translation
> >   remoteproc: stm32: Request IRQ with platform device
> >   remoteproc: stm32: Decouple rproc from DT parsing
> >   remoteproc: stm32: Remove memory translation from DT parsing
> >   remoteproc: stm32: Parse syscon that will manage M4 synchronisation
> >   remoteproc: stm32: Properly set co-processor state when attaching
> >   remoteproc: Make function rproc_resource_cleanup() public
> >   remoteproc: stm32: Parse memory regions when attaching to M4
> >   remoteproc: stm32: Properly handle the resource table when attaching
> >   remoteproc: stm32: Introduce new attach() operation
> >   remoteproc: stm32: Update M4 state in stm32_rproc_stop()
> >
> >  drivers/remoteproc/remoteproc_core.c |   3 +-
> >  drivers/remoteproc/stm32_rproc.c     | 214 ++++++++++++++++++++++++--
> > -
> >  include/linux/remoteproc.h           |   1 +
> >  3 files changed, 198 insertions(+), 20 deletions(-)
> >
> > --
> > 2.25.1
>
