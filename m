Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E43DC34034
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 09:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 435C722527
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 09:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z79p2R5o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgBRJSs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 04:18:48 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:45260 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbgBRJSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 04:18:47 -0500
Received: by mail-wr1-f51.google.com with SMTP id g3so22923878wrs.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 01:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pGj8/tYNr2ig9yDk7W4pxK2twpGRw2//c44318tSQKY=;
        b=z79p2R5onpcGuw8vQOPzZfTC7kCwHgJ5gd9evog64W4IaU0W4VTmDQxMFweMGbV+OR
         ylFwgiWjYOMY9M2sbkdXdMQ9WCFOQYkkn3uHVjgmYTGGEsumO+TShYDR+kik9hO8NudO
         Kd07/+G6vO7q6A3kT8fp5qrQde1bzjps0TGgbHhGHD0lyn4v6/WYsLYtVAw7fLgSQPTi
         fD0yZPk7NPJCl33wqPj+hpIKpzaaEO/EXcJMC9UzCn2alpnKEKe7k5qpJP0aatUWWWdR
         3bNdiajddk2e68c2x7VV+uYZ+QAxCvW7HWQ6zGPgGxbE9/HwTF+UJj+0OF2ihWDkXO+r
         fbxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pGj8/tYNr2ig9yDk7W4pxK2twpGRw2//c44318tSQKY=;
        b=TG4Sh8j4fMCHrfYHIvkGC2k0r+UDwDqR3J7vELp0xMrBbIFd5hGhVvPCatmIvLzzN2
         iPkBlZWAYOJs1Az7TBZJNFrCKKhZw5u+Di2frlwM+MfVBBIfwCFIlgk6ICVikh1mOQW8
         l7SuRut3yQmW4cXJryHsgjF+xdiiDNcFANG/UTTDg8ZduKNOyFlA0wDTJHkMfJNtk26F
         XIJ0EtiBNWxh+O0tWOvG3BbBy4h1KGfXvjgRNIkocLPXYf9EV/GLGz4ISHCTZizYz4dN
         sHsIQQjX8scpK7BvzRiPGp9kCzuAMQKOMqLZccaV4HVyhrZEGMN3sVXdAurvCbTqcRd9
         Oy5w==
X-Gm-Message-State: APjAAAVQJ2+LNT7oBncfA/oLnksh5PlJVvLLCOO/MQa0O4eCB5o/YvUW
        VhgObI44ChcCIT62qw5wqZJi+X5WmfA=
X-Google-Smtp-Source: APXvYqz02xAXAjUKJgD/rvMDjCVXHkpDbNxW9oqzSnZbpdPpfwXZ7NlrpXVc33TpioZPTWJNoTzjXQ==
X-Received: by 2002:adf:ed8e:: with SMTP id c14mr27740701wro.80.1582017525325;
        Tue, 18 Feb 2020 01:18:45 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id h128sm2917571wmh.33.2020.02.18.01.18.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Feb 2020 01:18:44 -0800 (PST)
Subject: Re: NVMEM usage consult for device information
To:     =?UTF-8?B?TWFjIEx1ICjnm6flrZ/lvrcp?= <mac.lu@mediatek.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>
Cc:     =?UTF-8?B?QW5kcmV3LUNUIENoZW4gKOmZs+aZuui/qik=?= 
        <Andrew-CT.Chen@mediatek.com>
References: <06d083206a4f4f5981be9d2e628162f8@mtkmbs01n1.mediatek.inc>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <11b42d7b-ff96-d377-5225-6f9fcd5c57b8@linaro.org>
Date:   Tue, 18 Feb 2020 09:18:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <06d083206a4f4f5981be9d2e628162f8@mtkmbs01n1.mediatek.inc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/02/2020 05:16, Mac Lu (盧孟德) wrote:
> Hello,
> 
> Mediatek chip have some SOC configurations and specific data which would 
> be delivered to kernel by DTB.
> 
Is this data stored in a non volatile memory on the SoC?
if yes, then we should have a proper nvmem provider driver.

--srini

> So we want to implement a new NVMEM driver to retrieve these data for 
> use by the NVMEM Framework.
> 
> Do you agree with the usage for our application?
> 
> Thanks
> 
> Mac
> 
> ************* MEDIATEK Confidentiality Notice ********************
> The information contained in this e-mail message (including any
> attachments) may be confidential, proprietary, privileged, or otherwise
> exempt from disclosure under applicable laws. It is intended to be
> conveyed only to the designated recipient(s). Any use, dissemination,
> distribution, printing, retaining or copying of this e-mail (including its
> attachments) by unintended recipient(s) is strictly prohibited and may
> be unlawful. If you are not an intended recipient of this e-mail, or believe
> that you have received this e-mail in error, please notify the sender
> immediately (by replying to this e-mail), delete any and all copies of
> this e-mail (including any attachments) from your system, and do not
> disclose the content of this e-mail to any other person. Thank you!
> 
