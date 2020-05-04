Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F16C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 16:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58C72206D9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 16:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VwTnWyDA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729703AbgEDQtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 12:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728655AbgEDQtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 12:49:33 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1069AC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 09:49:33 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id p25so5761229pfn.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 09:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=N98hzrvavUDmiZvqjRc8Y+NamEOGTTXQ9QYdiVbRQUI=;
        b=VwTnWyDAqzkDtnfnRgQ+QgRKkew37qUbEFsl/e0olaTckk9POdNzFiORuokPHsU7cr
         4+b3dqe/qJU/NBud1lZT3+CcNb91dNtjmBBneGSvFIy/k04EuQlHwdi0+/LGIoyrHg8C
         VA9O9YNxP+kpn0ADakess8vbaTVtsneJ6CJNw1Xvy1DyjCv2xrFuQZQfKTn/u/q6QcjQ
         QYTMpzlCno59ssPhfcoOU6vB/zaxSGVsF44ZuZeu8OonrkIW7BAyCkWUyqynEdE5oqtQ
         tQD+7mlEdV048vuEWVlWORiIte+CqOOQcv9ssYtGSS3UUOnqPIlwdUP5lotDLCuiOe/j
         E3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=N98hzrvavUDmiZvqjRc8Y+NamEOGTTXQ9QYdiVbRQUI=;
        b=OQjk/Pu9Sa3fKEp/vQ/RzcWfDP6/kfnbUElT+4PYTABtnGLVzkIwSILEA/P7AjG1A8
         f0X0LQ1xlNfhMm57aVG5xZO+Adr3CBYISgs3E2fV5gJMxOMh2j5w71Po1mDuRBgGav1f
         kSZKbz1r4ci5FZ+e9MF3Tz1Lh7GnxQ3RCftyUMdq6MqquRWiQ4Fhnuhyc6sL628BKchR
         ndQyRk5nOVBDQdXYey7pJvO9z1T63ckHvisLqskbrv7U3wKELbEA6EA4IqzLXNxfHTAR
         7UG9uWybvzoLNU24DGCxGWihtcKNRNHWl8VpHEQrRppX53NLrubi03UzW81X8hSsWJIu
         vWzA==
X-Gm-Message-State: AGi0PubAvHVP1ZUX3X2i6wy960/qHBKonp/jGHlwF1BtyRqVv0VIup7J
        dVR8E1d9TLj2C8OdT6mw/iT5dg==
X-Google-Smtp-Source: APiQypJ0UtE+FqSr0S/8CiLbts6PMUhrSDn8+4Okd3e/IXqVStp2R/N4PLwqQWR32HncAgCP22VImQ==
X-Received: by 2002:a62:6341:: with SMTP id x62mr19109043pfb.289.1588610972562;
        Mon, 04 May 2020 09:49:32 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id t20sm11014pjo.13.2020.05.04.09.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 09:49:31 -0700 (PDT)
Date:   Mon, 4 May 2020 10:49:30 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Douglas Anderson <dianders@chromium.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>
Subject: Re: [PATCH v2 1/2] coresight: Include required headers in C files
Message-ID: <20200504164930.GA755@xps15>
References: <20200428181010.170568-1-swboyd@chromium.org>
 <20200428181010.170568-2-swboyd@chromium.org>
 <20200429180818.GA3062@xps15>
 <158818506575.117437.11635372928426076937@swboyd.mtv.corp.google.com>
 <CANLsYkzkq=EuKx_=W2jv2TeWpM3P=Pd9NYS18VfG9KCey=2--g@mail.gmail.com>
 <158852907765.11125.7786353455300506998@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <158852907765.11125.7786353455300506998@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 03, 2020 at 11:04:37AM -0700, Stephen Boyd wrote:
> Quoting Mathieu Poirier (2020-04-29 12:24:42)
> > 
> > >
> > > So please remove slab.h from the two files (but not the other one) when
> > > applying. Thanks.
> > 
> > You got it.
> 
> I looked in next but coresight-cti-platform.c is missing slab.h even
> though I included it in my patch. There's a bare kcalloc() call in that
> file, so slab.h is required.

I know what happened.  The above comment mentions removing slab.h in two and
leaving the "other" one in place.  But looking at the original file only
coresight-cti-platform.c and coresight-cti-sysfs.c had an slab.h.

I have made the correction.

