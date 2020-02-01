Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD17C33CB3
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 16:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2AAB206E6
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 16:33:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgBAQd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Feb 2020 11:33:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:57026 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726622AbgBAQd0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Feb 2020 11:33:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8049AADE2;
        Sat,  1 Feb 2020 16:33:24 +0000 (UTC)
Date:   Sat, 1 Feb 2020 08:23:05 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, will@kernel.org, oleg@redhat.com,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, juri.lelli@redhat.com, williams@redhat.com,
        bristot@redhat.com, longman@redhat.com, jack@suse.com
Subject: Re: [PATCH -v2 0/7] locking: Percpu-rwsem rewrite
Message-ID: <20200201162305.tc4m4kv3fkc6ixob@linux-p48b>
References: <20200131150703.194229898@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200131150703.194229898@infradead.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Jan 2020, Peter Zijlstra wrote:

>Hi all,
>
>This is the long awaited report of the percpu-rwsem rework (sorry Juri).
>
>IIRC (I really have trouble keeping up momentum on this series) I've addressed
>all previous comments by Oleg and Davidlohr and Waiman and hope we can stick
>this in tip/locking/core for inclusion in the next merge.
>
>It has been cooked (thoroughly) in PREEMPT_RT, and not found wanting.
>
>Any objections to me stuffing it in so we can all forget about it properly?

Feel free to add my:

Reviewed-by: Davidlohr Bueso <dbueso@suse.de>

Thanks,
Davidlohr
