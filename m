Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 073F7C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 02:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF947206D4
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 02:47:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ajt4lgwm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgEPCrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 22:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgEPCrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 22:47:06 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3120DC05BD09
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 19:47:06 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id r10so1888213pgv.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 19:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mzee7s7lzKP00VYAVwMN3kmoIGL9oQCKmVseoYr6QOg=;
        b=Ajt4lgwmAaiaLF1LOfai+aUHBtRYpEEy0IcA3j4C72JhsD46IFDWXT3O8Gr3I7F4+w
         V7X9I8Z00bb4eV1Z0dETv1dm7pVCfdm9au7ReU7qaGMc1QVIYgD4tOGrhlm2OFAi9EV+
         zfbCU7o/W0Mq2OppjXUjVbp+grE6cQJwQEtFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mzee7s7lzKP00VYAVwMN3kmoIGL9oQCKmVseoYr6QOg=;
        b=nC/hLTXEmeKlGOXopfuuSCPgueRf9ExVcSUELsotn0CickFI+z7Z4zwDv7pSsMzjIq
         9Je64056ZJWNN09vtz8ogkAtQgsLpCEBE2Cd6M6Afk21mG8Lc/Tpn7c+HvLELBAb050G
         NmkDlxfiNZtV8vL7nTo+FH2P9GMOiRcS6WP3IMXOqXcLyojUE+g+vjkdsCHQiX9Aqdc7
         CBUHQpJA6iYIaM5SIh361p2Qkd3OMRgQQPPIwcYDw7GjNFkkx9nCg6o8zrkadjQHxeJr
         a8vbk9v8DfOiJweDbfs7C9WxnpLXl8vT8KscOK9rG7xYAA2UjJupcomqgTnhmiipybHx
         J0BA==
X-Gm-Message-State: AOAM532qYBemijLV8dlLvlHxoiBP1aRCbt01Fpdq5D9zp6ISbqJkKbCP
        CDIcDkiVpwgvYdC5tXtsb4jKrQ==
X-Google-Smtp-Source: ABdhPJwbw9A1wfUHkEcWeNg4t7Ux00lVlN/MzF9aTtjoxikAC3/qP/eVw0yL+mozojQiwA0eH/CUmg==
X-Received: by 2002:a62:29c3:: with SMTP id p186mr6830376pfp.237.1589597225614;
        Fri, 15 May 2020 19:47:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i9sm3000708pfk.199.2020.05.15.19.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 19:47:04 -0700 (PDT)
Date:   Fri, 15 May 2020 19:47:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     mcgrof@kernel.org, yzaikin@google.com, adobriyan@gmail.com,
        mingo@kernel.org, peterz@infradead.org, akpm@linux-foundation.org,
        yamada.masahiro@socionext.com, bauerman@linux.ibm.com,
        gregkh@linuxfoundation.org, skhan@linuxfoundation.org,
        dvyukov@google.com, svens@stackframe.org, joel@joelfernandes.org,
        tglx@linutronix.de, Jisheng.Zhang@synaptics.com, pmladek@suse.com,
        bigeasy@linutronix.de, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, wangle6@huawei.com
Subject: Re: [PATCH 2/4] proc/sysctl: add shared variables -1
Message-ID: <202005151946.C6335E92@keescook>
References: <1589517224-123928-1-git-send-email-nixiaoming@huawei.com>
 <1589517224-123928-3-git-send-email-nixiaoming@huawei.com>
 <202005150105.33CAEEA6C5@keescook>
 <88f3078b-9419-b9c6-e789-7d6e50ca2cef@huawei.com>
 <202005150904.743BB3E52@keescook>
 <ab5f75d4-4d69-7b95-e6bd-ba8fd9792d94@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab5f75d4-4d69-7b95-e6bd-ba8fd9792d94@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 16, 2020 at 10:32:19AM +0800, Xiaoming Ni wrote:
> On 2020/5/16 0:05, Kees Cook wrote:
> > On Fri, May 15, 2020 at 05:06:28PM +0800, Xiaoming Ni wrote:
> > > On 2020/5/15 16:06, Kees Cook wrote:
> > > > On Fri, May 15, 2020 at 12:33:42PM +0800, Xiaoming Ni wrote:
> > > > > Add the shared variable SYSCTL_NEG_ONE to replace the variable neg_one
> > > > > used in both sysctl_writes_strict and hung_task_warnings.
> > > > > 
> > > > > Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
> > > > > ---
> > > > >    fs/proc/proc_sysctl.c     | 2 +-
> > > > >    include/linux/sysctl.h    | 1 +
> > > > >    kernel/hung_task_sysctl.c | 3 +--
> > > > >    kernel/sysctl.c           | 3 +--
> > > > 
> > > > How about doing this refactoring in advance of the extraction patch?
> > > Before  advance of the extraction patch, neg_one is only used in one file,
> > > does it seem to have no value for refactoring?
> > 
> > I guess it doesn't matter much, but I think it's easier to review in the
> > sense that neg_one is first extracted and then later everything else is
> > moved.
> > 
> Later, when more features sysctl interface is moved to the code file, there
> will be more variables that need to be extracted.
> So should I only extract the neg_one variable here, or should I extract all
> the variables used by multiple features?

Hmm -- if you're going to do a consolidation pass, then nevermind, I
don't think order will matter then.

Thank you for the cleanup! Sorry we're giving you back-and-forth advice!

-Kees

-- 
Kees Cook
