Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1D3C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 16:41:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5601920848
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 16:41:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pph10uOE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgFJQlp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 12:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbgFJQlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 12:41:44 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC07C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 09:41:43 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j10so3028478wrw.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 09:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TTc2Z9TJYfIzIFDGvsmvK6hVBSuHubFwRjTEnMfWZaM=;
        b=pph10uOEtVWjam0MSkFgGo4Ze7vfIPcKk6odG7zs9j3ckHtV6dSrZFvYRngFfziebB
         cxtk0NjObGiRy8wN9SmGHL49Kb7DzYcFhk5pHUB+JP6OKS1yZWGoI/dtIUYQsYDjoYX3
         VtRX2Rq2ddo0yrCHXBKA2PAujQ+mlS0axatU7a8MW1luLVOvTLnicnydMnOdC29MyM3s
         CIN4gEkyUn27E8YFfqVFZEqreJiXU9L6p/Hx2fnkGfksDNB10UgdClKdhgVqhq+XRPi3
         ydlK1J/898SkUYvP/hks3chUW+1loAhJs2PDjGWqtEn44D5BRUhd3pp5PIJFQckisksl
         PKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TTc2Z9TJYfIzIFDGvsmvK6hVBSuHubFwRjTEnMfWZaM=;
        b=ukkGyE3vxJxabITvh+SUCZzVUgAkab7wlcFpx3OME/R1QrSEYw2kwdZWxsk4S2ODue
         RqSNve+rRSwDKp2y3zB345SYXMrb+P3PGertLiGEofH2jPrAqQaMdN8hRCef/eP39m7m
         eGA6Okuma3TJQnS/OfAkC9V7mydEra29KilFO/dYuHLIa/DBIMakOXM4Bcj2mQHVU1eJ
         yADo9yJGmT//eHgEf3CzrP3jT4XnHVozd1+XJUbOeCdlgC0HhDaJM3QE21hly3YZXqCK
         nQYiUtFv5J8ZM480hEXHVMxlVSEOwGgZGRuAhxZcl4FeBnTcoj5qUgNLOB++Ukf1ll4/
         ic5w==
X-Gm-Message-State: AOAM532J9nbawAxgmgEI5dBs8hyJBVc5w3IjzHcN+36/GCNmmABWyJD6
        +aSfLjtuhYwesbRdMvY6CACzbA==
X-Google-Smtp-Source: ABdhPJxSf03bcpYaW3bAJP347AmwFWa9hdgNrsHL4ylKCDUHlWLAvqSnNQSIgfujGyXZdFxFgFmM0w==
X-Received: by 2002:a5d:500d:: with SMTP id e13mr5001060wrt.150.1591807302549;
        Wed, 10 Jun 2020 09:41:42 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id o15sm308644wmm.31.2020.06.10.09.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 09:41:41 -0700 (PDT)
Date:   Wed, 10 Jun 2020 17:41:40 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Sumit Garg <sumit.garg@linaro.org>, Petr Mladek <pmladek@suse.com>,
        Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: [PATCH] printk/kdb: Redirect printk messages into kdb in any
 context
Message-ID: <20200610164140.tgzcn5oip2gzgmze@holly.lan>
References: <1589273314-12060-1-git-send-email-sumit.garg@linaro.org>
 <20200512142533.ta4uejwmq5gchtlx@holly.lan>
 <CAFA6WYOV7oPbYE=9fXueYMacb5wv0r9T6F8tmECt-Eafe-fctw@mail.gmail.com>
 <20200514084230.GO17734@linux-b0ei>
 <CAFA6WYPSsgdAB-wJC0e2YkVkW0XsqQsu5wrn4iB4M-cwvS7z2g@mail.gmail.com>
 <20200515085021.GS17734@linux-b0ei>
 <20200515103308.GD42471@jagdpanzerIV.localdomain>
 <CAFA6WYOBsimP1j8Fwq4OcePEug4MGoaY3wTTTVydHtTphZ-FTw@mail.gmail.com>
 <20200515163638.GI42471@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515163638.GI42471@jagdpanzerIV.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 16, 2020 at 01:36:38AM +0900, Sergey Senozhatsky wrote:
> On (20/05/15 17:32), Sumit Garg wrote:
> > > Can I please have some context what problem does this solve?
> > 
> > You can find the problem description here [1] which leads to this fix.
> 
> [..]
> 
> > [1] https://lkml.org/lkml/2020/5/12/213
> 
> Thanks for the link. I'm slightly surprised it took so many years
> to notice the addition of printk_nmi/printk_safe :)

Rather by coincidence (at least I think its a coincidence) the problem
has recently become much more obvious.

0d00449c7a28 ("x86: Replace ist_enter() with nmi_enter()") just brought
this to the surface by treating debug traps as NMIs. This means the CPU
that takes a breakpoint, and where almost all of the kdb printk() calls
take place, will now unconditionally have printk() interception enabled.


Daniel.
