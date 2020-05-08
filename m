Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34B8C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77CE9208CA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:25:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2/LOIVoE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgEHIZj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 04:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbgEHIZj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 04:25:39 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43CDC05BD43
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 01:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bPsh+9tUVxugx7x5PNvUGxnD+1Kx42U+6CJvSr1uG3Y=; b=2/LOIVoECReYBE9eiOPryMJ7Yj
        xEcHXkV6oiQUDo9LqPabLqNNDMNR2EGRPBVdQqq7I7XMxf2hSHpXmm03CM6moGOTGf1wI2zf2k5Pf
        e6Y6ZpVnALoiLSuWQAZrddTiSdG5aza5EJwXjCNAEJUSOeESPdxU9x3Qgz6ougyrIlsWWsj9NNd49
        65eX6+M5BSMdWI73ONBTdDPE9hQvQD0d40QbqmyivS8okUz3+T6+wwwrnF+s3dw0NjkcELiSBlrj/
        eZQImZLqTEVonoUnX7LrpWDK0nAUILLkHTEUK73XzNrNrltBeg+QCdz5aor2rl4qQGGho+M2atAJU
        1istVEjA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jWyJm-0003on-L2; Fri, 08 May 2020 08:25:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3CC87301A80;
        Fri,  8 May 2020 10:25:11 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 04E422038FB83; Fri,  8 May 2020 10:25:11 +0200 (CEST)
Date:   Fri, 8 May 2020 10:25:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kaige Li <likaige@loongson.cn>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, Tiezhu Yang <yangtiezhu@loongson.cn>,
        Xuefeng Li <lixuefeng@loongson.cn>
Subject: Re: [PATCH] perf/core: Do not initialise statics to 0 and add space
 before '{'
Message-ID: <20200508082510.GO5298@hirez.programming.kicks-ass.net>
References: <1588910663-9437-1-git-send-email-likaige@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588910663-9437-1-git-send-email-likaige@loongson.cn>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 12:04:23PM +0800, Kaige Li wrote:
> Fix the following checkpatch errors:
> 
> ERROR: do not initialise statics to 0
> #10616: FILE: ./kernel/events/core.c:10616:
> + static int hw_context_taken = 0;
> 
> ERROR: space required before the open brace '{'
> #11070: FILE: ./kernel/events/core.c:11070:
> + } else if (is_write_backward(event)){

Checkpatch can sod off. Please don't ever submit pure checkpatch patches
to anything I maintain.
