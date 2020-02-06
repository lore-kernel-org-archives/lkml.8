Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBF54C33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 15:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C33AE2465D
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 15:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="yqZ/FZfL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbgBFP1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 10:27:09 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:42299 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbgBFP1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 10:27:08 -0500
Received: by mail-qk1-f194.google.com with SMTP id q15so5887758qke.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 07:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XZOggLanx1OakxhbvmLypkwLB6o7BwYbW0LP99Ryt1o=;
        b=yqZ/FZfL7rzCP/2Jqs5bBr0b3LqQr+WLoYGIPyBGKw6323lJiZKUFKys6E+VHeTJf2
         Q6Piw50B5YbifhP9CblDm+U1GrvZEKZfGAIM/WgHxJp8L+nPX03q6D8VELhZ9R6NOLtJ
         0N0BATZjWI1IczjjfHIveuTCnUgMe+YptD0IpellozuQtXZMs1KXJDOQoRD808ussEVS
         Oeq1YPf/gA/4zQLcWiJBTPhyXQkV4fdKw2VzJoUCEkl+iDXax7CtlZ/cnhsc9SesEK6s
         rSpSpV2Ot3fvi+Ga5GgVIr1vsjh5V4Ifnz9qtatPI8rzuX97IK5IffeOowrdFDe+hNk2
         Ak9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XZOggLanx1OakxhbvmLypkwLB6o7BwYbW0LP99Ryt1o=;
        b=CJe6iiFE0a3ekuCySJXGwWSs36KVfqFORpmn3Ro7y6zYbnzvvN9x7z9INfvCcW8sJL
         eeKXu+d0xVtkdydmiwpCxCzKeOaLhkzo6AkxM1flPJ6CzPo+FFj2CE1qI95zu8Q/Z6yF
         4ivmn/fTTNighvhqtPYqNhHrs5LXoRt2D6rt9rbXxzW+rhhov2wqBJZAhsHiNYo2WWPa
         SmwDXy+Z2cNGrt84WwjdcPHZpPvYK89zMimoXu485e4/dFr0oMWiOVHheektoKoRmQIi
         L1qUzLIU2rqTavMVbC7LFcg0C4Yc2SPUA439kDatUXmpmuIvyEpf/HxDfOf4I/CPnONo
         +MQQ==
X-Gm-Message-State: APjAAAXb/1vp7y+iCLwwbaz4pU5Fm4UUmkyiwRCOEwAzsL9mlpJOYZYi
        3FcEojCmG64r9uk6stLHSn33O8+vutE=
X-Google-Smtp-Source: APXvYqwoCWoPoxMsBmJ48AbMG+4iF96O7gepmNsPc8GfJXUuFMj8rT6ge/PsiVIYjdA9hTy/JKrEoQ==
X-Received: by 2002:a05:620a:7f4:: with SMTP id k20mr2931953qkk.483.1581002826313;
        Thu, 06 Feb 2020 07:27:06 -0800 (PST)
Received: from localhost (pool-108-27-252-85.nycmny.fios.verizon.net. [108.27.252.85])
        by smtp.gmail.com with ESMTPSA id b24sm1741820qto.71.2020.02.06.07.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 07:27:05 -0800 (PST)
Date:   Thu, 6 Feb 2020 10:27:04 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Dan Schatzberg <dschatzberg@fb.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        Li Zefan <lizefan@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <linux-mm@kvack.org>
Subject: Re: [PATCH 1/2] mm: Charge current memcg when no mm is set
Message-ID: <20200206152704.GA24735@cmpxchg.org>
References: <20200205223348.880610-1-dschatzberg@fb.com>
 <20200205223348.880610-2-dschatzberg@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205223348.880610-2-dschatzberg@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 02:33:47PM -0800, Dan Schatzberg wrote:
> This modifies the shmem and mm charge logic so that now if there is no
> mm set (as in the case of tmpfs backed loop device), we charge the
> current memcg, if set.
> 
> Signed-off-by: Dan Schatzberg <dschatzberg@fb.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

It's a dependency for 2/2, but it's also an overdue cleanup IMO: it's
always been a bit weird that memalloc_use_memcg() worked for kernel
allocations but was silently ignored for user pages.

This patch establishes a precedence order for who gets charged:

1. If there is a memcg associated with the page already, that memcg is
   charged. This happens during swapin.

2. If an explicit mm is passed, mm->memcg is charged. This happens
   during page faults, which can be triggered in remote VMs (eg gup).

3. Otherwise consult the current process context. If it has configured
   a current->active_memcg, use that. Otherwise, current->mm->memcg.

Thanks Dan
