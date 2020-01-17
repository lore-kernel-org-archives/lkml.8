Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4278C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 07:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97FCE2073A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 07:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579247546;
	bh=ctYn8QhjKq55vtw5cfxyEIhxR3c87wUStc7lQp2BrWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=d/WK60DcyNDizsUTYXz6eP0jI/Dy2fFdwvLGB9uPQiOQAHcnKIGXyXQ4Tgsm2mmIp
	 tq77z0d3OdDz+usFKGaIIzk269PQSom1p2gBQypSMyVPnbv03fDTchFcDXe4tmzbek
	 ZnYM2r53ZRCJXFWbwWi17xzAVcsgm5R2BE9ACpvI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729354AbgAQHwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 02:52:25 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40695 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729139AbgAQHwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 02:52:25 -0500
Received: by mail-wr1-f65.google.com with SMTP id c14so21658820wrn.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 23:52:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cjtpHqzNStnWa7plhNueWjJHfnI7mKt9Zs5Ki4MWCwM=;
        b=KwAZr+Fwl9VX9EpLarEEWIaP3C5u2Z6hVprnYLPr2s27mJvMzZgJSFr+gKptLed7O5
         HTN6Z85nme8OuCE7eu+TjZ+BAhVjhpWszIx2NllkipUoLQJW1IadhX067WuQq7ttEzUd
         Bx/mjTD97d6PqrT3qBGkhaqLTpzW6S6sp4cu0z3I50k9nghiSidNRdkM+LHiW0HB8UVy
         FJL6pfJ5pRiJsD7W5A+rlhoSwmN6HYxIv4bX9qeccf7TkRw8UHKe/D7RfzYgB+RZQgwn
         b/7X9hJSxT7/WazzMulMMpBoEeLLXjDVDoeMqxUY1s5hBE5I14Y1UhzJfS6IMPxUSVEk
         Dmxw==
X-Gm-Message-State: APjAAAVkdQBZMBuJvaWJpYEVWr4G3p2CifFCXAtBt5I2wYDY6nvVC/iT
        R4PUwqJEaXmvzbez/+Y1Jt8=
X-Google-Smtp-Source: APXvYqyXxBJM1gLfxCZjbdkfkQw+EJAuReUQSwFLooP22oH65SxWdjA8/a3qB7XJwe9Bj8wCBAP28Q==
X-Received: by 2002:a5d:4b4e:: with SMTP id w14mr1644672wrs.187.1579247543480;
        Thu, 16 Jan 2020 23:52:23 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id n10sm32367435wrt.14.2020.01.16.23.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 23:52:22 -0800 (PST)
Date:   Fri, 17 Jan 2020 08:52:21 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Waiman Long <longman@redhat.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [LKP] Re: [mm/hugetlb] c77c0a8ac4: will-it-scale.per_process_ops
 15.9% improvement
Message-ID: <20200117075221.GG19428@dhcp22.suse.cz>
References: <20200114085637.GA29297@shao2-debian>
 <20200114091251.GE19428@dhcp22.suse.cz>
 <bd474ca4-9f47-0ab1-f461-513789fc074d@redhat.com>
 <20200117065628.GC86012@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117065628.GC86012@shbuild999.sh.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 17-01-20 14:56:28, Feng Tang wrote:
> Hi Waiman and Michal,
> 
> On Tue, Jan 14, 2020 at 09:57:14AM -0500, Waiman Long wrote:
> > On 1/14/20 4:12 AM, Michal Hocko wrote:
> > > On Tue 14-01-20 16:56:37, kernel test robot wrote:
> > >> Greeting,
> > >>
> > >> FYI, we noticed a 15.9% improvement of will-it-scale.per_process_ops due to commit:
> > >>
> > >>
> > >> commit: c77c0a8ac4c522638a8242fcb9de9496e3cdbb2d ("mm/hugetlb: defer freeing of huge pages if in non-task context")
> > >> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> > > This is more than surprising because the patch has only changed the
> > > behavior for hugetlb pages freed from the (soft)interrupt context and
> > > that should be a very rare event. Does the test really generate a lot of
> > > those?
> > >
> > Yes, I have the same question. I was not expecting to see any
> > performance impact.
> 
> We have the same question and did some further check.
> 
> This is the "pagefault3" test case of will-it-scale, and is  
> mmap/get_page/munmap test. The source code is: 
> https://github.com/antonblanchard/will-it-scale/blob/master/tests/page_fault3.c 
> 
> And its running on LKP does NOT involve any hugetlb actions, as
> could be checking HugePages_* in /proc/meminfo.
> 
> We also did another check, reverted c77c0a8ac4c5 and simply added
> some printk inside free_huge_page(), which can also bring 15%
> improvement.
> 
> So one possible reason could be the commit changes the cache
> alignment of other kernel codes in final bzImage, which happens
> to hugely affect this test case.

This sounds like the most logical explanation. The question is whether
we can somehow achieve the same without adding random printks or code
that doesn't matter ;)
-- 
Michal Hocko
SUSE Labs
