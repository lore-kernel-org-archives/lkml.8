Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E276CC3F2CE
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 03:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEBF8246B4
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 03:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="csg7gxtK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgB2DdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 22:33:00 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44846 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbgB2Dc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 22:32:59 -0500
Received: by mail-pl1-f195.google.com with SMTP id d9so1978687plo.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 19:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WWlc7PySHsdvwwIYJR3k0LGstQ/VQF9XESI8/nbyPDg=;
        b=csg7gxtKkqhVqKb8DlMR0ncRzgv5p7AA1oIATkymki1e+cq/FMCCQC/WaWChUx/TvQ
         kcOUBUiZUfMVUNtOAdCXFHv6KcUPmS6MvRJ5JMH6Ncv7NbFmPK8XhDV9GCB5tAeMNd7h
         Cp4ELClEzN1Xf6U10pGs9pnlWCK8TesOFZVL3VtxGQKm2vg0GBehsf7704sNmSa2SDsL
         bxzx+PIr17g23xdFHAciunDiNLg9p5sBAFkyoqE+rlT8EThZNShZ6quSusngWpKETcU5
         pbaUYs0v/TIdje5mh4aBK0veeAyqHoQ3BHp72dAF0vGH8lq/KfT6/HcyZyWeTOmc4+eE
         yX/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WWlc7PySHsdvwwIYJR3k0LGstQ/VQF9XESI8/nbyPDg=;
        b=Ia795x8EbiZB8f/RLVokuuev7A2FL/bx4+ScI+qh6/ew4F9PGPYrYB1BLpW3uy/EnO
         OsLipaxU+NOP/WB5QqWRVl8SZPfr/0hi5sxD+JbcD28lkCoNJel4hmKk/7mXxDZE/K/f
         oa8bJY3qsOpi1RdJRVAA+n19QxvPBf8sjvMRLCftdn+Jhy4KrOAK+KNmHNlNtGJAR8Sj
         OrkWcHuYSn/ls/bVrt5a0dwwftfNxEp+RWa7YQhD0bCDEHhwn6E+yuzVj8RA/IMej6Wo
         fZodcCCpNVfhMoujbqwQfghICB+iVDkX4ttm3xh9NDU7doOygZxl2X1bb3246ZTe9q6v
         L9QQ==
X-Gm-Message-State: APjAAAXYSIszIgh1omMGC4weW0IvcJNn+P5oSLjiFwyUNPoqFxmAEKuK
        wlefmFT+d7f0krn+PjY/v8o=
X-Google-Smtp-Source: APXvYqxbEKVGTDVu4gesY42kCC0StwycrEMxDzkBFbAM++iBEiZrBE64A3hMch8AkeWudI3kvs+PDw==
X-Received: by 2002:a17:90a:191a:: with SMTP id 26mr7863628pjg.111.1582947177174;
        Fri, 28 Feb 2020 19:32:57 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id m12sm3781362pjf.25.2020.02.28.19.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 19:32:56 -0800 (PST)
Date:   Sat, 29 Feb 2020 12:32:53 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Petr Mladek <pmladek@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Lech Perczak <l.perczak@camlintechnologies.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof =?utf-8?Q?Drobi=C5=84ski?= 
        <k.drobinski@camlintechnologies.com>,
        Pawel Lenkow <p.lenkow@camlintechnologies.com>,
        John Ogness <john.ogness@linutronix.de>,
        Tejun Heo <tj@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: Regression in v4.19.106 breaking waking up of readers of
 /proc/kmsg and /dev/kmsg
Message-ID: <20200229033253.GA212847@google.com>
References: <aa0732c6-5c4e-8a8b-a1c1-75ebe3dca05b@camlintechnologies.com>
 <20200227123633.GB962932@kroah.com>
 <42d3ce5c-5ffe-8e17-32a3-5127a6c7c7d8@camlintechnologies.com>
 <e9358218-98c9-2866-8f40-5955d093dc1b@camlintechnologies.com>
 <20200228031306.GO122464@google.com>
 <20200228100416.6bwathdtopwat5wy@pathway.suse.cz>
 <20200228105836.GA2913504@kroah.com>
 <20200228113214.kew4xi5tkbo7bpou@pathway.suse.cz>
 <20200228130217.rj6qge2en26bdp7b@pathway.suse.cz>
 <20200228205334.GF101220@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228205334.GF101220@mit.edu>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/02/28 15:53), Theodore Y. Ts'o wrote:
> > So, I would still prefer to _revert_ the commit 15341b1dd409749f
> > ("char/random: silence a lockdep splat with printk()"). It calmed
> > down lockdep report. The real life danger is dubious. The warning
> > is printed early when the system is running on single CPU where
> > it could not race.
> 
> I'm wondering now if we should revert this commit before 5.6 comes out
> (it landed in 5.6-rc1).  "Is much less likely to happen given the
> other random initialization patches" is not the same as "guaranteed
> not to happen".
> 
> What do folks think?

Well, my 5 cents, there is nothing that prevents "too-early"
printk_deferred() calls in the future. From that POV I'd probably
prefer to "forbid" printk_deffered() to touch per-CPU deferred
machinery until it's not "too early" anymore. Similar to what we
do in printk_safe::queue_flush_work().

	-ss
