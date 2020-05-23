Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A29EC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 09:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB83C20727
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 09:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbxfOHj7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387749AbgEWJ00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 05:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387513AbgEWJ0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 05:26:25 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD5DC061A0E
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 02:26:25 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id m18so15539301ljo.5
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 02:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3+UjsWYOj5RAA70832m2KjeDieKRHT5+oaeChsm4PiY=;
        b=EbxfOHj73ERD/vJjb5Gqxro9mSG+2H76UVDhL+7A5mkJ3+S5AKZjW8a0wtwNphqqaG
         Xo0Tj+foQ+zQE4OhGy8YVCBB7tvXBGv+wSAOUIJOFCGOfeJZjM+Gz5RYBF+daTFqHyA+
         iTJGatzMBRnSKZ/2UueHuIkM9z2VBL0UpDTiB7eTLyavgxmteMF1zE5iEeMSk8e3a/Rk
         +n3dy4Inw9M63v0v42GvFziLYbE2bOJGN39wAN8Zj5rUrX0/Y3BLL+hKBKRSzwpd500h
         PDsR4ltXcoTh6zObg6EJOuPuhgRifwPMJfWF2BVCsndUnMGit3wrdsC2aOL94yri74Sz
         CxXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3+UjsWYOj5RAA70832m2KjeDieKRHT5+oaeChsm4PiY=;
        b=ADc0+cdLoE8msfe4WpnMkHDn2P6A9VFQAMMpLGWoSknjPCvfAqEicc71NUlsKBBYRP
         um8x7ZGtJD0XNhgGMvj140P2AP8jWXISsruPwyOc4vFzR+gkaQiBkit4uhbgVsCP3uP2
         7KZqjVob+MXNnEkI7lD05Qhrl/ogiXqeT+uuB3eMyY9ZjVADzBVZntJSF49DVsN4z5B/
         YVq3FCh9g5Uv/dWahLVLV0rIPIxUDvY42OyYVF+MQvZ1xpYkOTGoNNMw8+WqwddlRwfW
         /LSLyT4zrE+JXUqcgKmtclsbLgtzfM7pHu/zs7j26gU2vnVsBeakehB6Mkq8uGrEZ6CM
         XGdQ==
X-Gm-Message-State: AOAM532kmnjp5tHym0i65G9CGuTWBoU2pUGXc9k1YePQCi52/z+HK/XU
        R2X5R7hrDm9pxAxVGRLjtSgIHJYaYd/VbQCY
X-Google-Smtp-Source: ABdhPJwD7NQzJIATCdMiLNTsRrlgf3lnqx/yCmCgLtLdCgUOid9ZHjky7/t6yxEw97hazi8NTrxZPQ==
X-Received: by 2002:a2e:978d:: with SMTP id y13mr10084219lji.80.1590225983329;
        Sat, 23 May 2020 02:26:23 -0700 (PDT)
Received: from [192.168.81.109] (2.71.98.25.mobile.tre.se. [2.71.98.25])
        by smtp.gmail.com with ESMTPSA id j14sm3223358lji.63.2020.05.23.02.26.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 May 2020 02:26:22 -0700 (PDT)
Subject: Re: [PATCH] uio: disable lazy irq disable to avoid double fire
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
References: <20200521144209.19413-1-thommyj@gmail.com>
 <20200522091444.GA1192483@kroah.com>
From:   Thommy Jakobsson <thommyj@gmail.com>
Message-ID: <6d5b0844-dcaf-902e-466a-1af5ca340b1e@gmail.com>
Date:   Sat, 23 May 2020 11:26:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200522091444.GA1192483@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-22 11:14, Greg KH wrote:
> On Thu, May 21, 2020 at 04:42:09PM +0200, Thommy Jakobsson wrote:
>> +	if (uioinfo->irq) {
> 
> How is this not true at this point in time based on the code above this?
> ->irq should always be set here, right?
It seems to me like there is a path to continue without an IRQ in the
section above, "uioinfo->irq = UIO_IRQ_NONE;", where UIO_IRQ_NONE is
0. Do you agree?

> 
>> +		struct irq_data *irq_data = irq_get_irq_data(uioinfo->irq);
>> +
>> +		/*
>> +		 * If a level interrupt, dont do lazy disable. Otherwise the
>> +		 * irq will fire again since clearing of the actual cause, on
>> +		 * device level, is done in userspace
>> +		 */
>> +		if (!irq_data) {
>> +			dev_err(&pdev->dev, "unable to get irq data\n");
>> +			ret = -ENXIO;
>> +			goto bad1;
> 
> Why is not having this information all of a sudden an error for this
> code?  What could cause that info to not be there?  Existing systems
> without this set would work just fine before this change, and I think
> this breaks them, right?
irq_data should always exists as long as there is an irq descriptor and
I assumed that the descriptors "should" exists at the point when this
code run. So a NULL would either mean something serious and would be
more of a sanity check than anything else, or (more likely) it is the
wrong irq configured.

The "should" comes from that this code path later registers the irq
(devm_uio_register_device->... ->__uio_register_device->...
->request_irq->... ->request_threaded_irq), and when this happen its an
-EINVAL back if there isn't any descriptor from irq_to_desc (which is
the same function as irq_get_data internally uses). So I don't see any
new breaks from this, but I could be wrong so please correct me in that
case. At least it was my intention to not break anything currently
working. Maybe it is better to just do a dev_dbg and let
request_threaded_irq handle the wrong irq case?

> 
>> +		}
>> +		/*
>> +		 * irqd_is_level_type() isn't used since isn't valid unitil
>> +		 * irq is configured.
>> +		 */
>> +		if (irqd_get_trigger_type(irq_data) & IRQ_TYPE_LEVEL_MASK) {
>> +			dev_info(&pdev->dev, "disable lazy unmask\n");
> 
> Why dev_info?  If drivers are working properly, they should be quiet.
> dev_dbg() is fine to use here if you want to debug things to see what is
> happening.
Agreed

BR,
Thommy Jakobsson
