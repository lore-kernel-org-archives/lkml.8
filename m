Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC71C2BA17
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 15:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A39924899
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 15:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="wlnXqyfr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbgDFPXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 11:23:04 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:42792 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728752AbgDFPXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 11:23:03 -0400
Received: by mail-qv1-f68.google.com with SMTP id ca9so87960qvb.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 08:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1ltdQGxIoOZcKaQ0m8jS41CHPguU2YIL9QMJC5K/Po4=;
        b=wlnXqyfrVq1ReVcpwl70ZojA9N8c9EU3/p/b7zdhMXgs0clWppCvS80b0B01nKBj5i
         o3z6MVRPYp9f3+UANbj6GQHbghgdxLYNxO7U6aic8TLJXfX+M8tKbsjMgllnGG8O3yQq
         XMCUzrlZc9QxwykX4uywbMjgxhH7l3a+2MKdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1ltdQGxIoOZcKaQ0m8jS41CHPguU2YIL9QMJC5K/Po4=;
        b=Ak2bTaEwDZnmD8/3Si1kWv9e8Su7Jn2WvsasB7QU0IjrhWTxjrYJW91FFe42E5la7J
         nu9Es8YBhgBTnV7HYhkYbUjsDKFrcYB7DCwePzDNOKPD1YmOIDTILy+y3AaHUbszaXfg
         7JWEmAHJXEQ1mrdZlbCOnluscxDK1T4yy1u2+FQezFZnbIRGk6NI5bzYzj3qX5N9v9Y6
         RAAOmx2wo1QAPmAkNUuu011FTD2zzLgZFk0NTZemtMJ0kpfpzzx9w+KaMXTogZMjiuDe
         Pm7ML2EXQO7VTbyJNAvZv6r/UkVAnc91Lo8RKcy07dYrHq145yiJCt4qeq3S6mLeMOFq
         GDmw==
X-Gm-Message-State: AGi0Pubp8AdkpBut6Qf9hcsRbGttFSDwnjamyDrnORvpCD23SfkqYffv
        /hmVPcWXg6mLdynKUCNBvXGGoA==
X-Google-Smtp-Source: APiQypK0Ff14E4uKfI0Ev5WKaRV7O+7xKRt9Ww91JMJswf9nQ3N8Yf26tWBqOci6hjgTYs31kI+SRQ==
X-Received: by 2002:a0c:ba9b:: with SMTP id x27mr148193qvf.194.1586186580941;
        Mon, 06 Apr 2020 08:23:00 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id a68sm8491498qkd.10.2020.04.06.08.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 08:23:00 -0700 (PDT)
Date:   Mon, 6 Apr 2020 11:22:59 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Amol Grover <frextrite@gmail.com>,
        linux-kernel@vger.kernel.org, philip.li@intel.com
Subject: Re: db4ead2cd5 ("Default enable RCU list lockdep debugging with
 .."): WARNING: suspicious RCU usage
Message-ID: <20200406152259.GG83565@google.com>
References: <5e89ae97.XlZ1PbIKMXWOOfLI%lkp@intel.com>
 <20200405145232.GY19865@paulmck-ThinkPad-P72>
 <20200406025056.GA13310@madhuparna-HP-Notebook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200406025056.GA13310@madhuparna-HP-Notebook>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 08:20:57AM +0530, Madhuparna Bhowmik wrote:
> On Sun, Apr 05, 2020 at 07:52:32AM -0700, Paul E. McKenney wrote:
> > On Sun, Apr 05, 2020 at 06:10:31PM +0800, kernel test robot wrote:
> > > Greetings,
> > > 
> > > 0day kernel testing robot got the below dmesg and the first bad commit is
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2020.03.21a
> > 
> > Is some of the required conversion still left to be done?  Or on its
> > way up some other tree?
> > 
> > If either of these two, my normal approach would be to hold this commit
> > back in order to give the fixes time to hit mainline.
> > 
> > But either way, please let me know!
> >
> Yes, some of the patches are not yet reviewed by maintainers and we will
> resend them. Also, this report reports a few new ones that we haven't
> fixed yet (need some help from maintainers to do so).
> We are working on fixing them. May be holding the commit is a
> good idea.

I am Ok with holding on to the commit for mainline. But I would like it into
linux-next so that we and others can get some more velocity on fixing the
remaining issues (and any maintainers who have not yet accepted patches to
review those). We fixed most of them but there could be some more lurking.
Paul, how does that sound?

Either way, we should consider that this feature is turned on only for
lockdep-enabled kernels so it is only used for debugging.

thanks,

 - Joel

