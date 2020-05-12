Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4B1CA90AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 16:42:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C1F920714
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 16:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589301743;
	bh=o/q0m5fQV5SQ9AOutbfjUZ8J9JYbCbkCSVaRy899Xv0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XaIoS4LX6vujmMYw8jqbsEofVxYKJc0MwFZuURWXkvI/THOWO5gOij+EW167RapGV
	 EA6uoCq6tlYTSgJQlafisO4thlj+ftxOn4mErFmpUNAeGXJcx3C31Glbiuihr8j+AB
	 Qcpih3hWngTnqjloWAIq9n6pic12SqLou96B4cjA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgELQmW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 12:42:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:40208 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbgELQmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 12:42:22 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 059B8206CC;
        Tue, 12 May 2020 16:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589301741;
        bh=o/q0m5fQV5SQ9AOutbfjUZ8J9JYbCbkCSVaRy899Xv0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hQlbhx2iMJhAWC00mvMREKCgH3TDavHWlXKLbhf4ihHzU7EHUXVvfD8lv/BSw8JxY
         OYq9Hq8+U21MLkEWc4l/Z7j2xErqr+B/GyfOehYuZykA3f/r53y/Hg77XIxGw5/cX8
         wP9Q4FSfHanV59TH58TS9DUGlsfbzAWSyedzosHc=
Date:   Tue, 12 May 2020 19:42:18 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] kasan: move kasan_report() into report.c
Message-ID: <20200512164218.GN4814@unreal>
References: <29bd753d5ff5596425905b0b07f51153e2345cc1.1589297433.git.andreyknvl@google.com>
 <78a81fde6eeda9db72a7fd55fbc33173a515e4b1.1589297433.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78a81fde6eeda9db72a7fd55fbc33173a515e4b1.1589297433.git.andreyknvl@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 05:33:20PM +0200, Andrey Konovalov wrote:
> The kasan_report() functions belongs to report.c, as it's a common
> functions that does error reporting.
>
> Reported-by: Leon Romanovsky <leon@kernel.org>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  mm/kasan/common.c | 19 -------------------
>  mm/kasan/report.c | 22 ++++++++++++++++++++--
>  2 files changed, 20 insertions(+), 21 deletions(-)
>

Thanks,
Tested-by: Leon Romanovsky <leon@kernel.org>
