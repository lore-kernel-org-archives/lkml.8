Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F89C34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 12:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 523BC2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 12:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgBRMl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 07:41:56 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:51288 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726512AbgBRMlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 07:41:55 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j42C6-00Efka-5Y; Tue, 18 Feb 2020 12:41:42 +0000
Date:   Tue, 18 Feb 2020 12:41:42 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Macpaul Lin <macpaul.lin@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Shen Jing <jingx.shen@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Vincent Pelletier <plr.vincent@gmail.com>,
        Jerry Zhang <zhangjerry@google.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>
Subject: Re: [PATCH] lib: iov_iter.c: fix a possible calculation error on
 remaining bytes
Message-ID: <20200218124142.GJ23230@ZenIV.linux.org.uk>
References: <1582011672-17189-1-git-send-email-macpaul.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582011672-17189-1-git-send-email-macpaul.lin@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 03:41:12PM +0800, Macpaul Lin wrote:
> This issue was found when adbd trying to open functionfs with AIO mode.
> Usually, we need to set "setprop sys.usb.ffs.aio_compat 0" to enable
> adbd with AIO mode on Android.
> 
> When adbd is opening functionfs, it will try to read 24 bytes at the
> fisrt read I/O control. If this reading has been failed, adbd will
> try to send FUNCTIONFS_CLEAR_HALT to functionfs. When adbd is in AIO
> mode, functionfs will be acted with asyncronized I/O path. After the
> successful read transfer has been completed by gadget hardware, the
> following series of functions will be called.
>   ffs_epfile_async_io_complete() -> ffs_user_copy_worker() ->
>     copy_to_iter() -> _copy_to_iter() -> copyout() ->
>     iterate_and_advance() -> iterate_iovec()
> 
> Adding debug trace to these functions, it has been found that in
> iterate_iovec(), the calculation result of n will be turned into zero.
>    n = wanted - n; /* 0 == n = 24 - 24; */
> Which causes copyout() won't copy data to userspace since the length
> to be copied "v.iov_len" will be zero, which isn't correct. This also
> leads ffs_copy_to_iter() always return -EFAULT. Finally adbd cannot
> open functionfs and send FUNCTIONFS_CLEAR_HALT.
> 
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>  lib/iov_iter.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index fb29c02c6a3c..f9334144e259 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -36,7 +36,8 @@
>  		skip = __v.iov_len;			\
>  		n -= __v.iov_len;			\
>  	}						\
> -	n = wanted - n;					\
> +	if (n != wanted)				\
> +		n = wanted - n;				\
>  }

	First of all, nothing in that line can possibly *cause*
copyout() to do anything - it's after the calls of step.  What's
more, this changes behaviour only when wanted would've been equal to
n, doesn't it?  Which translates into "no decrements of n have
happened at all", i.e. "nothing has been copied".  IOW, it's
a consequence of no copyout, not the cause of such.  You can
make copy_to_iter() lie and pretend if has copied everything
when it has copied nothing, but that won't change the underlying
bug.

	So I'm afraid your debugging is not finished - you
still need to find out what causes the copyout failures and/or
BS iov_iter padded by caller.
