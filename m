Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E054C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 03:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6472A2074B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 03:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="ei0yzKh/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbgG3DZc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 23:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbgG3DZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 23:25:31 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85936C0619D2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 20:25:31 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id t4so21300672iln.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 20:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BMOKpsoAycMZRgiyYsf2Iv8iNWZoQZsua7ZF5l9UzN0=;
        b=ei0yzKh/0+/EVfLlVvdicxsBwhwQbO0UpL2frM3TZ8p1BlLc/Bk6n5tzdHhkvE5kqC
         BuuvBcneeC9QqKUF3XHgDlQtxHv6ejgvQE03z+QoPx5WJsvdHz43ALA1wZip6POLKkAY
         w2DY4w/a2cpNv3En9dleOzNxW8o/45qRmUaTE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BMOKpsoAycMZRgiyYsf2Iv8iNWZoQZsua7ZF5l9UzN0=;
        b=MdVy1EYJtpeFJb86p/FNfZNUCaJ6ZDi+/hbQzwmhEZG5wosL+JaeDaaHyTPhMikTHa
         7niGdxtSiwnrAnQELYVxLo3MbmoUFOLoFqgOagDyK2dzjHJWq4rlLSTHXNzh66vzuMd7
         lSMUlGQOVzNeu/ERGByQnYx8cwH30qVXs4QusZFZ29gW7Zi5fvVAWG4j3t8zU5EBgktk
         yjieHSFVdroTLW7F5eJz0tymMZrpjjxY6a5BJtmMuEEX6wY4B5YkawHCN6xLW6FsH8t0
         f5FKabvTcpeYA3hCBH3HkvBaqCxM4t3ccKrHtu5o49axJMNx1AWIsJdfDbEpfYGVzHxP
         pppQ==
X-Gm-Message-State: AOAM532NJ6+k5GpR+IZYy059dlWbKimicmdkkfGnDCrCYk9QQWcEHzcr
        +175ogZXwwGoTOi0PCbLv+xKlwtgDir8U8tKppJQnmytStY=
X-Google-Smtp-Source: ABdhPJxf3SJtdtcC3xEnWvm6qVniq9pX3GBUs7lPhXnrpuU95EdRjwzChN8OOM19xBI9ulznZWr3XCnXu1ZfiGkUoPE=
X-Received: by 2002:a92:660e:: with SMTP id a14mr6084382ilc.262.1596079530713;
 Wed, 29 Jul 2020 20:25:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200730030221.705255-1-joel@joelfernandes.org> <20200730030221.705255-2-joel@joelfernandes.org>
In-Reply-To: <20200730030221.705255-2-joel@joelfernandes.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 29 Jul 2020 23:25:19 -0400
Message-ID: <CAEXW_YSbad9Cium_9f1eA1RfZ2Me9JcX2S-KMe-jRQo8W6AaBg@mail.gmail.com>
Subject: Re: [PATCH 2/2] rcu/tree: Clarify comments about FQS loop reporting
 quiescent states
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu <rcu@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 11:02 PM Joel Fernandes (Google)
<joel@joelfernandes.org> wrote:
>
> At least since v4.19, the FQS loop no longer reports quiescent states

I meant here, "FQS loop no longer reports quiescent states for offline CPUs."

Sorry,

 - Joel


> unless it is a dire situation where an offlined CPU failed to report
> a quiescent state. Let us clarify the comment in rcu_gp_init() inorder
> to keep the comment current.
>
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  kernel/rcu/tree.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 1e51962b565b..929568ff5989 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1701,8 +1701,8 @@ static bool rcu_gp_init(void)
>
>         /*
>          * Apply per-leaf buffered online and offline operations to the
> -        * rcu_node tree.  Note that this new grace period need not wait
> -        * for subsequent online CPUs, and that quiescent-state forcing
> +        * rcu_node tree.  Note that this new grace period need not wait for
> +        * subsequent online CPUs, and that RCU hooks in CPU offlining path
>          * will handle subsequent offline CPUs.
>          */
>         rcu_state.gp_state = RCU_GP_ONOFF;
> --
> 2.28.0.rc0.142.g3c755180ce-goog
>
