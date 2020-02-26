Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5490AC4BA0A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 05:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AFCE206E2
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 05:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582695832;
	bh=ZOzBYKXgbfY5U945SxtYnf0QrB/e73YIMy/DlPN1nEg=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=oP5IVxhSeFWIddjGr28LOKQ/tCgq+eJjh0ctV4iw75KYqy0CrSf+rj2D/hkTSlBDj
	 ChRMq1TUwrFXemSmakz5ISWuVRXog9qIuE1pfY4P1upBHjaMX/zyRBtVxseKcVcnZ6
	 JTdfuKqL7jpK7D5pCeqgHy8uFBNOs+xQ1mzWrWeI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgBZFnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 00:43:51 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39144 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgBZFnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 00:43:50 -0500
Received: by mail-pg1-f196.google.com with SMTP id j15so741793pgm.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 21:43:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1hgsM6gSNbXEr9X/HoPMyiDKMStkjECuYc49dVUE4lM=;
        b=Wz1UXa0jC4ewUvSNjkGXJCzSSkENlxqzzznMGZATgUzEaxDdm49Sdx9QGXk2QaHRFe
         MIxxjybdDB6tLKxVinr5IpOA2AqDQO2CCjyA/asQaX3LvJ60iane0Yi+xX09yGB3SfgN
         phPYsd/sk5n5CmD/+PWt/6h/Vs1UWPPaFTOCw4SxzvlVVSV72TxPjQ5fhm4G/yAZYt9E
         ka9y6jGBgBDU0tpzK63WOcGSXaluQPHt3Kq4fN5p3F+MFy3fGpqt7fvFYV4p/Pb+aU0Q
         M+RRWSzZsB7NH/XEGytWcusUJDZP1/aunwpK0thJlvO5GyXH++KWMZf2C4fInDNgG64V
         n+Ww==
X-Gm-Message-State: APjAAAW8MLQnXhqowkQmJVTUTYyNvJBrCVFkqh86e3B1rGgCc+MBHJU8
        o1XqVIPhDvR3ONn6La0L1cjksw==
X-Google-Smtp-Source: APXvYqxnrjnDevi8orLcmXFYCJ74+Br1CVnMQ2RMcREwMk2FBaJ0tIagUzPEA3VhPTzBnIf3JLHzcA==
X-Received: by 2002:a63:d344:: with SMTP id u4mr2119763pgi.153.1582695828342;
        Tue, 25 Feb 2020 21:43:48 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:3602:86ff:fef6:e86b? ([2601:646:c200:1ef2:3602:86ff:fef6:e86b])
        by smtp.googlemail.com with ESMTPSA id b27sm877029pgl.77.2020.02.25.21.43.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2020 21:43:47 -0800 (PST)
Subject: Re: [patch 4/8] x86/entry: Move irq tracing on syscall entry to
 C-code
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <20200225220801.571835584@linutronix.de>
 <20200225221305.605144982@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <6c4188c7-558e-b225-5a41-2ffaa5fa120e@kernel.org>
Date:   Tue, 25 Feb 2020 21:43:46 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200225221305.605144982@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/20 2:08 PM, Thomas Gleixner wrote:
> Now that the C entry points are safe, move the irq flags tracing code into
> the entry helper.

I'm so confused.

> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/x86/entry/common.c          |    5 +++++
>  arch/x86/entry/entry_32.S        |   12 ------------
>  arch/x86/entry/entry_64.S        |    2 --
>  arch/x86/entry/entry_64_compat.S |   18 ------------------
>  4 files changed, 5 insertions(+), 32 deletions(-)
> 
> --- a/arch/x86/entry/common.c
> +++ b/arch/x86/entry/common.c
> @@ -57,6 +57,11 @@ static inline void enter_from_user_mode(
>   */
>  static __always_inline void syscall_entry_fixups(void)
>  {
> +	/*
> +	 * Usermode is traced as interrupts enabled, but the syscall entry
> +	 * mechanisms disable interrupts. Tell the tracer.
> +	 */
> +	trace_hardirqs_off();

Your earlier patches suggest quite strongly that tracing isn't safe
until enter_from_user_mode().  But trace_hardirqs_off() calls
trace_irq_disable_rcuidle(), which looks [0] like a tracepoint.

Did you perhaps mean to do this *after* enter_from_user_mode()?

(My tracepoint-fu is pretty bad, and I can't actually find where it's
defined as a tracepoint.  But then it does nothing at all, so it must be
a tracepoint, right?)

>  	enter_from_user_mode();
>  	local_irq_enable();
>  }

