Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A375C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 19:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1525720724
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 19:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="ob0DSsT4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgHUTyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 15:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726749AbgHUTyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 15:54:38 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2A63C0613ED
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 12:54:37 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id v9so3143212ljk.6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 12:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JXmwu9P/D+knwsCeno9ESPy91dSSF4OAlwClgxTnACM=;
        b=ob0DSsT44/7x567v9uK91b3SmCLwG+sNCviIRwJ3sfFiUfGop+LssO/cehC29M7u2x
         W7OaPIztIq+m6WrOOq++7Qpqbqoz6m9iBmeUESeqyL1UGxX2TmGQVNQQ595TfSGZVhVE
         9uq0WPucSG9KV/8qsEwWKtwrv3pZRYu7/xUTIOxF8paOu0OBtFdEzROVnOTZfIRZH5+K
         5BNwYHkToyQ4Xv6RJTKL9pgkHBRT9LmVg3ybRd+X+f1VnAUNOBneEEtHCp61FGtbf1r3
         KlZmkf0B57ADsn1SHxuHVbaHemMMZQE/0woxKdO1PR580KcERa9uXXKTE1dyg4thOMp2
         4O/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JXmwu9P/D+knwsCeno9ESPy91dSSF4OAlwClgxTnACM=;
        b=L4oa3AP0kcwEovgVpoVqkwR6dlKMY5tSi2TxP3xZVbzLmmHzTL+ydnI1Zss/yafFbi
         bVlEY1unIL42lV3f5jx4+m/JGmDZsgQTeN/98d+cB7ESqj/A9TnWOxOP61iZq/kZwCox
         xDbXAe1oPoNmYZQXimCrc06TLCMUs5AkjCXcUnDUMeFIlvdMJQfnjJZ5Q4nVj4yLYnTs
         jFkI3zEwjqGa6p+oWz1NGSygQClu/jT/DZYgDKhpmbKojNhhEDcFT5bOLH2A5dD5JRl7
         kECartNqMMphmXuIuikZmKQbUZveDqB4xVQ1PXr+MmPVUHroPVN2qsXhG2EdY/T96bfW
         Arkw==
X-Gm-Message-State: AOAM533t6VEx4iAeyxFfeDtw1uOUG7grsSnUOSxkTCiIvADistfiNoOF
        ErWAYMAknRdyXH+OR9ZbmktTrg==
X-Google-Smtp-Source: ABdhPJxxFG7xLfrJKFZW1kB4VEo7fEoqDxxDcjYOPmRx4Z8yex/U8wHLSQr6ij8uIyQdQWtL4NcnbA==
X-Received: by 2002:a05:651c:294:: with SMTP id b20mr2128384ljo.4.1598039676363;
        Fri, 21 Aug 2020 12:54:36 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id u21sm576779ljl.11.2020.08.21.12.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 12:54:35 -0700 (PDT)
Date:   Fri, 21 Aug 2020 11:49:10 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Jens Wiklander <jens.wiklander@linaro.org>
List-Id: <soc.lore.kernel.org>
Cc:     arm@kernel.org, soc@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        tee-dev@lists.linaro.org, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [GIT PULL] tee subsystem pin_user_pages for v5.8
Message-ID: <20200821184910.GB3407@lx2k>
References: <20200526131259.GA97001@jade>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526131259.GA97001@jade>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 03:12:59PM +0200, Jens Wiklander wrote:
> Hello arm-soc maintainers,
> 
> Please pull this small patch converting the tee subsystem to use
> pin_user_pages() instead of get_user_pages().
> 
> Thanks,
> Jens
> 
> The following changes since commit ae83d0b416db002fe95601e7f97f64b59514d936:
> 
>   Linux 5.7-rc2 (2020-04-19 14:35:30 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.linaro.org:/people/jens.wiklander/linux-tee.git tags/tee-pin-user-pages-for-5.8
> 
> for you to fetch changes up to 37f6b4d5f47b600ec4ab6682c005a44a1bfca530:
> 
>   tee: convert get_user_pages() --> pin_user_pages() (2020-05-26 10:42:41 +0200)

Hi, I noticed this never got merged, but I don't see any follow-up here that
retracts it. Is it still pending merge such that I should queue it for v5.10?


-Olof
