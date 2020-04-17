Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4BDC2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 18:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFE6720780
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 18:42:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MgTq2g0+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbgDQSmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 14:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728801AbgDQSmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 14:42:01 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530F5C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 11:42:01 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id r14so1473667pfg.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 11:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Ju33b1g72uTAJNdx7tvrGrx42I2+s4vgy+9DTyNsRdk=;
        b=MgTq2g0+QPDr3oesAW/HHVoC/JjUZ5+d9D9oiJIWFpRrCiRXmAsGt/kZStXgTbeynL
         ++nCOqIEuGPy+qXVJ+KcY4od24xU5qFSu0YHHMysmyUrwotgVPo7MianqVterrTWUHoA
         XxuP6zhz0/YU7uK+0VBcevQLi1+hZE9TZgWDGteRTydfYVMV9xVNxZB7vf8Rt7+jf5z8
         lixGSkyHF7OLMpEp8xlwO8DMqAnA5DGS4QoQFSwwrIzDTwZBkGK3X7wNKjkwRk+k/T0a
         yCUNAX/+DXzERd2LtBHKwzAz5O7f7ceX2sZK3pxoPxvUpyyxjGi9VjxPLKF/Fch5at/o
         e6+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Ju33b1g72uTAJNdx7tvrGrx42I2+s4vgy+9DTyNsRdk=;
        b=HVdPk+ahBRfm3jiON6k10iS5U7LUmjks3fzRoqW55pxQHMj3k2wV5VLVdCFDMA3ZMU
         FQdwAH7hH3Z2BhbFz5A22T8lkoR97W5VIcn+8tSILLr0c8wu1huBYo+TUBpPe7QP/5Up
         +frT15bi0aSULj7Qs1x3imOwjlQCOjrHmUEyIABgRo+mKQFWUwCJuZk3HdjRgjuV+LO9
         sJ3IBEjkEu8ht1KA2IMLKp6emX/qJtlq9i0WIk5kEMTfpQfeAdPbiR5Ley7NTt3pKgPb
         Rt8x1JRnOmW3ezyEFSp1PPmZbUi5fgzCYgHEsiGlaR2PadmbQAo1b5ZLEvFG67Yhm1bH
         atkQ==
X-Gm-Message-State: AGi0PubQbnIVqdTjwhwfrirN7QUNKmEzgjIp3ixpUq77X+n6Hqf+KU0A
        0A5mFE8iv0Tn1FVFkRXvnecQsw==
X-Google-Smtp-Source: APiQypJC/aD8pTpMxfxD1DsFucYiSus4dpyYDV3M7HF2NRR9RFgjCECAPHHQoRU+qzU+Mzu87xLoBQ==
X-Received: by 2002:a62:2b05:: with SMTP id r5mr4240532pfr.120.1587148920663;
        Fri, 17 Apr 2020 11:42:00 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id i10sm6730303pfa.166.2020.04.17.11.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 11:41:59 -0700 (PDT)
Date:   Fri, 17 Apr 2020 11:41:59 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Christoph Hellwig <hch@lst.de>
cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Jon Grimm <jon.grimm@amd.com>, Joerg Roedel <joro@8bytes.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Subject: Re: [patch 0/7] unencrypted atomic DMA pools with dynamic
 expansion
In-Reply-To: <20200417071112.GD19153@lst.de>
Message-ID: <alpine.DEB.2.22.394.2004171126240.88048@chino.kir.corp.google.com>
References: <alpine.DEB.2.22.394.2004141700480.68516@chino.kir.corp.google.com> <20200417071112.GD19153@lst.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Apr 2020, Christoph Hellwig wrote:

> So modulo a few comments that I can fix up myself this looks good.  Unless
> you want to resend for some reason I'm ready to pick this up once I open
> the dma-mapping tree after -rc2.
> 

Yes, please do, and thanks to both you and Thomas for the guidance and 
code reviews.

Once these patches take on their final form in your branch, how supportive 
would you be of stable backports going back to 4.19 LTS?

There have been several changes to this area over time, so there are 
varying levels of rework that need to be done for each stable kernel back 
to 4.19.  But I'd be happy to do that work if you are receptive to it.

For rationale, without these fixes, all SEV enabled guests warn of 
blocking in rcu read side critical sections when using drivers that 
allocate atomically though the DMA API that calls set_memory_decrypted().  
Users can see warnings such as these in the guest:

BUG: sleeping function called from invalid context at mm/vmalloc.c:1710
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 3383, name: fio
2 locks held by fio/3383:
 #0: ffff93b6a8568348 (&sb->s_type->i_mutex_key#16){+.+.}, at: ext4_file_write_iter+0xa2/0x5d0
 #1: ffffffffa52a61a0 (rcu_read_lock){....}, at: hctx_lock+0x1a/0xe0
CPU: 0 PID: 3383 Comm: fio Tainted: G        W         5.5.10 #14
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 dump_stack+0x98/0xd5
 ___might_sleep+0x175/0x260
 __might_sleep+0x4a/0x80
 _vm_unmap_aliases+0x45/0x250
 vm_unmap_aliases+0x19/0x20
 __set_memory_enc_dec+0xa4/0x130
 set_memory_decrypted+0x10/0x20
 dma_direct_alloc_pages+0x148/0x150
 dma_direct_alloc+0xe/0x10
 dma_alloc_attrs+0x86/0xc0
 dma_pool_alloc+0x16f/0x2b0
 nvme_queue_rq+0x878/0xc30 [nvme]
 __blk_mq_try_issue_directly+0x135/0x200
 blk_mq_request_issue_directly+0x4f/0x80
 blk_mq_try_issue_list_directly+0x46/0xb0
 blk_mq_sched_insert_requests+0x19b/0x2b0
 blk_mq_flush_plug_list+0x22f/0x3b0
 blk_flush_plug_list+0xd1/0x100
 blk_finish_plug+0x2c/0x40
 iomap_dio_rw+0x427/0x490
 ext4_file_write_iter+0x181/0x5d0
 aio_write+0x109/0x1b0
 io_submit_one+0x7d0/0xfa0
 __x64_sys_io_submit+0xa2/0x280
 do_syscall_64+0x5f/0x250
