Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC00C3F2C2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 21:53:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC5DE246A2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 21:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582840384;
	bh=lmuF2usYvPwgBiy7m/ddx0T0+Q46dPbQkAUTaKMr60c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=M1obivX/U70AWpydaC08XYSCPx6bPvZxXDdfHJb8u1gGi2gF7TYIKLcQv2S8ipPjN
	 GxTEwEHohuqI9zRBPDf5aJhgWIlGum9qLipuWzwnr7o1+NsnI6AFW7h1HgWpBhHT/a
	 mw9HhLWrf7tLJ8oMjiAKGtc5XAmWG9vspTxAJ2DE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730085AbgB0VxD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 16:53:03 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:35902 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729661AbgB0VxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 16:53:03 -0500
Received: by mail-pj1-f66.google.com with SMTP id gv17so364788pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 13:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a8tz7pn6WYS1zSkKOSE65k1PsuDxpcFOThMRyfGsXzE=;
        b=MfQRdUQKcxxCrSC/WgIvIRxxrgpxV4pEVJPD3KSrjnKCyYy1DtH9YuIfwvrtkZ0rkk
         e4esIL0/td3cexwfwTcB+MjGYmUdyP2PENKFZHJXLbZ8P5sU2fQUWPMaAQNctsOmX/dn
         AGGGt2bWXaZ764Yldgf2q8QPMh3XvoJ+g+TgeVups/3GdaMKbXMo0HgCmxzqY1FTvObw
         ZS21j2nQUsw3IBJ/8oLQ0Ft4UE0vlIXUbL8hA6mFMLKAUbJi+Q1PvnSb6F7+9CIIG1yA
         n6d796AOcxL/rwXWH4RzSJPusTkXOFxW3IfwCAkvkkeZes83mGpiJDZkhS5JoMG+7JAG
         GIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=a8tz7pn6WYS1zSkKOSE65k1PsuDxpcFOThMRyfGsXzE=;
        b=rZ7qtIAwYBMTWyB3wE1zBPEazhnEkkeoOETMymv3TmGvLU3aBX4OVrG1oaHKxxEwx8
         VlNmci7FKfYa4zEw35U7+tfs2ROA/0iUqyZeAhDXQJbtMzijlSUA44EgvB/7WmDNXEVx
         i4r8BdK/0mJbKpWsHN3//d/9wQP25inTPOk0l4ZRQFNxRmQcsakDffsEb072e9tbu5aU
         NqAynBKn9t4Oneohzdq1z5W+QedSzC9W0D1TqT0WGLNU2tbHQBg+T8EC8/6cSMnPUTZJ
         1apJkIPvHkyvuM+vujRVYgC+dOaKFajsa7B0vjHrLsx89PUkSIYfuNgMdt0Ay01IgkKS
         yRrw==
X-Gm-Message-State: APjAAAWin7lT/HT0/sCUuHcB9ygafI+dMvv35IRJ1qQcdCzYRQrsNULc
        VRCDVqcZ2l+IwIrlH8qPEMc=
X-Google-Smtp-Source: APXvYqyBBSbhpwNl/y+B0CAz1QiXE9Xx9EaqVrkHv47pjZ+aPpztqa7IRVjA8W5qXes4DslEDVWfpw==
X-Received: by 2002:a17:902:b718:: with SMTP id d24mr896192pls.80.1582840382216;
        Thu, 27 Feb 2020 13:53:02 -0800 (PST)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id d4sm7399843pjg.19.2020.02.27.13.53.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 13:53:01 -0800 (PST)
Date:   Thu, 27 Feb 2020 13:52:59 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     linux-kernel@vger.kernel.org, boqun.feng@gmail.com,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:ZSMALLOC COMPRESSED SLAB MEMORY ALLOCATOR" 
        <linux-mm@kvack.org>
Subject: Re: [PATCH 10/30] mm/zsmalloc: Add missing annotation for
 migrate_read_lock()
Message-ID: <20200227215259.GC215068@google.com>
References: <0/30>
 <20200214204741.94112-1-jbi.octave@gmail.com>
 <20200214204741.94112-11-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214204741.94112-11-jbi.octave@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 08:47:21PM +0000, Jules Irenge wrote:
> Sparse reports a warning at migrate_read_lock()()
> 
>  warning: context imbalance in migrate_read_lock() - wrong count at exit
> 
> The root cause is the missing annotation at migrate_read_lock()
> Add the missing __acquires(&zspage->lock) annotation
> 
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
Acked-by: Minchan Kim <minchan@kernel.org>
