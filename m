Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7CFC33CB2
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 02:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BF1D206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 02:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hLyXhXuS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgA3CQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 21:16:52 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:41817 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgA3CQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 21:16:51 -0500
Received: by mail-oi1-f196.google.com with SMTP id i1so1963031oie.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 18:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=ESEG2SF4akO3jo6AanTsK74LjMSE+YgL8aNUFKiXd6Q=;
        b=hLyXhXuSVgxb+NZsynbVR3QoYFnSUmGs00E2bmQLv0Gc/8BpQYV4mTPnD8RudQfgQ6
         RZk1sxQaqEH61oPbAi06tfzJmyRw168PjFcXX/JlcLd58nGifG6S2nkQsLPak2lxGMdR
         yqkKGmSDPJ4NDoo3C+7DgKKau/yT0G7uWG/gDSIKTlzRpe/x/px8BA9uRPQXyDEGF3w+
         hkH8HMXuwc59SyLTBaaaqYQoqeJPAc4Wb2EE+c2cp7JoY79YCClE+CGwK5y0CSULE0Bs
         0vxbG0iiruPpY1GULNGoYb/BR9nfvJ5D56MgxeZI7vNaxnKiY774QxcgBCQgev1XPeGh
         aSIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=ESEG2SF4akO3jo6AanTsK74LjMSE+YgL8aNUFKiXd6Q=;
        b=hmwrK86HknfzxAun8+24RrCtOLD39Uva91BSAtZoayKXwgrnfVK03Y1jBtY9AMnjy3
         KjXMpBhpUsYAuwJqq/4gZK7gx5Pfji03PO9+nLa5EytZ6fXSJN7svXEhkOild5urwx9+
         tROWluUzYlMFtuUzqOVm27wd9B7YTtooZiknjUUBJFVNq+lUfuKW3g3WbmKhsOYhBAvc
         2zHMtvO/E1Jp6UMXpgtUKvD1wMmgf7PbxtqrnYN2LxLkByZIfIEqfAkQ/lRorKJEDVCJ
         xmLO0GSIe4K3JXE+uOxowvzAIv1FN6NxLVQS/pt9XWhCv4wYPRc7Y/IMEb19iGEKX2fF
         xFXw==
X-Gm-Message-State: APjAAAVXMPCkjZ+XxZ8B3sExDwS5F1XH81Ob1dR+w9anyUnDEg/gxsvB
        rKdL+LAdeYSyhTo6Gv55HMbHMAgf
X-Google-Smtp-Source: APXvYqynhyei0zV/c5d79YEq3hJvt3n0EfRNdiF0zgrTRs6pNn74WKX554VGDb7T9EL0Keh53TcHAw==
X-Received: by 2002:aca:4809:: with SMTP id v9mr1377408oia.92.1580350610665;
        Wed, 29 Jan 2020 18:16:50 -0800 (PST)
Received: from ubuntu-x2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id g25sm1355617otr.8.2020.01.29.18.16.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Jan 2020 18:16:50 -0800 (PST)
Date:   Wed, 29 Jan 2020 19:16:48 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: -Wfortify-source in kernel/printk/printk.c
Message-ID: <20200130021648.GA32309@ubuntu-x2-xlarge-x86>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

After commit 6d485ff455e ("Improve static checks for sprintf and
__builtin___sprintf_chk") in clang [1], the following warning appears
when CONFIG_PRINTK is disabled (e.g. allnoconfig):

../kernel/printk/printk.c:2416:10: warning: 'sprintf' will always
overflow; destination buffer has size 0, but format string expands
to at least 33 [-Wfortify-source]
                        len = sprintf(text,
                              ^
1 warning generated.

Specifically referring to
https://elixir.bootlin.com/linux/v5.5/source/kernel/printk/printk.c#L2416.

It isn't wrong, given that when CONFIG_PRINTK is disabled, text's length
is 0 (LOG_LINE_MAX and PREFIX_MAX are both zero). How should this
warning be dealt this? I am not familiar enough with the printk code to
say myself.

[1]: https://github.com/llvm/llvm-project/commit/6d485ff455ea2b37fef9e06e426dae6c1241b231

Cheers,
Nathan
