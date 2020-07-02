Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB578C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 17:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E32520885
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 17:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593709369;
	bh=bDQl5qvzxkTi9ZCnxC0GowCAYQCv6zA9MuDUFOcZCJo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=WrRddvswY9D9PKSUCmI3k8f1brrEHnG14L4Z0iikTyloW7tKQwbHm/qXtGAW0XLGL
	 KvC0Zb0DLSSO7E3sRkPpxGsFWcfBwvLIrmMFpNAvvFQqzy9XSTPESP2pLwWln7oXP+
	 hPaVhLWmjsQnRuUzoNXVnOkd6VF3Hvevy7Xtp4cc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgGBRCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 13:02:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:32856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726754AbgGBRCs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 13:02:48 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6F027206E2;
        Thu,  2 Jul 2020 17:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593709367;
        bh=bDQl5qvzxkTi9ZCnxC0GowCAYQCv6zA9MuDUFOcZCJo=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=dNHu7uwwlByzYKVhuYPFATnwTsNThKdOicvR2SDQ5sqxC1EWT2ma5t6qetH3p5nXQ
         s30IMGZp9b36Ba7H/OPmmq07+r9roQWe5oYdftQXYo63br5zauxZdJEVDvmQCr0g97
         YRk1iV7hPxB+jvIsmUlzIoOEFbcGvy9uRoUxrnz4=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 589AE3523164; Thu,  2 Jul 2020 10:02:47 -0700 (PDT)
Date:   Thu, 2 Jul 2020 10:02:47 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Hulk Robot <hulkci@huawei.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] scftorture: Make symbol 'scf_torture_rand' static
Message-ID: <20200702170247.GS9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200702144700.3602-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702144700.3602-1-weiyongjun1@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 10:47:00PM +0800, Wei Yongjun wrote:
> Fix sparse build warning:
> 
> kernel/scftorture.c:124:1: warning:
>  symbol '__pcpu_scope_scf_torture_rand' was not declared. Should it be static?
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Good catch, applied, thank you!

Due to recent changes, I hand-applied this as shown below.  Please
let me know if I messed anything up.

							Thanx, Paul

------------------------------------------------------------------------

commit ff9210137b0b8d8f045dd1fd116253ba7686e892
Author: Wei Yongjun <weiyongjun1@huawei.com>
Date:   Thu Jul 2 09:56:50 2020 -0700

    scftorture: Make symbol 'scf_torture_rand' static
    
    The sparse tool complains as follows
    
    kernel/scftorture.c:124:1: warning:
     symbol '__pcpu_scope_scf_torture_rand' was not declared. Should it be static?
    
    And this per-CPU variable is not used outside of scftorture.c,
    so this commit marks it static.
    
    Reported-by: Hulk Robot <hulkci@huawei.com>
    Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index 52f74f1..a7fea76 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -134,7 +134,7 @@ static atomic_t n_alloc_errs;
 static bool scfdone;
 static char *bangstr = "";
 
-DEFINE_TORTURE_RANDOM_PERCPU(scf_torture_rand);
+static DEFINE_TORTURE_RANDOM_PERCPU(scf_torture_rand);
 
 // Print torture statistics.  Caller must ensure serialization.
 static void scf_torture_stats_print(void)
