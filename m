Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6E1C433F1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 18:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9B0E20738
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 18:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWLazNtt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbgGMSYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 14:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgGMSYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 14:24:04 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C4DC061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 11:24:03 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id q4so19170327lji.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 11:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HxoMMP+GmR1MWhGQitmQoUdOlu7DI+nmxZW7vTrxTMc=;
        b=YWLazNttpXz7U6yf7fRrPaMpAVJSnGSy3J4OKIjP+wbGlwW8/bxlvRRJMw9uTNyLgz
         44jsFV0dscbDiFmfO9Qg9C+CwM0denJs9ln4PoSarH5g3NUupUtouVYOlvKI0Y6IyoRM
         XeoFH7x9TcixsKoqDl5c9lcm3xahj31hTNXiSauikd7S9e5AhB5giFcNGblxvLPWRT5M
         /jfDeT66tRA5nivfQPr+CF8QUP35MSgLvIMpfJnHTzyA6fwjh26V0RgECmldn3C9WMTc
         FMaPQ+LwksyO+fpmZBvmJ8Uavg0DDuuEuwJ52ibbAfhcuJs7f5XYxOCk6mOa6jAPRD6R
         xqRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HxoMMP+GmR1MWhGQitmQoUdOlu7DI+nmxZW7vTrxTMc=;
        b=g3eimCFlXoYAx9205DAfMgNBWjMS/9f5BnQeXT91zYCQxu1d3sMfe8lFdLub2RsVoj
         jsIDGzNWXRvj0Ky9CkUvdbi0+iLeRnv5uyWPkDCo0ETzVDV/1PVdV2sZDPv54Ryt+15o
         4Zu676tcGpyDDWSMAzms/WHoYz0tqOp1NN7MgEovgo+JPmL1ESEW5g39Af64B8GEwFFg
         yZL6jSBJutQOzoU3/k4EegJaAah8NVPB5X6nThDpk22iig6I0T8qOtJ/o85WkKxieloS
         cK6zX8+uv9F8Vel2+FKcYweMrmBEMbVeady/beM6mgxk1EGw1QowQtuUui0h6jvMPcOS
         gzWg==
X-Gm-Message-State: AOAM530MtqmG7ThNat/p+2Q0AWheoIwBe/EHE44NHOshD5GIYLAXvA9V
        TH1T6yAn4vBFqG8id3Gipec=
X-Google-Smtp-Source: ABdhPJx8FToCxY+SLBzkQJdlkSftBwCRV7YPXcRy9mW6kD2inBLKAN8BTmRzXkZwl7qJHqaNeImZUg==
X-Received: by 2002:a2e:8794:: with SMTP id n20mr429972lji.359.1594664642274;
        Mon, 13 Jul 2020 11:24:02 -0700 (PDT)
Received: from [192.168.0.160] (10.177.smarthome.spb.ru. [109.71.177.10])
        by smtp.gmail.com with ESMTPSA id c14sm4773868lfb.69.2020.07.13.11.24.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2020 11:24:01 -0700 (PDT)
Subject: Re: [PATCH] staging: r8188eu: remove unused members of struct
 xmit_buf
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Nishka Dasgupta <nishkadg.linux@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Soumyajit Deb <debsoumyajit100@gmail.com>
References: <20200712123821.553420-1-insafonov@gmail.com>
 <20200713131607.GR2549@kadam> <20200713142305.GV2549@kadam>
From:   Ivan Safonov <insafonov@gmail.com>
Message-ID: <5fdeb963-2729-dbc5-3fba-85998e28d8d5@gmail.com>
Date:   Mon, 13 Jul 2020 21:28:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200713142305.GV2549@kadam>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/20 5:23 PM, Dan Carpenter wrote:
> On Mon, Jul 13, 2020 at 04:16:07PM +0300, Dan Carpenter wrote:
>> On Sun, Jul 12, 2020 at 03:38:21PM +0300, Ivan Safonov wrote:
>>> Remove unused members of struct xmit_buf: alloc_sz, ff_hwaddr,
>>> dma_transfer_addr, bpending and last.
>>>
>>> Signed-off-by: Ivan Safonov <insafonov@gmail.com>
>>> ---
>>>   drivers/staging/rtl8188eu/include/rtw_xmit.h  | 5 -----
>>>   drivers/staging/rtl8188eu/os_dep/xmit_linux.c | 1 -
>>>   2 files changed, 6 deletions(-)
>>>
>>> diff --git a/drivers/staging/rtl8188eu/include/rtw_xmit.h b/drivers/staging/rtl8188eu/include/rtw_xmit.h
>>> index 12d16e98176a..3c03987c81a1 100644
>>> --- a/drivers/staging/rtl8188eu/include/rtw_xmit.h
>>> +++ b/drivers/staging/rtl8188eu/include/rtw_xmit.h
>>> @@ -193,14 +193,9 @@ struct xmit_buf {
>>>   	void *priv_data;
>>>   	u16 ext_tag; /*  0: Normal xmitbuf, 1: extension xmitbuf. */
>>>   	u16 flags;
>>> -	u32 alloc_sz;
>>>   	u32  len;
>>>   	struct submit_ctx *sctx;
>>> -	u32	ff_hwaddr;
>>>   	struct urb *pxmit_urb[8];
>>> -	dma_addr_t dma_transfer_addr;	/* (in) dma addr for transfer_buffer */
>>> -	u8 bpending[8];
>>> -	int last[8];
>>>   };
>>>   
>>>   struct xmit_frame {
>>> diff --git a/drivers/staging/rtl8188eu/os_dep/xmit_linux.c b/drivers/staging/rtl8188eu/os_dep/xmit_linux.c
>>> index 017e1d628461..61ced1160951 100644
>>> --- a/drivers/staging/rtl8188eu/os_dep/xmit_linux.c
>>> +++ b/drivers/staging/rtl8188eu/os_dep/xmit_linux.c
>>> @@ -24,7 +24,6 @@ int rtw_os_xmit_resource_alloc(struct adapter *padapter,
>>>   		return _FAIL;
>>>   
>>>   	pxmitbuf->pbuf = PTR_ALIGN(pxmitbuf->pallocated_buf, XMITBUF_ALIGN_SZ);
>>
>> Not related to this patch but kmalloc always returns data which is at
>> least ARCH_KMALLOC_MINALIGN aligned which is never less than
>> XMITBUF_ALIGN_SZ (4) so this is a no-op.

4-byte alignment for 8-byte pointer (for example void *priv_data) on 
64-bit arch is an _error_. It’s good that kmalloc (and vmalloc) is 
already aligned to 8 bytes.

> 
> The alignment in the driver is pretty crazy because it's all unnecessary
> and so complicated.  Every allocation is 4 bytes extra so we can align
> it later.
> 
> Also every buffer is called "pbuf" which stands for pointer to buffer.
> "pallocated_buf" is not really useful either.
> 
> I tried to look at this to see if we could change the alignment, and
> it's complicated because of the naming and the alignment.
> 
> regards,
> dan carpenter
> 

I have already fixed 4 places with unnecessary alignment, but, alas, 
there is no great desire to test them on real hardware.

Ivan.
