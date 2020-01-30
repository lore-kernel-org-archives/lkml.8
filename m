Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7F2C33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 05:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24AA520707
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 05:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ldzUaWK/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgA3FRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 00:17:15 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36002 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbgA3FRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 00:17:15 -0500
Received: by mail-pg1-f196.google.com with SMTP id k3so1031364pgc.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 21:17:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HgVZcNLI9NFyQNxv0grkqLVxwVjlyBQNZusKb8xDpmo=;
        b=ldzUaWK/BlIpCBJzVfT/KbsvEQDmYvr3UqS6Bi3Sc6uie9C1260aSogN9UPqCoPeDI
         EvgWQ2+IEFNgGeHAbgxIXDy1deJ4918PPB9y1eNDt/5HkfwgNhYULZWRs4+EfUUTlnHl
         /tyixm8lr0pP9afMBokhGcKA4kQmzm6CEL/SwBEKSl29oq5VkflaQoF3jDsXNiBQbzRt
         GjCUu0TMIBK7p/j4Bak5haimgfcAqduptWUiOpG/5KkpfRbBZjRgeE6YNejVbfAVtVaq
         xkdxL1sLFGFOosKyocqk2f5RPUnDIsDIJ3CJeSeDOA2xeo7pTGaVYGBXZs8N76YKSyBD
         gOcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HgVZcNLI9NFyQNxv0grkqLVxwVjlyBQNZusKb8xDpmo=;
        b=R4tPMsQaSt9G8LDkDNR2DYIOoSuPKA2PWjgTWUUVqj/VVOMcfzF3MI3v+Ivnl/0EtG
         9znxwtqdDNxPCQLF6FZSpF1UDRRt5w0OJn4UkNC/J3d/eFBh0bv784qlaltgjSa/A8hv
         fbPcBcuy9oxx/KyQLB3mAoR+m2JvNSb+f51mRL2MzS4IYtJ3rYkt50WYaGL54rdltwuD
         f7Kvu/5wuRSnuP5MlSNdktvhoGZ96MoOJI/6mmEQEc4vJDQiHakAHAa2nconZkhK65T2
         sLjH8Z2ydtyTaHjW7L87TJmi6oyDIplyreXdLj0XN+k/d+1wo53jNPTP5wWvKyWmc2DR
         n4qQ==
X-Gm-Message-State: APjAAAUizd95HLIj+DCk/f0N2c59qtbOvgYyo2EgSIgomIaWPon35+zt
        WTZuH1kSRJB0dP94Q93kQ1k=
X-Google-Smtp-Source: APXvYqzBlV9usWBUCUJC/gWjduVXKp/hPnU4LUo7jNqRqvKfeQkw4uMWeyihHAVO8A2+MiG9ovv85g==
X-Received: by 2002:a62:830c:: with SMTP id h12mr3442357pfe.162.1580361434515;
        Wed, 29 Jan 2020 21:17:14 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id x22sm4782205pgc.2.2020.01.29.21.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 21:17:13 -0800 (PST)
Date:   Thu, 30 Jan 2020 14:17:11 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: -Wfortify-source in kernel/printk/printk.c
Message-ID: <20200130051711.GF115889@google.com>
References: <20200130021648.GA32309@ubuntu-x2-xlarge-x86>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200130021648.GA32309@ubuntu-x2-xlarge-x86>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/01/29 19:16), Nathan Chancellor wrote:
> Hi all,
>
> After commit 6d485ff455e ("Improve static checks for sprintf and
> __builtin___sprintf_chk") in clang [1], the following warning appears
> when CONFIG_PRINTK is disabled (e.g. allnoconfig):
>
> ../kernel/printk/printk.c:2416:10: warning: 'sprintf' will always
> overflow; destination buffer has size 0, but format string expands
> to at least 33 [-Wfortify-source]
>                         len = sprintf(text,
>                               ^
> 1 warning generated.
>
> Specifically referring to
> https://elixir.bootlin.com/linux/v5.5/source/kernel/printk/printk.c#L2416.

Good catch.

> It isn't wrong, given that when CONFIG_PRINTK is disabled, text's length
> is 0 (LOG_LINE_MAX and PREFIX_MAX are both zero). How should this
> warning be dealt this? I am not familiar enough with the printk code to
> say myself.

It's not wrong.

Unless I'm missing something completely obvious: with disabled printk()
we don't have any functions that can append messages to the logbuf, hence
we can't overflow it. So the error in question should never trigger.

- Normal printk() is void, so kernel cannot append messages;
- dev_printk() is void, so drivers cannot append messages and dicts;
- devkmsg_write() is void, so user space cannot write to logbuf.

So I think we should never trigger that overflow (assuming that I
didn't miss something) message.

In any case feel free to submit a patch - switch it to snprintf().

	-ss
