Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918D1C2BB55
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 09:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6849020801
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 09:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="0VEEMUSX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbgDJJrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 05:47:14 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38329 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbgDJJrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 05:47:13 -0400
Received: by mail-lf1-f65.google.com with SMTP id l11so981215lfc.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 02:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ixWyit/BPi4Ka4deLVPgn2JfqAzulpluWjNuC7xycq0=;
        b=0VEEMUSXUIZzs5iYhN0FjOM3beqogpopP5rDDncQ9uEaoy9IhQCJpSjbS/XcuVqDNn
         U4gUQkn5snZ9ZQ951zs+i+EwryOye3aC64VlDiiQi91q54yOP4gLGuYywdugT/hJpCIp
         C9a//G0v6owmNFn1orp3IT+/Lk3iCxeR/d8bvRnRtTgW+gGXHLUE8BuVyv2tZXgKVDO0
         AdUUecxb5LHlNX8BwTIYJBdEBA6UF8fRgSiyky5Dp/ppC5ILPbCQdykVBXwRQ684kNIp
         rsKAmvl92WXQL/jppPC/wRaply/yTd2ovdgP+9ZA8v8YQubFLxfk2BJx24xnib5XMnwn
         3m9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ixWyit/BPi4Ka4deLVPgn2JfqAzulpluWjNuC7xycq0=;
        b=EpfLJXjKujMA1YUgPGRqivWS0ciAUSaeYluIWsKgmU0fGQLN2aJK6wtp4+edKXqPy3
         0/Jfk45pbRMAIjEoAJtuRphMzN0SLewi4++G0gpdL5N5Pur9quHyiKrKMM6RX2KJwgkS
         gHEL2f3oerzvc42WQH0X4QXmqHk6Y8tcZnct2Kpd6XbaSyzIK3EuvLp+WALfzTE+tLjf
         a4Ry+JoZJuPWIeUavYkofJCY0pBjr7Pz+jhdP8Ve+a10G3ggvt42ZU7mKSxKGQC3leT1
         0Mhyq8cY4j441camvDHSeNXW/+ksYYZFxXktIDOGc7oNadYMmuHPDl2AQ+Lp5JUgkdMj
         7PzA==
X-Gm-Message-State: AGi0PuYfappiGpNFH/nTh9XhywTtAS/IM5fe4AU6QLSJf7PO3l10k+Qo
        7+kLWKC9Gum1somBzbJrySxaFg==
X-Google-Smtp-Source: APiQypKlvy1p+ulGm7rmqXh0dNWrbd9j3xSh46zFxUDGl1I0qpueqnZ7JooiYzM/K+nLb3U/hKGRBQ==
X-Received: by 2002:ac2:498d:: with SMTP id f13mr2157743lfl.75.1586512032084;
        Fri, 10 Apr 2020 02:47:12 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:449c:a024:b8e5:a34a:c38e:b427? ([2a00:1fa0:449c:a024:b8e5:a34a:c38e:b427])
        by smtp.gmail.com with ESMTPSA id o6sm794019lji.15.2020.04.10.02.47.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2020 02:47:11 -0700 (PDT)
Subject: Re: [PATCH] usb: gadget: fsl: Fix a wrong judgment in fsl_udc_probe()
To:     Tang Bin <tangbin@cmss.chinamobile.com>, leoyang.li@nxp.com,
        balbi@kernel.org, gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Markus.Elfring@web.de,
        Shengju Zhang <zhangshengju@cmss.chinamobile.com>
References: <20200410015832.8012-1-tangbin@cmss.chinamobile.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <02aeae70-60b8-761c-b058-8b4bc78ffd99@cogentembedded.com>
Date:   Fri, 10 Apr 2020 12:47:01 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200410015832.8012-1-tangbin@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.04.2020 4:58, Tang Bin wrote:

> If the function "platform_get_irq()" failed, the negative value
> returned will not be detected here, including "-EPROBE_DEFER", which
> causes the application to fail to get the correct error message.
> Thus it must be fixed.

    platform_get_irq() prints an appropriate error message, the problem is that
the current code calls request_irq() with error code instead of IRQ.

> Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
> Signed-off-by: Shengju Zhang <zhangshengju@cmss.chinamobile.com>
[...]

MBR, Sergei
