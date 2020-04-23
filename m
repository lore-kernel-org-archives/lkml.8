Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC98C54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 17:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A32920704
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 17:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vXhJEFPx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729826AbgDWRCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 13:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729674AbgDWRCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 13:02:53 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF20BC09B042;
        Thu, 23 Apr 2020 10:02:51 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id v63so3241975pfb.10;
        Thu, 23 Apr 2020 10:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BdjmbukyN93EyhI1DSTNcyhVrYjSoObY8SQv9ckT3OI=;
        b=vXhJEFPxCQwVoQXSTNO7YMg1HIyKEpV6lC+8pPWILrho1vIrTYf7UoAtU9MirtLHZe
         i6KIAsnQK7M9f/BFnt5/Y/yopgyslrJalNcovo0+uJBc1yu1OTt8V5/wn1qPIHDQKp82
         DVcB8mHqkVdvrwJ9AODqJAc4JXSSUGkpwH+pWtj1dj+qrhXUlF8RYRQXG4FYjWkyvDfa
         4UtchUVnEcSAc31X4mLxPHPY1uWi7U2ZcJpagDCh7QFHJiA6x0d3VS4QxxgxyTJ0w5os
         KAhYbfPZR82MsC+AF9VB7T+ByJwLrc+3wWRv4++vLdCNdV1CFjuGjDn375prp2Uw9Wp0
         m/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BdjmbukyN93EyhI1DSTNcyhVrYjSoObY8SQv9ckT3OI=;
        b=bNYlayDEb1DAkjbFYu5g7VZUWoFXLEQRXhWL20wckF8Aw7Si6UZL4q842iK6Cz/enZ
         XgDmkql5oTSZIakumlRQyQsidBYwGlmjvQtV/ow6hHj00SBgtluOKSZbFpquHFULyvMI
         /z2x/FQAK/arXJcSSvnu1sKKNGW3OpvjjUzQQYu7Dh7xtLF5TETzsiPEVgwetPi2wXfj
         c4QqUnlXh5+KCWdHeRJ4HG5XZbvq606i05yrU5UfyzjIdfM7vJAs+O9S3nNvZeUmDh0W
         J9fSpv9HVXfyqAmsWHGbSBHmz15WArDOoTmFhz0m3L7tZFk3lhkP/RPmSm7aeBxpukHw
         7CAw==
X-Gm-Message-State: AGi0PubND9Cr2VAAXinSFBcWYKXTvOe5PyHF+RinHDjxOFG1wwsAqL22
        XLmu6EtpUpnX3XIrazbm9vQ=
X-Google-Smtp-Source: APiQypJWSjA7CCiMuitdqpKx5L1KTkJAM/q32nofaJP3XA57AQ41nGcVcHpg1zkfSbrYj7gWzJBy1g==
X-Received: by 2002:a63:1d08:: with SMTP id d8mr4797010pgd.306.1587661371447;
        Thu, 23 Apr 2020 10:02:51 -0700 (PDT)
Received: from localhost (176.122.158.71.16clouds.com. [176.122.158.71])
        by smtp.gmail.com with ESMTPSA id o198sm3105112pfg.183.2020.04.23.10.02.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Apr 2020 10:02:50 -0700 (PDT)
Date:   Fri, 24 Apr 2020 01:02:45 +0800
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Coccinelle <cocci@systeme.lip6.fr>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ralf =?utf-8?Q?B=C3=A4chle?= <ralf@linux-mips.org>,
        Thomas =?utf-8?Q?Bogend=C3=B6rfer?= <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: console: Complete exception handling in newport_probe()
Message-ID: <20200423170245.GA3417@nuc8i5>
References: <c62ec54f-348b-2eae-59eb-374dde4d49ad@web.de>
 <20200423142909.GB1562@nuc8i5>
 <f054f00c-b813-e0c2-fe2e-30ccdec1ff46@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f054f00c-b813-e0c2-fe2e-30ccdec1ff46@web.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 05:23:29PM +0200, Markus Elfring wrote:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/scripts/coccinelle/free/iounmap.cocci
> >>
> >> How do you think about to extend presented software analysis approaches?
> >>
> > Sorry, I am not familiar with it, I don't know.
> 
> Do you find the comments helpful at the beginning of this SmPL script?
>
Sorry, I do not know how to use the SmPL script. 

> Would you like to let any more source code analysis tools help you
> to find remaining update candidates?
>
yes, but I think the source code analysis tools only can found the simple
repetitive issue. and need spend some time learning to use it. at different
stages, it should have different methods for me. now, I think the best for
me may be that read and check the source code. Thanks!

BR,
Dejin

> Regards,
> Markus
