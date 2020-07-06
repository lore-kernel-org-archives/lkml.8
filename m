Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A41C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 02:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 521DB20747
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 02:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="IQCrUIbW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728662AbgGFCgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 22:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728621AbgGFCgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 22:36:25 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D704C061794
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 19:36:24 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b4so33525121qkn.11
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jul 2020 19:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sP8AeaVoozfO9npWWBtIIZljVBmSXvMUO9iliaOoAg4=;
        b=IQCrUIbW25djPzc7S+MU49TH4vVH1Vd+pGBli6+6MKgvtNoKYWzRXgRI1G3Gjcrwao
         EWF5fKDfubLC4QrN/oQF3XEtAB73ewZ7F4L89Lmb4tOgrb/qNTG0sqcNWnieU/d2w8pU
         wJPv9GtU6aC5RkDLlGleuKdBAd8UH1qgd51F4dQh331buZ2Tae6vFjJB0zVQKBb/AUeR
         YAdn/3WsrwIDWoI13yr6c38X4KPPzlTS/xCVPlr/xnKlmGZTiMmskjrq92YpsmV0axFF
         I+lHefcB21xIzAMKIgrUuIuA7w4siFSmOyYi8NzeXBLUK7LU7dnV2ZkPdcrstZ1Dp470
         qViw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sP8AeaVoozfO9npWWBtIIZljVBmSXvMUO9iliaOoAg4=;
        b=F6Amsg7WMkWEr4IeKVLXVXlu97a28sKx3gFLVu0jtzR/MWMPL6TomwCf2A1RNoRV83
         v7vp1fQlpI5ZANHp66BD1fg+BjGYiexrK5oFyTIQ21U5zxZLWQW9HohRgZd2ntMww7Ud
         DkslGqDOM7IR+DMefVz47D7herOfJm8yFjjSu8zQ91/fRrj7ANQFBTpeMyOAtC2ZE/fO
         Oalakx/DqnIBAdNjuRmM7FPcQoGUutSWzeoCOIw5NZkPjjkYsww0E/EVDLN6GLdAXAWQ
         OeLbARwG/jcixbIJwT71dDzKL5Pzrz4yEfcY4rojQm3pUHGGwIlvE8EKVnC+ZxWZbMxP
         i2aQ==
X-Gm-Message-State: AOAM532QVbmEMdJ4iz2O0X8QU7tQD7s5Msep6KnKHmp+bBfCVx6oA3Zs
        x+3vxx/WmkR9RtnOVX/a+5+c8A==
X-Google-Smtp-Source: ABdhPJwOxYQmUuL7A1CF/7JW/bxVMJULU8q19x6HmjPK1f5a/QoiaK7T4AQo82o4vbVkuplVxQW5pw==
X-Received: by 2002:a37:9c51:: with SMTP id f78mr8648119qke.60.1594002983385;
        Sun, 05 Jul 2020 19:36:23 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 16sm18216530qkv.48.2020.07.05.19.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2020 19:36:22 -0700 (PDT)
Date:   Sun, 5 Jul 2020 22:36:14 -0400
From:   Qian Cai <cai@lca.pw>
To:     Feng Tang <feng.tang@intel.com>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>, andi.kleen@intel.com,
        tim.c.chen@intel.com, dave.hansen@intel.com, ying.huang@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, lkp@lists.01.org
Subject: Re: [mm] 4e2c82a409: ltp.overcommit_memory01.fail
Message-ID: <20200706023614.GA1231@lca.pw>
References: <20200705044454.GA90533@shbuild999.sh.intel.com>
 <FAAE2B23-2565-4F36-B278-018A5AD219EE@lca.pw>
 <20200705125854.GA66252@shbuild999.sh.intel.com>
 <20200705155232.GA608@lca.pw>
 <20200706014313.GB66252@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706014313.GB66252@shbuild999.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 06, 2020 at 09:43:13AM +0800, Feng Tang wrote:
> On Sun, Jul 05, 2020 at 11:52:32AM -0400, Qian Cai wrote:
> > On Sun, Jul 05, 2020 at 08:58:54PM +0800, Feng Tang wrote:
> > > On Sun, Jul 05, 2020 at 08:15:03AM -0400, Qian Cai wrote:
> > > > 
> > > > 
> > > > > On Jul 5, 2020, at 12:45 AM, Feng Tang <feng.tang@intel.com> wrote:
> > > > > 
> > > > > I did reproduce the problem, and from the debugging, this should
> > > > > be the same root cause as lore.kernel.org/lkml/20200526181459.GD991@lca.pw/
> > > > > that loosing the batch cause some accuracy problem, and the solution of
> > > > > adding some sync is still needed, which is dicussed in
> > > > 
> > > > Well, before taking any of those patches now to fix the regression,
> > > > we will need some performance data first. If it turned out the
> > > > original performance gain is no longer relevant anymore due to this
> > > > regression fix on top, it is best to drop this patchset and restore
> > > > that VM_WARN_ONCE, so you can retry later once you found a better
> > > > way to optimize.
> > > 
> > > The fix of adding sync only happens when the memory policy is being
> > > changed to OVERCOMMIT_NEVER, which is not a frequent operation in
> > > normal cases.
> > > 
> > > For the performance improvment data both in commit log and 0day report
> > > https://lore.kernel.org/lkml/20200622132548.GS5535@shao2-debian/
> > > it is for the will-it-scale's mmap testcase, which will not runtime
> > > change memory overcommit policy, so the data should be still valid
> > > with this fix.
> > 
> > Well, I would expect people are perfectly reasonable to use
> > OVERCOMMIT_NEVER for some workloads making it more frequent operations.
> 
> In my last email, I was not saying OVERCOMMIT_NEVER is not a normal case,
> but I don't think user will too frequently runtime change the overcommit
> policy. And the fix patch of syncing 'vm_committed_as' is only called when
> user calls 'sysctl -w vm.overcommit_memory=2'.
> 
> > The question is now if any of those regression fixes would now regress
> > performance of OVERCOMMIT_NEVER workloads or just in-par with the data
> > before the patchset?
> 
> For the original patchset, it keeps vm_committed_as unchanged for
> OVERCOMMIT_NEVER policy and enlarge it for the other 2 loose policies
> OVERCOMMIT_ALWAYS and OVERCOMMIT_GUESS, and I don't expect the "OVERCOMMIT_NEVER
> workloads" performance  will be impacted. If you have suggetions for this
> kind of benchmarks, I can test them to better verify the patchset, thanks!

Then, please capture those information into a proper commit log when you
submit the regression fix on top of the patchset, and CC PER-CPU MEMORY
ALLOCATOR maintainers, so they might be able to review it properly.

> 
> - Feng
> 
> > 
> > Given now this patchset has had so much churn recently, I would think
> > "should be still valid" is not really the answer we are looking for.
> > 
> > > 
> > > Thanks,
> > > Feng
> > > 
> > > 
