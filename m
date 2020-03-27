Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 542ADC43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 03:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25BEB206DB
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 03:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="k/l+7EzR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbgC0Dc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 23:32:28 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38839 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbgC0Dc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 23:32:27 -0400
Received: by mail-qt1-f193.google.com with SMTP id z12so7533556qtq.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 20:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r71azbnhZkfrbX5EBuBZs+Z142rnXfAai7VBmmvucRQ=;
        b=k/l+7EzRvmXCev0yuQZ0c5mJXHjOLfvHQv5AbXX/oUQO+o9lT3gePYJcarWNlmcpCv
         ClHFnZTbq4sfmSoo8TOlCB6tzUEW7P/5gEYXFW/YRX3Pkssb9HoAXHR4MzQS6h3cMcRV
         nsx+2eXk4NImybe1UdIJbSYaSvypRWxcmZktI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r71azbnhZkfrbX5EBuBZs+Z142rnXfAai7VBmmvucRQ=;
        b=ftOFaVjuxW1AoQXyyuIBS/jRINyfj5NwTPJ6tCJ4oqE1HYXUfS7o9Wjyu9Q5yDwX2i
         yRsFmYQZ21jaVSLMeN7fL9mjZSVXgNLL/h89/LNmrZsJZdztryzJJEbQ3wsSsGj7yw0o
         UDfnBS9i6vrKQkphOT8i4zc4uDhusMpyfG6mcYG599XmtnOJs89HOyBQ4VR+CDf0j0Cc
         agCHAUbgeNegq7mtyOOF/SKy3NRVG5AjcM1K1rK4a7RVw6SFtMjEHz5LmBhdb8Vd2YBO
         6MJ0YUlj1gtP1QYdgZxDQkPxyhOC7fPoZf/YCnRnfNcUGaHfzCKjLPgzcvNC9qp9+PeU
         oJkA==
X-Gm-Message-State: ANhLgQ2bzeI1Ew4b9rAYLxO8Ian3aXnaOliP7lkV5wj8tvVJLAhfTwmh
        xVyYWunuxhHDi2MyoQIw5va13A==
X-Google-Smtp-Source: ADFU+vsTzsOQvgZZdj5qStX5c0xxObyeCKI3NnnQb0WpT0KdNeU7rXLEYJh4618T/wuDQOBRiFznkQ==
X-Received: by 2002:ac8:1b46:: with SMTP id p6mr12221767qtk.369.1585279946428;
        Thu, 26 Mar 2020 20:32:26 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id 199sm2629376qkm.7.2020.03.26.20.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 20:32:25 -0700 (PDT)
Date:   Thu, 26 Mar 2020 23:32:25 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Sonny Rao <sonnyrao@google.com>,
        linux-kernel@vger.kernel.org, Dmitry Shmidt <dimitrysh@google.com>,
        Amit Pundir <amit.pundir@linaro.org>, kernel-team@android.com,
        Jesse Barnes <jsbarnes@google.com>, vpillai@digitalocean.com,
        Peter Zijlstra <peterz@infradead.org>,
        Guenter Roeck <groeck@chromium.org>,
        Greg Kerr <kerrnel@google.com>, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>
Subject: Re: [PATCH RFC] cpuset: Make cpusets get restored on hotplug
Message-ID: <20200327033225.GA250520@google.com>
References: <20200326191623.129285-1-joel@joelfernandes.org>
 <20200326192035.GO162390@mtj.duckdns.org>
 <20200326194448.GA133524@google.com>
 <972a5c1b-6721-ac20-cec5-617af67e617d@redhat.com>
 <CAPz6YkVUsDz456z8-X2G_EDd-uet1rRNnh2sDUpdcoWp_fkDDw@mail.gmail.com>
 <20200326201649.GQ162390@mtj.duckdns.org>
 <20200326202340.GA146657@google.com>
 <592d4120-0b42-4607-5efd-fb2d4d29f0cc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <592d4120-0b42-4607-5efd-fb2d4d29f0cc@redhat.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 09:26:51PM -0400, Waiman Long wrote:
[...]
> I think the problem is that the v2_mode mount option is not that well
> documented. Maybe I should send a patch to add some some description
> about it in cgroup-v2.rst or cgroup-v1/cpusets.rst.

That is definitely worth it and I would fully support that.

thanks,

 - Joel

