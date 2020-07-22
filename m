Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22F6C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7423F207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wTi597w8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rzdia+Of"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732019AbgGVSZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 14:25:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51176 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgGVSZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 14:25:58 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595442356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=De2Oo3WYSjxDYyxtzHkgNAFZFz1uqYilAgoG2Mi1/0E=;
        b=wTi597w8/WAvYo6fRhtK8Csx9AtQpbzEmpgE3ZBRJ9pE/j2ad+0y5sTi0vRAghKFrxVejv
        EpcFdThV2BtJrR/Gf/tlO7DUSE4/2+wnqa6iCfEIyHY0yDh9QnXo5ZBOj64gGsX6qKsPkd
        8ZzWGZ5VrSiVViESnb4dXPf0P6vk+RTYWNZum31cPDhAQsSlZgNQW4wDP82kQf/bUZutwN
        so3gzqknEwCf/CFXSRbqx9VmYjIi49DyJpDeLcQdHTL3H4Zh9V/Vuco21Cem5ntUFIDcH4
        DFuwT5YrOXYcUyvpd17rnlvGAaFdbIE9Q4FvGjV8h/4LrIVkhQ64CyufKz2ZOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595442356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=De2Oo3WYSjxDYyxtzHkgNAFZFz1uqYilAgoG2Mi1/0E=;
        b=rzdia+Of0BW+JLmcJkwDHHcZakCXbL4PaRIYIuDNTEyyNIpL5hKfZCt7BOCx58Zq7T0/9t
        yJk/QNK9n7b1XmCA==
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [patch V4 10/15] x86/entry: Use generic syscall entry function
In-Reply-To: <202007211440.BEF76E2@keescook>
References: <20200721105706.030914876@linutronix.de> <20200721110809.325060396@linutronix.de> <202007211440.BEF76E2@keescook>
Date:   Wed, 22 Jul 2020 20:25:55 +0200
Message-ID: <87wo2vz9sc.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kees,

Kees Cook <keescook@chromium.org> writes:
> On Tue, Jul 21, 2020 at 12:57:16PM +0200, Thomas Gleixner wrote:
>
> This doesn't look very expensive, and they certain indicate really bad
> conditions. Does this need to be behind a CONFIG? (Whatever the answer,
> we can probably make those changes in a later series -- some of these
> also look not arch-specific...)

The most expensive part is native_save_flags(). The extra branches could
be visible in benchmarks, but its a good question whether this should be
just enabled.

I just keep it as is for now as I would need to make the flags and the
on_thread_stack() part x86 specific anyway, but yes we can revisit that
once we agreed on the general direction of this.

Thanks,

        tglx
