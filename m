Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9906C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 10:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFFC42070B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 10:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbgG0Kvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 06:51:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:45294 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbgG0Kvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 06:51:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 76F5FB615;
        Mon, 27 Jul 2020 10:51:59 +0000 (UTC)
Date:   Mon, 27 Jul 2020 12:52:10 +0200
From:   Cyril Hrubis <chrubis@suse.cz>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     kernel test robot <rong.a.chen@intel.com>,
        Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
        LKML <linux-kernel@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@infradead.org>, lkp@lists.01.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        Christoph Hellwig <hch@lst.de>, ltp@lists.linux.it
Subject: Re: [LTP] [blk] 6e6fcbc27e: ltp.fs_fill.fail
Message-ID: <20200727105210.GA12348@yuki.lan>
References: <20200726075511.GI1850@shao2-debian>
 <20200727093156.GA29739@dell5510>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727093156.GA29739@dell5510>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
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

Actually you had removed the most important part, it not only timeouted
but the process ended up stuck in kernel and could not be killed. So
this looks like deadlock somewhere in filesystem code.

-- 
Cyril Hrubis
chrubis@suse.cz
