Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962FFC2D0E5
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 14:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C3E820787
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 14:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="qoWgKMmx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728107AbgCZObH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 10:31:07 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36801 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgCZObH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 10:31:07 -0400
Received: by mail-qk1-f196.google.com with SMTP id d11so6596432qko.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 07:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OG09KzA4HuO3BOZQKOUcZGEc5bHon2VHvRmMFTk+/XA=;
        b=qoWgKMmxmpHam08hoCe/t+7K2pObYsUEj4WceDC2aYtZWU8vi2g/tN8slLtc3BxjBQ
         pGuuz/h4e4WdyEA4STkS2V20DKT0odYewLHs/KD6Swj+Hjz0EopvGoPjguT9OiHImxgz
         JSNQ4UfzFQLnDG8g0kaJ5JiI+DQgHfZDhV/C+QIVkyHBN6j/fCiN8tQFb1Gn0RXjPl/s
         p1XAl2850NR2WnH+fot1vcN8DkLnIB+aYxYnPX3B9cFQ4/gwFx4nH2GYGeguWFdMTR17
         yhUPE6GdTz0DDJly8bhRXzbabDbpiPZ9fctxKFzaD0nWYgvZ8wshtAgHBcC/gFOmLc3k
         wXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OG09KzA4HuO3BOZQKOUcZGEc5bHon2VHvRmMFTk+/XA=;
        b=LE1g7rfoVrZE+Osjdmir9rGE3LR5OKSm5wCsFfonBfILwZW6bXKuxkRLFRsQd+RmNf
         FwNdFpIaYCl+D/OehdIjjz4yWIBUWMuUpyFRXL0qariqc6H+RyJlgoISIPZXljUM59/y
         WRBAzgKs+yDm9v/P0i6/r+UjbQdfPWvBdHGylJSCtXe2zH43MA50ULuCJHkTxULCdo0Y
         VLSYQWDr/IWEA/gl++O6n8TW+/S9K/kTSfDjicaBGWnkdsT49+jA305KBF0Xrs8pjSkI
         gCZHcfJPRmDR6RWEGF3conmZH0j2g3yK+UwMsSP8z5IpSnG2FbTLSapycrMluD4k4Xlu
         SLiQ==
X-Gm-Message-State: ANhLgQ1eKGGVeydjkuLAJt3s1+nRTFogt7Pri3pLsDJ/J7heYngrpm9Y
        tWN1OTp+H2GIG/Covzpl5tw3CA==
X-Google-Smtp-Source: ADFU+vvGmFJhahNS012z36bU++nM6aRvUkvuLENBAKAt9FwVnPCjAaq50NPPkVV/ZfywFdTOJpV6LA==
X-Received: by 2002:a05:620a:529:: with SMTP id h9mr8463342qkh.142.1585233065063;
        Thu, 26 Mar 2020 07:31:05 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:a9a9])
        by smtp.gmail.com with ESMTPSA id l60sm1700051qtd.35.2020.03.26.07.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 07:31:04 -0700 (PDT)
Date:   Thu, 26 Mar 2020 10:31:02 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     peterz@infradead.org, akpm@linux-foundation.org, mhocko@kernel.org,
        axboe@kernel.dk, mgorman@suse.de, rostedt@goodmis.org,
        mingo@redhat.com, linux-mm@kvack.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] psi: enhance psi with the help of ebpf
Message-ID: <20200326143102.GB342070@cmpxchg.org>
References: <1585221127-11458-1-git-send-email-laoar.shao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585221127-11458-1-git-send-email-laoar.shao@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 26, 2020 at 07:12:05AM -0400, Yafang Shao wrote:
> PSI gives us a powerful way to anaylze memory pressure issue, but we can
> make it more powerful with the help of tracepoint, kprobe, ebpf and etc.
> Especially with ebpf we can flexiblely get more details of the memory
> pressure.
> 
> In orderc to achieve this goal, a new parameter is added into
> psi_memstall_{enter, leave}, which indicates the specific type of a
> memstall. There're totally ten memstalls by now,
>         MEMSTALL_KSWAPD
>         MEMSTALL_RECLAIM_DIRECT
>         MEMSTALL_RECLAIM_MEMCG
>         MEMSTALL_RECLAIM_HIGH
>         MEMSTALL_KCOMPACTD
>         MEMSTALL_COMPACT
>         MEMSTALL_WORKINGSET_REFAULT
>         MEMSTALL_WORKINGSET_THRASHING
>         MEMSTALL_MEMDELAY
>         MEMSTALL_SWAPIO

What does this provide over the events tracked in /proc/vmstats?

Can you elaborate a bit how you are using this information? It's not
quite clear to me from the example in patch #2.

