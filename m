Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED14C3F2CF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 04:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 416AA246A2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 04:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VNkilqIn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730854AbgB1ET3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 23:19:29 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45952 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730638AbgB1ET2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 23:19:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=/ByRSnkFfGIU/GeAgnY8IVLWxLVpYgFEykKN5Va68U8=; b=VNkilqInNjQDx9PW1rTzw4naW+
        tda34vOR3hcjQy7uf+8CTOYGG+uUlel6tEghMFzHsC4jVqBOBGER8oMxkro480KdTHoEB95pvJTAJ
        iyn+rz31d9SXegY1BIXXnlOHBam9x2SCLNc0Ke/kf7jO+xn7CPHb4p55JQNseYRygSzwpVi+X5C32
        bqTJ/vjk1kKraGnBzITnq6r6HvRhyB00LLRAmmKblleNs0WKYHEQMkhvbv47C42NXPIoRhtza1/3t
        uMqN431YILgOVGd8vuWetSlifrnYqxc0C/JHyGorvbYKe1Ik1CwXqrY2tVcB4W5+5r+cBQBTfYqa/
        hfKFrAxA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j7X7X-0000bE-83; Fri, 28 Feb 2020 04:19:27 +0000
Subject: Re: [PATCH] parport: fix if-statement empty body warnings
To:     Joe Perches <joe@perches.com>, LKML <linux-kernel@vger.kernel.org>,
        linux-parport@lists.infradead.org
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
References: <e7868a5c-5356-bbbb-f416-799a7f75f7ad@infradead.org>
 <8ce0d190e0e6061c14daf469d454bb3626e33549.camel@perches.com>
 <b249d3ec-7174-c8ba-af5c-d4e937232f0f@infradead.org>
 <f84c28c4d9a9b13a60b43b99756cb59ce14d7196.camel@perches.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <69fb1d36-b6cf-7c46-96d1-9403de6ab47a@infradead.org>
Date:   Thu, 27 Feb 2020 20:19:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <f84c28c4d9a9b13a60b43b99756cb59ce14d7196.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/20 7:19 PM, Joe Perches wrote:
> Eliminate warnings by using pr_debug which is the more typical
> kernel debugging style and also enable dynamic_debug on these
> outputs.
> 
> Miscellaneous:
> 
> o A few messages were logged at KERN_INFO when enabled, now KERN_DEBUG
> o Convert %d/%d to %zd/%zu to avoid compilation warnings
> 
> Original-patch-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Joe Perches <joe@perches.com>
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
> ---
>  drivers/parport/ieee1284.c     | 90 ++++++++++++++++--------------------------
>  drivers/parport/ieee1284_ops.c | 67 +++++++++++--------------------
>  2 files changed, 57 insertions(+), 100 deletions(-)

Thanks, Joe.

-- 
~Randy
