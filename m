Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04706C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 09:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB574206F1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 09:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="tnbqvvlN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbgEOJVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 05:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727905AbgEOJVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 05:21:51 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1433FC05BD09
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 02:21:51 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id e25so1472160ljg.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 02:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=I1nraDclARKrCA29EVoPDtpaaicLZToHhlMTKQVzenY=;
        b=tnbqvvlNgJUlMgPaXVcmYwDPK1ZEltSB+hMIiSEw01VJoPtGPO20Ffto2m7KVmVXm4
         3oOBH/hZoik3rHCGm+MoRfEYmaf5YHzr9fnPJB35wGze/FhI0C2KW0csgYmk29VigNpy
         obyyOVX3oZelWh2wm5TNJiCKbGm6OagkvYcNmzbTVZtDOiCqoMaV6kY7SS8PlRCyRDXE
         +Uj0Qksx0yjiMcFuOlQss4KfmcNhvPHojuf10StzL++Vje/ARhyjWUp4NlFsr2M8oYzk
         59wMBZ+NTnNBLNtPB3p/+EKJKiIsZl01EwQ2BV4R6ecnz6e2fUqdIN8oiDjahqJYOzpG
         ilqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=I1nraDclARKrCA29EVoPDtpaaicLZToHhlMTKQVzenY=;
        b=G5YNYNY6PhmN5GA+ir36biUabR9JVIVc9UVqChVd5fjK33Unm5yw27GVFbELrWzA6N
         WLIv9DMt19OAevNKDDIsw+LHOT9E//sY5AW/6yABObrLZXrLAjPJty6TshDdgNpU5VrB
         7HDOjHTpQkCgTfsqQ4Rz6T3hik43PatuWj+nY4dUT6ulDRA40e5bUAmRay2z9zPpGcWm
         T6M3Yt+bxljY4R1FIUwNEYdjWfNnMarJpAcBwSmnIiuP22PJ9NMHxZz4ImqphKeWB2xV
         2lYN522pJkMo0CDpbKwD8ylz8vahggNZJb/3ny3bLptd6BKLzqH79fnR8UDkGJ/vVqzW
         HNzg==
X-Gm-Message-State: AOAM531vn6ScNQy6JsrB6eMtqFdmfW2Fznz5FsIgNhVs0oMSsQqJ2p7g
        aQ45aY5tmLDTptQ5GTxSQnatQINt2d+bWw==
X-Google-Smtp-Source: ABdhPJyRyE45vtKnuPofzX0MqtQD/YgUetIHt8yKvb3J4GkUiZya6GMEdYU/kHj+T3EdCgDpkUCH3w==
X-Received: by 2002:a2e:9641:: with SMTP id z1mr1517068ljh.215.1589534509054;
        Fri, 15 May 2020 02:21:49 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:46b9:e14c:2541:1887:9a5d:d412? ([2a00:1fa0:46b9:e14c:2541:1887:9a5d:d412])
        by smtp.gmail.com with ESMTPSA id 125sm971515lfc.75.2020.05.15.02.21.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 02:21:48 -0700 (PDT)
Subject: Re: [PATCH] xhci: Fix log mistake of xhci_start
To:     jiahao <jiahao243@gmail.com>, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org, jiahao@xiaomi.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1589521506-19492-1-git-send-email-jiahao@xiaomi.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <95a9f0ea-05d0-f1c9-9665-8c8bb0c9c8fe@cogentembedded.com>
Date:   Fri, 15 May 2020 12:21:36 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1589521506-19492-1-git-send-email-jiahao@xiaomi.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.05.2020 8:45, jiahao wrote:

> It is obvious that XCHI_MAX_HALT_USEC is usec,
>   not milliseconds; Replace 'milliseconds' with

     I don't see 'milliseconds', only 'microseconds'...

> 'usec' of the debug message.
> 
> Signed-off-by: jiahao <jiahao@xiaomi.com>
> ---
>   drivers/usb/host/xhci.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> index bee5dec..d011472 100644
> --- a/drivers/usb/host/xhci.c
> +++ b/drivers/usb/host/xhci.c
> @@ -147,7 +147,7 @@ int xhci_start(struct xhci_hcd *xhci)
>   			STS_HALT, 0, XHCI_MAX_HALT_USEC);
>   	if (ret == -ETIMEDOUT)
>   		xhci_err(xhci, "Host took too long to start, "
> -				"waited %u microseconds.\n",
> +				"waited %u usec.\n",
>   				XHCI_MAX_HALT_USEC);
>   	if (!ret)
>   		/* clear state flags. Including dying, halted or removing */
> 

MBR, Sergei
