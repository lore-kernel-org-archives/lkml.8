Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADF2C433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 01:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB53F2068F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 01:11:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="lsdFdf2U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgIBBLe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 21:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgIBBLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 21:11:32 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3747EC061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 18:11:31 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id c6so3528929ilo.13
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 18:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yxpVZT82F8Ot3w2K2WW39C+us7JzpqLyVuxt8HNHYho=;
        b=lsdFdf2UszPNhzBz6ZzvssMApwYY4G0y2RwIf7Vq6iomtHHgZnlwObnic3N6vaH9xn
         VXDw1jsjEZth1J7+zoDxdh160PcqDiwjpn4UQHUlk49RO8gsh9aGqDdQOx/Cy0WoHWQt
         DpiL4UVdLQYOC/uaazJ426t8/r+wEeGczCY+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yxpVZT82F8Ot3w2K2WW39C+us7JzpqLyVuxt8HNHYho=;
        b=dcJ+Mx73N+0F9b0AD8IWA9bd3zPXf3C0ga2KxdttF8raaMQDG0e8eYhnELJuEbAS8/
         kGuh5y0W8MtjtMdydnRRIcby1hOGpm2mqaica0P3sFLSRhSAcS3wxrgSoD/+wHlLxNp7
         +mn0YtpNbBc5IE+KNTDTVla39AAiwBbSXbpc3EddsIqGE5iwtlGyHVAwERG0zmMs+KhD
         ZeySvDSWYrZD2pcd9FnBGO7hobeL++Gt8fTz/kiPsoBSOn5/DpM8zEmzVgYaWXMIQXtO
         e7MFmD1vWXnAXllQC00MADFP9Go9Kaq6px0gh9mtfrHW1/DbFcY0z+21QuR3YAKBnx+4
         ekvA==
X-Gm-Message-State: AOAM531onTqch5mxwAtc6xuvlNYuEA5inVuRJzu8u3HIi6wR+etzTDhp
        GvijQn8DBVNck2Bikg6RuSuVQHOYfsS1Pjuo9FOA0w==
X-Google-Smtp-Source: ABdhPJy9Rcb7DLKezJmRLoU7LBwfr6QmS38VFkhD6yKU1qKjiRTdThnPrBjrutj4h8k8jtC/oMa/Q6ZrWpwgeeikQh0=
X-Received: by 2002:a92:48da:: with SMTP id j87mr1747466ilg.78.1599009089523;
 Tue, 01 Sep 2020 18:11:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
 <df3af13cc820a3c2397b85cb7de08cb6a0780e1d.1598643276.git.jdesfossez@digitalocean.com>
 <20200828205154.GB29142@worktop.programming.kicks-ass.net>
 <381e6ea5-a48c-9882-4c0d-49cfa92d21cc@linux.microsoft.com>
 <20200829074719.GJ1362448@hirez.programming.kicks-ass.net>
 <20200901051014.GA3993517@google.com> <a41dac6f-6864-c215-0f7a-90f2126673a6@linux.microsoft.com>
 <20200901173052.GA1703315@google.com> <9e165d5e-1c73-4078-f9fc-5df4f655fc28@linux.microsoft.com>
In-Reply-To: <9e165d5e-1c73-4078-f9fc-5df4f655fc28@linux.microsoft.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 1 Sep 2020 21:11:18 -0400
Message-ID: <CAEXW_YSqbMQQyNwht66ZdoP8PqTv4yVCODZp4WqDq5qimj=YBQ@mail.gmail.com>
Subject: Re: [RFC PATCH v7 08/23] sched: Add core wide task selection and scheduling.
To:     Vineeth Pillai <viremana@linux.microsoft.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Glexiner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com,
        Dario Faggioli <dfaggioli@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Patrick Bellasi <derkling@google.com>,
        =?UTF-8?B?YmVuYmppYW5nKOiSi+W9qik=?= <benbjiang@tencent.com>,
        Aaron Lu <aaron.lu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 1, 2020 at 5:23 PM Vineeth Pillai
<viremana@linux.microsoft.com> wrote:
> > Also, Peter said pick_seq is for core-wide picking. If you want to add
> > another semantic, then maybe add another counter which has a separate
> > meaning and justify why you are adding it.
> I think just one counter is enough. Unless, there is a need to keep the
> counter
> to track core wide pick, I feel it is worth to change the design and
> make the
> counter serve its purpose. Will think through this and send it as a separate
> patch if needed.

Since you agree that it suffices to set core_pick to NULL if you don't
IPI a sibling, I don't see the need for your split pick_seq thing.
But let me know if I missed something.

thanks,

 - Joel
