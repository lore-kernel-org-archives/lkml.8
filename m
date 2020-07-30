Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 445FBC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 13:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A584206D8
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 13:33:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="f4yrzksu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728726AbgG3Ndd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 09:33:33 -0400
Received: from gateway36.websitewelcome.com ([192.185.186.5]:41571 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728342AbgG3Ndc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 09:33:32 -0400
Received: from cm17.websitewelcome.com (cm17.websitewelcome.com [100.42.49.20])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id 98FF940100B8D
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 07:09:32 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 17wikIclwBb5d17wikve30; Thu, 30 Jul 2020 07:46:04 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:Subject:From:References:Cc:To:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Z5uXuRI+aXgtQ1zcBbtoxXuoEsy13FiXL+bA4Jtl5F0=; b=f4yrzksuUtPBASWfmvqtozvNdn
        dRW2EJksROcq9wnNrRcbM8R4CAVlzb9w7qIz7fGhSD7+DjDGsv8sQQmaY+qucBGyPsPD0gqE0gO39
        CoxKszK6UhgiQE9oySp1G7h+aFoVJ+O0ud8BpIJYmyEwXZj+TGWR1iIBZ9Sj7Bt1W6BiJ66EFzefV
        BbxbBWYTwIgDarNw2M0iXKAl5iQ3TnJuuiSZLAIVoMgm/0uIo/Gmlt+Q2KNhYSTlMDShrY1V+gKC7
        Mn0YBvTnYPUkRmABWZfggfSYutSXTRUMiUAfAheTWv6iXUCYXdT+hRqPgcPqGfk3h6Bo6dBoS56am
        qC+bSFpQ==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:33390 helo=[192.168.15.3])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <gustavo@embeddedor.com>)
        id 1k17wf-00394J-On; Thu, 30 Jul 2020 07:46:01 -0500
To:     Qianli Zhao <zhaoqianligood@gmail.com>, stefanr@s5r6.in-berlin.de,
        linux1394-devel@lists.sourceforge.net
Cc:     linux-kernel@vger.kernel.org, zhaoqianli@xiaomi.com
References: <1596079620-20023-1-git-send-email-zhaoqianligood@gmail.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Autocrypt: addr=gustavo@embeddedor.com; keydata=
 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
 AP7RWS474w==
Subject: Re: [PATCH] firewire: firewire-cdev.h: Avoid the use of one-element
 array
Message-ID: <d7d33292-99a3-cddf-629b-a71acd1a7bee@embeddedor.com>
Date:   Thu, 30 Jul 2020 07:52:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1596079620-20023-1-git-send-email-zhaoqianligood@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1k17wf-00394J-On
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.3]) [187.162.31.110]:33390
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


NACK!

Please, stop doing this. You clearly don't know what you're doing.
You're just blindly copying/pasting all this. The subject line
has nothing to do with what the patch does and we don't want
any of these transformations in UAPI for now.

As I already said here:
https://lore.kernel.org/lkml/90b2c9f3-cc2b-b2e6-51ef-998d2f79123a@embeddedor.com/

start with drivers/staging/ and get hang of the kernel development
process, first. This is a great source, I encourage you to read it
thoroughly:
https://kernelnewbies.org/Outreachyfirstpatch

If you want to land your first kernel patch, blindly copying/pasting
stuff without actually paying attention to what you're doing, is
certainly not the best strategy and you won't start with the right
foot in terms of your reputation. Stop this and do things right from
the beginning.

--
Gustavo

On 7/29/20 22:27, Qianli Zhao wrote:
> From: Qianli Zhao <zhaoqianli@xiaomi.com>
> 
> There is a regular need in the kernel to provide a way to declare having a
> dynamically sized set of trailing elements in a structure. Kernel code should
> always use “flexible array members”[1] for these cases. The older style of
> one-element or zero-length arrays should no longer be used[2].
> 
> [1] https://en.wikipedia.org/wiki/Flexible_array_member
> [2] https://github.com/KSPP/linux/issues/21
> 
> Signed-off-by: Qianli Zhao <zhaoqianli@xiaomi.com>
> ---
>  include/uapi/linux/firewire-cdev.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/uapi/linux/firewire-cdev.h b/include/uapi/linux/firewire-cdev.h
> index 7e5b5c1..487de87f 100644
> --- a/include/uapi/linux/firewire-cdev.h
> +++ b/include/uapi/linux/firewire-cdev.h
> @@ -118,7 +118,7 @@ struct fw_cdev_event_response {
>  	__u32 type;
>  	__u32 rcode;
>  	__u32 length;
> -	__u32 data[0];
> +	__u32 data[];
>  };
>  
>  /**
> @@ -142,7 +142,7 @@ struct fw_cdev_event_request {
>  	__u64 offset;
>  	__u32 handle;
>  	__u32 length;
> -	__u32 data[0];
> +	__u32 data[];
>  };
>  
>  /**
> @@ -205,7 +205,7 @@ struct fw_cdev_event_request2 {
>  	__u32 generation;
>  	__u32 handle;
>  	__u32 length;
> -	__u32 data[0];
> +	__u32 data[];
>  };
>  
>  /**
> @@ -344,7 +344,7 @@ struct fw_cdev_event_iso_resource {
>   * @data:	Incoming data
>   *
>   * If @type is %FW_CDEV_EVENT_PHY_PACKET_SENT, @length is 0 and @data empty,
> - * except in case of a ping packet:  Then, @length is 4, and @data[0] is the
> + * except in case of a ping packet:  Then, @length is 4, and @data[] is the
>   * ping time in 49.152MHz clocks if @rcode is %RCODE_COMPLETE.
>   *
>   * If @type is %FW_CDEV_EVENT_PHY_PACKET_RECEIVED, @length is 8 and @data
> @@ -355,7 +355,7 @@ struct fw_cdev_event_phy_packet {
>  	__u32 type;
>  	__u32 rcode;
>  	__u32 length;
> -	__u32 data[0];
> +	__u32 data[];
>  };
>  
>  /**
> 
