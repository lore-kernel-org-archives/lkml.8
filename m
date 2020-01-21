Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D65F4C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 11:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6CAB20882
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 11:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aLqMzWAP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729121AbgAULn3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 06:43:29 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36482 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbgAULn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 06:43:29 -0500
Received: by mail-lj1-f193.google.com with SMTP id r19so2433757ljg.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 03:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zDdhun4ABRxY94wjs4jI9+9VhoTcNIW8MtiXNBzEmj0=;
        b=aLqMzWAPRfkY6hltEOk5gzzWOvQc0Q4DqSjPbfb49hBW0OKn40AMrmxjd+UH+Gx13T
         Dq2psHKs70owY6S/5qXtw3siC4d2gNUrWa7iVxb/F5jEoicCiHGjxS9OE44+i/1K7z6L
         qqqeW5SA5gpWcuoM8sbmEpCiJdrO6t7OxrW3PeEUEwtIaLjll5BVqQiczoommBlgsVyP
         LSBqo7NHUQxOIkJkuKTHUAm6l8a7WB/MubDDl/K331tPcFIGQCZqCZDeLOcHtAX20R/+
         ycmRYgvwqG7nzxsENPjqb3PR2fuMqg3LgvENDEfvYsT8EeIG+VBqZK19Mbtpz/4n1FPv
         dntw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zDdhun4ABRxY94wjs4jI9+9VhoTcNIW8MtiXNBzEmj0=;
        b=gk30il2SsxuQXDgBO+/BH2BXiiUryMFow/W6bpAqJLajSkoU0nit9W1e79jtFxrpsW
         c4yT/hywihRpZEuwcnHojdktuBkor1diwcifBHadXuPR3YWL90A9pkbhtJKzLmMAJQdt
         ZPy5XENI0NleWubvgYIDpX8rmnuts84GMmK4+ZRy0kXiARp3xVlcCuJ7WVVRJu/E2/Q7
         tbnRTHTiEzRVd5wO3wY7BwWCOp4eVZAo+b9jJCkJFeCuUmvId+8SLhdAvyG/ZmorOlSj
         FoBAwXZqdkSQn3gyTGr4/bFCoO/JJxhzwDDoxdbuNla+JUH5rTrmo+5KflP5ZIDKk7I/
         wwQw==
X-Gm-Message-State: APjAAAWYbGWHitTFRy/81F1vxWY9wrW25UJBIMR75WUFnIuY4EQQnXwG
        EXxi7pvav8Pe9UYsBKx/WWvAq1wv
X-Google-Smtp-Source: APXvYqyTKi8j0xgLfs8/+c1CJdJvt+nQSsVj5USAgjxYncSADx3KpoMospsM/FdOJEEKzHiibEPJVg==
X-Received: by 2002:a05:651c:21c:: with SMTP id y28mr15903217ljn.164.1579607007649;
        Tue, 21 Jan 2020 03:43:27 -0800 (PST)
Received: from uranus.localdomain ([5.18.171.94])
        by smtp.gmail.com with ESMTPSA id g25sm18223732ljn.107.2020.01.21.03.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 03:43:26 -0800 (PST)
Received: by uranus.localdomain (Postfix, from userid 1000)
        id 352B34617C8; Tue, 21 Jan 2020 14:43:26 +0300 (MSK)
Date:   Tue, 21 Jan 2020 14:43:26 +0300
From:   Cyrill Gorcunov <gorcunov@gmail.com>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/fpu: remove unused macros
Message-ID: <20200121114326.GF2437@uranus>
References: <1579596611-258536-1-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579596611-258536-1-git-send-email-alex.shi@linux.alibaba.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 21, 2020 at 04:50:11PM +0800, Alex Shi wrote:
> NR_VALID_PKRU_BITS/PKRU_VALID_MASK are never used after it was
> introduced. So better to remove them.

Dave moved them in so while they are not used indeed better to
get approve from him (to be sure they were not reserved for
future development).

Initial commit 8459429693395ca9e8d18101300b120ad9171795
