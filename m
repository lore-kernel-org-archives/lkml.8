Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D79C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 06:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C549C20717
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 06:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vCN0S6+u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbgGUG6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 02:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbgGUG6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 02:58:46 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187A7C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 23:58:46 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id gc15so1018254pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 23:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=Tno23bD6CNrvtvTJ8w81B3EthF3Ld5kpNkTOAg+JnsM=;
        b=vCN0S6+uLMv5XxoT4ifN8Mdl3iTpXPghqyV86DALod7pGA+schHiD8gHYrnVqyy2Gw
         NdGXaEZUVvaRR17C5MMQLEMJOasCO12cX8d8/FzpKEt1kD85nU46h0D6VmXzmYXg2B7v
         2hKu8/RCGgdRfjVU69+QlDO6CK3QKrVdWQLkcjL9a/ioimyRVfuE6zOTpRBu/0bumC6S
         i9kj2THROnCIdatTaUy+bAkDc5jXrTDRZr4PvOUqxZNskPpcLW+hWHvj+5BamjEUFbmg
         Zorhst4Y4suuRAnj6TCsOBhs6wW1c+ILYfv0LVwl+X+R4s9rm0dJe1CCXaueL1jbqqFy
         hz+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Tno23bD6CNrvtvTJ8w81B3EthF3Ld5kpNkTOAg+JnsM=;
        b=bl3tFYM9uzGYYp5CFq94Pa2hzG/Zn168LdXSRRt0+GLlA2ieg0zqRnMtjXRKI+K3E0
         bHZ25cE/qDENSeD9Xd1v6MXFuE9HgYSEt218NfMxXavXoCtnmZf+ymzrBsM3xM9HXRr4
         PpY10Rm7X69v3ediBCYfIz0CLxyO8VEYe1qD1yT7CrWfqlMQcVkij4nG4H2JjxNbR703
         OgwD5ncgjOCxr689CAWboXYfTozLtP44hr5AjUddkaOac+RI8TM28g+0d6TUcoibFjjX
         MYR8ojkqC//U2w6wytVq++nn3WPi1NzJqUyu3ZvyQB9mlOklNnv5gD1ywFZlNPDY0yeb
         iWdA==
X-Gm-Message-State: AOAM533kRPVBR4H6G57y11xZiJ9Bws5/QXFO9RNe4VspTJ41d/FaqaQ3
        yEjGNA7tOOOcIHVcmUr1LmmaNQ==
X-Google-Smtp-Source: ABdhPJxckY0lmGlBsj/0MC92yIRwggmuPmCKttx9B6PanKuNgALvduemXmj14Lm7ruLSqbUmbcdjHA==
X-Received: by 2002:a17:90b:400f:: with SMTP id ie15mr3235503pjb.94.1595314725521;
        Mon, 20 Jul 2020 23:58:45 -0700 (PDT)
Received: from ?IPv6:240e:362:4ac:f200:40d1:ed88:5dbd:3f3a? ([240e:362:4ac:f200:40d1:ed88:5dbd:3f3a])
        by smtp.gmail.com with ESMTPSA id mv6sm1756670pjb.57.2020.07.20.23.58.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jul 2020 23:58:44 -0700 (PDT)
Subject: Re: [PATCH] uacce: fix some coding styles
To:     Kai Ye <yekai13@huawei.com>, linux-accelerators@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com
References: <1595229523-14103-1-git-send-email-yekai13@huawei.com>
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <0775c541-5802-cdf3-e2aa-c62c027ab8a7@linaro.org>
Date:   Tue, 21 Jul 2020 14:57:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1595229523-14103-1-git-send-email-yekai13@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/7/20 下午3:18, Kai Ye wrote:
> 1. add some parameter check.
> 2. delete some redundant code.
> 3. modify the module author information.
>
> Signed-off-by: Kai Ye <yekai13@huawei.com>
> Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>
Thanks Kai.
> ---
>   drivers/misc/uacce/uacce.c | 28 +++++++++++++---------------
>   1 file changed, 13 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
> index 107028e..2e1af58 100644
> --- a/drivers/misc/uacce/uacce.c
> +++ b/drivers/misc/uacce/uacce.c
> @@ -63,8 +63,12 @@ static long uacce_fops_unl_ioctl(struct file *filep,
>   				 unsigned int cmd, unsigned long arg)
>   {
>   	struct uacce_queue *q = filep->private_data;
> -	struct uacce_device *uacce = q->uacce;
> +	struct uacce_device *uacce;
> +
> +	if (WARN_ON(!q))
> +		return -EINVAL;
WARN_ON should not be used in uacce, instead error can be printed in 
user space driver.
Error should not be printed in kernel log as pasid can be used by unpriv 
user.

And I think we do not need check filep->private_data.
The fd is double checked in __fget_files.

Thanks
