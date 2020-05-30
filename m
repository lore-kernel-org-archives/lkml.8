Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFCE8C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 16:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 776FA20723
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 16:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590855377;
	bh=+kv/tejxlUeyjVUPBseU73sxtGCpMm2CfuEpX32Whjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uexwvFKxe6H7vDjypd6+m61e+2rBjv6OuxT0DTEwyuQpn2Ari96mP3DWKGb6zTJan
	 GArBec+6Bg7PzakVcb7/VLRkRQWtYB6rVn6DtZ+/iLH2jjklXTunJKEUb4A6/Ugekt
	 pjvtAfNhbnTyaYMdXHgWSDLOsn+fHy3j1+y3kJBg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbgE3QQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 12:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728797AbgE3QQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 12:16:16 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9754C03E969
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 09:16:15 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id c14so4161251qka.11
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 09:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=5lmaga4Uf3rjRQHQaNUFbBD/yqUKegdJtvlIFMxLfGM=;
        b=Xd893GahVLbTLrG20ZwgXtTZVhoLwMHGyU/WutcER/0E2GlTC1b5OjnQ8PdakQu0H0
         fOwZ98iIhZB2j5HDvl9wXGmXcFup6PfURrUw4kFrqpOZLq4lXe5eYup69rk6hQK6iIAd
         XvIAzlB4mWwt8DTUoac4DhiBgmVMHk/sGR9BM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5lmaga4Uf3rjRQHQaNUFbBD/yqUKegdJtvlIFMxLfGM=;
        b=LL9OwtgO9W9wv6SwYo+z8QnLec9uXdN30/UpvNgMOeMLfc0bUU4BH6jPjveM92PNAu
         5FbKORiB3q0vR0EVEX2XfS0PiSSMuIVrIT3RUDBpw8brY/CdNg9Er3ZlYWhayAo3LPd1
         DcHdFJKRDAcmOo/W7OR2Yqi63axAY5z8vfPS87WvAax7aq+1GVfZc1L8qcKExHDrXNv1
         U2ZJVZvxt5wnJpvWSKHyyRpQBmvSxCdhmwnSg8UYlPF6OBdXEwRjTIZ4cqWW5MbBxg5P
         oI0X1KRTT4ojFlZt37ysJpCsEUb8RbLR7MA1cu0RcnkwQuhatrAl56gEz4gbIY3Jd5Hq
         w1VQ==
X-Gm-Message-State: AOAM533/JpAzfoVEJFTLaDlG9khRtoPMlpkRZtVd/3dyWlVPB7PTGqcw
        trDp3btvn5afRZhAG+2GvRkdQA==
X-Google-Smtp-Source: ABdhPJzBC14FpNnzEc9Y0UHIHP94PDMZucoNmXdY9KN5rI+BFa9LdNFUtihHrKZqmSIXefrJwSXxAg==
X-Received: by 2002:a37:4b17:: with SMTP id y23mr1230830qka.73.1590855375075;
        Sat, 30 May 2020 09:16:15 -0700 (PDT)
Received: from i7.mricon.com (107-179-243-71.cpe.teksavvy.com. [107.179.243.71])
        by smtp.gmail.com with ESMTPSA id t43sm7340876qtj.85.2020.05.30.09.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2020 09:16:14 -0700 (PDT)
Received: by i7.mricon.com (sSMTP sendmail emulation); Sat, 30 May 2020 12:16:12 -0400
Date:   Sat, 30 May 2020 12:16:12 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Toralf =?utf-8?Q?F=C3=B6rster?= <toralf.foerster@gmx.de>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: fatal: unable to access
 'https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/': SSL
 certificate problem: certificate has expired
Message-ID: <20200530161612.3rz42y5yyulitsdl@chatter.i7.local>
References: <7d5a91f3-e5bd-8410-487d-5cbcd23b174b@gmx.de>
 <8a425b75-cfc7-17b4-3991-63945a855715@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8a425b75-cfc7-17b4-3991-63945a855715@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 30, 2020 at 03:47:19PM +0200, Toralf Förster wrote:
> > $ git pull
> > 15:07:08.488836 git.c:439               trace: built-in: git pull
> > 15:07:08.504295 run-command.c:663       trace: run_command: git fetch --update-head-ok
> > 15:07:08.506481 git.c:439               trace: built-in: git fetch --update-head-ok
> > 15:07:08.516608 run-command.c:663       trace: run_command: GIT_DIR=.git git-remote-https origin https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > fatal: unable to access 'https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/': SSL certificate problem: certificate has expired
> >
> > $ curl https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
> > curl: (60) SSL certificate problem: certificate has expired
> > More details here: https://curl.haxx.se/docs/sslcerts.html
> >
> > curl failed to verify the legitimacy of the server and therefore could not
> > establish a secure connection to it. To learn more about this situation and
> > how to fix it, please visit the web page mentioned above.
> >
> 
> Well, the cert is expired: "notAfter=May 30 10:48:38 2020 GMT"

It's one of the intermediaries. We're replacing that cert right now.

-K
