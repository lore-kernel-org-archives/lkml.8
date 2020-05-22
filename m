Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A52C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 23:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 171E220738
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 23:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590190979;
	bh=oahDcicwRFmo7/2GQGTQCHhUqocnHDwRWsWdm6Vbj18=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ecRjf+K3QRAuHTcnvpyzO2xG6e726TAe5Fq8GsPe25x4FZ5YqDUeMDXet2jVO6TYS
	 qqdnwmwoQyexXIpNoEpYYv3ppqIZ/5CmGAZI8zi/yxTPDsqPaVTqgag2ZEUX8tYBMe
	 4ZnhNDXRx0XK81SjaRv0M61XKzVYF+Or7Cbih5To=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387458AbgEVXmy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 19:42:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:49110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387422AbgEVXms (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 19:42:48 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2AF7920723;
        Fri, 22 May 2020 23:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590190968;
        bh=oahDcicwRFmo7/2GQGTQCHhUqocnHDwRWsWdm6Vbj18=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mwbCPnxSc1pHdTkJMGmdYuU4RRLMPHYzf+jyG6Vu/zjQAPp/1mR5uveeunjxJCkuJ
         rBrjbgHjBuYtcltp2UqKHcxUBGIEpCbynv5R/0dZR6CdDrGjMmAC2R5lpIKTPGRmM3
         c2zoIl/7eVgAHc57ZMfGRoJ0R8BsTLQ/e48aaH+c=
Date:   Fri, 22 May 2020 16:42:47 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Marco Elver <elver@google.com>
Cc:     dvyukov@google.com, glider@google.com, andreyknvl@google.com,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        aryabinin@virtuozzo.com, linux-mm@kvack.org, cai@lca.pw,
        kernel test robot <rong.a.chen@intel.com>
Subject: Re: [PATCH v2] kasan: Disable branch tracing for core runtime
Message-Id: <20200522164247.4a88aed496f0feb458d8bca0@linux-foundation.org>
In-Reply-To: <20200522075207.157349-1-elver@google.com>
References: <20200522075207.157349-1-elver@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 May 2020 09:52:07 +0200 Marco Elver <elver@google.com> wrote:

> During early boot, while KASAN is not yet initialized, it is possible to
> enter reporting code-path and end up in kasan_report(). While
> uninitialized, the branch there prevents generating any reports,
> however, under certain circumstances when branches are being traced
> (TRACE_BRANCH_PROFILING), we may recurse deep enough to cause kernel
> reboots without warning.
> 
> To prevent similar issues in future, we should disable branch tracing
> for the core runtime.
> 
> Link: https://lore.kernel.org/lkml/20200517011732.GE24705@shao2-debian/
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Signed-off-by: Marco Elver <elver@google.com>

I assume this affects 5.6 and perhaps earlier kernels?

I also assume that a cc:stable is appropriate for this fix?
