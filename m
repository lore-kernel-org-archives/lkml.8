Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E086DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 13:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA806224B1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 13:14:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="borORmur"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbgGNNOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 09:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727944AbgGNNOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 09:14:46 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CBDC061794
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 06:14:46 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id j18so5654405wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 06:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=g2EyQlAqpHZO5s5qqHKlAo11WIHmOqc0rUAshNEUl2M=;
        b=borORmurH5EPJJNnd7Lhs3GNt3l3WCLMftWORGj+zrxXvkT3GSAjiw6lXlF54+CB7A
         W1bX0hSTU76d2ShMudHT/6fsfXkzmfailabgVc3MOvvjv5zJX+ncFsfpxvejGZW84o8z
         3er9h9m7CAECayAUE5SjM+MucvuPrewYpQU2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=g2EyQlAqpHZO5s5qqHKlAo11WIHmOqc0rUAshNEUl2M=;
        b=mY581ZbJSzz7cKmwCaxU1B4gxI+szqbMIy053b0CKa97csmpKo970KxTAXOlTXwahF
         tRhO2b8HAhVNjViZLLunEU1PJABaytZPiSkiIkjdOYZRb57B24B/A0Apvp7xaVhz0tCL
         pl591PwQRp/dcrpwWxLLMgDoFv/P7npbbY2+s/VkuB6yetCKLfwLuzaHyFWLjqI34ic6
         F8G/4OUz6eCDQl31zi/YZ3fMbpTq2lc8Y/gEmRd236Afk2/41URtdq2a0JxPwP9GOkMV
         ip0Z8hFHHevuSLS2hdZtXej0SWJ0dHAhyEwOMPQdmoF6WbNCnIBjyOXN1xqFj79GseXM
         aiDA==
X-Gm-Message-State: AOAM533vdg8KY1ZLfw4+kPP3KS1UfW2gZ5AHP0+NrputSg5en4UeH2eg
        H7Kt6GFCLNBngQtpDxOJI15g/g==
X-Google-Smtp-Source: ABdhPJwatvSqQbprk1c/oMEOGLR0UWtFeqVkvmelzVPpnXp5yBndiAquQQFvlNxWRQHf/rPgoJxbig==
X-Received: by 2002:a1c:d8:: with SMTP id 207mr4303796wma.81.1594732485190;
        Tue, 14 Jul 2020 06:14:45 -0700 (PDT)
Received: from [192.168.0.109] (84-238-136-197.ip.btc-net.bg. [84.238.136.197])
        by smtp.gmail.com with ESMTPSA id f14sm32074246wro.90.2020.07.14.06.14.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 06:14:44 -0700 (PDT)
Subject: Re: [PATCH net-next v4 03/12] bridge: mrp: Extend bridge interface
To:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        roopa@cumulusnetworks.com, davem@davemloft.net, kuba@kernel.org,
        jiri@resnulli.us, ivecera@redhat.com, andrew@lunn.ch,
        UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bridge@lists.linux-foundation.org
References: <20200714073458.1939574-1-horatiu.vultur@microchip.com>
 <20200714073458.1939574-4-horatiu.vultur@microchip.com>
From:   Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Message-ID: <e877ca40-8e84-ed05-f455-369ca43a179d@cumulusnetworks.com>
Date:   Tue, 14 Jul 2020 16:14:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200714073458.1939574-4-horatiu.vultur@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/07/2020 10:34, Horatiu Vultur wrote:
> This patch adds a new flag(BR_MRP_LOST_IN_CONT) to the net bridge
> ports. This bit will be set when the port lost the continuity of
> MRP_InTest frames.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  include/linux/if_bridge.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
> index b3a8d3054af0f..6479a38e52fa9 100644
> --- a/include/linux/if_bridge.h
> +++ b/include/linux/if_bridge.h
> @@ -49,6 +49,7 @@ struct br_ip_list {
>  #define BR_ISOLATED		BIT(16)
>  #define BR_MRP_AWARE		BIT(17)
>  #define BR_MRP_LOST_CONT	BIT(18)
> +#define BR_MRP_LOST_IN_CONT	BIT(19)
>  
>  #define BR_DEFAULT_AGEING_TIME	(300 * HZ)
>  
> 

Acked-by: Nikolay Aleksandrov <nikolay@cumulusnetworks.com>


