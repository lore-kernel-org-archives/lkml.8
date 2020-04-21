Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD42C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 20:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79883206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 20:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LHeG0J8r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgDUUZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 16:25:51 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24363 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725930AbgDUUZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 16:25:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587500749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BNhmHt4RMHenaofqoWMv475WdAp14sVTXvWnABShIgI=;
        b=LHeG0J8rgfvivEQ9MtA788gmhm+5sfksm/jIl1zOxL6WxBB3I9ujkHMB6UAFAunxZu1Imm
        VSpMcdqcuewBE5vdlaLSuRcgst4UkOpoyXvdQHtQJSKpBr+djGfPbjVqS7PjZzaaJwdHan
        vBtM3gvtcZ7JXBE5c8JBMbv0JVdXrig=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-HNLNAruhO7yCo8mlCQw5pQ-1; Tue, 21 Apr 2020 16:25:46 -0400
X-MC-Unique: HNLNAruhO7yCo8mlCQw5pQ-1
Received: by mail-wr1-f71.google.com with SMTP id g7so7436389wrw.18
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 13:25:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BNhmHt4RMHenaofqoWMv475WdAp14sVTXvWnABShIgI=;
        b=nbNaAZ5TQEmb8F5dh0Z54gChiY+FmBTRp5aVuw70K+YCJpKZy3YxZNLJUobjIza6yR
         EtJ1Y+Q9WBz1tIX1832RNg4PKY86Ru+jnxrEABrJK+NfmSkyIxUYEOGs4iHdCUBMuI/3
         n2jNbMy0p5Kr1vm7XFbGXCNv8nOZEqwubbAI+o0vA5UxHaQ7cFWKGkR9tPcOVDottww+
         0NL1nRsMol2b1ZP5AhXMWu2BjfS5Tt1QuzETooysuEX3a6Ovt+hnYzGkaTXaSD5Z+6YB
         V4s72VZNkU63WdA10iXKYCk+/6VWVswVJYbEKxlioFFAXfV8gu7YBfSVFxRUFI+jGT7l
         +R9A==
X-Gm-Message-State: AGi0PuavBDaVZpG5jYDXCThGTMvKoUc8fvfz7W/Cvb4SDfftc/jweQeL
        /GHITPFE4aY9GI9H0x1MGnyjkwDKqoI+qaSr/RwUp+JpHqrLByysCwKaoOC+RTBoeV7zzxzTGFS
        8HKrkZ2Fkr+cmUmI9KNFjsdqj
X-Received: by 2002:a1c:7d90:: with SMTP id y138mr7105638wmc.121.1587500744439;
        Tue, 21 Apr 2020 13:25:44 -0700 (PDT)
X-Google-Smtp-Source: APiQypKEl1/LaKqe5TKbNDkzBHlY5TT0KgVkGRX8P7aeJwKLOlLKLxxk/V4PeDMiOLVOh9I8f0byQQ==
X-Received: by 2002:a1c:7d90:: with SMTP id y138mr7105610wmc.121.1587500744175;
        Tue, 21 Apr 2020 13:25:44 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id 17sm4730210wmo.2.2020.04.21.13.25.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2020 13:25:43 -0700 (PDT)
Subject: Re: [PATCH v2] tpm/tpm_tis: Free IRQ if probing fails
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     linux-integrity@vger.kernel.org, stable@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200416160751.180791-1-jarkko.sakkinen@linux.intel.com>
 <fa25cd78-2535-d26d-dd66-d64111af857a@redhat.com>
 <20200421195403.GA46589@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <2692261d-5395-b03c-2a6f-1694212cd2d4@redhat.com>
Date:   Tue, 21 Apr 2020 22:25:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200421195403.GA46589@linux.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/21/20 9:54 PM, Jarkko Sakkinen wrote:
> On Tue, Apr 21, 2020 at 03:23:19PM +0200, Hans de Goede wrote:
>> Hi,
>>
>> On 4/16/20 6:07 PM, Jarkko Sakkinen wrote:
>>> Call disable_interrupts() if we have to revert to polling in order not to
>>> unnecessarily reserve the IRQ for the life-cycle of the driver.
>>>
>>> Cc: stable@vger.kernel.org # 4.5.x
>>> Reported-by: Hans de Goede <hdegoede@redhat.com>
>>> Fixes: e3837e74a06d ("tpm_tis: Refactor the interrupt setup")
>>> Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
>>
>> I can confirm that this fixes the "irq 31 nobody cared" oops for me:
>>
>> Tested-by: Hans de Goede <hdegoede@redhat.com>
> 
> Hi, thanks a lot! Unfortunately I already put this out given the
> criticality of the issue:
> 
> https://lkml.org/lkml/2020/4/20/1544
> 
> Sincere apologies that I couldn't include your tested-by

No problem.

> but the most
> important thing is to know that it works now.

Agreed.

Regards,

Hans

