Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFAEC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 22:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 842192084D
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 22:55:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbgIDWzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 18:55:10 -0400
Received: from mx2.suse.de ([195.135.220.15]:39098 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728162AbgIDWzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 18:55:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9936FAB54;
        Fri,  4 Sep 2020 22:55:09 +0000 (UTC)
Date:   Fri, 4 Sep 2020 15:39:20 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     oleg@redhat.com, axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 0/2] tasklist_lock vs get/set priority syscalls
Message-ID: <20200904223920.5bwqyuiw266ypufi@linux-p48b>
References: <20200817003148.23691-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200817003148.23691-1-dave@stgolabs.net>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 16 Aug 2020, Davidlohr Bueso wrote:

>Hi,
>
>This is a (late) update on trying to reduce some of the scope of the tasklist_lock
>for get/setpriority(2) as well as the block io equivalent. This version addresses
>Oleg's previous concerns and incorporates his feedback.
>
>Changes from v1:
>https://lore.kernel.org/lkml/20200512000353.23653-1-dave@stgolabs.net/
>
> - only take the lock for PGID cases.
> - drop bogus PF_EXITING checks (and live with the small exit race).
> - add patch for IOPRIO_WHO_PGRP.
>
>Please consider for v5.10.

Andrew, unless you have any objections, could you please pick these up?

Thanks,
Davidlohr
