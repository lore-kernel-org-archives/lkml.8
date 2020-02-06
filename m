Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68336C352A2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 16:32:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44652214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 16:32:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727723AbgBFQc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 11:32:28 -0500
Received: from relay.sw.ru ([185.231.240.75]:36714 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727574AbgBFQc2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 11:32:28 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1izk4j-0008WP-7H; Thu, 06 Feb 2020 19:32:21 +0300
To:     Jens Axboe <axboe@kernel.dk>, LKML <linux-kernel@vger.kernel.org>,
        io-uring@vger.kernel.org
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Subject: io_uring: io_grab_files() misses taking files->count?
Message-ID: <f0d2b7d3-2f6b-7eb2-aee0-4ff6a7daa35c@virtuozzo.com>
Date:   Thu, 6 Feb 2020 19:32:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jens,

in io_grab_files() we take pointer to current->files without taking files->count.
Later, this files become attached to worker in io_worker_handle_work() also without
any manipulation with counter.

But files->count is used for different optimizations. Say, in expand_fdtable() we
avoid synchonize_rcu() in case of there is only files user. In case of there are
more users, missing of synchronize_rcu() is not safe.

Is this correct? Or maybe there is some hidden logic in io_uring, which prevents
this problem? Say, IORING_OP_OPENAT/CLOSE/ETC can't be propagated to worker etc...

Kirill

