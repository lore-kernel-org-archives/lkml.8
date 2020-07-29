Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9AB4C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 12:40:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94EB420829
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 12:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="nE2NBVpN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgG2MkB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 08:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgG2MkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 08:40:00 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694FBC0619D2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 05:39:59 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id b2so165379qvp.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 05:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=spmyQP3L/yNiXY42BwMCA8cPT1EWwAdeGPZrcULFkt4=;
        b=nE2NBVpNVJeONO7+Dlq5cIwm+uHzUci3Za0sSd+X3HYlADyCM+AUV/yTIyl5wQ8OO4
         X0sOmPVqaxoHwBd1gXMX5hpn8o3zBr96GPYkLA08eFL7rlVemiUKJ4xW+EbZMW+dDJEc
         pYB97TfCJn5I3ZlPgRyEJTGIk4rnO6W2hkgZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=spmyQP3L/yNiXY42BwMCA8cPT1EWwAdeGPZrcULFkt4=;
        b=bRJb7Q9eZJzljCkHV21FiZrQgCJ1UQwEdK8c+MSfspjpVkKAddg4pexbE67KAP8P9T
         6Z9fynd8lroNoVY1nnNWA1Tqw1tMlWeE8SJ5qy8KbAfs8Fo1RqJmgFfU1JNLr4LqG+sr
         G0CeUdtiYAq3SJmsdoTVSaLyEtvSNpGu9AVEG1r0wtQ7adR86EPXaqU2QEj2G5gznCCQ
         jgodyq394+0Ib5CyZFzY+xliVpiiq55XgfbFeiz22F4NUubTFbtu/IC2cvssbRudDz8r
         P8vp8x6fzVLfhEI7TVh2zEuTHFi5biCaPin3Z5hl5IvaZst3gM4TLrGAy2ZryvOusddV
         ozZA==
X-Gm-Message-State: AOAM530/Sb0gewwxYotgQ1kVGvV4BL1tJUdqf0vmRcyrwbB+qRUjkCdp
        KjVumEqkdVxo2F6QHBjMAvX4gA==
X-Google-Smtp-Source: ABdhPJyCCHXXwDumfa6ncclTkZxwczJdk2K85nLzunPVAs6lxIo0hcpkWdN/ELYIxGWAjHbT9QJX8w==
X-Received: by 2002:a0c:8224:: with SMTP id h33mr19165728qva.52.1596026398412;
        Wed, 29 Jul 2020 05:39:58 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id d198sm1436718qke.129.2020.07.29.05.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 05:39:57 -0700 (PDT)
Date:   Wed, 29 Jul 2020 08:39:57 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Marco Elver <elver@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Subject: Re: [PATCH RFC] rcu/segcblist: Add counters to segcblist
 datastructure
Message-ID: <20200729123957.GC225345@google.com>
References: <20200719034210.2382053-1-joel@joelfernandes.org>
 <20200720142923.mrudcweyttlmnhqp@linux-p48b>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720142923.mrudcweyttlmnhqp@linux-p48b>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 07:29:23AM -0700, Davidlohr Bueso wrote:
> On Sat, 18 Jul 2020, Joel Fernandes (Google) wrote:
> 
> > +/* Move from's segment length to to's segment. */
> > +static void rcu_segcblist_move_seglen(struct rcu_segcblist *rsclp, int from, int to)
> > +{
> > +	long len = rcu_segcblist_get_seglen(rsclp, from);
> > +
> > +	if (!len || from == to)
> > +		return;
> 
> Nit: You probably wanna do the parameter sanity checks before the
> atomic_read.

Ok, I'll do that next revision. Thank you.

 - Joel

