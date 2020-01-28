Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F6FC33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 11:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 320812468B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 11:20:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="mInuM3Bo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbgA1LUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 06:20:32 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43434 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgA1LUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 06:20:32 -0500
Received: by mail-qk1-f196.google.com with SMTP id j20so12898181qka.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 03:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=ydbYF0D7QAu7P1+NQVQLTUDzbcrzMyEp6Q2vaSMl/rw=;
        b=mInuM3BomijaB5dkcqiPvPKK5VHT+6Iy8+Aq1QEagr6uy02KPqfSznEJ+RfrO8X2lg
         pfhL+ZAWSt8/WPpG/kurCqSlupX+FDNDTTEbxmMpjpE2ZhIoKODAiEOz7hftyqt/loCH
         aGcaEULlqja203QTzHsfIt6f5OJJ6uo0trg7deNEzIymH5oewDj+YYd7OL7lXVhsZVKG
         jz7mSaSfoxoPQGhPK+f3Tj0BP72HQeQv4Hwv9qxi+pHTy6RoemQ5xmnsnyuJOcUqaDoA
         L3h4woAuK8m4i109sY6LzNLjBtax7o5ZZ7VQTy7JwV7EE7Z2fqa36m42DUJt5sENODPq
         Ni8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=ydbYF0D7QAu7P1+NQVQLTUDzbcrzMyEp6Q2vaSMl/rw=;
        b=SYUNmx96bFGNcRKe3JkznadWVwm2Y/uUILammchoAay2kNorOfHjySi+6Wj/G7Ha8Q
         wK8ocGZTxiueU0fPS5aAPPyETUc7a7Q8UeVMff6FySMXW0Kp93VlWuM98eVvsz3RxOxo
         Kfgf4VqGN9KI9LjdsQE3hs8JUDYhlBu8mFLQL5js8VesX7ljEAJ8lVD1+9Qjp2cFzX1N
         3KSDsTt0kGXX+Ws34lq44UlXrTI6FmQL+BqY3BKwFHLkBkLBQTbZe/tb7au5nSzkcaD3
         j0N/PpPzt2dcFiEUBYNyMZCzlW2RI7uWUrN3J7ieRhjHgZYDwlHqWH+eUBqJ3va5xR4S
         kfRw==
X-Gm-Message-State: APjAAAWD5epD0aRBxccw5nQViJJpYim4Kpnh64X+5ljRigVZUzvesmZ4
        WBKmizDApUdYBmf3h8HDZAhdsQ==
X-Google-Smtp-Source: APXvYqwvPaBSvzQJwY/oOpco0RS56cu12JMOwhXZt+xPz01YyKCzDz71O2pLHLCzFweq+CXt0g26Og==
X-Received: by 2002:a05:620a:110c:: with SMTP id o12mr21630605qkk.66.1580210431039;
        Tue, 28 Jan 2020 03:20:31 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id z4sm11821742qkz.62.2020.01.28.03.20.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2020 03:20:30 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 0/9] Introduce Data Access MONitor (DAMON)
Date:   Tue, 28 Jan 2020 06:20:29 -0500
Message-Id: <41BBD985-4B3D-4F87-B69D-D8CFE6EC0EBE@lca.pw>
References: <20200128104942.11419-1-sjpark@amazon.com>
Cc:     akpm@linux-foundation.org, SeongJae Park <sjpark@amazon.de>,
        sj38.park@gmail.com, acme@kernel.org, amit@kernel.org,
        brendan.d.gregg@gmail.com, corbet@lwn.net, dwmw@amazon.com,
        mgorman@suse.de, rostedt@goodmis.org, kirill@shutemov.name,
        brendanhiggins@google.com, colin.king@canonical.com,
        minchan@kernel.org, vdavydov.dev@gmail.com, vdavydov@parallels.com,
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200128104942.11419-1-sjpark@amazon.com>
To:     sjpark@amazon.com
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 28, 2020, at 5:50 AM, sjpark@amazon.com wrote:
>=20
> For the comments from perf maintainers, I added Steven Rostedt and Arnaldo=

> Carvalho de Melo first, but I might missed someone.  If you recommend some=
 more
> people, I will add them to recipients.
>=20
> I made DAMON as a new subsystem because I think no existing subsystem fits=
 well
> to be a base of DAMON, due to DAMON's unique goals and mechanisms describe=
d
> below in the original cover letter.
>=20
> The existing subsystem that most similar to DAMON might be 'mm/page_idle.c=
'.
> However, there are many conceptual differences with DAMON.  One biggest
> difference I think is the target.  'page_idle' deals with physical page fr=
ames
> while DAMON deals with virtual address of specific processes.
>=20
> Nevertheless, if you have some different opinion, please let me know.

I thought everyone should know to go to the MAINTAINERS file and search PERFO=
RMANCE EVENTS SUBSYSTEM.

It might be difficult but there is a perf subcommand for some subsystems lik=
e sched: tracing/measuring of scheduler actions and latencies.=
