Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAAC1C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAABA206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z5NnE/EH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgEOPvt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 11:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726283AbgEOPvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 11:51:48 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1EBC05BD09
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 08:51:48 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id t11so1136134pgg.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 08:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tA+EMjW1VLqca6EzHa71oII4dWMrB7DJ+VRMsfne5wg=;
        b=Z5NnE/EHKLhl5fNCT/O9KT6XzbynyEvJz0IEjG4Ijbev0911UWm6o7shtlZ9ZCiEYE
         3+Ra6r140tXwXQf2O8Y4mZSrEHubQvM1K8kEW149Jyhn7vvlRfJGkqAyrKJS4ykwH+Nr
         NACf2roUlNkiqMXaLbdbnpNc5Dv/G6nMYvQpXmnnyrpOba4sWPwwMLJ/5d7J8Mpxwg9v
         dLV3yMnFwI5fr+uyKHW45Ys5fTEmk4sGTEkpWMCh/9+geopKiVRYcZ5XH0adjQNiWiY2
         RFGAkWtildUxpjvVfrwdIXfjpqMBArYV/pTJXw+mkWHjQL1ikyCcGeDxgpgwK2YhIZWB
         pv0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tA+EMjW1VLqca6EzHa71oII4dWMrB7DJ+VRMsfne5wg=;
        b=WhciCEF09Wd8bhN0mpk7yE1r0AEC/C8impagzO2ZUP/Xeg0+k97rXkHsAPQX8gdSC5
         TMk8dtJzk7EGs/JARS22f9jIlF7f0BkudIuyyUPudUWZkibrTR06lHsugnkKyO606uAN
         vPjUGPKQPYxIpmaCvBsFxaZnM/iookQ85epMF6uScMkGXw3yFj6uStitaLINfUSi/8fQ
         xUsdX/eqyiOiv4UFdclbc3NHB1Cer1er9bE3cpyKMun5+txEso0OYvsWr6mriBxG5SyM
         l6yr3jvVmAiUmnk2+IZ0mZo3Duv/nPSNV6HYIZug/0oLkbWehnRqGOQFPVHROi9Tyo1k
         Alig==
X-Gm-Message-State: AOAM532HrkdEII19dsd6oXe8mb0pE+9Iu/188wKrflxxha30d6gP5rUD
        tdxCznzNfZs21l3HbBBl8dsGuA==
X-Google-Smtp-Source: ABdhPJwlWcwKTqlkYO68NoSZ7gIvSmCybZaXRYhqcFQVJ2OHaE2OmcfLhgtaFFi19JTcmqicgEOGzQ==
X-Received: by 2002:a62:16d5:: with SMTP id 204mr3198305pfw.10.1589557907919;
        Fri, 15 May 2020 08:51:47 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id h17sm2261399pfk.13.2020.05.15.08.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 08:51:47 -0700 (PDT)
Date:   Fri, 15 May 2020 09:51:44 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Mike Leach <mike.leach@linaro.org>
Subject: Re: [PATCH] coresight: etm4x: Add support to disable trace unit
 power up
Message-ID: <20200515155144.GA7085@xps15>
References: <20200514105915.27516-1-saiprakash.ranjan@codeaurora.org>
 <20200514180055.GA29384@xps15>
 <2c932d57288508cc72a6ee323cf5595e@codeaurora.org>
 <CANLsYkxun2EWGeLU42ShbqkJMtCTh+Q9L3t=CXQR+-2zVuuJYg@mail.gmail.com>
 <a0f8f01f28506e10001885e387d3cb4f@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0f8f01f28506e10001885e387d3cb4f@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 08:37:13PM +0530, Sai Prakash Ranjan wrote:
> Hi Mathieu,
> 
> On 2020-05-15 20:22, Mathieu Poirier wrote:
> > On Thu, 14 May 2020 at 12:39, Sai Prakash Ranjan
> > <saiprakash.ranjan@codeaurora.org> wrote:
> > > 
> > > Hi Mathieu,
> > > 
> > > On 2020-05-14 23:30, Mathieu Poirier wrote:
> > > > Good morning Sai,
> > > >
> > > > On Thu, May 14, 2020 at 04:29:15PM +0530, Sai Prakash Ranjan wrote:
> > > >> From: Tingwei Zhang <tingwei@codeaurora.org>
> > > >>
> > > >> On some Qualcomm Technologies Inc. SoCs like SC7180, there
> > > >> exists a hardware errata where the APSS (Application Processor
> > > >> SubSystem)/CPU watchdog counter is stopped when ETM register
> > > >> TRCPDCR.PU=1.
> > > >
> > > > Fun stuff...
> > > >
> > > 
> > > Yes :)
> > > 
> > > >> Since the ETMs share the same power domain as
> > > >> that of respective CPU cores, they are powered on when the
> > > >> CPU core is powered on. So we can disable powering up of the
> > > >> trace unit after checking for this errata via new property
> > > >> called "qcom,tupwr-disable".
> > > >>
> > > >> Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
> > > >> Co-developed-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> > > >> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> > > >
> > > > Co-developed-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> > > > Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
> > > >
> > > 
> > > Tingwei is the author, so if I understand correctly, his signed-off-by
> > > should appear first, am I wrong?
> > 
> > It's a gray area and depends on who's code is more prevalent in the
> > patch.  If Tingwei wrote the most of the code then his name is in the
> > "from:" section, yours as co-developer and he signs off on it (as I
> > suggested).  If you did most of the work then it is the opposite.
> > Adding a Co-developed and a signed-off with the same name doesn't make
> > sense.
> > 
> 
> I did check the documentation for submitting patches:
> Documentation/process/submitting-patches.rst. And it clearly states
> that "Co-developed-by must be followed by Signed-off by the co-author
> and the last Signed-off-by: must always be that of the developer
> submitting the patch".
> 
> Quoting below from the doc:
> 
> Co-developed-by: <snip> ...Since
> Co-developed-by: denotes authorship, every Co-developed-by: must be
> immediately
> followed by a Signed-off-by: of the associated co-author.  Standard sign-off
> procedure applies, i.e. the ordering of Signed-off-by: tags should reflect
> the
> chronological history of the patch insofar as possible, regardless of
> whether
> the author is attributed via From: or Co-developed-by:.  Notably, the last
> Signed-off-by: must always be that of the developer submitting the patch.

Ah yes, glad to see that got clarified.  You can ignore my recommendation on
that snippet.

> 
> > > 
> > > >> ---
> > > >>  .../devicetree/bindings/arm/coresight.txt     |  6 ++++
> > > >>  drivers/hwtracing/coresight/coresight-etm4x.c | 29
> > > >> ++++++++++++-------
> > > >
> > > > Please split in two patches.
> > > >
> > > 
> > > Sure, I will split the dt-binding into separate patch, checkpatch did
> > > warn.
> > 
> > And you still sent me the patch...  I usually run checkpatch before
> > all the submissions I review and flatly ignore patches that return
> > errors.  You got lucky...
> > 
> 
> I did not mean to ignore it or else I wouldn't have run checkpatch itself.
> I checked other cases like "arm,scatter-gather" where the binding and the
> driver change was in a single patch, hence I thought it's not a very strict
> rule.

The patch has another warning for a line over 80 characters, that should have
been fixed before sending.  Putting DT changes in a separate patch is always
better for the DT people.  They review tons of patches and making their life
easier is always a good thing.

Regards,
Mathieu

> 
> Thanks,
> Sai
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
> of Code Aurora Forum, hosted by The Linux Foundation
