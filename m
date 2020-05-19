Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BCA8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 23:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C44020809
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 23:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gP5wxnBJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgESXL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 19:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgESXLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 19:11:24 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DC2C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 16:11:24 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id q16so543239plr.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 16:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L+7QJAXBjfTJ+AlH8byb/3GiDycgpsRF9Sq5WXCPucY=;
        b=gP5wxnBJxBWcrtjyMluDLMiPyewrNncS64EHHgPp+B5M8VlvjmUGx3plaFVco31aMq
         RpFy1n//+8JzRGeWcxluhSfKMAb4bNWo7nwYZzBfU8POB1X1AmxCynz0skXCltH2HQEc
         7rTCq5vn0/i63H17WVk0pZRzPfQDeXMnCyl8akbVKV0twSLso7DvVGxJ39T5EpPoWFIg
         +CO+9Vv9YQe4Y6IR1i0xtrt/IiYjROFyjYoaUwA7Fzh/h9FK36M7fWdKjXoJANNSQ1Og
         hATkgP4m864O55Qhe5bEq83CnP7uAAZ2b4wekCdoeL/zGL4u1qJUi/9loHAQGjjg/B+e
         303Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L+7QJAXBjfTJ+AlH8byb/3GiDycgpsRF9Sq5WXCPucY=;
        b=niytpwofxEBUJ+jYO2IBk88oGI7Bj+N0VDK2D9Ifg2Aabhd2IS0CSi5Yz1hjvZ4edd
         GcHAUU9GolZ7GWma7/oA5sR4wUY4vc+/snCshc4fMvYy6+iRHDwzpN0CjH998O095Ltc
         S7TB0fIukvZ1Yy9JlNG1rFYzvCqqzu8H6fgeIJrhJBuGkDnbPFIA7QpyBbADxhC79hb1
         h6tonq6tLVAv1wV+voK4KWrb5k7o4bwu0x8b0uNpHYH0r6sROdTe8yOWh9dUkSZicGez
         jfCjUPN7xxavBEVx7yEWkzxGkfAY6AtE/aT21hT5f3h/rgK7OqYvzjQ5MjCK0V2ja880
         4SxA==
X-Gm-Message-State: AOAM533shAfuDOBB1UdP9zICq8TpBT5hz4GjoAfUHmGqA5VbO9Qds0Vz
        Pqt1Q6CrlWwvd4bsaKA4Hue9vA==
X-Google-Smtp-Source: ABdhPJys9s8J9INgrU+CaIvU8ZNjpSsags3R398v5suCHgwKjLcqI84WmnxzgQHtjdRMxu8rJp4+Dw==
X-Received: by 2002:a17:90a:21cf:: with SMTP id q73mr1953058pjc.230.1589929884107;
        Tue, 19 May 2020 16:11:24 -0700 (PDT)
Received: from builder.lan (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id s2sm473945pjs.9.2020.05.19.16.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 16:11:23 -0700 (PDT)
Date:   Tue, 19 May 2020 16:10:02 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] net: qrtr: Fix passing invalid reference to
 qrtr_local_enqueue()
Message-ID: <20200519231002.GD2165@builder.lan>
References: <20200519181416.4235-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519181416.4235-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 19 May 11:14 PDT 2020, Manivannan Sadhasivam wrote:

> Once the traversal of the list is completed with list_for_each_entry(),
> the iterator (node) will point to an invalid object. So passing this to
> qrtr_local_enqueue() which is outside of the iterator block is erroneous
> eventhough the object is not used.
> 
> So fix this by passing NULL to qrtr_local_enqueue().
> 
> Fixes: bdabad3e363d ("net: Add Qualcomm IPC router")
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Julia Lawall <julia.lawall@lip6.fr>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  net/qrtr/qrtr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/qrtr/qrtr.c b/net/qrtr/qrtr.c
> index 7ed31b5e77e4..2d8d6131bc5f 100644
> --- a/net/qrtr/qrtr.c
> +++ b/net/qrtr/qrtr.c
> @@ -854,7 +854,7 @@ static int qrtr_bcast_enqueue(struct qrtr_node *node, struct sk_buff *skb,
>  	}
>  	mutex_unlock(&qrtr_node_lock);
>  
> -	qrtr_local_enqueue(node, skb, type, from, to);
> +	qrtr_local_enqueue(NULL, skb, type, from, to);
>  
>  	return 0;
>  }
> -- 
> 2.17.1
> 
