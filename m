Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CF8C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9BC520663
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CLgd6xmd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389636AbgF2Umz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731640AbgF2TOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:14:03 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F8EC0086F7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 02:50:43 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id w3so3011744wmi.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 02:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IXD7e4aEv7sgXUIWJkq0xUs1aBDV2xAaVnA6400SobQ=;
        b=CLgd6xmdcEKh0TYTp6bS2/cnN4ve6VpRHpjGNf1iI1fca4aR7317bHKFlRuZ9Wx2q6
         5agnn/14ytGl0Zc3TOng7wBjOUZXSXteNxxJwTw2NCavC0ZzZN8CaFmgPX49JPkVhUWL
         PFK5aaOWQuOkJT/BINyeAu1ZxoKKaJD9N3AOWGHjxna7hGelNbCEA2ApFp+EdFj3tjMa
         EcoY4RBXpeN1cp3atcfrD2v0mfB/sxZS/CrQID6YEV57FpKEIEgN20t1yY4GTxlShSdA
         WcqoXCviP51t0/2Z77vnIhZDuCmAZ8jBkpmkYnNPQIMaWW3Tkmc/z0xufzCR4jwBKR2E
         gHKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IXD7e4aEv7sgXUIWJkq0xUs1aBDV2xAaVnA6400SobQ=;
        b=YHI2HlacD4nSjh0KmGFVpmStkg5gKXZXUq55D7Y99EAcfug0ItD/Th8jeLsrWzhZJS
         ZA22gtk/M/J/eF13khTSzoZLzZGVGHFoQaJAeTuVx/CH6Phw8Ui16YrQ/4L4ksOyGEr/
         XP2kSgrVuvCl8B7/r5DVGD7fB0eOiFy3K2FuAee4Zfkg3rJ0NLaOqrKVsYAkE6K0m+sn
         NihLWzvbk4yPzF4MCStLNXbQXI9dsijMQU/U/4FoHkjy4erhb2YhqGiFnyGHjEYCeE5u
         c4PQyqEXE4G3267TBRt1kPdYIHjTZpV5BDuK6f9hhVdq4XFWfolV6s8KTQ2UvfdHZlf7
         cTkg==
X-Gm-Message-State: AOAM531iyhr/xVkosVZRW6VyCMDd/pCcOC8BkVKhfBNAUqKg2mkevlca
        4W84GdvTGS6JjsS6bmXZ0lt+yA==
X-Google-Smtp-Source: ABdhPJxMqPKSRyQRTa8e+1xxaRQXHveCNK3SVjkE6kDWmX2xGNysUBdu3iSx65dgB0uJZD4m0+GKlA==
X-Received: by 2002:a1c:ab84:: with SMTP id u126mr10979386wme.43.1593424242304;
        Mon, 29 Jun 2020 02:50:42 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id 138sm29835351wma.23.2020.06.29.02.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 02:50:41 -0700 (PDT)
Date:   Mon, 29 Jun 2020 10:50:38 +0100
From:   Quentin Perret <qperret@google.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        Jonathan Corbet <corbet@lwn.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com, tkjos@google.com, adharmap@codeaurora.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 3/3] cpufreq: Specify default governor on command line
Message-ID: <20200629095038.GB1231692@google.com>
References: <cover.1593418662.git.viresh.kumar@linaro.org>
 <96b6e6ca02b664194ff3e57e1ec768fbc597bf38.1593418662.git.viresh.kumar@linaro.org>
 <20200629094452.GB1228312@google.com>
 <20200629094627.jh7pwhftcdqj6nhm@vireshk-i7>
 <20200629094825.GA1231692@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629094825.GA1231692@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 Jun 2020 at 10:48:25 (+0100), Quentin Perret wrote:
> On Monday 29 Jun 2020 at 15:16:27 (+0530), Viresh Kumar wrote:
> > On 29-06-20, 10:44, Quentin Perret wrote:
> > > On Monday 29 Jun 2020 at 13:55:00 (+0530), Viresh Kumar wrote:
> > > >  static int __init cpufreq_core_init(void)
> > > >  {
> > > > +	struct cpufreq_governor *gov = cpufreq_default_governor();
> > > > +
> > > >  	if (cpufreq_disabled())
> > > >  		return -ENODEV;
> > > >  
> > > >  	cpufreq_global_kobject = kobject_create_and_add("cpufreq", &cpu_subsys.dev_root->kobj);
> > > >  	BUG_ON(!cpufreq_global_kobject);
> > > >  
> > > > +	if (!strlen(default_governor))
> > > 
> > > Should we test '!strlen(default_governor) && gov' here actually?
> > > We check the return value of cpufreq_default_governor() in
> > > cpufreq_init_policy(), so I'm guessing we should do the same here to be
> > > on the safe side.
> > 
> > With the current setup (the Kconfig option being a choice which
> > selects one governor at least), it is not possible for gov to be NULL
> > here. And so I didn't worry about it :)
> 
> Right, so should we remove the check in cpufreq_init_policy() then?
> I don't mind either way as long as we are consitent :)

And actually maybe we should remove the weakly defined
cpufreq_default_governor() implementation too? That'd make sure we get a
link-time error if for some reason things change in the Kconfig options.

Thanks,
Quentin
