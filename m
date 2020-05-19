Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09EB7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 03:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBA122075F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 03:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a8wAg21X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbgESDmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 23:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbgESDmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 23:42:18 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BA7C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 20:42:18 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id m7so5068307plt.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 20:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4/BjPGQWQmiJ9ENgCFkWCpYAZ2ZRvlC05U7wmeNA1ao=;
        b=a8wAg21X8NCDhYNS/otY351xeR+5EHERz5A1QQV+Y7Ypl2ERVeF248y/SiArtHRjr2
         H/P89hcSwePhQAdmEt1SkBWRbl+K3UcfL+Po1sgtCSBN4y/tMU06zJb5hED6nwWPy6ux
         WWQeswadJiLmzE+BkPQJf/JTBfFDs5PcV/QGvQ1/IxFA+xa+WHfVj2cePEkKbZKqQEPu
         6nwZV97ZFVqikdwmG3HKjYDHvtGG/9qWHHovZDwyf3UTv3tRdol7DxzvcxyifdIUuCIZ
         HqBNGnb1+W3qbYdGeO1SAYUxvybcNDqTpf/PZsEoHn0nrv+UcK3g5QSBXf250lrjQ9Ee
         ACNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4/BjPGQWQmiJ9ENgCFkWCpYAZ2ZRvlC05U7wmeNA1ao=;
        b=qeMB3+vrHiZr5qmpSmi1gN0q2oguOjvxDQlXFUoeyUzR9ck3cGUusv2PfomM81xJWR
         PSp+ePrVWBekZvZn6yZ7BawKYjhfAtkpxCyH/WZu2fIxdtaJ1x2553vjeMWpmhwZIwkV
         50aTk+tca+l0xLamt1trCWpXegoi6KXPIjzrCqS7NHIr6I8PzO8tkBEOy71Ur2H2OVu3
         Ptmc0CSFufAGEfsyoREhr00N7Nu4hIz/KGhTCMsGYOg72MFtJdsViptspXGvdkvwlAvy
         Q8Xvt3tp1p1Ns5iucPP1D3529JOdUrL96V0c5iMxilntcZ83IUg1eoXXYp6SRjUrENWX
         pYGw==
X-Gm-Message-State: AOAM533rFrgf6fVuQVZuF3CAo/CUDJ+NxiOqMbUxd5lg7od3mXATV8LO
        Tv9mSjxd7kEGogI4CGKUaIeegQ==
X-Google-Smtp-Source: ABdhPJxQvr/vGk96BcQAIlKBPRTaAWbkdoqMBIawp8ZTutAuzE7F1lZMEO0quqnXBxyiSkx6DWM3mg==
X-Received: by 2002:a17:902:c254:: with SMTP id 20mr6018967plg.287.1589859738182;
        Mon, 18 May 2020 20:42:18 -0700 (PDT)
Received: from localhost ([122.167.130.103])
        by smtp.gmail.com with ESMTPSA id j124sm4337974pfd.116.2020.05.18.20.42.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2020 20:42:17 -0700 (PDT)
Date:   Tue, 19 May 2020 09:12:15 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH] interconnect: Disallow interconnect core to be built as
 a module
Message-ID: <20200519034215.zr3gvrsokstxh2bs@vireshk-i7>
References: <b789cce388dd1f2906492f307dea6780c398bc6a.1567065991.git.viresh.kumar@linaro.org>
 <CAOCOHw4ri6ikRpkJWtAdaPQiMhdKMrdNciqQ8YNaXR+ApSnAew@mail.gmail.com>
 <66c3d470-48e2-619a-dd95-6064a85161e0@linaro.org>
 <20200515071152.GA1274556@kroah.com>
 <20200518184010.GF2165@builder.lan>
 <20200519033101.fi6oa4xjchdzafi3@vireshk-i7>
 <20200519033703.GX2165@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519033703.GX2165@builder.lan>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-05-20, 20:37, Bjorn Andersson wrote:
> On Mon 18 May 20:31 PDT 2020, Viresh Kumar wrote:
> 
> > On 18-05-20, 11:40, Bjorn Andersson wrote:
> > > It most certainly does.
> > > 
> > > With INTERCONNECT as a bool we can handle its absence with stub
> > > functions - like every other framework does. But as a tristate then
> > > every driver with a call to the interconnect api needs an entry in
> > > Kconfig to ensure the client driver must be a module if the interconnect
> > > framework is.
> > 
> > This patch has been pushed to linux-next a few days back.
> > 
> 
> Thanks Viresh, I had missed that.

Not your fault, we didn't resend it but simply applied the old version
itself :)

-- 
viresh
