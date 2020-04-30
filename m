Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBEDC8300D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81D8F2074A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 13:32:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cXzTQ8x1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbgD3Nc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 09:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726809AbgD3Nc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 09:32:57 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB491C035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 06:32:55 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j2so6931644wrs.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 06:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=tR6vRgNB+Hy246JhqymbwaLVzJsBiAZ16wFlCyZoIo8=;
        b=cXzTQ8x1IacAUDwWqH77bcYiQ3Q9+0Or86Jeepl+dh6EiX7iccljrvlzrYElCE18of
         6QjJnbdWdjJAEEPm1ur3wTrOsAaCbR6oMhU+EMsdt+4XkLwFWClUIKDJBee3reQtdQrv
         LRm1eqbRctoOTCgSYyhug46go3Qf8E5qUfbG13fMVvRL0GZUzqERCu2KcOx1y4AhZ9lD
         qaM7HS7kFs7yCNrJeop3fnumwv1CwShwAn6WXrgZAMjQjP2O3z5QU+kEGtuEPCCo6uHE
         mI2MMz2Vudd0RhUOT+S2BcQdr3r9taN61UvGHf5kn/joctiscPmR9pNkHw96UyPrlfOj
         kdQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding:content-language;
        bh=tR6vRgNB+Hy246JhqymbwaLVzJsBiAZ16wFlCyZoIo8=;
        b=ashCfrKm43ygKWtzFcDRfh9sJ8xff44ZMLmsFKb38ZVBVOTeX6Byw7c0avbkyXeGly
         oCSJXsDOjbL1MnGenWt7OiGAzE8myBS/iFM3QSo8Wo90WxjPTdc54IqFo1ABoyQqAkSn
         bOoDjIvy8V7FK2wVcdFq8i/62skuuWSQ4L4WM5zmgogDDCRCinY0WbiFfL5Cx3DdVZwR
         KtzoAlG8TvZIr06l8B3BQjF9RONf8ElXaen+65fHVyi34c3+aRhDPxNG4l+wOXoOtoHV
         erXBc3P4vvLvPTGQTIki6RS3SkYxtrQfyo5TTjtfGQDAcoSepQrOScmx+GkhXM258QfN
         ns6w==
X-Gm-Message-State: AGi0PuZwA89JBqCDjle1MNBoWWpv+AxdFJMrfe4FKjZtdmT1z5zL6SKu
        s0v3kMufYOZpAJveSStVVec=
X-Google-Smtp-Source: APiQypIsi6HpI6xvS1a5t9+IPa9RzomTPfSLeqPDbwTXUT48xAeab9ptQXYSu63nyI8JV19zgiUe2w==
X-Received: by 2002:adf:ea48:: with SMTP id j8mr4192968wrn.108.1588253574598;
        Thu, 30 Apr 2020 06:32:54 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id k3sm4383362wru.90.2020.04.30.06.32.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Apr 2020 06:32:54 -0700 (PDT)
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH] drm/radeon: cleanup coding style a bit
To:     Bernard <bernard@vivo.com>, Joe Perches <joe@perches.com>
Cc:     "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        opensource.kernel@vivo.com, David Airlie <airlied@linux.ie>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
References: <AO2AmAAQCPm7TNcK3aT264ov.3.1588244411605.Hmail.bernard@vivo.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <81368fdb-87c5-d963-68c2-e02d0c100363@gmail.com>
Date:   Thu, 30 Apr 2020 15:32:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <AO2AmAAQCPm7TNcK3aT264ov.3.1588244411605.Hmail.bernard@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 30.04.20 um 13:00 schrieb Bernard:
>
> 发件人：Joe Perches <joe@perches.com>
> 发送日期：2020-04-27 01:53:06
> 收件人："Christian König" <christian.koenig@amd.com>,Bernard Zhao <bernard@vivo.com>,Alex Deucher <alexander.deucher@amd.com>,"David (ChunMing) Zhou" <David1.Zhou@amd.com>,David Airlie <airlied@linux.ie>,Daniel Vetter <daniel@ffwll.ch>,amd-gfx@lists.freedesktop.org,dri-devel@lists.freedesktop.org,linux-kernel@vger.kernel.org
> 抄送人：opensource.kernel@vivo.com
> 主题：Re: [PATCH] drm/radeon: cleanup coding style a bit>On Sun, 2020-04-26 at 15:18 +0200, Christian König wrote:
>>> Am 26.04.20 um 15:12 schrieb Bernard Zhao:
>>>> Maybe no need to check ws before kmalloc, kmalloc will check
>>>> itself, kmalloc`s logic is if ptr is NULL, kmalloc will just
>>>> return
>>>>
>>>> Signed-off-by: Bernard Zhao <bernard@vivo.com>
>>> Reviewed-by: Christian König <christian.koenig@amd.com>
>>>
>>> I'm wondering why the automated scripts haven't found that one before.
>> because this pattern is
>>
>> 	if (foo)
>> 		kfree(bar);
>>
>> and the pattern looked for is:
>>
>> 	if (foo)
>> 		kfree(foo);
>>
>>>> diff --git a/drivers/gpu/drm/radeon/atom.c b/drivers/gpu/drm/radeon/atom.c
>> []
>>>> @@ -1211,8 +1211,7 @@ static int atom_execute_table_locked(struct atom_context *ctx, int index, uint32
>>>>    	SDEBUG("<<\n");
>>>>    
>>>>    free:
>>>> -	if (ws)
>>>> -		kfree(ectx.ws);
>>>> +	kfree(ectx.ws);
>>>>    	return ret;
>>>>    }
>> I'm wondering if this removal is correct as the function
>> is named _locked and it may be recursive or called under
>> some external lock.
>>
> Hi
> I am a little confused about this. I understand that the caller guarantees the lock protection
> that we will not release the wrong pointer. And the NULL check is the same with the first check in kfree?
> Maybe we do not need check twich.

I don't understand the comment either. When you look at the function you 
see that code is freeing up the temporary allocated buffer which is to 
large for the stack.

In other words we kcalloc() this buffer a few lines above and free it 
here again. So I think the patch is perfectly valid.

What we could do is to update the coci pattern to catch this as well, 
but this case is so rare that it is probably not worth it.

Regards,
Christian.

>
> Regards,
> Bernard
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

