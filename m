Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9438CC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 19:51:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72AAC20829
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 19:51:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="i916syol"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgHMTvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 15:51:44 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:13069 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726312AbgHMTvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 15:51:43 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597348303; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=dDK8BdAhyMff+YBgjmOEx9G0LZqK11Et6I+uQh1z7Wc=; b=i916syolOI0CvTDEVYLUSZQTxIPcjuNI/b7qLIkfe4FcYwMkH5gnboZIbuuJzONcgg4uIf65
 uy8N7VAn1iRmf/lKZxqblPO69cNLQxeR+844jqp6xFNTj1TwqH28yvedOQSUVBv7zbKBKZLw
 2bMbBnx/lD+vZFIjivnrsT++8co=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-west-2.postgun.com with SMTP id
 5f3599c803528d4024cd761c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 13 Aug 2020 19:51:36
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 293F6C433C6; Thu, 13 Aug 2020 19:51:36 +0000 (UTC)
Received: from [192.168.1.3] (unknown [183.83.140.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: prsood)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EE6BCC433C9;
        Thu, 13 Aug 2020 19:51:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EE6BCC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=prsood@codeaurora.org
Subject: Re: [PATCH] firmware_loader: fix memory leak for paged buffer
To:     Takashi Iwai <tiwai@suse.de>
Cc:     mcgrof@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org,
        linux-kernel@vger.kernel.org
References: <1597258819-14080-1-git-send-email-prsood@codeaurora.org>
 <s5ha6yyvh1f.wl-tiwai@suse.de>
From:   Prateek Sood <prsood@codeaurora.org>
Message-ID: <3f9dac61-1ba5-1a44-1d08-75666c9398bc@codeaurora.org>
Date:   Fri, 14 Aug 2020 01:21:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <s5ha6yyvh1f.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/13/2020 6:28 PM, Takashi Iwai wrote:
> On Wed, 12 Aug 2020 21:00:19 +0200,
> Prateek Sood wrote:
>> vfree() is being called on paged buffer allocated
>> using alloc_page() and mapped using vmap().
>>
>> Freeing of pages in vfree() relies on nr_pages of
>> struct vm_struct. vmap() does not update nr_pages.
>> It can lead to memory leaks.
>>
>> Signed-off-by: Prateek Sood <prsood@codeaurora.org>
> Thanks for spotting this out!  This is essentially a revert of the
> commit ddaf29fd9bb6 ("firmware: Free temporary page table after
> vmapping"), so better to mention it via Fixes tag as well as Cc to
> stable.
> About the changes:
>> --- a/drivers/base/firmware_loader/firmware.h
>> +++ b/drivers/base/firmware_loader/firmware.h
>> @@ -142,10 +142,12 @@ static inline void fw_state_done(struct fw_priv *fw_priv)
>>   void fw_free_paged_buf(struct fw_priv *fw_priv);
>>   int fw_grow_paged_buf(struct fw_priv *fw_priv, int pages_needed);
>>   int fw_map_paged_buf(struct fw_priv *fw_priv);
>> +bool fw_is_paged_buf(struct fw_priv *fw_priv);
> I guess this isn't necessary if we just swap the call order of
> fw_free_paged_buf() and vfree(); then fw_priv->is_paged_buf is
> referred only in fw_free_paged_buf().
> That is, something like below.
>
> In anyway, take my review tag:
>    Reviewed-by: Takashi Iwai <tiwai@suse.de>

Thanks for reviewing.

I would prefer to keep the patch as is to have vmap() and vunmap() pair used

for readability. Will upload a new version with Fixes tag and your 
Reviewed-by.

>
> thanks,
>
> Takashi
>
> --- a/drivers/base/firmware_loader/main.c
> +++ b/drivers/base/firmware_loader/main.c
> @@ -252,9 +252,9 @@ static void __free_fw_priv(struct kref *ref)
>   	list_del(&fw_priv->list);
>   	spin_unlock(&fwc->lock);
>   
> -	fw_free_paged_buf(fw_priv); /* free leftover pages */
>   	if (!fw_priv->allocated_size)
>   		vfree(fw_priv->data);
> +	fw_free_paged_buf(fw_priv); /* free leftover pages */
>   	kfree_const(fw_priv->fw_name);
>   	kfree(fw_priv);
>   }
> @@ -272,7 +272,7 @@ void fw_free_paged_buf(struct fw_priv *fw_priv)
>   {
>   	int i;
>   
> -	if (!fw_priv->pages)
> +	if (!fw_priv->is_paged_buf)
>   		return;
>   
>   	for (i = 0; i < fw_priv->nr_pages; i++)
> @@ -328,10 +328,6 @@ int fw_map_paged_buf(struct fw_priv *fw_priv)
>   	if (!fw_priv->data)
>   		return -ENOMEM;
>   
> -	/* page table is no longer needed after mapping, let's free */
> -	kvfree(fw_priv->pages);
> -	fw_priv->pages = NULL;
> -
>   	return 0;
>   }
>   #endif

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation
Center, Inc., is a member of Code Aurora Forum, a Linux Foundation
Collaborative Project

