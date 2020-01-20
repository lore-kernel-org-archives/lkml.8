Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MIME_QP_LONG_LINE,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1618C32771
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 20:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCC86217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 20:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Azm74f9b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgATUfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 15:35:12 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45696 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbgATUfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 15:35:12 -0500
Received: by mail-qt1-f195.google.com with SMTP id w30so816091qtd.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jan 2020 12:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=uWbG+L0o14IZj3qiM7C/tN6Cfd1CRzUg46OsGAWkndI=;
        b=Azm74f9bLpx0RHMqOE+4JZ1YVuAOBmv5fTDmuOnBktuhIl/n5ySiWJx355ifEM0p0M
         nesCts8lRvdjWFIXNGR72742cx7auysZkjqtv4dfLmme4DLNAnlmy7BXJzV0tEU95EKA
         oW36ey7Ka+nFv346R9uOn9mOiQubvO3QWw6VPPohbdNu1P36NycIsbjO3dtvOnxaPb3U
         ualVbcu97G8ajskRjJC0Y0zoc9TcCokzJdntEHqrxOUEeRAwRn75eRbUsYvgRbXrqaJ6
         uY3eEsX3wJA1+G2DE3g4vex6V5A8dBvXO1Rla8MJO5tMe7NkEhxlU4cNsa8FzB/Z7hue
         MyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=uWbG+L0o14IZj3qiM7C/tN6Cfd1CRzUg46OsGAWkndI=;
        b=nwnMn+BMrt0NDpZc+l6NrZnowC6pq3kI0lRvs4e+Hc8rleb+i3qZTFafx10wrCm4xW
         WvZz0q3akKV4Z/N6MBxGVzFOHjf4q3YuI+mXVHYwnjd7YxQ0nFVrUl6+br+9ne2BVrhl
         H4IjaPvVfvEjeZM6RrEg7ojjGcEDChXlvT5cDbjLeYJiL0nhvO4f/cIBCYfysoGK31lM
         iWLw1fOtSq/hCTmLe5NrLRajx/Jfgr2ov2gkUw31wVKpb155tyx7eRhD71fUnUR7WZrH
         +UhRj3vMmeMZfszm45r1QI2D+AlKR4u6f3xOc4uBXPeoug9ufQFA9+TWkyadzn0S8Hlk
         ZUlw==
X-Gm-Message-State: APjAAAXvy3XbbYjZfu/qbLKB1fqd9W2rFs5c9mAuCzankWr/efS1bzOR
        VmPrYSLNZKVq07thRE8DWaRB9w==
X-Google-Smtp-Source: APXvYqyZVqvs5gkBK+6X6ozDe5OxP4ZKixI6zB9Lbc9sGgREZyxpFufx/qut0WqF8jvyNaZpIwoMcw==
X-Received: by 2002:ac8:12c8:: with SMTP id b8mr1190499qtj.111.1579552511371;
        Mon, 20 Jan 2020 12:35:11 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 68sm16537846qkj.102.2020.01.20.12.35.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2020 12:35:10 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] sched/core: fix illegal RCU from offline CPUs
Date:   Mon, 20 Jan 2020 15:35:09 -0500
Message-Id: <F96BF662-BB11-4AFB-BF05-CB1720441A92@lca.pw>
References: <20200120101652.GM14879@hirez.programming.kicks-ass.net>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        paulmck@kernel.org, tglx@linutronix.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200120101652.GM14879@hirez.programming.kicks-ass.net>
To:     Peter Zijlstra <peterz@infradead.org>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 20, 2020, at 5:17 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>=20
> Bah.. that's horrible. Surely we can find a better place to do this in
> the whole hotplug machinery.
>=20
> Perhaps you can have takedown_cpu() do the mmdrop()?

The problem is that no all arch_cpu_idle_dead() will call idle_task_exit(). =
For example, alpha and parisc are not, so it needs to deal with some kind of=
 ifdef dance in takedown_cpu() to conditionally call mmdrop() which sounds e=
ven more horrible?

If you really prefer it anyway, maybe something like touching every arch=E2=80=
=99s __cpu_die() to also call mmdrop() depends on arches?

BTW, how to obtain the other CPU=E2=80=99s current task mm? Is that cpu_rq(c=
pu)->curr->active_mm?=
