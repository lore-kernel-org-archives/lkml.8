Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D2BC47254
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 09:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB8BC20731
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 09:48:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="CIXNVKyD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728477AbgEAJsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 05:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728325AbgEAJsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 05:48:19 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72C7C08E934
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 02:48:17 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id w14so3515300lfk.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 02:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=E+55KwVtt39F0FUZIs63usXF4KVchVbXru/GQRmkybk=;
        b=CIXNVKyDmwb8SV/NbRJQk9UZx8Ir4gNmbPMoRURR1iyNmzylzhzLVIcLf1SMlAKveD
         W4wDAVdMIYGaZbLWYFzpr13vbW9cssGoEe7103U88rWveWju+ImT+J3JONN7q1ra9H+m
         QZDa9CVvYPluroCNd4TExPCiXORowi3d/lzTxz2KJYGmv6HA6Lh4JakRbRFsqOZXgoDM
         g2Jf2edvpG2bWmxZ2Iyu2HKym/j0+TyPKvIpAY7OOsWVVfkjGSc/Gj9t4Etg86DaW9eU
         ayxv+N3ZGcdeO0PillFzQm7ucOQ2MP6mLw+/NGH2gqTMQIqZ1XWT8zgzRj53TIpV7aHv
         VQVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=E+55KwVtt39F0FUZIs63usXF4KVchVbXru/GQRmkybk=;
        b=sFnnG9tp/7HP5LX4phDN+gCIfvREtTRpmy8PsXIUKIqke/EmXmTyfDnCZvV2VZ+STQ
         8nN0cv69me2Jk96WhYL2ZFPZptZ1y1ADLEK658qeIGAx5/oJnmEAKxiLF8KfKikuNCEs
         v3l218c0tZSACtCgrKvQQ7TYlFKXMp0RuoS7KSJlJr82DnwjMMD4rAjUUCSJZJCCiagV
         C4Uqn+6IgFjASCatVxd5wHasfBmIzSs35ABmMN0ILr86byQQbubtYsdsnEmdCo9CsNgG
         WdrTXhLoeLXRHbCyhr0w3HG3MHg5iJZQhMBj5Ge1D6mKFC6iPOFyaK8NDA82Ss5I5QN/
         SYVQ==
X-Gm-Message-State: AGi0Puaot7EeCBhohgRg1gCGR4kXPhGffABLSDyzCveBhtOZ+jlIom58
        +2SBnSOW291ULwJCwWf7pTmsWUMlQPTBNg==
X-Google-Smtp-Source: APiQypLgGjXO9MDw1TPGncnfKI11yrNESA8OV1lYN+DhUjHxtAsh8XDLnZsRw7NOlFlFZ/inyqoqfQ==
X-Received: by 2002:ac2:464c:: with SMTP id s12mr1978836lfo.147.1588326495967;
        Fri, 01 May 2020 02:48:15 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:26a:3272:1523:7e11:1c84:29f6? ([2a00:1fa0:26a:3272:1523:7e11:1c84:29f6])
        by smtp.gmail.com with ESMTPSA id p8sm1640722ljn.93.2020.05.01.02.48.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2020 02:48:15 -0700 (PDT)
Subject: Re: [PATCH] MIPS: tools: Show result for loongson3-llsc-check
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>
References: <1588250184-18730-1-git-send-email-yangtiezhu@loongson.cn>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <b53aef0a-2441-3c4b-ebf0-74d0203eeda0@cogentembedded.com>
Date:   Fri, 1 May 2020 12:48:03 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1588250184-18730-1-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 30.04.2020 15:36, Tiezhu Yang wrote:

> It is better to show the result before loongson3-llsc-check exit,
> otherwise we can see nothing if the return status is EXIT_SUCCESS,
> it seems confusing.
> 
> E.g. without this patch:
> 
> [loongson@localhost tools]$ ./loongson3-llsc-check ../../../vmlinux
> [loongson@localhost tools]$
> 
> With this patch:
> 
> [loongson@localhost tools]$ ./loongson3-llsc-check ../../../vmlinux
> loongson3-llsc-check returns success
> [loongson@localhost tools]$
> 
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>   arch/mips/tools/loongson3-llsc-check.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/mips/tools/loongson3-llsc-check.c b/arch/mips/tools/loongson3-llsc-check.c
> index 0ebddd0..facd016 100644
> --- a/arch/mips/tools/loongson3-llsc-check.c
> +++ b/arch/mips/tools/loongson3-llsc-check.c
> @@ -303,5 +303,7 @@ int main(int argc, char *argv[])
>   out_close:
>   	close(vmlinux_fd);
>   out_ret:
> +	fprintf(stdout, "loongson3-llsc-check %s\n",
> +		status ? "returns failure" : "returns success");

    Why not "loongson3-llsc-check returns %s\n"?

>   	return status;
>   }
> 

MBR, Sergei
