Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92116C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:33:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71234207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 00:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592872393;
	bh=9x3mi2JLwqzBJ0uwS6uTgCuyS51XcqYzjRYKyMtA5QA=;
	h=Date:From:To:Cc:Subject:Reply-To:List-ID:From;
	b=U/FvOGMaFguR+13rPV4nsPkrata5hgigX64mjDmsa7+JP4+k5rYY3gUtTZwKAo7w3
	 tvyAu9eA/6V80YEr5dF560GWjRsvTYpFi4eTPdTo/5WEvxuwR+2ld2+2RVtUCX0Eqo
	 RATjm4vnoXaiWTggtS6wCqTC/iV/8LID1RM88FTg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731677AbgFWAdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 20:33:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:57892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731433AbgFWAdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 20:33:11 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25C062053B;
        Tue, 23 Jun 2020 00:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592872391;
        bh=9x3mi2JLwqzBJ0uwS6uTgCuyS51XcqYzjRYKyMtA5QA=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=Wj7NHNTwhUySc+CuZ8hrOKs1XSXDF8qj6nyeaEMSujBSOYXHhitU6xRBlU6+0fAbJ
         e4heccWd0xzwfWoHUM133kSYsRffIKaAPIVmUcjQIRWnwW0oRc2xGdMuqnGaJS/eMi
         YDdMpra58rfSDRUVaYGZFnFaCrwh2OVF7k6jtHgk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 051A5352306A; Mon, 22 Jun 2020 17:33:11 -0700 (PDT)
Date:   Mon, 22 Jun 2020 17:33:11 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org
Subject: [PATCH tip/core/rcu 0/3] SRCU updates for v5.9
Message-ID: <20200623003310.GA26539@paulmck-ThinkPad-P72>
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

This series provides SRCU updates.

1.	Fix a typo in comment "amoritized"->"amortized", courtesy of
	Ethon Paul.

2.	Avoid local_irq_save() before acquiring spinlock_t, courtesy
	of Sebastian Andrzej Siewior.

3.	Remove KCSAN stubs.

							Thanx, Paul

------------------------------------------------------------------------

 srcutree.c |   29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)
