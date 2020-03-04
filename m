Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59C6C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 22:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9F472084E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 22:37:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EAtJLQO/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388546AbgCDWhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 17:37:02 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33886 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388337AbgCDWhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 17:37:02 -0500
Received: by mail-pf1-f194.google.com with SMTP id y21so1719711pfp.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 14:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VOHGjPwLEYzJ+NqPhTxXCzJYmftKGLSSp5cAtNLCFMU=;
        b=EAtJLQO/uI42Fek4uQmblnQJLffzrG9Ebiq37Cb1UGIUgfWykLmw1kfB7wjHV/cJO4
         2FUC/RJMJMvnbUpjIqNxadfBZQ1nF8dAUCDYZPnf4++UHHa+gp5G92941Qd6fc1fvXXv
         NrOLS85QX48s9NmoAgcaPM9FeA3vd1zq6mAoM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VOHGjPwLEYzJ+NqPhTxXCzJYmftKGLSSp5cAtNLCFMU=;
        b=fHtQiOmpqJuHmp51gvTeM6oDjFhH1U5Ex1LMA1K2QfzFIevlyHPe8Eoa7bL4DAGcNR
         5vkt2pQ35b0kwVNlcPRT0rqq81nY0hiyD6MFg5cL2PMqinXY5I6KcvaO2Qtdx7dAoCD5
         wzEsnnlu6EembNW/ur5JMalT9pOsMZKIFT8PcZnJC/yyi8YLwwlyawJ4grxUmY8BHSUx
         qujEJnawrXcUw46b7KKkaweVnBYFYRyIuhYHW5HvcHpZ7YEtnJScvch/wZy7x/N0Cnw/
         AMD4e3ysWv+kXygM2rwe4v5NBbivOIYZZmvcRfOim6bynytipnunoStsDzkCW6s4HBrc
         9REA==
X-Gm-Message-State: ANhLgQ0V7oMF89RvlQbhEx6wEbpGCO1/jLsPiWO8HMy0SggbI9Cyfo8n
        VQ+YF+1Fa5PRRNOHb48wIAky+oAFZx0=
X-Google-Smtp-Source: ADFU+vuJoRxLlv+ejqD00BykMbxlvzIi4uD50iFg3ZLBaKHAupLn1/8YQyAxfhPrcxeNEjh0i4TJqQ==
X-Received: by 2002:a63:4752:: with SMTP id w18mr4343082pgk.379.1583361421234;
        Wed, 04 Mar 2020 14:37:01 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a7sm3646560pjo.11.2020.03.04.14.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 14:37:00 -0800 (PST)
Date:   Wed, 4 Mar 2020 14:36:59 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Scott Wood <oss@buserror.net>
Cc:     Jason Yan <yanaijie@huawei.com>, pmladek@suse.com,
        rostedt@goodmis.org, sergey.senozhatsky@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        linux-kernel@vger.kernel.org,
        "Tobin C . Harding" <tobin@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH v3 0/6] implement KASLR for powerpc/fsl_booke/64
Message-ID: <202003041433.5E2AAC5@keescook>
References: <20200304124707.22650-1-yanaijie@huawei.com>
 <202003041022.26AF0178@keescook>
 <b5854fd867982527c107138d52a61010079d2321.camel@buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5854fd867982527c107138d52a61010079d2321.camel@buserror.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 04, 2020 at 03:11:39PM -0600, Scott Wood wrote:
> In any case, this came up now due to a question about what to use when
> printing crash dumps.  PowerPC currently prints stack and return addresses
> with %lx (in addition to %pS in the latter case) and someone proposed

Right -- I think other archs moved entirely to %pS and just removed %lx
and %p uses.

> converting them to %p and/or removing them altogether.  Is there a consensus
> on whether crash dumps need to be sanitized of this stuff as well?  It seems
> like you'd have the addresses in the register dump as well (please don't take
> that away too...).  Maybe crash dumps would be a less problematic place to
> make the hashing conditional (i.e. less likely to break something in userspace
> that wasn't expecting a hash)?

Actual _crash_ dumps print all kinds of stuff, even the KASLR offset,
but for generic stack traces, it's been mainly %pS, with things like
registers using %lx.

I defer to Linus, obviously. I just wanted to repeat what he'd said
before.

-- 
Kees Cook
