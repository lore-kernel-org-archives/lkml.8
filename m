Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2849C2BA1A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 10:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C6B32084D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 10:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="taFlNApL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbgDXKMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 06:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726614AbgDXKMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 06:12:21 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B62C09B045
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 03:12:21 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id a21so6481377ljj.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 03:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8hnwyy4503M97KIyTJbVUPAgWJRZoB4APIu0QnGDpRc=;
        b=taFlNApLlAX0N3aDKmfyyICpts2QNl6sQ8mzqfUbFKU518OaF0Ui10/YNBSPgzZXT9
         wpIJ7fFe0JNA/yd0DK384FFnMhAPnMq7wcYAsrRZvQDx3I886/MnHPaWzQw3H3SkaefU
         FFapBW+vhrP29FK9mwPur8JInxzEYWhQt39U70BfoaXBtmc3Z3kTTPPVJia89q1mPM9U
         g+zpxKDc+ZlCtMRNLqRr7aGYE1n+cHXjVOjbwUCkjxjls457tvnwRaHlFkFoPg9sqGeb
         k+bzbI/C2SoS7hbK2ZsDWm7wa1SXQ/kcHTXcsnFvze0sN7NL19o2uPVUjkOaC/2Ihbtg
         H6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8hnwyy4503M97KIyTJbVUPAgWJRZoB4APIu0QnGDpRc=;
        b=BJ8PY3sF4NTqh8dfE0HDs1FQ6+/565AuieZx+oFnB22ruUWvAWlRKSUpILui1EXz1C
         0F4E0QNb9zAP4iYQ7++szH0BlKBiMo6gUCJAGmGNCr7ECxkQ/piUWpNIC2mza8YSdGrT
         xNp9X2G5G7KTqrKjgjko+FIQb0WrRQuBLE4+DfqTy+jrZvCYXnJBcC+/+D9S4S5oT/XR
         SRqjkCj9oNaAMSOeiujz/T1RSxC9ZuX712nDCPfPwxCIWvKh+MM/HtfYXNrjq0X5LtHK
         zglfQwNXemqyK4LAKpFmA8LEFRxqC+Vt6Up3rLVzVF58fOlvp6A5uJcQD1F+vYddRj93
         q7aA==
X-Gm-Message-State: AGi0Pua47c0Aq9VzCbT+zJcbgg5VejgDjxHI2IlnHgEPulyY7J8+xSBP
        wRae1T9n7vzeWURDuxtmmDdW6RTMWak=
X-Google-Smtp-Source: APiQypLm20GzwJHygFQCB4K8W4SYS9CdMiatvAPfI3CJT+/u69stqVF60KIr0LqJ7c6dCjxt1rUumQ==
X-Received: by 2002:a2e:a313:: with SMTP id l19mr5668228lje.133.1587723139778;
        Fri, 24 Apr 2020 03:12:19 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:420f:6e5c:31c9:acae:d924:779a? ([2a00:1fa0:420f:6e5c:31c9:acae:d924:779a])
        by smtp.gmail.com with ESMTPSA id q22sm3856002ljm.10.2020.04.24.03.12.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2020 03:12:19 -0700 (PDT)
Subject: Re: [PATCH net-next] ptp: clockmatrix: remove unnecessary comparison
To:     Yang Yingliang <yangyingliang@huawei.com>,
        richardcochran@gmail.com, vincent.cheng.xh@renesas.com,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1587716058-1840-1-git-send-email-yangyingliang@huawei.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <2c85e220-3765-4424-ee22-c9acf27f9d22@cogentembedded.com>
Date:   Fri, 24 Apr 2020 13:12:05 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1587716058-1840-1-git-send-email-yangyingliang@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 24.04.2020 11:14, Yang Yingliang wrote:

> The type of loaddr is u8 which is always '<=' 0xff, so the
> loaddr <= 0xff is always true, we can remove this comparison.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>   drivers/ptp/ptp_clockmatrix.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ptp/ptp_clockmatrix.c b/drivers/ptp/ptp_clockmatrix.c
> index 032e112..56aee4f 100644
> --- a/drivers/ptp/ptp_clockmatrix.c
> +++ b/drivers/ptp/ptp_clockmatrix.c
> @@ -780,7 +780,7 @@ static int idtcm_load_firmware(struct idtcm *idtcm,
>   
>   			/* Page size 128, last 4 bytes of page skipped */
>   			if (((loaddr > 0x7b) && (loaddr <= 0x7f))
> -			     || ((loaddr > 0xfb) && (loaddr <= 0xff)))
> +			     || loaddr <= 0xff)

    Haven't you just said that this is always true? :-)

[...]

MBR, Sergei
