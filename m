Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB70C3F2CE
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 12:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A471B20736
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 12:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgCQM1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 08:27:46 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45672 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgCQM1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 08:27:46 -0400
Received: by mail-wr1-f66.google.com with SMTP id t2so15337676wrx.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 05:27:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Z/0pv2cjogkVFhrXiDlUMAJAgEk2pgniotPeFa2SHrg=;
        b=bpfM7fpMyvcChI20yNqXJoi7mWB7wF1tSvgUlICzn9caQ9W7VKo9iasBZW+5089FPE
         L7tAsA1xSduHvZ2yw8Ah7jXmMEiwP24yKM3m8/n+2M1Esxwvrw2xw0T8pKylTIj3I0ff
         YcGkf6kTBWxBuLDRaqfvHCM8jpx+JXmxx3uXY24cvVPAPn8LIvHnngNCabOwcdssn7jX
         nXvMkuFBx1m+jx7n/d3FtIgElDm3sDPzsGrTejnwpNhlA2FzsVO0Yssq5Vj8rI4FUh8X
         ATIsNr77MxzEIlQVnwpUtyxHhF9M9BqNu7Kj/tAv19zGNEjSkCr2kSgnzDd+HsREfagb
         GGWA==
X-Gm-Message-State: ANhLgQ2iwGxERYqbfc2ZEsO4cOzdOwaWqpY1kfv8qgsFj8O2Cqqf/T4r
        U004HXAoUYs5ckCXaW3Q1JDUesd6
X-Google-Smtp-Source: ADFU+vtnxwsxHEB3pSpthopYmWwdNXfWd4kstw7VnPi1YAvzF5TiP/r9pXlgZgkL9Lx3PfhiS2I6ig==
X-Received: by 2002:adf:a457:: with SMTP id e23mr5888629wra.21.1584448063209;
        Tue, 17 Mar 2020 05:27:43 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id r28sm4563634wra.16.2020.03.17.05.27.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2020 05:27:42 -0700 (PDT)
Subject: Re: [PATCH 18/22] tty: mips_ejtag_fdc: Mark expected switch
 fall-through
To:     Sergey Semin <Sergey.Semin@baikalelectronics.ru>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-kernel@vger.kernel.org
References: <20200306124705.6595-1-Sergey.Semin@baikalelectronics.ru>
 <20200306124913.151A68030792@mail.baikalelectronics.ru>
 <20200309161243.D5D5180307C7@mail.baikalelectronics.ru>
 <20200310010653.9DE7380307C5@mail.baikalelectronics.ru>
From:   Jiri Slaby <jslaby@suse.com>
Autocrypt: addr=jslaby@suse.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <34627024-0f0c-f17e-a10a-f24327d28b76@suse.com>
Date:   Tue, 17 Mar 2020 13:27:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200310010653.9DE7380307C5@mail.baikalelectronics.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10. 03. 20, 2:06, Sergey Semin wrote:
> On Mon, Mar 09, 2020 at 05:12:40PM +0100, Jiri Slaby wrote:
>> On 06. 03. 20, 13:47, Sergey.Semin@baikalelectronics.ru wrote:
>>> From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
>>>
>>> Mark mips_ejtag_fdc_encode() methods switch-case-4 as expecting to
>>> fall through.
>>>
>>> This patch fixes the following warning:
>>>
>>> drivers/tty/mips_ejtag_fdc.c: In function ‘mips_ejtag_fdc_encode’:
>>> drivers/tty/mips_ejtag_fdc.c:245:13: warning: this statement may fall through [-Wimplicit-fallthrough=]
>>>    word.word &= 0x00ffffff;
>>>    ~~~~~~~~~~^~~~~~~~~~~~~
>>> drivers/tty/mips_ejtag_fdc.c:246:2: note: here
>>>   case 3:
>>>   ^~~~
>>>
>>> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
>>> Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
>>> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
>>> Cc: Paul Burton <paulburton@kernel.org>
>>> Cc: Ralf Baechle <ralf@linux-mips.org>
>>> ---
>>>  drivers/tty/mips_ejtag_fdc.c | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/drivers/tty/mips_ejtag_fdc.c b/drivers/tty/mips_ejtag_fdc.c
>>> index 620d8488b83e..21e76a2ec182 100644
>>> --- a/drivers/tty/mips_ejtag_fdc.c
>>> +++ b/drivers/tty/mips_ejtag_fdc.c
>>> @@ -243,6 +243,7 @@ static struct fdc_word mips_ejtag_fdc_encode(const char **ptrs,
>>>  		/* Fall back to a 3 byte encoding */
>>>  		word.bytes = 3;
>>>  		word.word &= 0x00ffffff;
>>> +		/* Fall through */
>>
>> We now have "fallthrough;", so I believe you should use that instead of
>> comments.
>>
> 
> Hello Jiri,
> 
> Thanks for the comment. I didn't know about that new macro. Since Greg
> already pulled this patch in his tty-next branch, I won't send an
> update in the next patchset revision.

Hi, OK -- now there is a whole-tree conversion undergoing anyway, so I
think they will take care about this one too...

thanks,
-- 
js
suse labs
