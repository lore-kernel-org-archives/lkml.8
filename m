Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D6BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 10:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F414E206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 10:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbgFOKVM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 06:21:12 -0400
Received: from nautica.notk.org ([91.121.71.147]:53115 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728368AbgFOKVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 06:21:09 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 341B6C01C; Mon, 15 Jun 2020 12:21:08 +0200 (CEST)
Date:   Mon, 15 Jun 2020 12:20:53 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Zheng Bin <zhengbin13@huawei.com>
Cc:     ericvh@gmail.com, lucho@ionkov.net,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
Subject: Re: [PATCH RESEND] 9p: Fix memory leak in v9fs_mount
Message-ID: <20200615102053.GA11026@nautica>
References: <20200615012153.89538-1-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200615012153.89538-1-zhengbin13@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Zheng Bin wrote on Mon, Jun 15, 2020:
> v9fs_mount
>   v9fs_session_init
>     v9fs_cache_session_get_cookie
>       v9fs_random_cachetag                     -->alloc cachetag
>       v9ses->fscache = fscache_acquire_cookie  -->maybe NULL
>   sb = sget                                    -->fail, goto clunk
> clunk_fid:
>   v9fs_session_close
>     if (v9ses->fscache)                        -->NULL
>       kfree(v9ses->cachetag)
> 
> Thus memleak happens.
> 
> Signed-off-by: Zheng Bin <zhengbin13@huawei.com>

Thanks, will run tests & queue next weekend

-- 
Dominique
