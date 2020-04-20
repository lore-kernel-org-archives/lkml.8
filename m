Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEF9EC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 10:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EE3E21473
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 10:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g001.emailsrvr.com header.i=@g001.emailsrvr.com header.b="CvDuyE0Z";
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="YD6ZZr+N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgDTKVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 06:21:50 -0400
Received: from smtp105.ord1c.emailsrvr.com ([108.166.43.105]:58808 "EHLO
        smtp105.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725773AbgDTKVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 06:21:50 -0400
X-Greylist: delayed 394 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Apr 2020 06:21:49 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=g001.emailsrvr.com;
        s=20190322-9u7zjiwi; t=1587377714;
        bh=KE+p7nNz2ulsXQ37ZSxFILCnrC3V3T2DkQkwLsftGEs=;
        h=Subject:To:From:Date:From;
        b=CvDuyE0Z+g2G9s2Gni0Wv0vFUbJGSIBmFLj4U6Dp1bZZrfPV165Lcp6o3VzQujoQX
         psPfQJMNvi+dXEictMOYRYeN3WaOK68D3ptwDeVrSSyFwCxri+rpOENnlyYalgMtxd
         qO8/z8J01IRpQmZZPTyk+jBmz17ooMiC62XvroDw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1587377714;
        bh=KE+p7nNz2ulsXQ37ZSxFILCnrC3V3T2DkQkwLsftGEs=;
        h=Subject:To:From:Date:From;
        b=YD6ZZr+NVivTfMnXYy3qJaA8bX2C1qNXKS5LQhJL3LKkAR9M1R4vJu5gddOmUd1i3
         /7c6zO2TaFOlQFzotuOnp9HXh5dqW0mmhDlaNrpKJ/lZ0FaihDzerJAE+PbNNzHxNX
         ijF9WO6p1KpErJpm5uaN0AUvCrEOFpPrN1QH6OgU=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp6.relay.ord1c.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 96E37A0109;
        Mon, 20 Apr 2020 06:15:13 -0400 (EDT)
X-Sender-Id: abbotti@mev.co.uk
Received: from [10.0.0.173] (remote.quintadena.com [81.133.34.160])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Mon, 20 Apr 2020 06:15:14 -0400
Subject: Re: [PATCH] staging: comedi: Fix comedi_device refcnt leak in
 comedi_open
To:     Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Xin Tan <tanxin.ctf@gmail.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     yuanxzhang@fudan.edu.cn, kjlu@umn.edu
References: <1587361459-83622-1-git-send-email-xiyuyang19@fudan.edu.cn>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
Message-ID: <a5988c23-e552-b787-feb0-2d1bda8f1668@mev.co.uk>
Date:   Mon, 20 Apr 2020 11:15:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1587361459-83622-1-git-send-email-xiyuyang19@fudan.edu.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Classification-ID: 061321d8-5d6b-4c3f-b7bb-fc78540ae002-1-1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/2020 06:44, Xiyu Yang wrote:
> comedi_open() invokes comedi_dev_get_from_minor(), which returns a
> reference of the COMEDI device to "dev" with increased refcount.
> 
> When comedi_open() returns, "dev" becomes invalid, so the refcount
> should be decreased to keep refcount balanced.
> 
> The reference counting issue happens in one exception handling path of
> comedi_open(). When "cfp" allocation is failed, the refcnt increased by
> comedi_dev_get_from_minor() is not decreased, causing a refcnt leak.
> 
> Fix this issue by calling comedi_dev_put() on this error path when "cfp"
> allocation is failed.
> 
> Fixes: 20f083c07565 ("staging: comedi: prepare support for per-file read
> and write subdevices")
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
> ---
>   drivers/staging/comedi/comedi_fops.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/comedi/comedi_fops.c b/drivers/staging/comedi/comedi_fops.c
> index 08d1bbbebf2d..e84b4fb493d6 100644
> --- a/drivers/staging/comedi/comedi_fops.c
> +++ b/drivers/staging/comedi/comedi_fops.c
> @@ -2725,8 +2725,10 @@ static int comedi_open(struct inode *inode, struct file *file)
>   	}
>   
>   	cfp = kzalloc(sizeof(*cfp), GFP_KERNEL);
> -	if (!cfp)
> +	if (!cfp) {
> +		comedi_dev_put(dev);
>   		return -ENOMEM;
> +	}
>   
>   	cfp->dev = dev;
>   
> 

Thanks for spotting that!

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || Web: www.mev.co.uk )=-
-=( MEV Ltd. is a company registered in England & Wales. )=-
-=( Registered number: 02862268.  Registered address:    )=-
-=( 15 West Park Road, Bramhall, STOCKPORT, SK7 3JZ, UK. )=-
