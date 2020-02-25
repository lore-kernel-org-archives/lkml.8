Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36118C35E04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 17:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 098BD2082F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 17:04:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZUftV1WZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731322AbgBYRE3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 12:04:29 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39409 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729832AbgBYRE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 12:04:29 -0500
Received: by mail-wm1-f68.google.com with SMTP id c84so3928183wme.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 09:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yL67/kVowXihssgOC1k49Z4q5Ob7fhLHIikyQaonlB0=;
        b=ZUftV1WZ602cexEiDuSvy3/OpIcp5HARA+6Lt+CjXDqheCE8P1aoq7mFIPGwqdcvK1
         zZaqZqDmcutwDFb8bV9NHklnZTt4VuTfoFXeBcM/qGGPPbHCHz1oCMohnEVoaRZY3WHg
         Ft7rS0PSvYIYeT0RNG10FhY4ZIptxQMmCJCj6Zp+YW8j67dugJI9XeOKDp4PxCb5WWAt
         IL8na28YrWqy/BMxhyiyU5lblWnRsiVsS6xkzWbcH52tHxg4KmAr8TD898M0c9qD9WHT
         9Wvs3kLZtrDDQuXlHwd3VEfMWEBBmkVBy/SUtPdItByGoVpU3fK0Oyc3l33z3ktN91At
         yMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yL67/kVowXihssgOC1k49Z4q5Ob7fhLHIikyQaonlB0=;
        b=kMGp+uFoyVrrSNWZvuJadjEXTvmeIlRfdSg9cShEnqdpZAHoMZ4bHkSHa4i4145zIr
         LC4LH2W+s77pZI06shH2RPa3u0jbliy7VRTn6lLBnjXHJSOrz9Xqt4yc0THm+afo3DMC
         M0fkxxDiKaXTatCFiLx5nMej3h4T2gRzxezvrqg6/pl8uXdqUfoYLh2MmHbkDviuijXz
         t4t87HIihbwu3yI5rBX5gvtYx3ggPBYTkQ0XaakcT90ByriOVj63bN29rtcbFvNfwWgz
         FC9FdOpuj5PxLzkcx/zLbUsboFL9YogHBNw1JkohLPnO7W92m0/tuUxpBjJq2LUo64Jh
         yFIA==
X-Gm-Message-State: APjAAAVhJExs4FVK5gdS+uEXQ7XX20zy1GZcUDPsS0zzvvzpQRe7IuQM
        kPBNgq6BL1mKpDVVR3brWMhEyg==
X-Google-Smtp-Source: APXvYqxb+sPu46jQfnDGzzIaLYa1L8i2d3V8PA9FcCKuBnfzBeGZ+OJjLuvSMO6y5PTjMuwrt97iSw==
X-Received: by 2002:a05:600c:1009:: with SMTP id c9mr223285wmc.162.1582650267367;
        Tue, 25 Feb 2020 09:04:27 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id q9sm25764319wrx.18.2020.02.25.09.04.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Feb 2020 09:04:26 -0800 (PST)
Subject: Re: [PATCH v1 0/3] nvmem: Add support for write-only instances, and
 clean-up
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <PSXP216MB043899D4B8F693E1E5C3ECCE80EC0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <abdbeaf4-487d-8921-facc-b979421e97e7@linaro.org>
 <PSXP216MB043872618DA517085324FA0580ED0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <84f85b5e-aae6-8636-448c-37d6e9cb5261@linaro.org>
Date:   Tue, 25 Feb 2020 17:04:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <PSXP216MB043872618DA517085324FA0580ED0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/02/2020 15:23, Nicholas Johnson wrote:
>> Why can not we add a check for reg_read in bin_attr_nvmem_read() before
>> dereferencing it?
> That can be easily done in PATCH v2. What error code should be returned?
> 
-EPERM should be good in this case indicating Operation not permitted 
for implementation reasons!

--srini
