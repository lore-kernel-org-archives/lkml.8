Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88732C33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 06:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53E8E2077C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 06:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fRdy9FIS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbgATGAK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 01:00:10 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41154 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgATGAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 01:00:10 -0500
Received: by mail-pf1-f195.google.com with SMTP id w62so15276504pfw.8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jan 2020 22:00:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DFjThD5KqeMZi/zXBmMw7tvmONl4MC0LP5kRzMUQwQY=;
        b=fRdy9FISKBGOtrPq94MvbSt01MUCNeIhsVans22cQTANqaaNvq6M/IBjDym08+/225
         2HpA3OhJR1qfQXE9QlvKeeLEqYTfeMZqkbt3tZMyrw1M4QZyq5UUq58+oYzCOdlAHarX
         oeAj1NyrwQl2BFwn9q8gsLHcRpWe2+O4OppSEUQ1k/VrxlCZOFPqV38UEVrjsrtUYmeU
         C2FxO25cEnKSuJ6DCcWuoTSAZdw1DDdrXQw0+y654FT52ICTJ8b4+Wl8XKlt9DHzkVbV
         bp/RD1ZP/yqirQu1ysja7LVN9SZWowcLC8KE6OZsOAhnZyX99q59188UmE/EZ3vbEMoI
         wJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DFjThD5KqeMZi/zXBmMw7tvmONl4MC0LP5kRzMUQwQY=;
        b=GDpshwVmU1QrRwxRRMEGqH/ec7SZTgCCOvt9t94Ajdl38/5x5vxS5hw2xJdJhzh62D
         CAKwuoCmUuf8WBKWhsjlnrT6HejukiFs85sdNTuryeYkYRPmucil9dluPPDB2XODI79J
         BYDFmU3RUig2V8ZpfK5fBkeTWvJ6u+lH5ATUaZOAatR6FIEzI+LArJ43+8Bo1miEIEJG
         0McAVwYbnbTR7+NjXcH0kXCmD+dvgwbs/TieI5xcPPMPBDaoNslR/cFtwHQ0GCR1eJJ/
         0vvAsLf22rMhbCdt6T8Ajr92uti8vSi6w/FT6hmS6l2ln1HXur1DHRfUr6urfFzffoyy
         bgqw==
X-Gm-Message-State: APjAAAWuJxYW6tWLkzm0TKRCQe64kZY9FJHqmufTjq6rL0x+ri/mGw95
        HvTLMOCP9j0nEzA1CRQWt/p2QA==
X-Google-Smtp-Source: APXvYqzvgBcY8f/cIeCJBhyM78RkJZ88kv+h77VnoqksyXWYX8mMpcvOieW5fDE3qhmQBInYNYJnyw==
X-Received: by 2002:a63:1d1a:: with SMTP id d26mr55612556pgd.98.1579500008181;
        Sun, 19 Jan 2020 22:00:08 -0800 (PST)
Received: from localhost ([122.172.71.156])
        by smtp.gmail.com with ESMTPSA id w11sm38194423pfi.77.2020.01.19.22.00.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Jan 2020 22:00:07 -0800 (PST)
Date:   Mon, 20 Jan 2020 11:30:05 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the tip tree
Message-ID: <20200120060005.g7at22c4g2rxmpet@vireshk-i7>
References: <20200120163853.53da0ac5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120163853.53da0ac5@canb.auug.org.au>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-01-20, 16:38, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the tip tree, today's linux-next build (x86_64 allnoconfig
> and a couple of other allnoconfigs) produced this warning:
> 
> kernel/sched/fair.c:5221:12: warning: 'sched_idle_cpu' defined but not used [-Wunused-function]
>  5221 | static int sched_idle_cpu(int cpu)
>       |            ^~~~~~~~~~~~~~
> 
> Introduced (I think) by commit
> 
>   323af6deaf70 ("sched/fair: Load balance aggressively for SCHED_IDLE CPUs")

Thanks for reporting this Stephen.

I have sent a fix for it now and cc'd you as well.

-- 
viresh
