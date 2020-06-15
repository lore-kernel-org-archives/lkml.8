Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B91C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 19:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36DE2206F1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 19:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="htk/wr9C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730598AbgFOTsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 15:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728773AbgFOTsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 15:48:02 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 232E7C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 12:48:01 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id h185so8275600pfg.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 12:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=4Oo8s/QWbpDZr4xi8KnZTtjTjxYni0MZt8kUBdqu5VI=;
        b=htk/wr9CZhh7BispPYN0l9VEYefTEbe+m8L0DFW6nONI28qvO+rrmIP26yTnZiC3/a
         k4Ikux1aHoXa/ersJeeOcF7JnUJPzvRbqD6TL/KbOP4eiIRbHljHiQZh8MVWtmXf2psL
         ohSsiuU5wZ444dPD08OmkAJXA5gNQcaa9eDk+kWPcKi7ngdGiQNENixxsk29hX5fTUUL
         +2Gr8X6RSpIrB11keBPCFjOOHdo81TEPQe2ps+O2QFOzdthxg0CN4CQ5KKvwRqXkgTq8
         1XWqCHPxD5TYkIYckcywomz/CJaxwdaJX55G2rvP/Lp5+NtjZVki2wm0HwLRLXp6szmO
         qQxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=4Oo8s/QWbpDZr4xi8KnZTtjTjxYni0MZt8kUBdqu5VI=;
        b=VBsd5+ymx1GFVn7gjADjObIEc3OIT8PNco64gHohEnuMZKH4AZmV5m5Rf5xX+AzzIT
         VCcb560MtDOHeZ7eD4FNnO7SwSIGoFSKxa18FVM63Mc/tEESTlMJvh3Tw6NOOVukmgtF
         wdASPPifAKZg8c6WDomHLukpfhJli8Kr5du7xAZLTUoPSgh+stHROmY8cNB5VuClx6um
         D52n4oSWoyP8wzdY67NYLO2Rkf5xtly1lpFvZ6/X1IPDBeDJQurIPeR8YqJmpFNndIR1
         UROqCjE22ZTd9MRYD4JDH5KPrpdPVjkpIGck7IxpFEwbDTCVmGG590hti8gdTxToqZXR
         Cvug==
X-Gm-Message-State: AOAM531By7PPdu5M+GaS3CxUzSFtzxrcNjgG1eZs6wExzfrChHuG9VRr
        9NVidZ1U1AEWRe3Iw38LSDZj6w==
X-Google-Smtp-Source: ABdhPJyYv3MZBadWCVDVlnYUf2Vr8kiWgFeIBjpBACKF3scasoWDd8ocqGpuxr84b/5wRncOObVW8g==
X-Received: by 2002:a62:1951:: with SMTP id 78mr23810321pfz.226.1592250479950;
        Mon, 15 Jun 2020 12:47:59 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id gb4sm297852pjb.6.2020.06.15.12.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 12:47:59 -0700 (PDT)
Date:   Mon, 15 Jun 2020 12:47:58 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Shuah Khan <skhan@linuxfoundation.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, Takashi Iwai <tiwai@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 5.8-rc1 BUG unable to handle page fault (snd_pcm)
In-Reply-To: <446c7a14-db97-6389-a03c-9ffccd251529@linuxfoundation.org>
Message-ID: <alpine.DEB.2.22.394.2006151247140.140801@chino.kir.corp.google.com>
References: <446c7a14-db97-6389-a03c-9ffccd251529@linuxfoundation.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Jun 2020, Shuah Khan wrote:

> I am seeing the following problem on my system. I haven't started debug
> yet. Is this a known issue?
> 
> [    9.791309] BUG: unable to handle page fault for address: ffffb1e78165d000
> [    9.791328] #PF: supervisor write access in kernel mode
> [    9.791330] #PF: error_code(0x000b) - reserved bit violation
> [    9.791332] PGD 23dd5c067 P4D 23dd5c067 PUD 23dd5d067 PMD 22ba8e067 PTE
> 80001a3681509163
> [    9.791337] Oops: 000b [#1] SMP NOPTI
> [    9.791340] CPU: 7 PID: 866 Comm: pulseaudio Not tainted 5.8.0-rc1 #1
> [    9.791341] Hardware name: LENOVO 10VGCTO1WW/3130, BIOS M1XKT45A 08/21/2019
> [    9.791346] RIP: 0010:__memset+0x24/0x30
> [    9.791348] Code: cc cc cc cc cc cc 0f 1f 44 00 00 49 89 f9 48 89 d1 83 e2
> 07 48 c1 e9 03 40 0f b6 f6 48 b8 01 01 01 01 01 01 01 01 48 0f af c6 <f3> 48
> ab 89 d1 f3 aa 4c 89 c8 c3 90 49 89 f9 40 88 f0 48 89 d1 f3
> [    9.791350] RSP: 0018:ffffb1e7817a7dd0 EFLAGS: 00010216
> [    9.791352] RAX: 0000000000000000 RBX: ffff97b32dfd7400 RCX:
> 00000000000008a0
> [    9.791354] RDX: 0000000000000000 RSI: 0000000000000000 RDI:
> ffffb1e78165d000
> [    9.791356] RBP: ffffb1e7817a7e00 R08: ffffb1e780000000 R09:
> ffffb1e78165d000
> [    9.791358] R10: ffffffffffffffff R11: ffffb1e78165d000 R12:
> 0000000000000000
> [    9.791359] R13: ffff97b32dfd3000 R14: ffffffffc0b48880 R15:
> ffff97b33aa42600
> [    9.791361] FS:  00007fa11cb34ec0(0000) GS:ffff97b33edc0000(0000)
> knlGS:0000000000000000
> [    9.791363] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    9.791365] CR2: ffffb1e78165d000 CR3: 0000000210db6000 CR4:
> 00000000003406e0
> [    9.791367] Call Trace:
> [    9.791377]  ? snd_pcm_hw_params+0x3ca/0x440 [snd_pcm]
> [    9.791383]  snd_pcm_common_ioctl+0x173/0xf20 [snd_pcm]
> [    9.791389]  ? snd_ctl_ioctl+0x1c5/0x710 [snd]
> [    9.791394]  snd_pcm_ioctl+0x27/0x40 [snd_pcm]
> [    9.791398]  ksys_ioctl+0x9d/0xd0
> [    9.791400]  __x64_sys_ioctl+0x1a/0x20
> [    9.791404]  do_syscall_64+0x49/0xc0
> [    9.791406]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [    9.791408] RIP: 0033:0x7fa11d4c137b
> [    9.791410] Code: Bad RIP value.

Hi Shuah, do you have CONFIG_AMD_MEM_ENCRYPT enabled?

If so, could you try 
http://git.infradead.org/users/hch/dma-mapping.git/commitdiff/dbed452a078d56bc7f1abecc3edd6a75e8e4484e
