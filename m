Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5596C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 03:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95FCB206A5
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 03:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgF3D04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 23:26:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:40662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728949AbgF3D0z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 23:26:55 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 82E94206B6;
        Tue, 30 Jun 2020 03:26:53 +0000 (UTC)
Date:   Mon, 29 Jun 2020 23:26:52 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Yordan Karadzhov <y.karadz@gmail.com>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Jason Behmer <jbehmer@google.com>,
        Julia Lawall <julia.lawall@inria.fr>,
        Clark Williams <williams@redhat.com>,
        bristot <bristot@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Darren Hart <dvhart@vmware.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Suresh E. Warrier" <warrier@linux.vnet.ibm.com>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>
Subject: Re: [RFC][PATCH] ring-buffer: Have nested events still record
 running time stamp
Message-ID: <20200629232652.5872c966@oasis.local.home>
In-Reply-To: <650783164.16607.1593486812734.JavaMail.zimbra@efficios.com>
References: <20200625094454.732790f7@oasis.local.home>
        <1548518134.13177.1593107707149.JavaMail.zimbra@efficios.com>
        <20200625143525.2f3a2902@oasis.local.home>
        <79426976.13417.1593113702719.JavaMail.zimbra@efficios.com>
        <20200629202146.29520925@oasis.local.home>
        <650783164.16607.1593486812734.JavaMail.zimbra@efficios.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jun 2020 23:13:32 -0400 (EDT)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> -> This configuration's avg varies between 239 and 256 ns based on your benchmark methodology. The std. dev. varies between  
> 138 and 201 ns.
> 
> In the benchmark results you collected, config #1 appeared to have little delta between xadd and cmpxchg, whereas
> config #2 and #3 had some avg difference. Did you try running this test many times on each machine to see if the
> result was indeed stable ?


Yes, but as we discussed on IRC, my machines are much smaller than this
one, and that makes it a bit more deterministic. I also run them with
distro configs. When there's debugging enabled, I get much more erratic
results.

-- Steve

