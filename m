Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34027C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 02:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3766206F5
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 02:19:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ROp/0+QK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbgFMCTn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 22:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbgFMCTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 22:19:42 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BDDC03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 19:19:41 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id g12so4474475pll.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 19:19:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Bo0TAuzTN7c9oRMEnH/nTxVp984RSzHy+ZWlZuT0u48=;
        b=ROp/0+QK2eUfPPBuUEv9CrEl/J3QmKM5q4rYsB5p8kdf3h4bq2jl3JlUWLoT5mCkQf
         6H7B+OWAFfcT+0p4n5sf1p5FX0CxeeQZq6rXBt4/upKbAgXS3c4oVTwIG1Tpcl2Xjs5b
         SGN0u1NkTpz4BZ5n4JgKLnnwpC6UxSfi7cQsen9oKafX5dZQZjArfeTW46T7BgGBEp29
         UFNCcHx20/ZzL2+LGSgiUZOsyNdkuxTpLw2wROvR4vRIYBpi0MOjD2d7qvI9f5qyCdaI
         2KGAa/8WvuU4cXVCIzRGC9GQXcgslGipxpRrmWyv0+qdkW5oTP2vX9AfzRxgWenP4Yfy
         qq9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Bo0TAuzTN7c9oRMEnH/nTxVp984RSzHy+ZWlZuT0u48=;
        b=YGKqugrW46SUVJV4Ngds2vNvtbVkcBzeQxA2hOx6sBQLyGUzMgwflsv5Fultld+QeG
         lbG2v32g0WKQs/WXWvL7ahPi4K16rGecXFnISjzuMXmiTqf7JPApWFEzAC7WJCLtzuSn
         DyTm59ymhTMeVHBTR770imr5iBWJbyvifNDmtaDW4XYfQ0QN+96mSRl+ImbAxBDzvG96
         vjzOjS56VteK8yv9HgCtAmrLxXzIwQ9+Kk53xiEH+MWJguJZOMp2kjZ+GxVdg5oLemt4
         zhull2pvXY9sgucRHxuSC+9mOXYwf6RnyoDYxiivIxgIY9VXtV85+myNVl45OGvufUtl
         Hl8g==
X-Gm-Message-State: AOAM531OpV2XQjkmvqp54xWpPfSijTjPxKIGiq5ELpTZhlZd6mCQ6tgH
        qeN0lJsuP5nH67mUyMu1MraAIDRg
X-Google-Smtp-Source: ABdhPJzfg5fG/KiTssGHqRsSdRs82XZN06XUV0vl9NFITbS8LB1efTd2+AXFfrV27C/yzTfoMG0uKA==
X-Received: by 2002:a17:90a:e007:: with SMTP id u7mr1689819pjy.208.1592014780295;
        Fri, 12 Jun 2020 19:19:40 -0700 (PDT)
Received: from localhost (g228.115-65-196.ppp.wakwak.ne.jp. [115.65.196.228])
        by smtp.gmail.com with ESMTPSA id c2sm7343978pfi.71.2020.06.12.19.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 19:19:39 -0700 (PDT)
Date:   Sat, 13 Jun 2020 11:19:37 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>
Subject: Re: [GIT PULL] OpenRISC updates for v5.8
Message-ID: <20200613021937.GN75760@lianli.shorne-pla.net>
References: <20200613021757.GM75760@lianli.shorne-pla.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200613021757.GM75760@lianli.shorne-pla.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CCing list.

On Sat, Jun 13, 2020 at 11:17:57AM +0900, Stafford Horne wrote:
> Hi Linus,
> 
> Please consider for pull:
> 
> The following changes since commit ae83d0b416db002fe95601e7f97f64b59514d936:
> 
>   Linux 5.7-rc2 (2020-04-19 14:35:30 -0700)
> 
> are available in the Git repository at:
> 
>   git://github.com/openrisc/linux.git tags/for-linus
> 
> for you to fetch changes up to 6bd140e14d9aaa734ec37985b8b20a96c0ece948:
> 
>   openrisc: Fix issue with argument clobbering for clone/fork (2020-06-01 06:15:32 +0900)
> 
> ----------------------------------------------------------------
> OpenRISC updates for 5.8
> 
> One patch found wile I was getting the glibc port ready:
>  - Fix issue with clone TLS arg getting overwritten
> 
> ----------------------------------------------------------------
> Stafford Horne (1):
>       openrisc: Fix issue with argument clobbering for clone/fork
> 
>  arch/openrisc/kernel/entry.S | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
