Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FD3C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 14:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ECD82173E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 14:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="KT22H+M9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbgCBORv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 09:17:51 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:36947 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgCBORu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 09:17:50 -0500
Received: by mail-io1-f68.google.com with SMTP id c17so11676942ioc.4
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 06:17:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a0tBhZvtllQvUWUp6ZQPztoGNFVwtv7YcFVARrMmvDg=;
        b=KT22H+M9A+/N+EaDP0Po6iV8/MsUrppvM/g1dXtkaygzEgRudsTB+xHOuiVBrQ6+ym
         EZImuro2nvNgQvxmb2YrX3Xq1AvLyAzZtTD+M2cBIUl6sddpsm5iDrMgO/IrNFnsz81k
         acDPEGwkloN1LhVw9h2hvB5loaBWm/2aisCK7XEvFaoZmgzINFPYkwyXVbQ7aK9939mU
         kX08pOawvjJUVbTiTpO9hFLefonqdROKfrPomv+r+kvIHvt+aR5qTkY2Tur0Fdf+7YX+
         XHH95Ob16H4KfCW9Sy6Q9WzLIOWbnODpWh61JNBmj71bk+Ap6vC0owQ1JSTwgF4EvTiI
         /0MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a0tBhZvtllQvUWUp6ZQPztoGNFVwtv7YcFVARrMmvDg=;
        b=Vhj2GwMQXVqrWsk6YmstedTQZ7c7D+mI9cBY/vKOIgTps72dhEcn5gtApqihIpInvT
         LUQ3JvsMLgW6dd2sC7gFs2fyZpyYId2w20e9fPpEchNBG5AdnbsYsI4e6bekrjNfkKTw
         FB8zWMYCjIu+BXob6sYY/whXTMbqVL01G8H5M844gUlrVp5GdaqwfKJzZtcMRgNzmZwC
         Sd2K8CoEjSriNsyqqWLQEuTxGXUY4o95t2+Csa3VmK3MicPsc29zPl9RVTpTvH+xv4fK
         CS9C+vI+MHn9IKiLNlyHDdxMGmNdaQfRDgOvlm6nuEC+sRezdMKzG2CIrWgsJ8pFUp9s
         KNdQ==
X-Gm-Message-State: APjAAAURIfLCk2RmoyBvxqVfHBcCkVre+pfRF1f3yTiDbxvbp9I0Y207
        gtkINFoKLVo9xkw/UNE58OpMB+fLrwA=
X-Google-Smtp-Source: APXvYqx3YVHyUAM1aPAByzs4DZtc1emIuOG1m7mpL/Ib4m6txxnpN5VXkKNSeh1FSb5OckpPmF/y1A==
X-Received: by 2002:a5e:8e46:: with SMTP id r6mr7092279ioo.50.1583158669229;
        Mon, 02 Mar 2020 06:17:49 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id n81sm3879057ili.28.2020.03.02.06.17.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2020 06:17:48 -0800 (PST)
Subject: Re: [PATCH] block: Remove used kblockd_schedule_work_on()
To:     Daniel Wagner <dwagner@suse.de>, linux-block@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20200302132408.15954-1-dwagner@suse.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <843612ae-c5ae-39af-63eb-dc861948a7e7@kernel.dk>
Date:   Mon, 2 Mar 2020 07:17:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200302132408.15954-1-dwagner@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/20 6:24 AM, Daniel Wagner wrote:
> Commit ee63cfa7fc19 ("block: add kblockd_schedule_work_on()")
> introduced the helper in 2016. Remove it because since then no caller
> was added.

Applied, thanks.

-- 
Jens Axboe

