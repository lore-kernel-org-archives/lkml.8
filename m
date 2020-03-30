Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C15C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 17:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D9820578
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 17:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="w6604BaQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729546AbgC3RQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 13:16:10 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39881 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728458AbgC3RQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 13:16:09 -0400
Received: by mail-qk1-f194.google.com with SMTP id b62so19872059qkf.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 10:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5Hb3YICc0dQAEVyoNlG3L1tHHULy434n9VObNuEbA9A=;
        b=w6604BaQDAbvTJytjaHbPOoDmh31vmbcqImc4hMQd+IoU0bCTuMH80o1nKxT3IWrx7
         rPUyst3YhScpH5wI0rC5lcwIHHkBmPIQ9aZNphU3u23uM4NBvwIim/5WqHpetYpJgA8p
         KfBAIZuJ5lHUUNUlWxAsqEQwradx3/ntsRTWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5Hb3YICc0dQAEVyoNlG3L1tHHULy434n9VObNuEbA9A=;
        b=ItjBdvwR0NHyDWkrgp3eTnl1PtqCJ1JMGu9bf0BwH7rO9bNvc0hCD8BFAGoe8Op1XY
         Mq7WpVSHczhiDHk2ulvxRAiShjPVaNhLKieMW3htK5yZ8AZnwgfcBP8/aW1I18F20GXT
         MJUhUVquMRNTFA33ZGv2oVlX5IeTv9/ze034rC6UDvJE+i27vsFaMC/3vyoVCBoQTnap
         huXZwabRIs3VtNmDfHt0lm5Ijs538d2ACxZFPtR861PfCTAzXaXYi6WM5aNgwUPcJZS4
         Q8C2JL/AcHA4z3/588blWUdn8n7C6Jhq1WYQobYpuEHhctPwAK7umVjwxn19ME0xQ0ss
         TWUw==
X-Gm-Message-State: ANhLgQ0GO+ep9H6RX/fqbGoixNXrIZeSWtQJ5a6KwHqlU4syBbGVd9DC
        Xp1KXq1H62tOqF9RXya3v2Wv1A==
X-Google-Smtp-Source: ADFU+vttYGHHbC6ci+pq2vQNiQFIOoWoawrD1WjECr66+PSOPjeIUMfw78suCshCVnbcks4qmXok6A==
X-Received: by 2002:a37:a208:: with SMTP id l8mr1013210qke.302.1585588567704;
        Mon, 30 Mar 2020 10:16:07 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id z11sm11357255qti.23.2020.03.30.10.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 10:16:07 -0700 (PDT)
Date:   Mon, 30 Mar 2020 13:16:06 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Uladzislau Rezki <urezki@gmail.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>, linux-mm@kvack.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        rcu@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 10/18] rcu/tree: Maintain separate array for vmalloc ptrs
Message-ID: <20200330171606.GA166021@google.com>
References: <20200330023248.164994-11-joel@joelfernandes.org>
 <202003301715.9gMSa9Ca%lkp@intel.com>
 <20200330152951.GA2553@pc636>
 <20200330153149.GE22483@bombadil.infradead.org>
 <20200330153702.GK19865@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330153702.GK19865@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 08:37:02AM -0700, Paul E. McKenney wrote:
> On Mon, Mar 30, 2020 at 08:31:49AM -0700, Matthew Wilcox wrote:
> > On Mon, Mar 30, 2020 at 05:29:51PM +0200, Uladzislau Rezki wrote:
> > > Hello, Joel.
> > > 
> > > Sent out the patch fixing build error.
> > 
> > ... where?  It didn't get cc'd to linux-mm?
> 
> The kbuild test robot complained.  Prior than the build error, the
> patch didn't seem all that relevant to linux-mm.  ;-)

I asked the preprocessor to tell me why I didn't hit this in my tree. Seems
it because vmalloc.h is included in my tree through the following includes. 

./include/linux/nmi.h
./arch/x86/include/asm/nmi.h
./arch/x86/include/asm/io.h
./include/asm-generic/io.h
./include/linux/vmalloc.h

Such paths may not exist in kbuild robot's tree, so I will apply Vlad's patch to
fix this and push it to my rcu/kfree branch.

thanks,

 - Joel

