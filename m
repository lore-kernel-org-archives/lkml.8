Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506D6C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 08:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28AC92073B
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 08:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOftp8Lu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbgEXILh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 04:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbgEXILe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 04:11:34 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B95C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 01:11:32 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id t8so4974661pju.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 01:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3HmigCjALU51rYyyBGLBKoAkAQrHtdUuG74Co9AoT2k=;
        b=bOftp8LuT45vtlcgLJtjpOry5/pv7Z9eYAW/kDJ4hv9mL1zH6kBeG9rGtJO/SUkxKD
         AhjB9/hQYWO2IvXPAYBQveWvNSMAV7Bi9GyK1m3yDD8ZY11At5npkesASAhZRT5EyiAi
         2ZwJwciZQSZM3eastyOWAcDaCExSo1HNsXVpgDfakIz1I0hnBc3jXebsZnvqj2FINutY
         6un9yGg+cRgpaQOhel7BuhW3f0DmtTJHBaOAca1Rs0jhlVQ1Kkwa65ZozwBS4Y/f8iyb
         nLw11kV+l7FTvOV2lr/HLGPwbUF/HgpexqTQMqFBQbpMFXMaqeZTemVIVg2ks1U1RLrl
         hbLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3HmigCjALU51rYyyBGLBKoAkAQrHtdUuG74Co9AoT2k=;
        b=oybLdZtG72QGdh0B6K0yFkWKDm1abTMuhtVuE3JDo999tiEaDcJ3ZhPPrZeCc7NW41
         kqhiTWI0kpwHyHxROA1gAA6j9kKuvRTO0NJ/OMQ+9jzxnWyOLna57swBrOHXdbb1x+XD
         xWzcx6fX6AN45fk/VBQAWnjSd3GPB0iuISXVQFQXah4mNQCCV6krp1mJmKMsA8EgcJG9
         cPAmvNJocga+fi1zXdO7qL179FyTaIMFf9DuX3hYoT+A094cDqJozwr5iEUw9yoNFZV+
         AkMt/QB1dnxtJirke2q9wObmd79pE+UxmIdBOSSXxRmGk+RM7Vb4/KPf4Bay3IYSmDCR
         HeQA==
X-Gm-Message-State: AOAM5316TwkFP6qxeRkNQACKsYQkzbCtM2rMaqcp/MtJIqsuK5UogV34
        1kHxhNtjmcU9MQQT8dJozjE=
X-Google-Smtp-Source: ABdhPJxZfKElYBNI4glOcgWKrPyJxs5PiTsJpx+QFxqGsjUJty7CXioEENo2hycw40fd49jQga2ajg==
X-Received: by 2002:a17:90a:8989:: with SMTP id v9mr14838930pjn.180.1590307892183;
        Sun, 24 May 2020 01:11:32 -0700 (PDT)
Received: from workstation-LAP.localdomain ([103.87.57.241])
        by smtp.gmail.com with ESMTPSA id p190sm10520227pfp.207.2020.05.24.01.11.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 24 May 2020 01:11:31 -0700 (PDT)
Date:   Sun, 24 May 2020 13:41:17 +0530
From:   Amol Grover <frextrite@gmail.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        James Morris <jamorris@linux.microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jann Horn <jannh@google.com>,
        David Howells <dhowells@redhat.com>,
        Shakeel Butt <shakeelb@google.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@redhat.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-audit@redhat.com,
        Joel Fernandes <joel@joelfernandes.org>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH 1/3 RESEND] sched: Remove __rcu annotation from cred
 pointer
Message-ID: <20200524081117.GA29@workstation-LAP.localdomain>
References: <20200402055640.6677-1-frextrite@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402055640.6677-1-frextrite@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 11:26:38AM +0530, Amol Grover wrote:
> task_struct::cred (subjective credentials) is *always* used
> task-synchronously, hence, does not require RCU semantics.
> 
> task_struct::real_cred (objective credentials) can be used in
> RCU context and its __rcu annotation is retained.
> 
> However, task_struct::cred and task_struct::real_cred *may*
> point to the same object, hence, the object pointed to by
> task_struct::cred *may* have RCU delayed freeing.
> 
> Suggested-by: Jann Horn <jannh@google.com>
> Co-developed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Signed-off-by: Amol Grover <frextrite@gmail.com>

Hello everyone,

Could you please go through patches 1/3 and 2/3 and if deemed OK, give
your acks. I sent the original patch in beginning of February (~4 months
back) and resent the patches again in beginning of April due to lack of
traffic. Paul Moore was kind enough to ack twice - the 3/3 and its
resend patch. However these 2 patches still remain. I'd really
appreciate if someone reviewed them.

Thanks
Amol
