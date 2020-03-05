Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A668C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 00:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F86520866
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 00:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583369451;
	bh=vChol9pO7kDygComiayrT41Ba8h4bUJcsrtBd1jCgbk=;
	h=Date:From:To:Cc:Subject:Reply-To:List-ID:From;
	b=ltLeAwMUNB7OPlyglOKYiyfJJBDYDqASwOqx7xgXKkiCfk3Gkm73/7YDuGowLmwDy
	 K79RSUqx6SVENKSUYt1rD6Q6DfD8mnMMArb2S+ika5eVTv6QI2APufibV4bfHJYNMV
	 zTF/yq9806k8+6PZKM+UD1qhAIUW3uFBrNTZcAr0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbgCEAuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 19:50:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:57274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbgCEAut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 19:50:49 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 456FC2084E;
        Thu,  5 Mar 2020 00:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583369449;
        bh=vChol9pO7kDygComiayrT41Ba8h4bUJcsrtBd1jCgbk=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=JnlUnxZEjfbxuBRZyX6b5DSsTDWk/E65DK4GSJvLSgr1DCoONlpQSvJaFSfKT7UVa
         JMon4Qxr/KhMU1OhqKmqznD0tXuDA0ErOchQmvnUZxei9UJBwaGwp7IRK0i8zmNRnP
         Ar5YfzhPx9FuBBpjOu6gBGIu0AdaU3xuSr72wCNE=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 155113522731; Wed,  4 Mar 2020 16:50:49 -0800 (PST)
Date:   Wed, 4 Mar 2020 16:50:49 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de
Cc:     linux-kernel@vger.kernel.org
Subject: Pinning down a blocked task to extract diagnostics
Message-ID: <20200305005049.GA21120@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Suppose that I need to extract diagnostics information from a blocked
task, but that I absolutely cannot tolerate this task awakening in the
midst of this extraction process.  Is the following code the right way
to make this work given a task "t"?

	raw_spin_lock_irq(&t->pi_lock);
	if (t->on_rq) {
		/* Task no longer blocked, so ignore it. */
	} else {
		/* Extract consistent diagnostic information. */
	}
	raw_spin_unlock_irq(&t->pi_lock);

It looks like all the wakeup paths acquire ->pi_lock, but I figured I
should actually ask...

							Thanx, Paul
