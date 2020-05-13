Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C6AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 23:42:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A41F82054F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 23:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="lr4OqABL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732781AbgEMXmT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 19:42:19 -0400
Received: from mail.efficios.com ([167.114.26.124]:44240 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732456AbgEMXmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 19:42:18 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 8EA6C2BFAFD;
        Wed, 13 May 2020 19:42:17 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id HE5reDYQ7HtZ; Wed, 13 May 2020 19:42:17 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 374D02BFE99;
        Wed, 13 May 2020 19:42:17 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 374D02BFE99
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1589413337;
        bh=gZP/CrJgMswY4fKTD3gwvtjS/7Z/7asD+PSqyElTKh8=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=lr4OqABLsSp0aAaqyT2bm+99FbSmkH7Uto45Qvqz1GGv8zNdq+LIeyRA/2bMn9Sw1
         vGHg7UHNoazfOzSalNFkQJO4HKcBX2zPcQmFN3GtrlVmNKqmhatW+0uKUJ3Uv5ZLOY
         VyuXxaDvvJrYUH8w7jHLWbA7GQe+d/Wq4sWuyQr8/aedzs7Quil/t8lLs5P/DkiK1+
         gBRVXqmewBhmlLxaaE4s5Vuyatx9Chasy0z0GtJL3zn123nZ+R9GX8vNC6fTS4Fd1J
         Ifsit3yLO5uNHoqVZewzZx7oMmiLGyCwetthiI4MW3HOSLwxMMF22eZ4JL/BzB8nvr
         Bi5VCd9Hj5n3Q==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id MHSL4MiIFPVP; Wed, 13 May 2020 19:42:17 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 24C4F2BFE20;
        Wed, 13 May 2020 19:42:17 -0400 (EDT)
Date:   Wed, 13 May 2020 19:42:17 -0400 (EDT)
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
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Message-ID: <409359846.20366.1589413337072.JavaMail.zimbra@efficios.com>
In-Reply-To: <20200505134100.957390899@linutronix.de>
References: <20200505131602.633487962@linutronix.de> <20200505134100.957390899@linutronix.de>
Subject: Re: [patch V4 part 1 29/36] x86/mce: Send #MC singal from task work
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3928 (ZimbraWebClient - FF76 (Linux)/8.8.15_GA_3928)
Thread-Topic: x86/mce: Send #MC singal from task work
Thread-Index: q+R/MvvYlgGjd3KZ3y/QG7hHPokAjQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On May 5, 2020, at 9:16 AM, Thomas Gleixner tglx@linutronix.de wrote:

> From: Peter Zijlstra <peterz@infradead.org>
> 

Patch title: singal -> signal.

> Convert #MC over to using task_work_add(); it will run the same code
> slightly later, on the return to user path of the same exception.

So I suspect that switching the order between tracehook_notify_resume()
(which ends up calling task_work_run()) and do_signal() done by an
earlier patch in this series intends to ensure the information about the
instruction pointer causing the #MC is not overwritten by do_signal()
(but I'm just guessing).

If it's the case, I think it should be clearly stated as the intent of the
earlier patch.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
