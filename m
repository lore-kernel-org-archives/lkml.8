Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BBAC5ACD7
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 09:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 806B220772
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 09:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584524544;
	bh=SQTIbCKJ+jpSTrfHDFn1bl4g7K9UMBStlxwazxe/ZV4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Kh1fmPUADTNg/xOZScYmVqJ7AUPGxAbOefm5SfxiV6cFanPdPpB5lEcymdIhxGO2U
	 huD0JM055pT6MMJ4j6+kq+ud53hGSVE0WqvoOkq6hKCvx+pA3iiq88v5Nwhwc5acSV
	 EQbMIjhRhlr9vx2ZKUk1ORhq1dLL8J0dpcpIFeWc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbgCRJmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 05:42:23 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36734 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbgCRJmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 05:42:23 -0400
Received: by mail-wm1-f65.google.com with SMTP id g62so2460439wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 02:42:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ljtseRed9kkl1p0LldSZEtHZ23CStZbRjiW3J11/rXg=;
        b=oJn+BGjGXGXSSPNpPKMNPXWGrT/w5tTU/FjilRJXEmdETT9UBg+kn0YL/PILwnrpY7
         DgDI2LqjY/qH6fwjda7IKItg8lkO0imLN4Ip68O58SFltjfSyt0mLf2slVs3V/yP1guV
         9p49JxfzRxd+Nt+9Prm35YctH5b4GC5ZYougLjKhG9jns8ksw+vD2zUf2frl1dHekXcT
         94xsQ7yzP4aajzce4k2pEOnwZ4sOvyQCxyHntFACsYa3lmTi9JyTudRMtxq2d54vp+oR
         Tk87oM1zxZEllj5VY3XnBwCWfnpGWejuKxu98X6112kgIWOD5ly/Fx9iH/6+0yMg3N/a
         3V0w==
X-Gm-Message-State: ANhLgQ2qlRWsg+vvpV6bee8i2wfcDk8GwvdRNk4EGiyoeLKIGjcopazA
        y+P/PvthgOkkvYg0M7+uw8k=
X-Google-Smtp-Source: ADFU+vvP3LS0LaEjrw/WAD9Qk7RHGbGtBAt4Jjsh8GMY5tqbX5OV2LjVXH2YVK16i3+uApOFqMuWmg==
X-Received: by 2002:a1c:491:: with SMTP id 139mr4410440wme.21.1584524541504;
        Wed, 18 Mar 2020 02:42:21 -0700 (PDT)
Received: from localhost (ip-37-188-180-89.eurotel.cz. [37.188.180.89])
        by smtp.gmail.com with ESMTPSA id q9sm2636789wmg.41.2020.03.18.02.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 02:42:20 -0700 (PDT)
Date:   Wed, 18 Mar 2020 10:42:19 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Vlastimil Babka <vbabka@suse.cz>,
        Robert Kolchmeyer <rkolchmeyer@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch v2] mm, oom: prevent soft lockup on memcg oom for UP
 systems
Message-ID: <20200318094219.GE21362@dhcp22.suse.cz>
References: <8395df04-9b7a-0084-4bb5-e430efe18b97@i-love.sakura.ne.jp>
 <alpine.DEB.2.21.2003161648370.47327@chino.kir.corp.google.com>
 <202003170318.02H3IpSx047471@www262.sakura.ne.jp>
 <alpine.DEB.2.21.2003162107580.97351@chino.kir.corp.google.com>
 <alpine.DEB.2.21.2003171752030.115787@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2003171752030.115787@chino.kir.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 17-03-20 17:55:04, David Rientjes wrote:
> When a process is oom killed as a result of memcg limits and the victim
> is waiting to exit, nothing ends up actually yielding the processor back
> to the victim on UP systems with preemption disabled.  Instead, the
> charging process simply loops in memcg reclaim and eventually soft
> lockups.

It seems that my request to describe the setup got ignored. Sigh.

> Memory cgroup out of memory: Killed process 808 (repro) total-vm:41944kB, 
> anon-rss:35344kB, file-rss:504kB, shmem-rss:0kB, UID:0 pgtables:108kB 
> oom_score_adj:0
> watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [repro:806]
> CPU: 0 PID: 806 Comm: repro Not tainted 5.6.0-rc5+ #136
> RIP: 0010:shrink_lruvec+0x4e9/0xa40
> ...
> Call Trace:
>  shrink_node+0x40d/0x7d0
>  do_try_to_free_pages+0x13f/0x470
>  try_to_free_mem_cgroup_pages+0x16d/0x230
>  try_charge+0x247/0xac0
>  mem_cgroup_try_charge+0x10a/0x220
>  mem_cgroup_try_charge_delay+0x1e/0x40
>  handle_mm_fault+0xdf2/0x15f0
>  do_user_addr_fault+0x21f/0x420
>  page_fault+0x2f/0x40
> 
> Make sure that once the oom killer has been called that we forcibly yield 
> if current is not the chosen victim regardless of priority to allow for 
> memory freeing.  The same situation can theoretically occur in the page 
> allocator, so do this after dropping oom_lock there as well.

I would have prefered the cond_resched solution proposed previously but
I can live with this as well. I would just ask to add more information
to the changelog. E.g.
"
We used to have a short sleep after the oom handling but 9bfe5ded054b
("mm, oom: remove sleep from under oom_lock") has removed it because
sleep inside the oom_lock is dangerous. This patch restores the sleep
outside of the lock.
"
> Suggested-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> Tested-by: Robert Kolchmeyer <rkolchmeyer@google.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: David Rientjes <rientjes@google.com>
> ---
>  mm/memcontrol.c | 2 ++
>  mm/page_alloc.c | 2 ++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1576,6 +1576,8 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	 */
>  	ret = should_force_charge() || out_of_memory(&oc);
>  	mutex_unlock(&oom_lock);
> +	if (!fatal_signal_pending(current))
> +		schedule_timeout_killable(1);

Check for fatal_signal_pending is redundant.

-- 
Michal Hocko
SUSE Labs
