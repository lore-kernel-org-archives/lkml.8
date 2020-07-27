Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44228C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 15:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FD4920672
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 15:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bxpXFkKe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729766AbgG0POm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 11:14:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:29887 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728711AbgG0POl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 11:14:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595862880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a2iihc1HWAJriXV+8/xi93MCdLbyiJT8cN8MK6IDGnQ=;
        b=bxpXFkKehZV352XwKr5ldfC1K6vaq6j48OjnFLCsRkRhSIVYEH0L1axmweWUws0qNQxfKW
        HUUUrbWGwt+rq7cqEMQvDWezIY1H2uoyVrLOryZujVjRZM2yj4UsRW7395K2Aplc2oeQ4s
        DdVG5osze+SPQshqwSjcQPdSLyHtf+A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-2KTziDVCMn-lEWAW22M7jA-1; Mon, 27 Jul 2020 11:14:36 -0400
X-MC-Unique: 2KTziDVCMn-lEWAW22M7jA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73B35193248A;
        Mon, 27 Jul 2020 15:14:32 +0000 (UTC)
Received: from T590 (ovpn-12-208.pek2.redhat.com [10.72.12.208])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 916045C1C3;
        Mon, 27 Jul 2020 15:14:21 +0000 (UTC)
Date:   Mon, 27 Jul 2020 23:14:16 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>, lkp@lists.01.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        Christoph Hellwig <hch@lst.de>, ltp@lists.linux.it
Subject: Re: [LTP] [blk] 6e6fcbc27e: ltp.fs_fill.fail
Message-ID: <20200727151416.GA1298062@T590>
References: <20200726075511.GI1850@shao2-debian>
 <20200727093156.GA29739@dell5510>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727093156.GA29739@dell5510>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 11:31:56AM +0200, Petr Vorel wrote:
> Hi,
> 
> > FYI, we noticed the following commit (built with gcc-9):
> 
> > commit: 6e6fcbc27e7788af54139c53537395d95560f2ef ("blk-mq: support batching dispatch in case of io")
> > https://git.kernel.org/cgit/linux/kernel/git/axboe/linux-block.git for-5.9/drivers
> 
> 
> > in testcase: ltp
> > with following parameters:
> 
> > 	disk: 1HDD
> > 	fs: ext4
> > 	test: fs-03
> 
> > test-description: The LTP testsuite contains a collection of tools for testing the Linux kernel and related features.
> > test-url: http://linux-test-project.github.io/
> 
> 
> > on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> ...
> > tst_test.c:1308: INFO: Testing on vfat
> > tst_mkfs.c:90: INFO: Formatting /dev/loop0 with vfat opts='' extra opts=''
> > tst_test.c:1247: INFO: Timeout per run is 0h 05m 00s
> > fs_fill.c:103: INFO: Running 10 writer threads
> > Test timeouted, sending SIGKILL!
> > Test timeouted, sending SIGKILL!
> > Test timeouted, sending SIGKILL!
> > Test timeouted, sending SIGKILL!
> > Test timeouted, sending SIGKILL!
> > Test timeouted, sending SIGKILL!
> The only "error" I found is that fs_fill test timeouted on vfat. That might
> indicate some problems. Note, for slow machines, there is LTP_TIMEOUT_MUL
> https://github.com/linux-test-project/ltp/wiki/User-Guidelines#1-library-environment-variables

I have run fs_fill test for a while, and can't reproduce it, and I am
sure vfat is covered.



Thanks,
Ming

