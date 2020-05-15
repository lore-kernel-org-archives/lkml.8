Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7359C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A552320657
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="rzJExiwo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgEONLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 09:11:41 -0400
Received: from mail.efficios.com ([167.114.26.124]:35276 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbgEONLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 09:11:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 608442AE9CD;
        Fri, 15 May 2020 09:11:40 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id xN0YRVTzlkDk; Fri, 15 May 2020 09:11:39 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id C9CFD2AE9CC;
        Fri, 15 May 2020 09:11:39 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com C9CFD2AE9CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1589548299;
        bh=ckXGYo/mwLj3Sl75hO6m/BXI6eeRGWK4bk+UTIcpgr0=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=rzJExiwomdtGvHkAXUrG0G56AAxdJPuuafskN/tCpeC8mZzWXsFMpY8dx2JYPAEBU
         QXVAKRmsRII9ZEI5zIP4UQkLHFQPPhj6a2lld1/yvobSbqj0JbGgdV7Mm958h/2tOu
         5Gz2JpQnr3mkxLUL7IfvgWaK+26jNLy38JoQ96Sg0Un7hWP7VSYr9b/sKpk2p/QM/A
         SjUHHL/Q5aEK7ghgJ3wBEwjz4xG2AkFvLPVLWcsIwuFY+k1mFdyCVqtCO85gTuOUw8
         gnV2Y7RtLeAojbQzaiNZ1P1uRoCjI9AzBJI1UP+FLYIi1hL4iebv5zC1SI46Dh0pEM
         p3R7QM4HTF/IA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id MqocqiZ0O0Ac; Fri, 15 May 2020 09:11:39 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id B7AFF2AE769;
        Fri, 15 May 2020 09:11:39 -0400 (EDT)
Date:   Fri, 15 May 2020 09:11:39 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        paulmck <paulmck@kernel.org>, Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>, rostedt <rostedt@goodmis.org>,
        "Joel Fernandes, Google" <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
Message-ID: <2096020113.22176.1589548299729.JavaMail.zimbra@efficios.com>
In-Reply-To: <877dxdy211.fsf@nanos.tec.linutronix.de>
References: <20200505131602.633487962@linutronix.de> <20200505134059.462640294@linutronix.de> <1777514130.20137.1589410645669.JavaMail.zimbra@efficios.com> <877dxdy211.fsf@nanos.tec.linutronix.de>
Subject: Re: [patch V4 part 1 14/36] x86/entry: Get rid of
 ist_begin/end_non_atomic()
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3928 (ZimbraWebClient - FF76 (Linux)/8.8.15_GA_3928)
Thread-Topic: x86/entry: Get rid of ist_begin/end_non_atomic()
Thread-Index: 9uyVhZ+9PK6Uht/T7s935ZVPtLoupA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On May 15, 2020, at 5:34 AM, Thomas Gleixner tglx@linutronix.de wrote:
[...]
> 
> Can you please trim your replies?

Sorry, will do,

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
