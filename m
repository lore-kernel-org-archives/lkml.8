Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4B0C10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 07:31:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EED9E2073D
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 07:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583566289;
	bh=/8wztW9Zw/Qy4YL7T27+Awuor+c/aBqBFPJ4+2qen6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JbpHmc46YUfZVsCbvCqiudPZY1WD7Llh2jTlM7xosenflyJT1+1AFMGgeEEb/B41l
	 ZxhrRIxKwP9vHHlxBhKXJi+oOFziMjxT63Ar4sNDAGDSvPul/Ktq6hVg5O5Hu52OH9
	 5qDdM3EeEXjTOF814MQKuUec1G5Lg2/W6iU3UdYs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbgCGHbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 02:31:16 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37971 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgCGHbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 02:31:16 -0500
Received: by mail-wr1-f67.google.com with SMTP id t11so4918109wrw.5;
        Fri, 06 Mar 2020 23:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GZ63kSzDRSNavMbJagZdDOIL2ssyD8h5PHQ+jSGVk9g=;
        b=nLUQinBitKbEXi4eN/VMqeM4FTz1hfr4Pafaq8jZpg9jUQ10bAJt5SqBSVbwZFjMB/
         UwOyfGEd82Lhq2KfbJ6/oNYDsquNYpNwT8XwrhIlu6jDwCaMoTIL9muYjCshhtHlj5l1
         m6gSXmtQUiZ0iXYSWFQ8zBoKzmP74N/IW4O7frsQRF54qMsG0LWkRkGJr8ItWVQTrxlA
         I+5AYXOY3LeisQ/IEtUqL5oXnTD7TondRR9zmHfwHqlbolYwCWEg5q5GeU/AtgtOnQBq
         b6ul5tLm1eCy7feIepCGKvmtg8zENQHxezv6cqF6Ixh5oB7OeDh0aG5B9gLmQuIGg6z2
         6glA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=GZ63kSzDRSNavMbJagZdDOIL2ssyD8h5PHQ+jSGVk9g=;
        b=VAih7++ZSxbC3OVKQuULdlUNjc8q8iHQ05HEjWjlqSn/pM6jDSD94gxZ0AXvZ64+th
         3FsWaOXCKT+1kdyhc4JQkEKwPuZNLnLoxhH6ZQi7GoxrbG3zYTgHYXt9AIt7s2oqi7AV
         RSrlHJ18/q+sqGPDHx3ZODQj8XJe6ZRvpcBV8/1Ew0vhoqtEkVkqZkn0LVNk65X3x6hK
         dMmX4qP7YQ4NkcVlPpNaXr9VlNNOOachzwZOxWG5Fv3VBQayV/8QaIQORjoSWPbgVj6B
         G6WhNYLmEEvtYpHsP2PpqoJiYIvbbEw1K+SG7Vf4P96CgWKBSGEdWOUkfKRQtIxZzI0w
         Ab0g==
X-Gm-Message-State: ANhLgQ16fjaSoJse3ws4FIxbEGF1BvWSKyKLsmuoW0Un/KMfMmgzkgsi
        eDzS6JlJ0kUR4b7owEwdDGw=
X-Google-Smtp-Source: ADFU+vvIaY4nJ0X48HYp4pHbU++MtBaUb4eCQr7QNMijWKDUUZXX5XXPCQs5tb0OFx99zbyXmn3dIg==
X-Received: by 2002:a5d:4b09:: with SMTP id v9mr7971140wrq.85.1583566275057;
        Fri, 06 Mar 2020 23:31:15 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id f207sm19608124wme.9.2020.03.06.23.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 23:31:14 -0800 (PST)
Date:   Sat, 7 Mar 2020 08:31:11 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Ian Rogers <irogers@google.com>,
        John Garry <john.garry@huawei.com>,
        Nick Desaulniers <nick.desaulniers@gmail.com>,
        Tommi Rantala <tommi.t.rantala@nokia.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL] perf/urgent fixes
Message-ID: <20200307073111.GA32920@gmail.com>
References: <20200306191144.12762-1-acme@kernel.org>
 <20200306215642.GA15931@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306215642.GA15931@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Em Fri, Mar 06, 2020 at 04:11:33PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Hi Ingo/Thomas,
> > 
> > 	Please consider pulling,
> > 
> > Best regards,
> 
> OOps, messed up and sent more messages than needed, the branch should be
> ok tho:
> 
> [acme@quaco perf]$ git log --oneline acme/perf/urgent tip/perf/urgent..perf-urgent-for-mingo-5.6-20200306
> 441b62acd9c8 (tag: perf-urgent-for-mingo-5.6-20200306, five/perf/urgent, acme/perf/urgent, acme.korg/perf/urgent) tools: Fix off-by 1 relative directory includes
> 3f5777fbaf04 perf jevents: Fix leak of mapfile memory
> 7b919a53102d perf bench: Clear struct sigaction before sigaction() syscall
> f649bd9dd5d5 perf bench futex-wake: Restore thread count default to online CPU count
> 29b4f5f18857 perf top: Fix stdio interface input handling with glibc 2.28+
> cfd3bc752a3f perf diff: Fix undefined string comparision spotted by clang's -Wstring-compare
> [acme@quaco perf]$
> 
> Sorry about that,

No problem, and pulled into perf/urgent, thanks Arnaldo!

	Ingo
