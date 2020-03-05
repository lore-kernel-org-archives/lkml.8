Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB44C3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:40:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E8C620848
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 17:40:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qMqAXVvp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbgCERkE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 12:40:04 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46762 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgCERkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 12:40:04 -0500
Received: by mail-pl1-f194.google.com with SMTP id w12so2769680pll.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 09:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Fwow6K7jsM635u4hX7uuA9k3vOkPSqTTypNUyW6/TUY=;
        b=qMqAXVvphxubq/lxkcZ85TqcPWB9iEOe7HMOwCW0BoGX157x/CVL9Bmy5s0JRX44j1
         1BA2lRXB0a4OJqQo3McZFfbhbU63nhep8v9tfp8T7KMErGp/N6jZXZFHAHB9ojJzw3RL
         lYAQB6JT1FsqgJjQGkjZ3OY9Rczgbq94Oemnxkj9Yx+8/TR4jnoRycjJ3DCehlKgss9r
         KdYG7gw/vEe+hnsa7JGbkqgVgSBn5QG2fYyx37bJq8TqnDvTV0bIoTG8cdlL1iBbeqhg
         8KDdIhmJryfaxjXNzebYoXuiCtohwx/D/yOQdIiZ0yF2k2SReOgY7jH3fN1+dQEEFiTJ
         rRog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Fwow6K7jsM635u4hX7uuA9k3vOkPSqTTypNUyW6/TUY=;
        b=sDELOVTdnmyc12jDNY+h1GiB1YDRJpl/H2xIDfm/1GooU97rTOMudxMyvfr+G0+acP
         cwwOe9L2p+Wo+iqLlO+XJE3iviOzOfMOjM+hDVrCcKCQDbQTPdm5E0O681x4Tkizr2MJ
         A7DlPggoGjT6tR/uB7+Aq2wytfOScnVNT64hNvGAyqiy98ZFAc6GlYInjwYjp9mnlzQK
         1Xnix9JF2KcOYyquSdwGIcv9KS9Zl68agx4NKrACzQrQcDj8dVwji8tlzQh+nECySJZz
         tj/yXOfC77T7IQi8kGsd5g9mt8g1d886mQxNFSC0isLX439ai8YszgpoYUdsPGxgNYYK
         /nxw==
X-Gm-Message-State: ANhLgQ0kvEN4Tq+9ebA25jgKOoUQZFyPUTeO4N26/nbU4xpQpN7QgruY
        8aQy9WU9KsGIxoOLvY214m8sCCI=
X-Google-Smtp-Source: ADFU+vsEiecdkVptIoIkzpBcZJEM2BircXIFYz4xLout7u/nfoCzPAi1DZqkZ2ny15wjU2cu5gcSOw==
X-Received: by 2002:a17:902:8b8a:: with SMTP id ay10mr9372833plb.288.1583430001634;
        Thu, 05 Mar 2020 09:40:01 -0800 (PST)
Received: from madhuparna-HP-Notebook ([2402:3a80:1ee0:fa4c:45f1:8421:bfd8:b0fb])
        by smtp.gmail.com with ESMTPSA id y18sm31808475pfe.19.2020.03.05.09.39.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 05 Mar 2020 09:40:00 -0800 (PST)
From:   Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
X-Google-Original-From: Madhuparna Bhowmik <change_this_user_name@gmail.com>
Date:   Thu, 5 Mar 2020 23:09:54 +0530
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     madhuparnabhowmik10@gmail.com, paulmck@kernel.org,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        Amol Grover <frextrite@gmail.com>
Subject: Re: [PATCH] Default enable RCU list lockdep debugging with PROVE_RCU
Message-ID: <20200305173953.GA10538@madhuparna-HP-Notebook>
References: <20200228092451.10455-1-madhuparnabhowmik10@gmail.com>
 <20200305155238.GA8669@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200305155238.GA8669@roeck-us.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 07:52:38AM -0800, Guenter Roeck wrote:
> On Fri, Feb 28, 2020 at 02:54:51PM +0530, madhuparnabhowmik10@gmail.com wrote:
> > From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> > 
> > This patch default enables CONFIG_PROVE_RCU_LIST option with
> > CONFIG_PROVE_RCU for RCU list lockdep debugging.
> > 
> > With this change, RCU list lockdep debugging will be default
> > enabled in CONFIG_PROVE_RCU=y kernels.
> > 
> > Most of the RCU users (in core kernel/, drivers/, and net/
> > subsystem) have already been modified to include lockdep
> > expressions hence RCU list debugging can be enabled by
> > default.
> > 
> > However, there are still chances of enountering
> > false-positive lockdep splats because not everything is converted,
> > in case RCU list primitives are used in non-RCU read-side critical
> > section but under the protection of a lock. It would be okay to
> > have a few false-positives, as long as bugs are identified, since this
> > patch only affects debugging kernels.
> > 
> > Co-developed-by: Amol Grover <frextrite@gmail.com>
> > Signed-off-by: Amol Grover <frextrite@gmail.com>
> > Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> 
> Who is going to fix the fallout ?
> 
> fs/btrfs/block-group.c:2011 RCU-list traversed in non-reader section!!
> kernel/kprobes.c:329 RCU-list traversed in non-reader section!!
> net/ipv4/ipmr.c:136 RCU-list traversed in non-reader section!!
>
Hi,
There is already a patch for fixing the warnings in kernel/kprobes.c :
https://lore.kernel.org/lkml/157905963533.2268.4672153983131918123.stgit@devnote2/

Same for net/ipv4/ipmr:
https://lore.kernel.org/patchwork/patch/1198934/

Can you please send the warning with the stack backtrace and locks held
for btrfs/block-group.c, I will work on it.

Thank you,
Madhuparna
> This is just from my boot tests. I'll keep PROVE_RCU enabled for the
> time being, but unless the noise is addressed I'll have to disable it
> because otherwise the real problems disappear in the noise.
> 
> Guenter
