Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2725CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 13:23:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7B612075D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 13:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="K7j7VQvW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728194AbgFZNXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 09:23:05 -0400
Received: from smtpcmd02101.aruba.it ([62.149.158.101]:45381 "EHLO
        smtpcmd02101.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgFZNXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 09:23:04 -0400
X-Greylist: delayed 430 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Jun 2020 09:23:03 EDT
Received: from [192.168.1.129] ([93.146.66.165])
        by smtpcmd02.ad.aruba.it with bizsmtp
        id vpFk2200D3Zw7e501pFldb; Fri, 26 Jun 2020 15:15:51 +0200
Subject: Re: [PATCH 01/10] misc: c2port: core: Ensure source size does not
 equal destination size in strncpy()
To:     Lee Jones <lee.jones@linaro.org>, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rodolfo Giometti <giometti@linux.it>,
        "Eurotech S.p.A" <info@eurotech.it>
References: <20200626130525.389469-1-lee.jones@linaro.org>
 <20200626130525.389469-2-lee.jones@linaro.org>
From:   Rodolfo Giometti <giometti@enneenne.com>
Message-ID: <7d8996e9-74d3-ca47-cae8-a457c9a4baab@enneenne.com>
Date:   Fri, 26 Jun 2020 15:15:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200626130525.389469-2-lee.jones@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aruba.it; s=a1;
        t=1593177351; bh=tjoxSQWjytk5PnjXa46BXRfkKzFN75tkC7pTAZu4Kk0=;
        h=Subject:To:From:Date:MIME-Version:Content-Type;
        b=K7j7VQvWWR4cwXC2jbkjy/WF6kq1IwGqR4gre2cjOj66WtuBXYtjkMLNBTkrG88+N
         TYDHKVZsKlNlx17RZtR1kZzJUd2F89URbl2Pm7rS3f9zAR995MDVKD2kdpYVf0pAk0
         JAsSZoY8piIbjdbvf3mXUoMHetCdoPdDAa+HLJBnFkUzL3B1SzK23rx64IW+y+2gxa
         iF3NyxkP7WSzHtIfE7XoUtwLsNHzhilNwJrz6xHMXxiaMc5hh2saSWdVWAZCNLIS5G
         JqCZIwr/WHsz7gUQz/PsIw4g1QK5d0XwFPjYzzLq77Y9fCmc0Fdlj4gDD2VT4Jtjdf
         Ku1We2atPoaog==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/06/2020 15:05, Lee Jones wrote:
> We need to ensure there's a place for the NULL terminator.
> 
> Fixes the following W=1 warning(s):
> 
>  In file included from include/linux/bitmap.h:9,
>  from include/linux/nodemask.h:95,
>  from include/linux/mmzone.h:17,
>  from include/linux/gfp.h:6,
>  from include/linux/umh.h:4,
>  from include/linux/kmod.h:9,
>  from include/linux/module.h:16,
>  from drivers/misc/c2port/core.c:9:
>  In function ‘strncpy’,
>  inlined from ‘c2port_device_register’ at drivers/misc/c2port/core.c:926:2:
>  include/linux/string.h:297:30: warning: ‘__builtin_strncpy’ specified bound 32 equals destination size [-Wstringop-truncation]
>  297 | #define __underlying_strncpy __builtin_strncpy
>  | ^
>  include/linux/string.h:307:9: note: in expansion of macro ‘__underlying_strncpy’
>  307 | return __underlying_strncpy(p, q, size);
>  | ^~~~~~~~~~~~~~~~~~~~
> 
> Cc: Rodolfo Giometti <giometti@linux.it>
> Cc: "Eurotech S.p.A" <info@eurotech.it>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/misc/c2port/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/c2port/core.c b/drivers/misc/c2port/core.c
> index 33bba18022892..80d87e8a0bea9 100644
> --- a/drivers/misc/c2port/core.c
> +++ b/drivers/misc/c2port/core.c
> @@ -923,7 +923,7 @@ struct c2port_device *c2port_device_register(char *name,
>  	}
>  	dev_set_drvdata(c2dev->dev, c2dev);
>  
> -	strncpy(c2dev->name, name, C2PORT_NAME_LEN);
> +	strncpy(c2dev->name, name, C2PORT_NAME_LEN - 1);
>  	c2dev->ops = ops;
>  	mutex_init(&c2dev->mutex);
>  

Acked-by: Rodolfo Giometti <giometti@enneenne.com>

Note that giometti@linux.it is just an alias. My main e-mail address is
giometti@enneenne.com

Rodolfo Giometti

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming                     skype:  rodolfo.giometti
