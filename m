Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29221C3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:12:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F62E20863
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 10:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbgCCKME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 05:12:04 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40527 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbgCCKMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 05:12:03 -0500
Received: by mail-ed1-f67.google.com with SMTP id p3so3593896edx.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 02:12:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QFxG9RCA40BrkjxxC1U2JfSdDk/sXGRl4lMZI+3OtTI=;
        b=O3/YTyt61C3Z9YYiUKN2u/7coX7iu23nwTHvU6CcU/XmNl56JSNKteQGqwkzUovKF0
         NefUssP8KNC98fpS+/VehkaYdG9A7xUjOxrALLQoxL6ZmCI352nNi7+UIWNh03KD9FGn
         tB4ilL5QmIdYl/nutenu28RGJaF+41d27IzaKzDOQIs79cikyhMPmfZ00vHsE+sMFQ3s
         gc8BjRsWsf0hXfktvwiphbocqXoxZgXw69TcZnMRDau7udIW7ZSnC4WYOOBANOifsyAn
         ws3sJzPBzJ1CN/6LxN1b9R2S58904q3elGuaHBYLyG4NPaK7GGMl343ACYAsJ+lDXARp
         Zs6w==
X-Gm-Message-State: ANhLgQ36r7/vlvM0yrNXO9UjZ/cpCARUAW4C27ZZecqaR3iysjBkDTKV
        pEfeHuZWDEQ57fhgR4XHFCE=
X-Google-Smtp-Source: ADFU+vv1ScCTAYe2G90HyG56h26u7ytSes9n9XZ4/8Se5c6R9tx9vXtqxhfkY00XY6UOqxDWzuhJPQ==
X-Received: by 2002:a50:ec89:: with SMTP id e9mr3297178edr.123.1583230321762;
        Tue, 03 Mar 2020 02:12:01 -0800 (PST)
Received: from a483e7b01a66.ant.amazon.com (54-240-197-230.amazon.com. [54.240.197.230])
        by smtp.gmail.com with ESMTPSA id by19sm635002ejc.85.2020.03.03.02.12.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 02:12:00 -0800 (PST)
Subject: Re: [Xen-devel] [PATCH 2/2] xenbus: req->err should be updated before
 req->state
To:     Dongli Zhang <dongli.zhang@oracle.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     jgross@suse.com, boris.ostrovsky@oracle.com,
        sstabellini@kernel.org, joe.jin@oracle.com
References: <20200303015859.18813-1-dongli.zhang@oracle.com>
 <20200303015859.18813-2-dongli.zhang@oracle.com>
From:   Julien Grall <julien@xen.org>
Message-ID: <4c2594c8-9146-fbd9-6074-9c8366afb391@xen.org>
Date:   Tue, 3 Mar 2020 10:11:59 +0000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200303015859.18813-2-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03/03/2020 01:58, Dongli Zhang wrote:
> This patch adds the barrier to guarantee that req->err is always updated
> before req->state.
> 
> Otherwise, read_reply() would not return ERR_PTR(req->err) but
> req->body, when process_writes()->xb_write() is failed.

The memory barrier below looks good. However, as mentionned in patch #1, 
barrier() is not the correct barrier to pair with virt_wmb().

> 
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>   drivers/xen/xenbus/xenbus_comms.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/xen/xenbus/xenbus_comms.c b/drivers/xen/xenbus/xenbus_comms.c
> index 852ed161fc2a..eb5151fc8efa 100644
> --- a/drivers/xen/xenbus/xenbus_comms.c
> +++ b/drivers/xen/xenbus/xenbus_comms.c
> @@ -397,6 +397,8 @@ static int process_writes(void)
>   	if (state.req->state == xb_req_state_aborted)
>   		kfree(state.req);
>   	else {
> +		/* write err, then update state */
> +		virt_wmb();
>   		state.req->state = xb_req_state_got_reply;
>   		wake_up(&state.req->wq);
>   	}
> 

Cheers,

-- 
Julien Grall
