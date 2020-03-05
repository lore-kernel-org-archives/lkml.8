Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155B9C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 00:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB50620842
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 00:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583367051;
	bh=iRqeuR4zqIe44/ohDAsoST7Lv50uMJs4rL4YHPuU0AE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=BQ9WMWZG2P5L3giOCOu4qbUTDpxeXQcvSZYsZrDm/MXWD+JjTlC2dA25+uUx0o5ck
	 UWUTfD4RpVQgY3VohrbovBTjOdpv85u5ixL3BQa0BjBfMzE5zTFfab3c6wqmbDsUXK
	 Q+ulkRaFPGLWJ3BI3yxpag0ws5z6h/ojsrEjcpfA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388542AbgCEAKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 19:10:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:45454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388389AbgCEAKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 19:10:47 -0500
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2211020842;
        Thu,  5 Mar 2020 00:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583367046;
        bh=iRqeuR4zqIe44/ohDAsoST7Lv50uMJs4rL4YHPuU0AE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=GK/YKQHZXYef51SPBiZpY5AHhRzUhyE6DpUGpmjOZPiTa4gFtV253qBENyjex4FG8
         fYVr9TNCAyF55cJwGbi07Kam1hscWZbL32pSouG8pT2HqWeaPKao8lcTowOFTi8Et7
         EWWOfUwk8ADb+sZles3s15N5+SVcTKY7wpfSRSsg=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id E8ACA3522731; Wed,  4 Mar 2020 16:10:45 -0800 (PST)
Date:   Wed, 4 Mar 2020 16:10:45 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Pawan Kumar Meena <pawank1804@gmail.com>
Cc:     joel@joelfernandes.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH RESEND] Documentation: RCU: lockdep.txt: Convert to
 lockdep.rst
Message-ID: <20200305001045.GT2935@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200303144546.20405-1-pawank1804@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303144546.20405-1-pawank1804@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 03, 2020 at 08:15:46PM +0530, Pawan Kumar Meena wrote:
> This patch converts lockdep.txt to lockdep.rst and adds it to index.rst.
> 
> Signed-off-by: Pawan Kumar Meena <pawank1804@gmail.com>

Given an ack from someone on the docs side, I will be happy to queue
this one.  Given the large change from the last posted version with no
version history, I am a bit leery of taking it straight away.

						Thanx, Paul

> ---
>  Documentation/RCU/index.rst                    | 1 +
>  Documentation/RCU/{lockdep.txt => lockdep.rst} | 9 ++++++---
>  2 files changed, 7 insertions(+), 3 deletions(-)
>  rename Documentation/RCU/{lockdep.txt => lockdep.rst} (97%)
> 
> diff --git a/Documentation/RCU/index.rst b/Documentation/RCU/index.rst
> index 81a0a1e5f767..109dea13f165 100644
> --- a/Documentation/RCU/index.rst
> +++ b/Documentation/RCU/index.rst
> @@ -10,6 +10,7 @@ RCU concepts
>     arrayRCU
>     rcubarrier
>     rcu_dereference
> +   lockdep
>     whatisRCU
>     rcu
>     listRCU
> diff --git a/Documentation/RCU/lockdep.txt b/Documentation/RCU/lockdep.rst
> similarity index 97%
> rename from Documentation/RCU/lockdep.txt
> rename to Documentation/RCU/lockdep.rst
> index 89db949eeca0..3a88d8a59753 100644
> --- a/Documentation/RCU/lockdep.txt
> +++ b/Documentation/RCU/lockdep.rst
> @@ -1,4 +1,7 @@
> +.. _lockdep_doc:
> +
>  RCU and lockdep checking
> +========================
>  
>  All flavors of RCU have lockdep checking available, so that lockdep is
>  aware of when each task enters and leaves any flavor of RCU read-side
> @@ -63,7 +66,7 @@ checking of rcu_dereference() primitives:
>  The rcu_dereference_check() check expression can be any boolean
>  expression, but would normally include a lockdep expression.  However,
>  any boolean expression can be used.  For a moderately ornate example,
> -consider the following:
> +consider the following::
>  
>  	file = rcu_dereference_check(fdt->fd[fd],
>  				     lockdep_is_held(&files->file_lock) ||
> @@ -82,7 +85,7 @@ RCU read-side critical sections, in case (2) the ->file_lock prevents
>  any change from taking place, and finally, in case (3) the current task
>  is the only task accessing the file_struct, again preventing any change
>  from taking place.  If the above statement was invoked only from updater
> -code, it could instead be written as follows:
> +code, it could instead be written as follows::
>  
>  	file = rcu_dereference_protected(fdt->fd[fd],
>  					 lockdep_is_held(&files->file_lock) ||
> @@ -105,7 +108,7 @@ false and they are called from outside any RCU read-side critical section.
>  
>  For example, the workqueue for_each_pwq() macro is intended to be used
>  either within an RCU read-side critical section or with wq->mutex held.
> -It is thus implemented as follows:
> +It is thus implemented as follows::
>  
>  	#define for_each_pwq(pwq, wq)
>  		list_for_each_entry_rcu((pwq), &(wq)->pwqs, pwqs_node,
> -- 
> 2.17.1
> 
