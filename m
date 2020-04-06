Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9CCC2BA1B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 16:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7559F2490A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 16:01:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="QmqwCirH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729198AbgDFQBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 12:01:42 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43887 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728976AbgDFQBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 12:01:42 -0400
Received: by mail-qt1-f194.google.com with SMTP id a5so61601qtw.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 09:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5ic27BW1iJdYbTNtKyKXQRX9PLP/1hCKUgIGplcjrCI=;
        b=QmqwCirHzsR+Uyk8WaHKfjq+sq2vfOyKw9KbAE7sieNsEvyGwomVYk++XbfoS8RGm6
         ATqw+gTBF8zJ+3wy7eNcwoTqmls7wHLw7zIOV1Bb5ER0anB2tB3bA0dqVAPMSYP2UWId
         K3+AhBPPKXNqWsi6WLI549jkTq9iDFQ/DZWNw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5ic27BW1iJdYbTNtKyKXQRX9PLP/1hCKUgIGplcjrCI=;
        b=bh/Bj3RqImhzXbe6FQxHn66VA83jDOl0EZO81yl0tLdrVJdVIDgCCbZNBFlTZTLzAy
         dAgXAncnVIdWWLuRcQDxkJK7trOPPR8HfJAzIwL5Zt/EqhvqTq9CQLgAub5saVpwyZmS
         RFpZ5iTc/tdZc0tI50pWcjuFyYDlISHQ2oaAP8lP/18WWggFfMiI9KkOtWI9TJ4GZ+Tr
         Ir+M690NkcXEaN8Wq+nRj7rY5AvEG2q2ikkb21Ck2Imif0v40pJzfljdco44yUgUzASl
         3l9J0BmVFnhPVQ2UmKb+SwmoV9ZflVyc4PMy/6S7FfoX1/A5nEYEOm9Yj6lwtls/A8Fz
         NEgQ==
X-Gm-Message-State: AGi0PuatedQJodbnUqxk1/AGepOZ/PqNbC1k6nGNzmathMQDFvB+8hpQ
        uK+toPDWPEWVBqaf1n77+h4QUA==
X-Google-Smtp-Source: APiQypJgmtrZ1yaRJ/1cOD03beiLocPbNaNQJ5bjoMe8Nmmo1LJvnynZ/CD8Fr7rTsSq/8IZJ7h+KA==
X-Received: by 2002:aed:2b27:: with SMTP id p36mr78735qtd.322.1586188899127;
        Mon, 06 Apr 2020 09:01:39 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id y127sm14938249qkb.76.2020.04.06.09.01.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 09:01:38 -0700 (PDT)
Date:   Mon, 6 Apr 2020 12:01:38 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        Amol Grover <frextrite@gmail.com>,
        linux-kernel@vger.kernel.org, philip.li@intel.com
Subject: Re: db4ead2cd5 ("Default enable RCU list lockdep debugging with
 .."): WARNING: suspicious RCU usage
Message-ID: <20200406160138.GJ83565@google.com>
References: <5e89ae97.XlZ1PbIKMXWOOfLI%lkp@intel.com>
 <20200405145232.GY19865@paulmck-ThinkPad-P72>
 <20200406025056.GA13310@madhuparna-HP-Notebook>
 <20200406152259.GG83565@google.com>
 <20200406153237.GF19865@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406153237.GF19865@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 08:32:37AM -0700, Paul E. McKenney wrote:
> On Mon, Apr 06, 2020 at 11:22:59AM -0400, Joel Fernandes wrote:
> > On Mon, Apr 06, 2020 at 08:20:57AM +0530, Madhuparna Bhowmik wrote:
> > > On Sun, Apr 05, 2020 at 07:52:32AM -0700, Paul E. McKenney wrote:
> > > > On Sun, Apr 05, 2020 at 06:10:31PM +0800, kernel test robot wrote:
> > > > > Greetings,
> > > > > 
> > > > > 0day kernel testing robot got the below dmesg and the first bad commit is
> > > > > 
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2020.03.21a
> > > > 
> > > > Is some of the required conversion still left to be done?  Or on its
> > > > way up some other tree?
> > > > 
> > > > If either of these two, my normal approach would be to hold this commit
> > > > back in order to give the fixes time to hit mainline.
> > > > 
> > > > But either way, please let me know!
> > > >
> > > Yes, some of the patches are not yet reviewed by maintainers and we will
> > > resend them. Also, this report reports a few new ones that we haven't
> > > fixed yet (need some help from maintainers to do so).
> > > We are working on fixing them. May be holding the commit is a
> > > good idea.
> > 
> > I am Ok with holding on to the commit for mainline. But I would like it into
> > linux-next so that we and others can get some more velocity on fixing the
> > remaining issues (and any maintainers who have not yet accepted patches to
> > review those). We fixed most of them but there could be some more lurking.
> > Paul, how does that sound?
> 
> Once v5.7-rc1 comes out, it sounds great!
> 
> (Just got my knuckles rapped (gently) for forgetting to pull this stuff
> out of -next for all of last week.)
> 
> So early next week it returns to -next.

Perfect, thanks!

 - Joel

