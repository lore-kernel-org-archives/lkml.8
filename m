Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15D1C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 17:59:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94166208DB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 17:59:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rtUe86of"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729914AbgEAR7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 13:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729373AbgEAR7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 13:59:41 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDC4C061A0E
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 10:59:40 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id d3so4865122pgj.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 10:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SrJ+suZtBWr1oaesi/k2ktaEJnaAc56s/fpYYwm6YkQ=;
        b=rtUe86ofD35Jm4kswBmEsEiDvYps/sFLvc+ucRqtIMN6Wg3XEGcRYzZyWhpnEWffql
         I3cAVYkpNiJg9tmvu7bXzxraGLxCbRGRO4ZxtZkJohoMaBUoJdbTCyYKximei2dOynJ3
         hxG6dZLTt74LX5VnwHPk1A1McsjT/SzfbUN1AkGAUJMPYcY8CHlx5nZ5z7wEiqkT4tU6
         ArTfBHszH1/lrdfolV+z/4bLsFO7PgN+KXYar26fPiH2TFLda7soTzqU5Ks1iXxpQ7Xl
         lhRMVyBkTCHNR9RhjR++rAN8EYAFapQFr+yPZ2+hm8nhAtuoAAUy1pE5YWIx7KXTNgj1
         Q2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SrJ+suZtBWr1oaesi/k2ktaEJnaAc56s/fpYYwm6YkQ=;
        b=CA1TCxzI1ttsuU+Zwjyo2fjANn0hHNuxMPcM3DqF6b6y2B9NelusLdC4CqbY5LyegD
         zFjlX/39tZLbjuu9J49DasJ3Zc8UMP/s2VtHLFG1YJS+zLznkh6f5u1CYHKfo1Kz1auz
         AMctO8iEEVyJ55/A0EbbdhlIOhkFLiBvntdsgjn1t2uRzNequ4QOu19VtXioHSoNDXBV
         CyruuvlHARGa9nfug65dumbWdm9iq0d5gwT53rSkjoZejjJ0phOAkj5ZZ7KDYIcZcZ+T
         MNRLR0Gba268JKG+gplM1CD5iUQD1Ohlm5SpR1Mm/fOym6gPXAyLEjbrYpzEjD24HZBh
         cfzw==
X-Gm-Message-State: AGi0PuYF+S/79Ll32VKiH8ySnWcCKvsBIVGa8jNgEeSHZuJyDAu7KZJv
        R/9vKbzjEGzzCfodRNu5h5B9rQ==
X-Google-Smtp-Source: APiQypKSvb3juH8yufYz3pZtYJr5I7jYwQqi+KNzHP8QMg+pl6CzWIz0QI5ety/mLdAJyEKbW8lq+w==
X-Received: by 2002:a65:62ce:: with SMTP id m14mr5189526pgv.174.1588355980303;
        Fri, 01 May 2020 10:59:40 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id e16sm2510386pgg.8.2020.05.01.10.59.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2020 10:59:39 -0700 (PDT)
Date:   Fri, 1 May 2020 11:59:37 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Cc:     bjorn.andersson@linaro.org, ohad@wizery.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        loic.pallardy@st.com, linux-remoteproc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/12] remoteproc: stm32: Add support for
 synchronising with M4
Message-ID: <20200501175937.GG18004@xps15>
References: <20200424202505.29562-1-mathieu.poirier@linaro.org>
 <219771d3-b0a5-0ec7-7f20-d2055bcb0217@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <219771d3-b0a5-0ec7-7f20-d2055bcb0217@st.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 05:08:32PM +0200, Arnaud POULIQUEN wrote:
> Hi Mathieu,
> 
> On 4/24/20 10:24 PM, Mathieu Poirier wrote:
> > This patchset needs to be applied on top of this one [1].
> > 
> > It refactors the STM32 platform code in order to introduce support for
> > synchronising with the M4 remote processor that would have been started by
> > the boot loader or another entity.
> > 
> > It carries the same functionatlity as the previeous revision but account
> > for changes in the remoteproc core to support synchronisation scenarios.
> > Some RB tags have been removed when the content of the patch has strayed 
> > too far from the original version. See patch 3, 8, 9 and 12 for more
> > details.
> 
> I reviewed the series, and made some tests on my side.
> FYI, I do not answer to patches when tagged "Reviewed-by: Loic Pallardy" 
> and with no extra remark. So consider them as Reviewed-by me but not
> necessary to add the tag in commit, Reviewed-by: loic in commit is sufficient. 

Well, if you spent all this time reviewing the code might as well get credit for
it...  And it also helps maintainers get a feel for how many eyes have looked
at the code.

> 
> Concerning tests, it works find except the crash recovery from a sync start.
> But i suppose that you know the limitation, waiting Loic patches[1] update :)

As I commented in the patch itself, I'll fix this so that the condition leading
to the recovery limbo can't happen.

Thanks,
Mathieu

> 
> [1]: https://lkml.org/lkml/2020/3/11/403
> 
> Thanks a lot for your work!
> Arnaud
>  
> 
> > 
> > Tested on ST's mp157c board.
> > 
> > Thanks,
> > Mathieu
> > 
> > [1]. https://patchwork.kernel.org/project/linux-remoteproc/list/?series=277049
> > [2]. https://patchwork.kernel.org/project/linux-remoteproc/list/?series=239877
> > 
> > Mathieu Poirier (12):
> >   remoteproc: stm32: Decouple rproc from memory translation
> >   remoteproc: stm32: Request IRQ with platform device
> >   remoteproc: stm32: Decouple rproc from DT parsing
> >   remoteproc: stm32: Remove memory translation from DT parsing
> >   remoteproc: stm32: Parse syscon that will manage M4 synchronisation
> >   remoteproc: stm32: Get coprocessor state
> >   remoteproc: stm32: Get loaded resource table for synchronisation
> >   remoteproc: stm32: Introduce new start ops for synchronisation
> >   remoteproc: stm32: Update M4 state in stm32_rproc_stop()
> >   remoteproc: stm32: Introduce new parse fw ops for synchronisation
> >   remoteproc: stm32: Introduce new loaded rsc ops for synchronisation
> >   remoteproc: stm32: Set synchronisation state machine if needed
> > 
> >  drivers/remoteproc/stm32_rproc.c | 262 ++++++++++++++++++++++++++++---
> >  1 file changed, 244 insertions(+), 18 deletions(-)
> > 
