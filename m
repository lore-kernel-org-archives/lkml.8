Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B394FC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 22:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E8BF2080C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 22:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgH0WjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 18:39:03 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35616 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbgH0WjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 18:39:02 -0400
Received: by mail-lf1-f68.google.com with SMTP id y26so3803791lfe.2;
        Thu, 27 Aug 2020 15:38:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=jWe/MZBuXsPQIPwGDtHXYOGQF+tZkW1rf6P5WyO7gU0=;
        b=ou8tUqcv+e/mf5W5uXYZM0+tCez8tNGqhjutmr8/IayMsX+4nid4k5qvT83HNoH1oQ
         N3kNFBAgKUeTU5HrpQL/YmoK0jDG+wbu6aSOKpy07mBPQA2z3lbg3W8/5J3P86oknqx8
         3zpNg/BtUgJMHye7QJBvCqhh3LCJskEtXvRY7hynUDt0JsmYMdipZvo8ANCYAi3sU2Qm
         E32+PjuPnZ6OIV1aDRlpjX1wZYm5TqC8Vu1DmYBMFIV2u3Ew3s+Qjj6M4PuH8obzbgaR
         LzS4qHUOflJj132jsQdziL3xpIejG6PHv8SkYNkOWyVo19pWm0PT9VaXkw49ZyfUmDXb
         cZwg==
X-Gm-Message-State: AOAM531ncLkjkq3Z6127LEI+eNdO7N83hM5n0JSDkQ5Zh0BJzIo/MjSx
        PVo/f3NXdGkTwUdSZ5/+y9w=
X-Google-Smtp-Source: ABdhPJzNbZED6jAG/dXcSnQMVX21gJmCJMfrCRm6uK1ETK0qVpTDxrRAo0S5cqh9JjAkUoVOdtG0VA==
X-Received: by 2002:a05:6512:1146:: with SMTP id m6mr1957763lfg.1.1598567938855;
        Thu, 27 Aug 2020 15:38:58 -0700 (PDT)
Received: from [192.168.1.8] ([213.87.147.111])
        by smtp.gmail.com with ESMTPSA id d21sm355589lfi.41.2020.08.27.15.38.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 15:38:58 -0700 (PDT)
To:     Joe Perches <joe@perches.com>, Julia Lawall <julia.lawall@inria.fr>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, cocci <cocci@systeme.lip6.fr>,
        accessrunner-general@lists.sourceforge.net,
        Alex Dewar <alex.dewar90@gmail.com>
References: <20200824222322.22962-1-alex.dewar90@gmail.com>
 <48f2dc90-7852-eaf1-55d7-2c85cf954688@rasmusvillemoes.dk>
 <20200827071537.GA168593@kroah.com>
 <20200827131819.7rcl2f5js3hkoqj2@lenovo-laptop>
 <def24e9e-018c-9712-0d07-d4cbc84f07d9@rasmusvillemoes.dk>
 <20200827144846.yauuttjaqtxaldxg@lenovo-laptop>
 <5d1dfb9b031130d4d20763ec621233a19d6a88a2.camel@perches.com>
 <alpine.DEB.2.22.394.2008272141220.2482@hadrien>
 <5853c58e-7d26-2cf9-6cbf-698ecd93cbf9@linux.com>
 <alpine.DEB.2.22.394.2008272334500.2482@hadrien>
 <d6d5836196208d5280cedf5837952096c3518852.camel@perches.com>
From:   Denis Efremov <efremov@linux.com>
Autocrypt: addr=efremov@linux.com; keydata=
 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
Subject: Re: [Cocci] [PATCH] usb: atm: don't use snprintf() for sysfs attrs
Message-ID: <adfca3f2-561a-9d91-c064-cf01c2b573e7@linux.com>
Date:   Fri, 28 Aug 2020 01:38:55 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <d6d5836196208d5280cedf5837952096c3518852.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> I tried:
> @@
> identifier f_show =~ "^.*_show$";


This will miss this kind of functions:
./drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c:1953:static DEVICE_ATTR(vbios_version, 0444, amdgpu_atombios_get_vbios_version,
./drivers/gpu/drm/amd/amdgpu/df_v3_6.c:266:static DEVICE_ATTR(df_cntr_avail, S_IRUGO, df_v3_6_get_df_cntr_avail, NULL);
./drivers/input/touchscreen/melfas_mip4.c:1348:static DEVICE_ATTR(fw_version, S_IRUGO, mip4_sysfs_read_fw_version, NULL);
./drivers/input/touchscreen/melfas_mip4.c:1373:static DEVICE_ATTR(hw_version, S_IRUGO, mip4_sysfs_read_hw_version, NULL);
./drivers/input/touchscreen/melfas_mip4.c:1392:static DEVICE_ATTR(product_id, S_IRUGO, mip4_sysfs_read_product_id, NULL);
...

> identifier dev, attr, buf;
> const char *chr;
> @@
> ssize_t f_show(struct device *dev, struct device_attribute *attr, char
> *buf)
> {
> 	<...
> (
> -	sprintf
> +	sysfs_sprintf
> 	(...);
> |
> -	snprintf(buf, PAGE_SIZE,
> +	sysfs_sprintf(buf,
> 	...);
> |
> -	scnprintf(buf, PAGE_SIZE,
> +	sysfs_sprintf(buf,
> 	...);
> |
> 	strcpy(buf, chr);
> 	sysfs_strcpy(buf, chr);
> )
> 	...>
> }
> 
> which finds direct statements without an assign
> but that doesn't find
> 
> arch/arm/common/dmabounce.c:static ssize_t dmabounce_show(struct device *dev, struct device_attribute *attr, char *buf)
> arch/arm/common/dmabounce.c-{
> arch/arm/common/dmabounce.c-    struct dmabounce_device_info *device_info = dev->archdata.dmabounce;
> arch/arm/common/dmabounce.c-    return sprintf(buf, "%lu %lu %lu %lu %lu %lu\n",
> arch/arm/common/dmabounce.c-            device_info->small.allocs,
> arch/arm/common/dmabounce.c-            device_info->large.allocs,
> arch/arm/common/dmabounce.c-            device_info->total_allocs - device_info->small.allocs -
> arch/arm/common/dmabounce.c-                    device_info->large.allocs,
> arch/arm/common/dmabounce.c-            device_info->total_allocs,
> arch/arm/common/dmabounce.c-            device_info->map_op_count,
> arch/arm/common/dmabounce.c-            device_info->bounce_count);
> arch/arm/common/dmabounce.c-}
>

This will match it (the difference is in the ';'):
@@
identifier f_show =~ "^.*_show$";
identifier dev, attr, buf;
@@

ssize_t f_show(struct device *dev, struct device_attribute *attr, char *buf)

{

	<...
-	sprintf
+	sysfs_sprintf
	(...)
	...>
}

Regards,
Denis
