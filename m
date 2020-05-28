Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C556C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 09:05:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75C902145D
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 09:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590656725;
	bh=SSOXeyUfnzlwYw9KF5SUzb/9cU0KvOUKPrY9OD21x9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gHFzCTip3rRtCo+UgIlr8dEFxgYD5B8iYNlj0LoumSwc5nfuNS1NicV1iVlMycJxq
	 uDysko2Feb23zc7clHMsR1lqVX56xgMHSNUkRISCmfL+NYSgGt+RohHzggdqFo5MNt
	 kkT72gj17LZbAB7WEnC15aJtQQ7z49onz0yiGyrY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbgE1JFY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 05:05:24 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:42333 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728028AbgE1JFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 05:05:23 -0400
Received: by mail-ej1-f66.google.com with SMTP id k11so6022977ejr.9
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 02:05:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/vaqLjNbs4piNK8cHlXi2gJftHYymCTgiDe8fspLXcw=;
        b=ACDAeF71BZX0fh2EItmHAyVTRynLVfWfpToJkKLw3aRrrTvCzOS32glO3uJ1pHB3Pg
         8Gp7eG8dhijq5Ya3ZvlDDlrZxmINfGDZ77a1LL/XqN9iC2AvWhqrEOuFoA1scwS++pkf
         +vJTk8ZoJoIYR5EkMJzysJIaZPSaSwIRclH3wG0ks90vh3cJEhU3ZODMr7bSOMzoeBE8
         UhNCZi2oF48+TVc0sg4+2lDyFZRcs+/Q7WxZ/s6tgl+R7cbwJthDbfcf7Y2QfpBP0Ns2
         n0Tc40haItetWBTIEuuFbezrD2/HkT9q1lQT92lLYOxPaMwdb7VK65h7+BaNJ4XDgvHx
         z1Wg==
X-Gm-Message-State: AOAM532ppsft7llK6kO1aLTRvqueE4I3vyAD7mkpdEjFW44PzmsctPPK
        j/pWVZRpZD1ERJMEihphGRM=
X-Google-Smtp-Source: ABdhPJwq6tD4O0trcWGRjfLio769XDUhV7qoG+YbP4wCCZ+7K+Gtl8VzA/n45+sr+G24aaA2R77mwA==
X-Received: by 2002:a17:906:7b52:: with SMTP id n18mr2124539ejo.292.1590656721457;
        Thu, 28 May 2020 02:05:21 -0700 (PDT)
Received: from localhost (ip-37-188-185-40.eurotel.cz. [37.188.185.40])
        by smtp.gmail.com with ESMTPSA id r2sm1332714ejs.94.2020.05.28.02.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 02:05:19 -0700 (PDT)
Date:   Thu, 28 May 2020 11:05:17 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@osdl.org>, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com
Subject: Re: next-20200515: Xorg killed due to "OOM"
Message-ID: <20200528090517.GA27484@dhcp22.suse.cz>
References: <20200526091054.GA12103@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526091054.GA12103@amd>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 26-05-20 11:10:54, Pavel Machek wrote:
[...]
> [38617.276517] oom_reaper: reaped process 31769 (chromium), now anon-rss:0kB, file-rss:0kB, shmem-rss:7968kB
> [38617.277232] Xorg invoked oom-killer: gfp_mask=0x0(), order=0, oom_score_adj=0
> [38617.277247] CPU: 0 PID: 2978 Comm: Xorg Not tainted 5.7.0-rc5-next-20200515+ #117
> [38617.277256] Hardware name: LENOVO 17097HU/17097HU, BIOS 7BETD8WW (2.19 ) 03/31/2011
> [38617.277266] Call Trace:
> [38617.277286]  dump_stack+0x54/0x6e
> [38617.277300]  dump_header+0x45/0x321
> [38617.277313]  oom_kill_process.cold+0x9/0xe
> [38617.277324]  ? out_of_memory+0x167/0x420
> [38617.277336]  out_of_memory+0x1f2/0x420
> [38617.277348]  pagefault_out_of_memory+0x34/0x56
> [38617.277361]  mm_fault_error+0x4a/0x130
> [38617.277372]  do_page_fault+0x3ce/0x416

The reason the OOM killer has been invoked is that the page fault
handler has returned VM_FAULT_OOM. So this is not a result of the page
allocator struggling to allocate a memory. It would be interesting to
check which code path has returned this. 
-- 
Michal Hocko
SUSE Labs
