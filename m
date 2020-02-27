Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C6FC3F2C2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 21:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68CA32469F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 21:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582840467;
	bh=s7q7yFV4bfgg69t6DbKqh424gg5IK8W5+fOiHatPHxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lzA12fi2np2DfI+hrMcysvuzbnEf/2GLjnIgSrABuQ1nEd2Ne/9b4uJSoluFaLdxV
	 wHjQzopCbebA/F4YN/dbgEEzK27AqrKllA3FRRHrtjDQMWFbXqQ520j9fSL8sGCXkP
	 gwFPxGfD/pzosR8ETTLIQ9SqVLIy5zHuUDKwIj2U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730059AbgB0Vy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 16:54:26 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:52613 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729773AbgB0VyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 16:54:25 -0500
Received: by mail-pj1-f68.google.com with SMTP id ep11so361884pjb.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 13:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aWQjRfD263PGFSWLYeye9fWJ9nZRg32z3KxjvyDZXrg=;
        b=n2jzjZjwu07thEgJQI35ioymXtHOwXo8lvcLzl9cFm9gu60A2HTlJznoMvuFXNQ8CV
         36QsZg7nba3Am6zK2Id4yKIbCTcENut1Hg88TbIoSAtcn3/KjhnCDfZBfclCx/0LfLqE
         tnXsfFxhkwZ8yjF50zmXsoQUTD1pADesZWJLZsMBC6OCbgxlBpUnbwlY5ZJxOctBtYj0
         L0W8ndd3c6JrSc8LvVIw/OHUHqqXAMuOkM9/qUKkb6RmfFtX3d5FvnVI/aeoA5wNj3sX
         V8okCYs+RH0Jq45Hir6Vt8ysQ44eTJNoV2PUjATwkO6w38gdoqrKcGzxAx9WHTsJ8aKM
         eODQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=aWQjRfD263PGFSWLYeye9fWJ9nZRg32z3KxjvyDZXrg=;
        b=m2GWIJxJIN8bVv/tvE4IKax4l2GJIgmY1pplr1HBXNfXW8/FW36RxJkLft7seRhOh0
         y22PyozwRcFwWRnBzwIDmvAasGpvPNKLYvVEagvxxu/n+1hoHGHZOkxnv+d2raSsR3j1
         dAMbXuMLz+n//a6l4pO4s0soqj4Cqjcjx+tP66le9sRQSLWT5zA7Hwpm7uYnjvFrWlpG
         sOAD/Vpa5ade3DPKqtRyvRVO1eawreF1YidBgTBvk/lLSzQnuFJW+FGm8Myh8MkMISxf
         cN/i4B4pOXNNT6RJOSNz3jkvb7HzVQnz7gmYHy5/cAxKB7GH2BAOSXHDTCionrvoFJxB
         g1ew==
X-Gm-Message-State: APjAAAXzb4tLu/a8oamkKzuYsQqSymZVjqE/f/yG+8Bly55v2EOENOIC
        ++28XF6JrjxvMPXSwz4wtqs=
X-Google-Smtp-Source: APXvYqy3UpbSi7+joaMTcmQ9dyBtZUaB+9jKUOQHTWEJ8rUv4VLKJ85g3UIczW/iruCNAotCfhXwOA==
X-Received: by 2002:a17:902:444:: with SMTP id 62mr751742ple.209.1582840464193;
        Thu, 27 Feb 2020 13:54:24 -0800 (PST)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id t189sm8248302pfd.168.2020.02.27.13.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 13:54:23 -0800 (PST)
Date:   Thu, 27 Feb 2020 13:54:21 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     linux-kernel@vger.kernel.org, boqun.feng@gmail.com,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:ZSMALLOC COMPRESSED SLAB MEMORY ALLOCATOR" 
        <linux-mm@kvack.org>
Subject: Re: [PATCH 11/30] mm/zsmalloc: Add missing annotation for
 migrate_read_unlock()
Message-ID: <20200227215421.GF215068@google.com>
References: <0/30>
 <20200214204741.94112-1-jbi.octave@gmail.com>
 <20200214204741.94112-12-jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200214204741.94112-12-jbi.octave@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 08:47:22PM +0000, Jules Irenge wrote:
> Sparse reports a warning at migrate_read_unlock()()
> 
>  warning: context imbalance in migrate_read_unlock() - unexpected unlock
> 
> The root cause is the missing annotation at migrate_read_unlock()
> Add the missing __releases(&zspage->lock) annotation
> 
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
Acked-by: Minchan Kim <minchan@kernel.org>
