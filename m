Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3397FC10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 12:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C8D520873
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 12:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729259AbgCKMYW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 08:24:22 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53866 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729095AbgCKMYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 08:24:22 -0400
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jC0PJ-0001lN-7Q; Wed, 11 Mar 2020 12:24:17 +0000
Date:   Wed, 11 Mar 2020 13:24:16 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian@brauner.io>,
        Oleg Nesterov <oleg@redhat.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        wsd_upstream <wsd_upstream@mediatek.com>
Subject: Re: [PATCH] pid: fix uninitialized var warnings
Message-ID: <20200311122416.p4bz5twufd3kdzqs@wittgenstein>
References: <20200311122049.11589-1-walter-zh.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200311122049.11589-1-walter-zh.wu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 08:20:49PM +0800, Walter Wu wrote:
> Compiling with gcc-9.2.1 points out below warnings. Fix it.
> 
> kernel/pid.c: In function 'alloc_pid':
> kernel/pid.c:180:10: warning: 'retval' may be used uninitialized
> in this function [-Wmaybe-uninitialized]
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Christian Brauner <christian@brauner.io>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Signed-off-by: Walter Wu <walter-zh.wu@mediatek.com>

Thanks. A correct fix for this is already in my tree:
https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/commit/?h=fixes&id=10dab84caf400f2f5f8b010ebb0c7c4272ec5093
(Background is 
 https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/commit/?h=fixes&id=b26ebfe12f34f372cf041c6f801fa49c3fb382c5
 )

 Christian
