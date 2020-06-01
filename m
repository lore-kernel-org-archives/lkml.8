Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265ADC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF4C4206A4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591003909;
	bh=uJSNUkNV60ALdGq4VZSf0hyg9yQS5TMJ9qk2pChZ39A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S6VnaKMHyoEmb/UabKtWZg/TavW2e50NmS8jed2Is0oimmpS8OmH6ceilpNQvxt+q
	 BuqiffK2X4mGkecdVJz7cBvxlqAWGpqGO5oZ6MYAqVB/EiMxr/tRHoQ1EkgNvtimjo
	 aOklK+kRmpvOjOrDIn5Qe6AHwgqWjnonkQ20VOFc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbgFAJbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 05:31:48 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36442 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725290AbgFAJbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:31:47 -0400
Received: by mail-wr1-f65.google.com with SMTP id q11so10820239wrp.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 02:31:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Aed0KpZa+n6oM+Y9/I8ZaZIih3OG/g+XsWiovI6NGqw=;
        b=gpISvJtwlpn43LVCPZzvlfr4yRfUiH68FftVVyOSp+dWD1mq3mF1G+EWxl8j36n6Oz
         5HfgFgEyW7X1L1w9Ig93aeqxVbWJh8DENJDiA+i1OSU/bLwAprkfzreOFg12ws2Y6esW
         4D3yiaSzJxRlJ2S95437sTb9o6YOKT+9MmV7LG0h0C+G5pA4I0bZlOvTMTMtK3OPUscF
         eqm1DiFFqfXzYdwxa5GifFS8eR8A11AScjYHvTeEZG4SLY1yzJaQZvpwLgxllBOsZRXB
         PzxezMbxMD91yS4yfZMjeWRAvEjlBDMHyqftCB6RRsdA7RIO0gQ/QdpRI5u6SCOcubZw
         Xtpg==
X-Gm-Message-State: AOAM531/EQ1YOfE6sdEoomlLngAZ5EBp3xNYfMzAN8lZ4wmGUCKGpvPy
        +GPWCcZ6aiFA1caG7Hm4oQc=
X-Google-Smtp-Source: ABdhPJyNRSkjW3exixOApKgLqXfkA+TPWPp2VUJc1IXLtetyf1hcrTpaqzjXBbn/FyFfHL9NEXFW/A==
X-Received: by 2002:a5d:484b:: with SMTP id n11mr21256376wrs.356.1591003905547;
        Mon, 01 Jun 2020 02:31:45 -0700 (PDT)
Received: from localhost (ip-37-188-178-109.eurotel.cz. [37.188.178.109])
        by smtp.gmail.com with ESMTPSA id u13sm10152697wmm.6.2020.06.01.02.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 02:31:44 -0700 (PDT)
Date:   Mon, 1 Jun 2020 11:31:42 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com
Subject: Re: next-20200515: Xorg killed due to "OOM"
Message-ID: <20200601093142.GE1161@dhcp22.suse.cz>
References: <20200526091054.GA12103@amd>
 <20200528090517.GA27484@dhcp22.suse.cz>
 <20200528120354.GB22054@duo.ucw.cz>
 <20200528120750.GC27484@dhcp22.suse.cz>
 <20200531121601.GA14196@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200531121601.GA14196@duo.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 31-05-20 14:16:01, Pavel Machek wrote:
> On Thu 2020-05-28 14:07:50, Michal Hocko wrote:
> > On Thu 28-05-20 14:03:54, Pavel Machek wrote:
> > > On Thu 2020-05-28 11:05:17, Michal Hocko wrote:
> > > > On Tue 26-05-20 11:10:54, Pavel Machek wrote:
> > > > [...]
> > > > > [38617.276517] oom_reaper: reaped process 31769 (chromium), now anon-rss:0kB, file-rss:0kB, shmem-rss:7968kB
> > > > > [38617.277232] Xorg invoked oom-killer: gfp_mask=0x0(), order=0, oom_score_adj=0
> > > > > [38617.277247] CPU: 0 PID: 2978 Comm: Xorg Not tainted 5.7.0-rc5-next-20200515+ #117
> > > > > [38617.277256] Hardware name: LENOVO 17097HU/17097HU, BIOS 7BETD8WW (2.19 ) 03/31/2011
> > > > > [38617.277266] Call Trace:
> > > > > [38617.277286]  dump_stack+0x54/0x6e
> > > > > [38617.277300]  dump_header+0x45/0x321
> > > > > [38617.277313]  oom_kill_process.cold+0x9/0xe
> > > > > [38617.277324]  ? out_of_memory+0x167/0x420
> > > > > [38617.277336]  out_of_memory+0x1f2/0x420
> > > > > [38617.277348]  pagefault_out_of_memory+0x34/0x56
> > > > > [38617.277361]  mm_fault_error+0x4a/0x130
> > > > > [38617.277372]  do_page_fault+0x3ce/0x416
> > > > 
> > > > The reason the OOM killer has been invoked is that the page fault
> > > > handler has returned VM_FAULT_OOM. So this is not a result of the page
> > > > allocator struggling to allocate a memory. It would be interesting to
> > > > check which code path has returned this. 
> > > 
> > > Should the core WARN_ON if that happens and there's enough memory, or
> > > something like that?
> > 
> > I wish it would simply go away. There shouldn't be really any reason for
> > VM_FAULT_OOM to exist. The real low on memory situation is already
> > handled in the page allocator.
> 
> Umm. Maybe the WARN_ON is first step in that direction? So we can see
> what driver actually did that, and complain to its authors?

This is much harder done than it seems. But maybe this doesn't really
need a full coverage. Some of the code paths which return VM_FAULT_OOM
will simply not fail. But checking for vma->vm_ops->fault() failures
might be interesting. Does the following tell you more about the failure
you can see

diff --git a/mm/memory.c b/mm/memory.c
index 9ab00dcb95d4..5ff023ab7b49 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3442,8 +3442,11 @@ static vm_fault_t __do_fault(struct vm_fault *vmf)
 
 	ret = vma->vm_ops->fault(vmf);
 	if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE | VM_FAULT_RETRY |
-			    VM_FAULT_DONE_COW)))
+			    VM_FAULT_DONE_COW))) {
+		if (unlikely(ret & VM_FAULT_OOM))
+			pr_warn("VM_FAULT_OOM returned from %ps\n", vma->vm_ops->fault);
 		return ret;
+	}
 
 	if (unlikely(PageHWPoison(vmf->page))) {
 		if (ret & VM_FAULT_LOCKED)

-- 
Michal Hocko
SUSE Labs
