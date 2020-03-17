Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEAF3C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 16:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B74220738
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 16:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgCQQfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 12:35:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:42914 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbgCQQfo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 12:35:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B3C8EAF84;
        Tue, 17 Mar 2020 16:35:42 +0000 (UTC)
Date:   Tue, 17 Mar 2020 09:34:43 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jason Baron <jbaron@akamai.com>
Cc:     akpm@linux-foundation.org, rpenyaev@suse.de,
        linux-kernel@vger.kernel.org, normalperson@yhbt.net,
        viro@zeniv.linux.org.uk
Subject: Re: [PATCH v2] fs/epoll: make nesting accounting safe for -rt kernel
Message-ID: <20200317163443.o5ffdpkp5t6axsl3@linux-p48b>
References: <20200224163835.08ab964483519052d7c2e39b@linux-foundation.org>
 <1582739816-13167-1-git-send-email-jbaron@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1582739816-13167-1-git-send-email-jbaron@akamai.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Feb 2020, Jason Baron wrote:

>Davidlohr Bueso pointed out that when CONFIG_DEBUG_LOCK_ALLOC is set
>ep_poll_safewake() can take several non-raw spinlocks after disabling
>interrupts. Since a spinlock can block in the -rt kernel, we can't take a
>spinlock after disabling interrupts. So let's re-work how we determine
>the nesting level such that it plays nicely with the -rt kernel.
>
>Let's introduce a 'nests' field in struct eventpoll that records the
>current nesting level during ep_poll_callback(). Then, if we nest again we
>can find the previous struct eventpoll that we were called from and
>increase our count by 1. The 'nests' field is protected by
>ep->poll_wait.lock.
>
>I've also moved the visited field to reduce the size of struct eventpoll
>from 184 bytes to 176 bytes on x86_64 for !CONFIG_DEBUG_LOCK_ALLOC,
>which is typical for a production config.
>
>Reported-by: Davidlohr Bueso <dbueso@suse.de>
>Signed-off-by: Jason Baron <jbaron@akamai.com>

Sorry for the tardy reply. This looks good to me:

Reviewed-by: Davidlohr Bueso <dbueso@suse.de>
