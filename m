Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E66DC4332B
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 16:01:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32A35206D4
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 16:01:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N6pSD8rj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbgDDQBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 12:01:49 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59895 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726229AbgDDQBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 12:01:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586016107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FUdF7iY9SS4OEmK+NSy6HOWdmAoXBxog9A83yLakpIU=;
        b=N6pSD8rjDqkXLc4GCSkwKuyhxQbMPzLn/DpMrjSqeacBuf9hfkOUSkfLGZMoOj/f1Xrz33
        rvAlZkq5rnLpgU1MswcktZ9uXZI93ip/4p3ZWuPudqMxVt2plgqnzsvDNXr8ba70wM1zpJ
        6qNsJrr8b6oKqvqzCn5Y2l2X2NsLF5E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-BLP3HdZDO0Sr1HutAcntrQ-1; Sat, 04 Apr 2020 12:01:45 -0400
X-MC-Unique: BLP3HdZDO0Sr1HutAcntrQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D07218A6EC1;
        Sat,  4 Apr 2020 16:01:08 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.53])
        by smtp.corp.redhat.com (Postfix) with SMTP id 2443F5C541;
        Sat,  4 Apr 2020 16:01:01 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Sat,  4 Apr 2020 18:01:07 +0200 (CEST)
Date:   Sat, 4 Apr 2020 18:01:00 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        Peter Zijlstra <peterz@infradead.org>,
        clang-built-linux@googlegroups.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Marco Elver <elver@google.com>,
        Brian Gerst <brgerst@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] x86: signal: move save_altstack_ex out of generic
 headers
Message-ID: <20200404160100.GB26298@redhat.com>
References: <20200324220830.110002-1-ndesaulniers@google.com>
 <20200403231611.81444-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403231611.81444-1-ndesaulniers@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03, Nick Desaulniers wrote:
>
> --- a/arch/x86/kernel/signal.c
> +++ b/arch/x86/kernel/signal.c
> @@ -416,6 +416,7 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
>  	return 0;
>  Efault:
>  	user_access_end();
> +	reset_altstack();
>  	return -EFAULT;
>  }
>  #else /* !CONFIG_X86_32 */
> @@ -507,6 +508,7 @@ static int __setup_rt_frame(int sig, struct ksignal *ksig,
>  
>  Efault:
>  	user_access_end();
> +	reset_altstack();
>  	return -EFAULT;
>  }

I must have missed something, but this looks just wrong.

reset_altstack() should be called when __setup_rt_frame() (and
unsafe_save_altstack() in particular) succeeds, not when it fails.

Nevermind, Al has already suggested to use signal_delivered()...

Oleg.

