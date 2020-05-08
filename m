Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FADC47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 175D220720
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:01:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xen0n.name header.i=@xen0n.name header.b="RKZgcroP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729510AbgEHNBv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:01:51 -0400
Received: from [115.28.160.31] ([115.28.160.31]:37932 "EHLO
        mailbox.box.xen0n.name" rhost-flags-FAIL-FAIL-OK-OK)
        by vger.kernel.org with ESMTP id S1729210AbgEHNBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:01:45 -0400
X-Greylist: delayed 584 seconds by postgrey-1.27 at vger.kernel.org; Fri, 08 May 2020 09:01:44 EDT
Received: from hanazono.local (unknown [116.236.177.50])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 332BC600B4;
        Fri,  8 May 2020 20:51:56 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=xen0n.name; s=mail;
        t=1588942316; bh=HDjHMr6Wm9wSc694o01E98JEM0XZjMXpbv98vll1dXs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RKZgcroPWCAm49IrZ9c+3R18tnP6iedDoJVXpGk4K0jbg9X9S1K1OtlrZtloC6CyB
         QUeuh0EYGIio+qc3f/g0WNT43E8PVrWA6wJV5wAZhSKNnQB4C4yIAyBdV4ejeM+rmu
         T+eSOIID5kTd5kAAmykDuKmLyqDhkNkc1ZXdz4sc=
Subject: Re: [PATCH 2/3] MIPS: Loongson: Add hwmon support for generic CPU
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>
References: <1588938904-924-1-git-send-email-yangtiezhu@loongson.cn>
 <1588938904-924-3-git-send-email-yangtiezhu@loongson.cn>
From:   WANG Xuerui <kernel@xen0n.name>
Message-ID: <f7184121-c044-6e79-78ab-dcc9103b27c2@xen0n.name>
Date:   Fri, 8 May 2020 20:51:55 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.0a1
MIME-Version: 1.0
In-Reply-To: <1588938904-924-3-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/5/8 19:55, Tiezhu Yang wrote:

> Add PRID_IMP_LOONGSON_64G case to enable hwmon support for Loongson
> generic CPU such as 3A4000 and newer CPU.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>   drivers/platform/mips/cpu_hwmon.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/platform/mips/cpu_hwmon.c b/drivers/platform/mips/cpu_hwmon.c
> index add5f52..7b4bde1 100644
> --- a/drivers/platform/mips/cpu_hwmon.c
> +++ b/drivers/platform/mips/cpu_hwmon.c
> @@ -43,6 +43,7 @@ int loongson3_cpu_temp(int cpu)
>   		break;
>   	case PRID_REV_LOONGSON3A_R3_0:
>   	case PRID_REV_LOONGSON3A_R3_1:
> +	case PRID_IMP_LOONGSON_64G:
>   	default:
>   		reg = (reg & 0xffff)*731/0x4000 - 273;
>   		break;

Hi,

This is obviously wrong, as the value being matched is a PRID_REV. You 
can tell from the neighboring match arms.

Also, the LOONGSON_64G cores are 3A4000 and newer, that have CSR 
support. The csr_temp_enable flag is probed in loongson_hwmon_init, then 
the switch is simply never entered for these.

