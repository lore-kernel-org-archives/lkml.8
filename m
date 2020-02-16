Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996ACC2BA83
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 14:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7570520857
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 14:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728284AbgBPOmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 09:42:21 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:56909 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbgBPOmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 09:42:21 -0500
X-Originating-IP: 79.86.19.127
Received: from [192.168.0.12] (127.19.86.79.rev.sfr.net [79.86.19.127])
        (Authenticated sender: alex@ghiti.fr)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id DFF67C0007;
        Sun, 16 Feb 2020 14:42:17 +0000 (UTC)
Subject: Re: [PATCH v2 2/3] riscv: End kernel region search in setup_bootmem
 earlier
To:     Jan Kiszka <jan.kiszka@web.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
References: <cover.1581767384.git.jan.kiszka@web.de>
 <b11898805c2f9f01b10867a05701aa0fafeaa886.1581767384.git.jan.kiszka@web.de>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <8f0ddf1f-1ea9-8bde-76a0-ba60788c2a2d@ghiti.fr>
Date:   Sun, 16 Feb 2020 09:42:17 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <b11898805c2f9f01b10867a05701aa0fafeaa886.1581767384.git.jan.kiszka@web.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

On 2/15/20 6:49 AM, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> No need to look further when that single region is found.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> =2D--
>   arch/riscv/mm/init.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index aec39a56d6cf..a774547e9021 100644
> =2D-- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -160,6 +160,8 @@ void __init setup_bootmem(void)
>   			if (reg->base + mem_size < end)
>   				memblock_remove(reg->base + mem_size,
>   						end - reg->base - mem_size);
> +
> +			break;
>   		}
>   	}
>   	BUG_ON(mem_size =3D=3D 0);
> =2D-
> 2.16.4
> 
> 

I was looking at the test above that determines if the current memblock 
contains the kernel:

if (reg->base <= vmlinux_end && vmlinux_end <= end)

Shouldn't it be:

if (reg->base <= vmlinux_start && vmlinux_end <= end)

?

Otherwise, we can indeed stop as soon as we found the region containing 
the kernel, so feel free to add:

Reviewed-by: Alexandre Ghiti <alex@ghiti.fr>

Thanks,

Alex
