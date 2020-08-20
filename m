Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9695CC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DEE12078B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 07:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ihby9AfJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbgHTHTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 03:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbgHTHTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 03:19:22 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA17FC061757
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 00:19:21 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id e4so589158pjd.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 00:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q1y153rv3+KWnniS+JYSIpUMYocRsqS/3wTmJQItL5A=;
        b=Ihby9AfJSJd3xfDg1VZadZT+7rW7KKeAUby8/LeJxr7U94ghH6mdTZ+sY6WjGW8FsC
         974Dh5crpVjPbwNT+hLFsWHB/dwxS1CbTFRxjZh+tnZ7rXBY/UrXCC37Nla9u8Hs/s7Q
         KBbkvJOeyK1/RsgPlERl3rwxnEw2w7iy+3v3tj4tQT4rxJJECHuF185fs41489JOsyXF
         RDVwNIkXvRT8qyH6qVGug0Ym3uy5UQFanBb4EDpEXnPD3GX8JkyhJ5yUWxyiwYcJRkCr
         g8zN++6ocfodrvL/jrxC0urtvj590qlHLfHcSj4VV1+k0oZGN+9jgJ2tBZm+n50JUUlg
         9DcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=q1y153rv3+KWnniS+JYSIpUMYocRsqS/3wTmJQItL5A=;
        b=Raq2LkHOmVohOvmYKONIcozvfTbyEQhcKEcj8T1KZcvUekMM4kLpv/g3N+PD3ag+Oz
         L85zTtzEeYhHylW/GvSXteoGard61am2/sCXeAGxs1+ns5XGs+y6PzXcsvZ/HehX0x3D
         EZkx+z4UCWQnsGH0YpjfD4/icZpMvOlrnvEvAolQ7je7Cv5HWsz9lrW6ChSYIVtl5RWN
         oP9t3ew8zmK5VTLATcHDS/VuhOqronhgXSAgJwzRwivSa7Uf/J9uBW1zkrVKmyAZBUrH
         ibdeN6A4DVrQMOmVIUcVZjdpUuzybk+dtFcydMNyoIfu6uuzNndk3fscGepG80sBExWH
         SuNg==
X-Gm-Message-State: AOAM531YNhNqZfuTGLVpQmF4sk2KLLnDiUhx7kHyac8jvurP7dkYFPw6
        Yajb7nnDlHtoZEtV93WhG1z7QA==
X-Google-Smtp-Source: ABdhPJzsGMOP88P06n6XKgAFoOtd2Ztnx+QwcXLRfiOCgjjcKq4wvMzH8HohQf85X7949R2/c6op5Q==
X-Received: by 2002:a17:902:b708:: with SMTP id d8mr1652138pls.138.1597907958772;
        Thu, 20 Aug 2020 00:19:18 -0700 (PDT)
Received: from localhost ([122.172.43.13])
        by smtp.gmail.com with ESMTPSA id x15sm1657609pfr.208.2020.08.20.00.19.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Aug 2020 00:19:17 -0700 (PDT)
Date:   Thu, 20 Aug 2020 12:49:15 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Nishanth Menon <nm@ti.com>, Viresh Kumar <vireshk@kernel.org>,
        linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, mka@chromium.org,
        sibis@codeaurora.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] opp: Reused enabled flag and remove regulator_enabled
Message-ID: <20200820071915.eesd3hygheraqbyh@vireshk-i7>
References: <1597043179-17903-1-git-send-email-rnayak@codeaurora.org>
 <c6bba235a9a6fd777255bb4f1d16492fdcabc847.1597292833.git.viresh.kumar@linaro.org>
 <359b588928b7e58b009f786b17ddc088c6a7d18b.1597292833.git.viresh.kumar@linaro.org>
 <159747812515.33733.6233341429546003955@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159747812515.33733.6233341429546003955@swboyd.mtv.corp.google.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-08-20, 00:55, Stephen Boyd wrote:
> Quoting Viresh Kumar (2020-08-12 21:29:00)
> > diff --git a/drivers/opp/core.c b/drivers/opp/core.c
> > index e8882e7fd8a5..5f5da257f58a 100644
> > --- a/drivers/opp/core.c
> > +++ b/drivers/opp/core.c
> > @@ -703,12 +703,10 @@ static int _generic_set_opp_regulator(struct opp_table *opp_table,
> >          * Enable the regulator after setting its voltages, otherwise it breaks
> >          * some boot-enabled regulators.
> >          */
> > -       if (unlikely(!opp_table->regulator_enabled)) {
> > +       if (unlikely(!opp_table->enabled)) {
> >                 ret = regulator_enable(reg);
> >                 if (ret < 0)
> >                         dev_warn(dev, "Failed to enable regulator: %d", ret);
> > -               else
> > -                       opp_table->regulator_enabled = true;
> 
> A quick glance makes this look unsafe now because we're only checking
> 'enabled' and not actually setting it when this function is called. I
> have to go back to the previous patch to understand where enabled is now
> set to confirm that it is OK. If it was all one patch all the context
> would be here.

The only case where things can go crazy are the cases where (for
example) clk_set_rate() fails, or something like that which would be a
bug and it shouldn't bother in the normal working of this code.

-- 
viresh
