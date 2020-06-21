Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE40C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 13:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BAC022516
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 13:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajr+lcAh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730128AbgFUNLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 09:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730016AbgFUNLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 09:11:34 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E53C061794
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 06:11:34 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ne5so6692078pjb.5
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jun 2020 06:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IkUGdQWMXK+kOz7YHBuqdTcLCfEzkHSPew/c4ZoAYIk=;
        b=ajr+lcAhyDq9MPdPbrMwTbTTH+zjhMpGwfMVO0yR/5wICP92yFw/c7bp6W62Q/gUG3
         b9c+GVPgsaiVuALC44jEwUPxCXYfK8di21S1Q5BrAEhPWhgBAcMa1GyRX+WgiDiMJhYO
         rieZ7eX4lxQP1QvSSHbW9SiTpWpUB1W/XmZBuUAKSnIXpM0E3oqxRlm+q5r1hJBvXAxj
         ewTgQ27yQdDVmzCGmebwYFMZNPzye98bwxU2C/FDdq6CexZoYhUeeUap8nmj+cqqNAtC
         uSdxRCoz1u5zXlMOle7mswb6H2gwfN0VR30WZGN+v0XXEeUf+/9v9NU/YXuAtpIf9Jtm
         SXKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=IkUGdQWMXK+kOz7YHBuqdTcLCfEzkHSPew/c4ZoAYIk=;
        b=oD3w93P4f9pWsXGf06Rcybg6jr0pxm685ZIApmP90u5jcIGLIVYCPHr0jYwBoFTXfy
         +BiHDKJft03ggLfl7UX5+jdRv+sdhyCpG+1cLuBWDzAPq8Aaovg6QgOarWAfstyckNMo
         yIsZBEB3mKoOQTruMQ0necaQfn693nerHJIJKyl8k3NmwFaDtJywqKF7mk4L/ckI6Zkr
         rI/+nQDethiuPCypUBkriKkQhyepa317zznpA6mLfo5DLDj8sXugVcMBWF6ugXhqXSkp
         I+htvjluXnMiQx6vzr6OmgyCh0zWaJgvslHxKkR1PvUI2hu6AhFoHNwRqVRsj7eJQiA+
         ywSw==
X-Gm-Message-State: AOAM531ZBgIf2hwUei4L5X9JSoiEwu3bJQdWeMAOC9FQZNmdHK6wzXaH
        Ymybicv34j+2GJZSpw60FzSgIwfR
X-Google-Smtp-Source: ABdhPJwv5b2lA1PMqNRi4I9Xn3bUtVBg/2c3rD2g6rNXwVK2NgkB0j7u7V6FMvpYHKOTSDReArKqUA==
X-Received: by 2002:a17:90a:247:: with SMTP id t7mr13142876pje.33.1592745092569;
        Sun, 21 Jun 2020 06:11:32 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m9sm8554036pgq.61.2020.06.21.06.11.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jun 2020 06:11:31 -0700 (PDT)
Subject: Re: [PATCH v2] dma-pool: Fix too large DMA pools on medium systems
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        David Rientjes <rientjes@google.com>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200608132217.29945-1-geert@linux-m68k.org>
 <20200620200936.GA106151@roeck-us.net>
 <CAMuHMdX3mBDm9iHk+jhbGfmo+dbix=3tp5z2ewyddWxM1tdqGQ@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <c0889f5c-34ae-2314-6530-a9240e0901f2@roeck-us.net>
Date:   Sun, 21 Jun 2020 06:11:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdX3mBDm9iHk+jhbGfmo+dbix=3tp5z2ewyddWxM1tdqGQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/20 1:35 AM, Geert Uytterhoeven wrote:
> Hi Günter,
> 
> On Sat, Jun 20, 2020 at 10:09 PM Guenter Roeck <linux@roeck-us.net> wrote:
>> On Mon, Jun 08, 2020 at 03:22:17PM +0200, Geert Uytterhoeven wrote:
>>> On systems with at least 32 MiB, but less than 32 GiB of RAM, the DMA
>>> memory pools are much larger than intended (e.g. 2 MiB instead of 128
>>> KiB on a 256 MiB system).
>>>
>>> Fix this by correcting the calculation of the number of GiBs of RAM in
>>> the system.  Invert the order of the min/max operations, to keep on
>>> calculating in pages until the last step, which aids readability.
>>>
>>> Fixes: 1d659236fb43c4d2 ("dma-pool: scale the default DMA coherent pool size with memory capacity")
>>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>>> Acked-by: David Rientjes <rientjes@google.com>
>>
>> This patch results in a boot failure in some of my powerpc boot tests,
>> specifically those testing boots from mptsas1068 devices. Error message:
>>
>> mptsas 0000:00:02.0: enabling device (0000 -> 0002)
>> mptbase: ioc0: Initiating bringup
>> ioc0: LSISAS1068 A0: Capabilities={Initiator}
>> mptbase: ioc0: ERROR - Unable to allocate Reply, Request, Chain Buffers!
>> mptbase: ioc0: ERROR - didn't initialize properly! (-3)
>> mptsas: probe of 0000:00:02.0 failed with error -3
>>
>> Configuration is bamboo:44x/bamboo_defconfig plus various added drivers.
>> Qemu command line is
>>
>> qemu-system-ppc -kernel vmlinux -M bamboo \
>>      -m 256 -no-reboot -snapshot -device mptsas1068,id=scsi \
>>      -device scsi-hd,bus=scsi.0,drive=d0,wwn=0x5000c50015ea71ac -drive \
>>      file=rootfs.ext2,format=raw,if=none,id=d0 \
>>      --append "panic=-1 slub_debug=FZPUA root=/dev/sda  mem=256M console=ttyS0" \
>>      -monitor none -nographic
>>
>> canyonlands_defconfig with sam460ex machine and otherwise similar command line
>> fails as well.
>>
>> Reverting this patch fixes the problem.
> 
> This looks like the minimum value of 128 KiB is not sufficient, and the
> bug is in the intention of 1d659236fb43c4d2 ("dma-pool: scale the
> default DMA coherent pool size with memory capacity")?
> Before, there was a single pool of (fixed) 256 KiB size, now there are
> up to three coherent pools (DMA, DMA32, and kernel), albeit of smaller
> size (128 KiB each).
> 
> Can you print the requested size in drivers/message/fusion/mptbase.c:
> PrimeIocFifos()?

172928 bytes

> Does replacing all SZ_128K by SZ_256K in my patch help?

Yes, it does.

Guenter
