Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C32C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 10:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41E7B206C1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 10:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728319AbgGWKZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 06:25:30 -0400
Received: from gecko.sbs.de ([194.138.37.40]:46523 "EHLO gecko.sbs.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726867AbgGWKZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 06:25:29 -0400
Received: from mail2.sbs.de (mail2.sbs.de [192.129.41.66])
        by gecko.sbs.de (8.15.2/8.15.2) with ESMTPS id 06NAPMTB009202
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Jul 2020 12:25:22 +0200
Received: from [139.25.68.37] ([139.25.68.37])
        by mail2.sbs.de (8.15.2/8.15.2) with ESMTP id 06NAPMp8032716;
        Thu, 23 Jul 2020 12:25:22 +0200
Subject: Re: [PATCH] scripts/gdb: fix lx-symbols 'gdb.error' while loading
 modules
To:     Stefano Garzarella <sgarzare@redhat.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Kieran Bingham <kbingham@kernel.org>
References: <20200722102239.313231-1-sgarzare@redhat.com>
From:   Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <418f0953-1815-1844-e3f5-a11f2a5eaf33@siemens.com>
Date:   Thu, 23 Jul 2020 12:25:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722102239.313231-1-sgarzare@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.07.20 12:22, Stefano Garzarella wrote:
> Commit ed66f991bb19 ("module: Refactor section attr into bin
> attribute") removed the 'name' field from 'struct module_sect_attr'
> triggering the following error when invoking lx-symbols:
> 
>    (gdb) lx-symbols
>    loading vmlinux
>    scanning for modules in linux/build
>    loading @0xffffffffc014f000: linux/build/drivers/net/tun.ko
>    Python Exception <class 'gdb.error'> There is no member named name.:
>    Error occurred in Python: There is no member named name.
> 
> This patch fixes the issue taking the module name from the 'struct
> attribute'.
> 
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>   scripts/gdb/linux/symbols.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/gdb/linux/symbols.py b/scripts/gdb/linux/symbols.py
> index be984aa29b75..1be9763cf8bb 100644
> --- a/scripts/gdb/linux/symbols.py
> +++ b/scripts/gdb/linux/symbols.py
> @@ -96,7 +96,7 @@ lx-symbols command."""
>               return ""
>           attrs = sect_attrs['attrs']
>           section_name_to_address = {
> -            attrs[n]['name'].string(): attrs[n]['address']
> +            attrs[n]['battr']['attr']['name'].string(): attrs[n]['address']
>               for n in range(int(sect_attrs['nsections']))}
>           args = []
>           for section_name in [".data", ".data..read_mostly", ".rodata", ".bss",
> 

Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>

Thanks,
Jan

-- 
Siemens AG, Corporate Technology, CT RDA IOT SES-DE
Corporate Competence Center Embedded Linux
