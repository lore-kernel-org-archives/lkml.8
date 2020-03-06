Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27F7C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 21:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 924EB206D7
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 21:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XFOGn8Zi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgCFV4s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 16:56:48 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:37264 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgCFV4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 16:56:48 -0500
Received: by mail-qv1-f68.google.com with SMTP id w16so1257213qvn.4;
        Fri, 06 Mar 2020 13:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/qftFsm6HdBxEnInarXAUBlShoM/f/zFOOpC3dVn39Q=;
        b=XFOGn8ZiNF9gDWhSp9WK2ABpn7tbfuwE+MEbJ38wPJfGPteh2WI9Nbo7auXKRoz9W/
         ll8Oj9n3WPdWph1BW3yFypeH0HQ0yO6dcgxn6lag+3ksyFT6NG7ErbMuPz9WveG1p21U
         FScT2IqnxtUNseZcJ7BdQLKOY0eSZ6ewt6+pahm3W6uY+La/lMwQiIGRC6k2j5XJNAjf
         yh0xoWcC0nM1Fpz4S2XtRqL+MgX/hnnA6VEb84iIJos1xv2Aw6bgfm+vvgXsxxxepgMM
         FgTuPyOdkH8uwkrAQfEPq8jwS+TIASDwOiI0xxpF3SeVL2cGoZmqih6O96P0LY/HJQYM
         Y+fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/qftFsm6HdBxEnInarXAUBlShoM/f/zFOOpC3dVn39Q=;
        b=dpO7pYA7ru6N8WIBUUJHktKBliRGuZQ9gaQgqd1m07Nz9lQAnQSten+3obp1RKhAh/
         7etPfM1OSFLZh3LIs1ixs024zXn8M7IYSg2L3VsstdTm6v1aRyLIhR2zD/HHBC9m+Gqd
         7XPKC6xSPgxRTovtPwjJBNU0flzcWgq9p73s0yGNLfzd6mPrn1bi6u8K+xfhSymo+rKm
         DzO2NxmZUKUuITjWPfHGuyhjODXwRWAW76nL9OwordCob0Czv15rgsvEfDUgri/p1/r8
         nE4uKrca32LuEJX9fgOBCHTzzx9yGvHk41+L+uESZxA4LCZVEdTmVfIwP6/4fwW5J4Wl
         OqMA==
X-Gm-Message-State: ANhLgQ0aXRXqRfHXG3YKe5ZMctrfacImz+ysPGHUCPeSsdqINpeN/zVb
        I7xV6btU+Z/eD1voChERKQs=
X-Google-Smtp-Source: ADFU+vtRK326WTe5Rhk3W22+QYv88e1MOwq2ZpdmEeSYJOVDfResegYf9iXjkcVNjsBgk3jk2G5qJw==
X-Received: by 2002:a05:6214:5c1:: with SMTP id t1mr4834011qvz.39.1583531805669;
        Fri, 06 Mar 2020 13:56:45 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id o129sm2793045qke.109.2020.03.06.13.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 13:56:44 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9DB9040009; Fri,  6 Mar 2020 18:56:42 -0300 (-03)
Date:   Fri, 6 Mar 2020 18:56:42 -0300
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Ian Rogers <irogers@google.com>,
        John Garry <john.garry@huawei.com>,
        Nick Desaulniers <nick.desaulniers@gmail.com>,
        Tommi Rantala <tommi.t.rantala@nokia.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL] perf/urgent fixes
Message-ID: <20200306215642.GA15931@kernel.org>
References: <20200306191144.12762-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200306191144.12762-1-acme@kernel.org>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Mar 06, 2020 at 04:11:33PM -0300, Arnaldo Carvalho de Melo escreveu:
> Hi Ingo/Thomas,
> 
> 	Please consider pulling,
> 
> Best regards,

OOps, messed up and sent more messages than needed, the branch should be
ok tho:

[acme@quaco perf]$ git log --oneline acme/perf/urgent tip/perf/urgent..perf-urgent-for-mingo-5.6-20200306
441b62acd9c8 (tag: perf-urgent-for-mingo-5.6-20200306, five/perf/urgent, acme/perf/urgent, acme.korg/perf/urgent) tools: Fix off-by 1 relative directory includes
3f5777fbaf04 perf jevents: Fix leak of mapfile memory
7b919a53102d perf bench: Clear struct sigaction before sigaction() syscall
f649bd9dd5d5 perf bench futex-wake: Restore thread count default to online CPU count
29b4f5f18857 perf top: Fix stdio interface input handling with glibc 2.28+
cfd3bc752a3f perf diff: Fix undefined string comparision spotted by clang's -Wstring-compare
[acme@quaco perf]$

Sorry about that,

- Arnaldo
