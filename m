Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45045C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03CA421532
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TFCAIMkt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbgIGRpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:45:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20658 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731480AbgIGRod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 13:44:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599500671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tbJAEmbnhj5tfQXq87hCWAEhP8FiF1I1Gv0tPdPnVrE=;
        b=TFCAIMktny/5X44ir04UEVonQf7BdR4BkxWfCeCNclwC5cOK0V2dqt6HETwkk+0aphvuLD
        325MPtUbJOeF994ec8eG2wt8dqTHAUF2idzG1C3+P7hRuREyQQmraUo+NoS09ZLrHVvioj
        nets/7/rd0z9uQy6qsEgRJVZRS4vuMo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-8kB39vAsMAeDCf3R6wktFg-1; Mon, 07 Sep 2020 13:44:29 -0400
X-MC-Unique: 8kB39vAsMAeDCf3R6wktFg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0636A10054FF;
        Mon,  7 Sep 2020 17:44:27 +0000 (UTC)
Received: from redhat.com (ovpn-112-64.phx2.redhat.com [10.3.112.64])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 93DD25C230;
        Mon,  7 Sep 2020 17:44:23 +0000 (UTC)
Received: from [127.0.0.1] (helo=vm-rhel7)
        by redhat.com with esmtp (Exim 4.94)
        (envelope-from <fche@redhat.com>)
        id 1kFLBj-000064-R6; Mon, 07 Sep 2020 13:44:19 -0400
From:   fche@redhat.com (Frank Ch. Eigler)
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     peterz@infradead.org, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org, Eddy_Wu@trendmicro.com,
        x86@kernel.org, davem@davemloft.net, rostedt@goodmis.org,
        naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        linux-arch@vger.kernel.org, cameron@moodycamel.com,
        oleg@redhat.com, will@kernel.org, paulmck@kernel.org,
        systemtap@sourceware.org
Subject: Re: [PATCH v5 00/21] kprobes: Unify kretprobe trampoline handlers and make kretprobe lockless
References: <159870598914.1229682.15230803449082078353.stgit@devnote2>
        <20200901190808.GK29142@worktop.programming.kicks-ass.net>
        <20200902093739.8bd13603380951eaddbcd8a5@kernel.org>
        <20200902070226.GG2674@hirez.programming.kicks-ass.net>
        <20200902171755.b126672093a3c5d1b3a62a4f@kernel.org>
        <20200902093613.GY1362448@hirez.programming.kicks-ass.net>
        <20200902221926.f5cae5b4ad00b8d8f9ad99c7@kernel.org>
        <20200902134252.GH1362448@hirez.programming.kicks-ass.net>
        <20200903103954.68f0c97da57b3679169ce3a7@kernel.org>
        <20200903110226.8963179e6a7c978e2d56c595@kernel.org>
Date:   Mon, 07 Sep 2020 13:44:19 -0400
In-Reply-To: <20200903110226.8963179e6a7c978e2d56c595@kernel.org> (Masami
        Hiramatsu's message of "Thu, 3 Sep 2020 11:02:26 +0900")
Message-ID: <87eendo51o.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masami Hiramatsu <mhiramat@kernel.org> writes:

> Sorry, for noticing this point, I Cc'd to systemtap. Is systemtap taking
> care of spinlock too?

On PRREMPT_RT configurations, systemtap uses the raw_spinlock_t
types/functions, to keep its probe handlers as atomic as we can make them.

- FChE

