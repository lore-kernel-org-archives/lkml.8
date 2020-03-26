Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50973C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 20:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24CCE2070A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 20:23:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="dY7wSC08"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbgCZUXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 16:23:44 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:44417 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727446AbgCZUXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 16:23:43 -0400
Received: by mail-qk1-f196.google.com with SMTP id j4so8334246qkc.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 13:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hJWp5t89/iwbfn8Ca+Lrz1rZRbdYA2KCpWmXHJOj3y4=;
        b=dY7wSC0838pzka4AzUdCK19Pqo/xSg0AU8qIfHTom1OXY5mFHlZIYMENXzpLnBMDcC
         NwYnyykFW1mIgRuaJe2SIZNN+JLl1bR6XMi/axhztQ+3Lol92UZB9R5juK0hc6a1xaWl
         o5DOw2ARWnmKhSSoBhVBErNkXtykPQzMjcX8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hJWp5t89/iwbfn8Ca+Lrz1rZRbdYA2KCpWmXHJOj3y4=;
        b=nDWzljTZFPrnQHPLyHDqAbeNdENkR0qykl+fwlE6BBjKgGdK21m4312sGrUpe1WzaR
         f3tQm8YDFskv01KUg4Cwcum17NF5SIOq+CFx9kJH6PVcuWo6dRheIGO4sYRCokzPjX1y
         O15Sn+3VYl1iGnGsmbsArfjrnSi1Vt/mKHPJlTMzFN73m0yfbVT+kbnaFbWmhZHtHe4q
         EVctcFgta5ieG4fcI1C56xJxjrw2x5OdcQS2Pwgm1u48TKOOfdPeKYr7egkY/u/aTUjK
         ZT8AtCKQR/4kxaKtHAcnAlhHcJV0yMJAr4X9/POG9QLItBbAiHBOz/BqaXmpR5yq9qW9
         v6Vg==
X-Gm-Message-State: ANhLgQ3rbB2abfGZkMoP6K7Wag2H58DVgtt4x9lRprHijQzyVa/UdEo7
        8Z8mMH0eUh0cp++u3y10MlPgpw==
X-Google-Smtp-Source: ADFU+vvdfgPWrcllkj1WQ8cugXCsD6gKi4uamCH0UN8ejJIKkiAcGgtzhXH9Q2UhVC/2+6inHbi62w==
X-Received: by 2002:a05:620a:539:: with SMTP id h25mr10212915qkh.395.1585254222181;
        Thu, 26 Mar 2020 13:23:42 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id z6sm2092718qka.34.2020.03.26.13.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 13:23:40 -0700 (PDT)
Date:   Thu, 26 Mar 2020 16:23:40 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     Sonny Rao <sonnyrao@google.com>, Waiman Long <longman@redhat.com>,
        linux-kernel@vger.kernel.org, Dmitry Shmidt <dimitrysh@google.com>,
        Amit Pundir <amit.pundir@linaro.org>, kernel-team@android.com,
        Jesse Barnes <jsbarnes@google.com>, vpillai@digitalocean.com,
        Peter Zijlstra <peterz@infradead.org>,
        Guenter Roeck <groeck@chromium.org>,
        Greg Kerr <kerrnel@google.com>, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>
Subject: Re: [PATCH RFC] cpuset: Make cpusets get restored on hotplug
Message-ID: <20200326202340.GA146657@google.com>
References: <20200326191623.129285-1-joel@joelfernandes.org>
 <20200326192035.GO162390@mtj.duckdns.org>
 <20200326194448.GA133524@google.com>
 <972a5c1b-6721-ac20-cec5-617af67e617d@redhat.com>
 <CAPz6YkVUsDz456z8-X2G_EDd-uet1rRNnh2sDUpdcoWp_fkDDw@mail.gmail.com>
 <20200326201649.GQ162390@mtj.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326201649.GQ162390@mtj.duckdns.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 04:18:59PM -0400, Tejun Heo wrote:
> On Thu, Mar 26, 2020 at 01:05:04PM -0700, Sonny Rao wrote:
> > I am surprised if anyone actually wants this behavior, we (Chrome OS)
> 
> The behavior is silly but consistent in that it doesn't allow empty active
> cpusets and it has been like that for many many years now.
> 
> > found out about it accidentally, and then found that Android had been
> > carrying a patch to fix it.  And if it were a desirable behavior then
> > why isn't it an option in v2?
> 
> Nobody is saying it's a good behavior (hence the change in cgroup2) and there
> are situations where changing things like this is justifiable, but, here:
> 
> * The proposed change makes the interface inconsistent and does so
>   unconditionally on what is now a mostly legacy interface.
> 
> * There already is a newer version of the interface which includes the
>   desired behavior.
> 
> * I forgot but as Waiman pointed out, you can even opt-in to the new
>   behavior, which is more comprehensive without the inconsitencies,
>   while staying on cgroup1.

Thank you Tejun, Waiman and Sonny. I confirmed the cgroup_v2_mode option
fixes cgroup v1's broken behavior.

We will use this mount option on our systems to fix it.

thanks,

 - Joel

