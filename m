Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABABC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 798EF206F1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:55:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yo/HNQ93"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389730AbgF2Uzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731094AbgF2TNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:11 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C538AC0086ED
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 02:46:30 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 67so3603056pfg.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 02:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=twG/EpHFuddy1cJI4fW+wI5sB13DCvr59QOYZyPQvNU=;
        b=yo/HNQ93HufpwCBYJHzJLpKYwIIAl0VMUj2nyPl6T2UPoijncLXHNKAdPYjL3L5lHT
         Zk86qKQesI8zLVRj91lRQFZ9gQVG6tC5Rv9Io2JBMHEY3TZeHFmlCuEdE8Gr83Eip4YF
         aEfxDR3S8vxeRS+pitFuvIq9wr9a6InjsNKI3O1wn3B06wNQd8vGg6OOOfNYtFctHxbp
         qANSp15+IMUav5Rv3+a+7wzSUYJP3D2jOOYf9hLBUNPWef9axGtHkdFl0re9zwtYPKpg
         HspnQ8i/aT7uNI3lE0e9Hg9fJjDeUxSVPBzdwYixvKF2NhNoxF0OSzFQLS72aksVZc4a
         Ia5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=twG/EpHFuddy1cJI4fW+wI5sB13DCvr59QOYZyPQvNU=;
        b=Yt9hLB/FK+ygW7C1tmxPWewdyUhQQoe5EWOAXVtImeuoB7ERyNOLs9FFS2J5Rbw5vZ
         A26vOG7XQvtHum6lAqdOFWOAzIPyPZd90ULJismYpz6Pfxrwvn9so7N/36fU27JkcMLW
         RP/aVK5W7UgksfJLPePN6j0QByHfHH4Lu/ZP0AiJG8nBvqnVGWk4dH2eZ+4PhqhWgdau
         QFaMJnrTGhXKzy8tGLyn2SoePWl1pmNKrMFPnB807Vpam2Vv3Vq75dhwl+DC4+lf1C/g
         ppusJahAGDPcH5u9CwDKyk9iXPjF5ljmfUjOrts5wMEINuS1aLeCnjq++PO0Jd7xgRzX
         eiaw==
X-Gm-Message-State: AOAM533aJFOAHSJNSfY/iBcPwhMgeJZ9e+EcyqzmRkmp8PbIGvElBVeT
        RNNwPt6RmoHHsn1Vl8aHwPERrg==
X-Google-Smtp-Source: ABdhPJxucTS/dE2M+PRfCssDuqawGeg909Rg9RxBv9//zm0cML2sSyfvU+J7x5kZWv89y8yYC7MFcw==
X-Received: by 2002:a63:f903:: with SMTP id h3mr9891025pgi.437.1593423990258;
        Mon, 29 Jun 2020 02:46:30 -0700 (PDT)
Received: from localhost ([122.172.127.76])
        by smtp.gmail.com with ESMTPSA id b14sm15088557pfb.186.2020.06.29.02.46.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jun 2020 02:46:29 -0700 (PDT)
Date:   Mon, 29 Jun 2020 15:16:27 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Quentin Perret <qperret@google.com>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com, tkjos@google.com, adharmap@codeaurora.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 3/3] cpufreq: Specify default governor on command line
Message-ID: <20200629094627.jh7pwhftcdqj6nhm@vireshk-i7>
References: <cover.1593418662.git.viresh.kumar@linaro.org>
 <96b6e6ca02b664194ff3e57e1ec768fbc597bf38.1593418662.git.viresh.kumar@linaro.org>
 <20200629094452.GB1228312@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629094452.GB1228312@google.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-06-20, 10:44, Quentin Perret wrote:
> On Monday 29 Jun 2020 at 13:55:00 (+0530), Viresh Kumar wrote:
> >  static int __init cpufreq_core_init(void)
> >  {
> > +	struct cpufreq_governor *gov = cpufreq_default_governor();
> > +
> >  	if (cpufreq_disabled())
> >  		return -ENODEV;
> >  
> >  	cpufreq_global_kobject = kobject_create_and_add("cpufreq", &cpu_subsys.dev_root->kobj);
> >  	BUG_ON(!cpufreq_global_kobject);
> >  
> > +	if (!strlen(default_governor))
> 
> Should we test '!strlen(default_governor) && gov' here actually?
> We check the return value of cpufreq_default_governor() in
> cpufreq_init_policy(), so I'm guessing we should do the same here to be
> on the safe side.

With the current setup (the Kconfig option being a choice which
selects one governor at least), it is not possible for gov to be NULL
here. And so I didn't worry about it :)

-- 
viresh
