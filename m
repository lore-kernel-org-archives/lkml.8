Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F8CC433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 21:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33F042082E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 21:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THgzZSec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgGMVPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 17:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbgGMVPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 17:15:45 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCC6C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 14:15:45 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id p26so2705428oos.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 14:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qjuZJNT2nmHWODfcbipNILNPsrHac01Xb1NkyxlZsYo=;
        b=THgzZSecpJNXVHihMziM8zXe9G4OVd57nNd/IYrlmkoCMEKtq1phQFDbY3R8Pghqow
         idlzkoH+hU59tOaGmgdJ2tfduM1cTqHe2305ymOrU5HDxps3GsDXjg1ynxyRGlkjTJM/
         rwM/9Y2LmB5HAOwMbf/sanxUEz3sa8O7ae7B5JTNKMqfbZ6+38RSBv3uK7YKpKmzdgjM
         iZeDhR9EraH8ZR7R60VSb0tVBRX7ExPS1gJWwVf8WFVHj5PaqLQ5KbHzCv3IZ3Nkz3Wi
         9I3XX3z1xNeXfUGNK2I3XtAgG6K28dgXiJLvTK2xHg81kCFnFJRQHL/r59iqZD5tEKBK
         WgEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qjuZJNT2nmHWODfcbipNILNPsrHac01Xb1NkyxlZsYo=;
        b=AWaV955HBuohckJR75Vffh+c73sl3XOpcrfU6e4ocIyGUdsHnvrzLlO5SJnAQkqxGd
         +SqPvhJ6Hb8zL5sRRlu/+KsRVnAo4tDBSY80+HlifmwGLiln544l6Q0fElLGgOYuwjz7
         UdkmZTHLuhkgWjufA4ES1vHTFc/IUI2+LzpaJj/tStAHRoRJzwNYuhAF7tGvAQfzDzvv
         n2R4JEwne2UOMwlwKimP9d4fvp22aKDhkVoO0+PEE3EvWNEQPL/PCS6cqlvzopTZ1nge
         XZGTPs33c7KwoXxDhcN2jOz3AUupJ+MY3cLzKdFdIVumPLcPK4Bt8XI2hAuMcLPbNrrf
         gh4Q==
X-Gm-Message-State: AOAM530wTFTfwq7SxE6y34fegnO/ni72tX5M38PwMEhSjwkpTBr2HW4c
        ToNQsNoTBOnRhIpCnEkNyIg=
X-Google-Smtp-Source: ABdhPJzIfN1AboVENY11PTwSGMDeDkiICqolIWkLTLNFk3ZVzw9gpWcs4af337SaL2dnxAyoWl24cg==
X-Received: by 2002:a4a:7459:: with SMTP id t25mr1731283ooe.25.1594674944498;
        Mon, 13 Jul 2020 14:15:44 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id c206sm3321930oob.22.2020.07.13.14.15.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2020 14:15:43 -0700 (PDT)
Subject: Re: [PATCH] staging: r8188eu: remove unused members of struct
 xmit_buf
To:     Ivan Safonov <insafonov@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Soumyajit Deb <debsoumyajit100@gmail.com>
References: <20200712123821.553420-1-insafonov@gmail.com>
 <20200713131607.GR2549@kadam> <20200713142305.GV2549@kadam>
 <5fdeb963-2729-dbc5-3fba-85998e28d8d5@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <1fa0b2fe-4320-f1e0-c3ca-6a3b4b5fea18@lwfinger.net>
Date:   Mon, 13 Jul 2020 16:15:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5fdeb963-2729-dbc5-3fba-85998e28d8d5@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/20 1:28 PM, Ivan Safonov wrote:
> On 7/13/20 5:23 PM, Dan Carpenter wrote:
>> On Mon, Jul 13, 2020 at 04:16:07PM +0300, Dan Carpenter wrote:
>>> On Sun, Jul 12, 2020 at 03:38:21PM +0300, Ivan Safonov wrote:
>>>> Remove unused members of struct xmit_buf: alloc_sz, ff_hwaddr,
>>>> dma_transfer_addr, bpending and last.
>>>>
>>>> Signed-off-by: Ivan Safonov <insafonov@gmail.com>
>>>> ---
>>>>   drivers/staging/rtl8188eu/include/rtw_xmit.h  | 5 -----
>>>>   drivers/staging/rtl8188eu/os_dep/xmit_linux.c | 1 -
>>>>   2 files changed, 6 deletions(-)
>>>>
>>>> diff --git a/drivers/staging/rtl8188eu/include/rtw_xmit.h 
>>>> b/drivers/staging/rtl8188eu/include/rtw_xmit.h
>>>> index 12d16e98176a..3c03987c81a1 100644
>>>> --- a/drivers/staging/rtl8188eu/include/rtw_xmit.h
>>>> +++ b/drivers/staging/rtl8188eu/include/rtw_xmit.h
>>>> @@ -193,14 +193,9 @@ struct xmit_buf {
>>>>       void *priv_data;
>>>>       u16 ext_tag; /*  0: Normal xmitbuf, 1: extension xmitbuf. */
>>>>       u16 flags;
>>>> -    u32 alloc_sz;
>>>>       u32  len;
>>>>       struct submit_ctx *sctx;
>>>> -    u32    ff_hwaddr;
>>>>       struct urb *pxmit_urb[8];
>>>> -    dma_addr_t dma_transfer_addr;    /* (in) dma addr for transfer_buffer */
>>>> -    u8 bpending[8];
>>>> -    int last[8];
>>>>   };
>>>>   struct xmit_frame {
>>>> diff --git a/drivers/staging/rtl8188eu/os_dep/xmit_linux.c 
>>>> b/drivers/staging/rtl8188eu/os_dep/xmit_linux.c
>>>> index 017e1d628461..61ced1160951 100644
>>>> --- a/drivers/staging/rtl8188eu/os_dep/xmit_linux.c
>>>> +++ b/drivers/staging/rtl8188eu/os_dep/xmit_linux.c
>>>> @@ -24,7 +24,6 @@ int rtw_os_xmit_resource_alloc(struct adapter *padapter,
>>>>           return _FAIL;
>>>>       pxmitbuf->pbuf = PTR_ALIGN(pxmitbuf->pallocated_buf, XMITBUF_ALIGN_SZ);
>>>
>>> Not related to this patch but kmalloc always returns data which is at
>>> least ARCH_KMALLOC_MINALIGN aligned which is never less than
>>> XMITBUF_ALIGN_SZ (4) so this is a no-op.
> 
> 4-byte alignment for 8-byte pointer (for example void *priv_data) on 64-bit arch 
> is an _error_. It’s good that kmalloc (and vmalloc) is already aligned to 8 bytes.
> 
>>
>> The alignment in the driver is pretty crazy because it's all unnecessary
>> and so complicated.  Every allocation is 4 bytes extra so we can align
>> it later.
>>
>> Also every buffer is called "pbuf" which stands for pointer to buffer.
>> "pallocated_buf" is not really useful either.
>>
>> I tried to look at this to see if we could change the alignment, and
>> it's complicated because of the naming and the alignment.
>>
>> regards,
>> dan carpenter
>>
> 
> I have already fixed 4 places with unnecessary alignment, but, alas, there is no 
> great desire to test them on real hardware.

I have now tested on real hardware and it works fine.

Acked-by: Larry Finger <Larry.Finger@lwfinger.net>

Larry

