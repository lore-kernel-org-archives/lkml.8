Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0AFC32771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 03:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F10A24656
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 03:19:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="byvNTIop"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729208AbgAVDTZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 22:19:25 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:51624 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728779AbgAVDTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 22:19:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xvFKwj3rwmGWzeThWcd7d3rmYbLkm5ktTQrerysyp1c=; b=byvNTIopxeYqXcxl5IbLITlbQ
        e1yUvJ0eOpprtdcX6NkHe2qlQiEdb9/8kDbB/UC/uXs+cxnuvr/DYdmazf/EoiOSRdfccl6hkZKL3
        gYbE7XCHiMRn4h8bdxzueJCy/Ty+C2Zhwsd5g5LvV3ujLNknP2JFFmJWP4PyofVoGTfp98f5mLuwh
        m8YbYguXs2Zdq0JZrp9rskLzePEpNzao2QFaYZH93wlnXHu7zAnxQO30HFmFhOFgXrQPqHjRJub3L
        3hAcuUzALcUH8c/tg7mz1AYuqRwu8J09MCR8yRZH5gjvpNVbqW2fnP51zQPNtxzWQGmEqVO3TH6bh
        8l8lJpvIA==;
Received: from [2601:1c0:6280:3f0::ed68]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iu6Y7-0007pl-PP; Wed, 22 Jan 2020 03:19:23 +0000
Subject: Re: mmotm 2020-01-21-13-28 uploaded (struct proc_ops)
To:     akpm@linux-foundation.org, broonie@kernel.org, mhocko@suse.cz,
        sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>
References: <20200121212915.APuBK%akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <d18345b6-616f-4ea3-7b9e-956f8edc26b7@infradead.org>
Date:   Tue, 21 Jan 2020 19:19:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200121212915.APuBK%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/21/20 1:29 PM, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2020-01-21-13-28 has been uploaded to
> 
>    http://www.ozlabs.org/~akpm/mmotm/
> 
> mmotm-readme.txt says
> 
> README for mm-of-the-moment:
> 
> http://www.ozlabs.org/~akpm/mmotm/
> 
> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> more than once a week.

and when CONFIG_PROC_FS is not set/enabled, kernel/sched/psi.c gets:

../kernel/sched/psi.c: In function ‘psi_proc_init’:
../kernel/sched/psi.c:1287:56: error: macro "proc_create" requires 4 arguments, but only 3 given
   proc_create("pressure/cpu", 0, NULL &psi_cpu_proc_ops);
                                                        ^
../kernel/sched/psi.c:1287:3: error: ‘proc_create’ undeclared (first use in this function); did you mean ‘sock_create’?
   proc_create("pressure/cpu", 0, NULL &psi_cpu_proc_ops);
   ^~~~~~~~~~~
   sock_create


-- 
~Randy

