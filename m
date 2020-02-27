Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFACC4BA06
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 09:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 320632467F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 09:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582794575;
	bh=ameTfSpd2/vi0KpT5v31U2fJJecfkJZj9Fk9cp8Z354=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=D17NcVzeshLZg7HNjhmiXy9TuSgsdwCPYrgxQ9LCwPfvIFDgr7iUwFw+5hPGjrgez
	 MgtHrQqU828XqCMjEyE6qigpDAnv019tRteH/ymwOCJS2w5ndxTwbhpCpLirybPOtX
	 pfV+ieAa2DudMJ6JJCL8g4eQiCCeiPk6yrzintf8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbgB0JJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 04:09:34 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54914 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728693AbgB0JJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 04:09:33 -0500
Received: by mail-wm1-f68.google.com with SMTP id z12so2570958wmi.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 01:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EQQnvINcM1rixtSK0n5nMnVE2atRMKEwNu+vLaqHiK8=;
        b=o7+HqYSwgM7WAjfV85IkFNtfIy9fR8D0iGhC9tRHvEkFmCq6z4NbuCMHTfp7mWLVJq
         a3XNWapZW6+U/jgzJVSAnGasEbhjxqSQsAWqMKxB0MhL8UyyzGQlmj9TklHwqx/Jlrvd
         kJlXw/Xnokb6zyFWFNZbo84PA8I0HFPm2IQYXBv5mPEZGk1q88DoSOiGHOKB7Wb3LJA/
         yAUh7x8ifRyffjzyJRthKxvBijR+1akOHEB5bj4swUlZX/0RRJUv45hIF2FxHVKdtkyZ
         khM7PLHS4NsGTk1U+BReJ0BrZw9CS/MxC3ixaNzCXVgrrgxehp2b2/RUy9oPbb7QDjh1
         jkNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=EQQnvINcM1rixtSK0n5nMnVE2atRMKEwNu+vLaqHiK8=;
        b=GGjHseS3ZI5V7Qa/c2tk60kkarT+7ULMYk8tDFOHClWgUMgB6Rddov6pJOpn05AQCI
         ljR6Uq7VxwtuU8A8Axs4rCb7a+W9UPQWE59iwAlByGBZWJ98r0WFwtmbe1fRR6FgTeI/
         LBxJlfwZKKIUx8AkwcrZjCttkjUyXfOGeL8Rq87tgDXv4yLV/ZXHdGfp1LIW28TxJkxE
         4qJnHxSdqIbb4HELNIJn5sG/xMjq60b6VclL/UeZ2aLZ+BycVqGwZLBlgpnD8O0+xqYa
         Zb7tc49VmD6CHaIdsk5pCI+znQRnymug0f8lBuyBNjqxpB9wLVX/oSBN02c7Bdh6wSh1
         LAXA==
X-Gm-Message-State: APjAAAWChGWH6XhqvghoGvbkAPU5IWftlkW4eoNyYxiIK5Eh4Sc9QsUA
        tl1ak5rx5iT4WAZr/NS+I78=
X-Google-Smtp-Source: APXvYqzwjzEwDpAwKLGNPAgRYjbuCZtcyo2XzDgdmMq/aDIzoqhOnvXP5fdeNotV7sf3rWp9pHhBxw==
X-Received: by 2002:a1c:99c5:: with SMTP id b188mr3941990wme.176.1582794571799;
        Thu, 27 Feb 2020 01:09:31 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id z6sm7011534wrw.36.2020.02.27.01.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 01:09:31 -0800 (PST)
Date:   Thu, 27 Feb 2020 10:09:29 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Phil Auld <pauld@redhat.com>, Hillf Danton <hdanton@sina.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/13] Reconcile NUMA balancing decisions with the load
 balancer v6
Message-ID: <20200227090929.GA57547@gmail.com>
References: <20200224095223.13361-1-mgorman@techsingularity.net>
 <20200224151641.GA24316@gmail.com>
 <20200225115901.GB3466@techsingularity.net>
 <CAKfTPtDN-XP7LAyy-zQ-J=nxv5M1x_f2AZ2qJ8CK6B82f5WwYg@mail.gmail.com>
 <20200225142430.GC3466@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200225142430.GC3466@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Mel Gorman <mgorman@techsingularity.net> wrote:

> On Tue, Feb 25, 2020 at 02:28:16PM +0100, Vincent Guittot wrote:
> > >
> > > Will do.
> > >
> > > However I noticed that "sched/fair: Fix find_idlest_group() to handle
> > > CPU affinity" did not make it to tip/sched/core. Peter seemed to think it
> > > was fine. Was it rejected or is it just sitting in Peter's queue somewhere?
> > 
> > The patch has already reached mainline through tip/sched-urgent-for-linus
> > 
> 
> Bah, I pasted the wrong subject. I am thinking of your
> patch "sched/fair: fix statistics for find_idlest_group" --
> https://lore.kernel.org/lkml/20200218144534.4564-1-vincent.guittot@linaro.org/
> It still appears to be relevant or did I miss something else?

Applied to tip:sched/urgent now, thanks guys!

	Ingo
