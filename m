Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6AAFCA90AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 18:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD76620720
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 18:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="JeNJEtRS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730650AbgELSJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 14:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgELSJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 14:09:33 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1DAC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 11:09:33 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id f189so8946197qkd.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 11:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=fw0mhRHjB0Y+7l+AID2aLmXiWkjNKhnoC4UhC7gwssg=;
        b=JeNJEtRSwJAHNNTz/K8kGHym+MMr/c+i4V2pS3G2g7vrOVKBJFj2ZciHOA/U2eIv1i
         nQ9DNPocygaVtyWonaj9MzhFteaFA0n1sSb6TnOCUDw66y8sMc40c8gL2ofgkoM5G3zy
         0gmRwZhtkvwoXy5h1Z9/a/M9sc828DkLGJSscBTL/btiKimL5lbBorSsmpOEWV2d4BrD
         8AAVM/5czOorxoihZATpY/7c2QheeOyzLoZiWcclZ9sdbA6ySuuNmZHBREvgog2wa0/O
         SDXoF3BC3fYsv9CbQnEj9HlgplFa+QkwJtf1K3YX7jSBs41hYh+KuUV+7Moo4o8nDYS7
         WcSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=fw0mhRHjB0Y+7l+AID2aLmXiWkjNKhnoC4UhC7gwssg=;
        b=KAvf7s3XQg4ah/PCo9fmSpW/suH6PeF4gf+IlDMuD3QQjFHmrsU74blBYyNQzHgXdZ
         L+kfWwNHxdijZlQlakw/CpiWKK1QpFL5TkH9NZDU3QpkbF59RWDjqWwdB5Eb1YXEQZnk
         Gc6CTMrqUglFzclLCrkgN+JIpLEjo7KRme9hWGxkjaZ08yp9zkMnDP3cw5fO4qhsN7NJ
         MinJGzQqjQpggXt08Ya3CqD8oHWNckFjxLyM89E8pKJbKqLWTgrD+DQ8KV8jFofum8rW
         BFEkMrzuskO68c1NAfj6rl6jP5J3r2JYGh6a5qOt/iL4iapItvOfS9Uzt4LnhHLBW+pH
         TDyQ==
X-Gm-Message-State: AGi0PuamDzYXTLYDaatOaYE4U2RhngBuwollq7guiUjdD8hqHooyaFAP
        KPOSAnkS9hXUaEcVdvP6sGixNrFJMbP2lw==
X-Google-Smtp-Source: APiQypL89ez88XKLzXv1q7szzOQuFQVrwRlN6/zc1GhyQMbs6oD/nJj1F+lTqJMFbYd0PqxY91bmDw==
X-Received: by 2002:a37:8786:: with SMTP id j128mr22665963qkd.63.1589306972618;
        Tue, 12 May 2020 11:09:32 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id i23sm11817133qke.65.2020.05.12.11.09.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2020 11:09:31 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: Kmemleak infrastructure improvement for task_struct leaks and call_rcu()
Date:   Tue, 12 May 2020 14:09:30 -0400
Message-Id: <E812E94D-B8B7-4934-965A-3038F56FD980@lca.pw>
References: <20200512141535.GA14943@gaia>
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
In-Reply-To: <20200512141535.GA14943@gaia>
To:     Catalin Marinas <catalin.marinas@arm.com>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 12, 2020, at 10:15 AM, Catalin Marinas <catalin.marinas@arm.com> wr=
ote:
>=20
> In this case it uses kref_get() to increment the refcount. We could add
> a kmemleak_add_trace() which allocates a new array and stores the stack
> trace, linked to the original object. Similarly for kref_put().
>=20
> If we do this for each inc/dec call, I'd leave it off as default and
> only enable it explicitly by cmdline argument or
> /sys/kerne/debug/kmemleak when needed. In most cases you'd hope there is
> no leak, so no point in tracking additional metadata. But if you do hit
> a problem, just enable the additional tracking to help with the
> debugging.

Well, we would like those testing bots to report kmemleak (I knew there woul=
d be many false positives) with those additional information of refcount lea=
ks in case they found ones, albeit never saw one from those bots at all yet.=


Since some of those bots will run fuzzers, so it would be difficult to repro=
duce. Thus, the option has to be enabled by default somehow. Otherwise, they=
 could easily miss it in the first place. I=E2=80=99ll look into the see if w=
e could make it fairly low overhead.=
