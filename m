Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A515C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42B7220753
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585056747;
	bh=k3sG9/9cgaNDCcVKdRrfpWGhTLpsDpD5E2tXYdinvCU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=mju4RmTt4RFA+hVvfKcxGjS74dxREBnAUR4B/phfVVvncDBo6wW9JBR8QFtk+ZQW2
	 Lr0V+tH9UN/ccVxaxbUhs4Wp11gfSQq+g8di6VOnbC2zVH8eSwKIvo3nEJaNdIS5Z9
	 cefU+wTuSHCflVrdJIybafVqhjWrovgv5SSy4lwI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbgCXNc0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:32:26 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54085 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbgCXNRk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:17:40 -0400
Received: by mail-wm1-f68.google.com with SMTP id b12so3151954wmj.3;
        Tue, 24 Mar 2020 06:17:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=MlUVdqvPsd43LNWgtTjRFWpttrWIzyOLgg7iukgREUQ=;
        b=NklST4Adgo11bg9Fd2S89JRNQQgBwVxqRV73h4eqTpp/sEgEUaOzR2Zh4fACLqQXgX
         ZWuSRJ6BBdx77HQFuLxWgYaOvCf1L/XzQlAqJyE3kmWr7OD+FfFMYg6q0NuYaurG7wQA
         8hZ3OJ4Uk5H/NbsiR0IHNfktcboDS5BHMBydt0o9OKcKTBD3MxnEhu1xKUXrB3WwXzBe
         iWzu5wZzyiI7vJuNYmRytilRXnH0kai+SaOlpVC4dvt6ZZC/Pm4Ec+bQ0h/95K79lv62
         oS0TYiWqFTf1cPZF95EoQIWyhqXS6SMQEhosc+xgcKLxzRPQdF+wF6XqpYfyhRruyH6H
         4f2Q==
X-Gm-Message-State: ANhLgQ2cfhJJsQtYFlS37p9sp3ltvqft7ugsecpp+FlxzlpvVIjdsrOt
        w6U9K9eIZdL/YqSDh2B4mlQ=
X-Google-Smtp-Source: ADFU+vtKqW+piCwbRuCwv8vVoYUmBSFEMo/U7U+zkJo89YQxNVypxKzolTOfIZ/OJ/XmbzK62z9VLQ==
X-Received: by 2002:a1c:4e0f:: with SMTP id g15mr5796918wmh.163.1585055858829;
        Tue, 24 Mar 2020 06:17:38 -0700 (PDT)
Received: from localhost (ip-37-188-135-150.eurotel.cz. [37.188.135.150])
        by smtp.gmail.com with ESMTPSA id g3sm11987687wrm.66.2020.03.24.06.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 06:17:37 -0700 (PDT)
Date:   Tue, 24 Mar 2020 14:17:36 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     teawater <teawaterz@linux.alibaba.com>
Cc:     Hui Zhu <teawater@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, hughd@google.com,
        yang.shi@linux.alibaba.com, kirill@shutemov.name,
        dan.j.williams@intel.com, aneesh.kumar@linux.ibm.com,
        sean.j.christopherson@intel.com, thellstrom@vmware.com,
        guro@fb.com, shakeelb@google.com, chris@chrisdown.name,
        tj@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm, memcg: Add memory.transparent_hugepage_disabled
Message-ID: <20200324131736.GN19542@dhcp22.suse.cz>
References: <1585045916-27339-1-git-send-email-teawater@gmail.com>
 <20200324110034.GH19542@dhcp22.suse.cz>
 <816B70EC-20AD-4BB8-AD13-4F5640EBAB35@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <816B70EC-20AD-4BB8-AD13-4F5640EBAB35@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 24-03-20 20:30:32, teawater wrote:
> 
> 
> > 2020年3月24日 19:00，Michal Hocko <mhocko@kernel.org> 写道：
> > 
> > On Tue 24-03-20 18:31:56, Hui Zhu wrote:
> >> /sys/kernel/mm/transparent_hugepage/enabled is the only interface to
> >> control if the application can use THP in system level.
> >> Sometime, we would not want an application use THP even if
> >> transparent_hugepage/enabled is set to "always" or "madvise" because
> >> thp may need more cpu and memory resources in some cases.
> > 
> > Could you specify that sometime by a real usecase in the memcg context
> > please?
> 
> 
> Thanks for your review.
> 
> We use thp+balloon to supply more memory flexibility for vm.
> https://lore.kernel.org/linux-mm/1584893097-12317-1-git-send-email-teawater@gmail.com/
> This is another thread that I am working around thp+balloon.
> 
> Other applications are already deployed on these machines.  The
> transparent_hugepage/enabled is set to never because they used to have
> a lot of THP related performance issues.  And some of them may call
> madvise thp with itself.

If they call madvise then they clearly indicate they prefer THP
regardless the cost. So I really fail to see what memcg specific tuning
brings in.

Could you be more specific about the usecase that cannot work with the
existing THP tuning?
-- 
Michal Hocko
SUSE Labs
