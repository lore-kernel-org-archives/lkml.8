Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91EA7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 16:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 667972073B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 16:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="R0N/0iO4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729496AbgEZQ3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 12:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728361AbgEZQ3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 12:29:08 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3294FC03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 09:29:08 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id c12so6729487qtq.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 09:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=USfFzBEHek85lFYev0KT3pxdBQkXOQ5hnkErtExpajU=;
        b=R0N/0iO4oT4/wpOoD3fmmj1mwWYmlrrZtZ+rZyL9+xNbGs3WKUS8Azc33DJAz866hh
         7uvZfmtaT+/fCG9UxDIg2tqFi8ARX4ICE7RJwxYI/4rEoJ0siS6YhmNMX0SqNvuNYVzb
         1UXfJjreEjgKGdpNXa6T5/OsbcN5t6PsvUryk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=USfFzBEHek85lFYev0KT3pxdBQkXOQ5hnkErtExpajU=;
        b=kVelXWDLiBLei5WJjnfPdDmKPpzDAwdhi7uzUGkImnSWDLBOZU3OAqqzOwQd/naBxA
         e8mhgnrLdVqafEbb09Nps4JYRIYJaq3XKMzQx3zmzhyIfRR+sHknoOu1H63X5XETnG2F
         E5UV4aMHP21eVurer2xIRHK4T0mcVJKxRrwtc+EgqH4haSDAEdI4NLDl17DzUmc+tOrE
         h0RyUD2KO48hWVrIhMkgEQpZqyJPIYAymYtHHVH6wlzMKXji458ojcVtNN40sf20pO8D
         1F6KhA3pTi+q9jeNcJGDFfq1evJrWQv3RN4fL6Ad0isSBnQmR6nJ60r+NcufQg7mlCzi
         XTQg==
X-Gm-Message-State: AOAM531XEV6kBWRExFGb1wSlyaYyxny7Kh+Js74pTieyD/dCympnY2j/
        xqce7cVAnCNrJg0nEAwnIHg6zg==
X-Google-Smtp-Source: ABdhPJxkETOT1u7GqrA0vnJmqzQTHUACll2qq9TlhoN0XyF8oJQoUzBAQjwlDlYZgSLDJSTIIRd5lw==
X-Received: by 2002:ac8:34d0:: with SMTP id x16mr2187142qtb.300.1590510547246;
        Tue, 26 May 2020 09:29:07 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id l22sm86050qki.45.2020.05.26.09.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 09:29:06 -0700 (PDT)
Date:   Tue, 26 May 2020 12:29:06 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [rcu:dev.2020.05.25a 51/63] kernel/rcu/refperf.c:298:6: warning:
 no previous prototype for function 'reset_readers'
Message-ID: <20200526162906.GA112595@google.com>
References: <202005262032.uaSJI5NU%lkp@intel.com>
 <20200526161117.GH2869@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526161117.GH2869@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 09:11:17AM -0700, Paul E. McKenney wrote:
> On Tue, May 26, 2020 at 08:07:35PM +0800, kbuild test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2020.05.25a
> > head:   1e9451642683146552713c5ce6d269ae378eacd5
> > commit: 786a25497743696d79592b864cafbfe48787e6e1 [51/63] refperf: Add a test to measure performance of read-side synchronization
> > config: x86_64-allyesconfig (attached as .config)
> > compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project 3393cc4cebf9969db94dc424b7a2b6195589c33b)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install x86_64 cross compiling tool for clang build
> >         # apt-get install binutils-x86-64-linux-gnu
> >         git checkout 786a25497743696d79592b864cafbfe48787e6e1
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kbuild test robot <lkp@intel.com>
> > 
> > All warnings (new ones prefixed by >>, old ones prefixed by <<):
> > 
> > >> kernel/rcu/refperf.c:298:6: warning: no previous prototype for function 'reset_readers' [-Wmissing-prototypes]
> > void reset_readers(int n)
> > ^
> > kernel/rcu/refperf.c:298:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
> > void reset_readers(int n)
> > ^
> > static
> > >> kernel/rcu/refperf.c:311:5: warning: no previous prototype for function 'process_durations' [-Wmissing-prototypes]
> > u64 process_durations(int n)
> > ^
> > kernel/rcu/refperf.c:311:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
> > u64 process_durations(int n)
> > ^
> > static
> > 2 warnings generated.
> 
> Good catches, fixing!
> 
> 							Thanx, Paul

Thanks in advance, Paul, for the fix!

 - Joel

> > vim +/reset_readers +298 kernel/rcu/refperf.c
> > 
> >    297	
> >  > 298	void reset_readers(int n)
> >    299	{
> >    300		int i;
> >    301		struct reader_task *rt;
> >    302	
> >    303		for (i = 0; i < n; i++) {
> >    304			rt = &(reader_tasks[i]);
> >    305	
> >    306			rt->last_duration_ns = 0;
> >    307		}
> >    308	}
> >    309	
> >    310	// Print the results of each reader and return the sum of all their durations.
> >  > 311	u64 process_durations(int n)
> >    312	{
> >    313		int i;
> >    314		struct reader_task *rt;
> >    315		char buf1[64];
> >    316		char buf[512];
> >    317		u64 sum = 0;
> >    318	
> >    319		buf[0] = 0;
> >    320		sprintf(buf, "Experiment #%d (Format: <THREAD-NUM>:<Total loop time in ns>)",
> >    321			exp_idx);
> >    322	
> >    323		for (i = 0; i <= n && !torture_must_stop(); i++) {
> >    324			rt = &(reader_tasks[i]);
> >    325			sprintf(buf1, "%d: %llu\t", i, rt->last_duration_ns);
> >    326	
> >    327			if (i % 5 == 0)
> >    328				strcat(buf, "\n");
> >    329			strcat(buf, buf1);
> >    330	
> >    331			sum += rt->last_duration_ns;
> >    332		}
> >    333		strcat(buf, "\n");
> >    334	
> >    335		PERFOUT("%s\n", buf);
> >    336	
> >    337		return sum;
> >    338	}
> >    339	
> > 
> > ---
> > 0-DAY CI Kernel Test Service, Intel Corporation
> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
> 
