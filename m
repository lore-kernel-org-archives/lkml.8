Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA040C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 10:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEAC6206F4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 10:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TN4sSOhd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbgBQKrl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 05:47:41 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35588 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727803AbgBQKrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 05:47:40 -0500
Received: by mail-wr1-f65.google.com with SMTP id w12so19097823wrt.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 02:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=7uJCwOXevc3AyI7lWZC3RUDZR5Y6Ndzzd9RybpHzjy4=;
        b=TN4sSOhdc57M5aW0Azt5rcWFA9t509h9f5TWlT3rR0Cda4TayZs+QvaajZ0/YKmsUj
         p3qGIDUwR12TIcJRh3Aaafs/y6tDaTAl0xwT57GrBdPqV9ohV6/Nt/iE7Iw/ydSGrnjs
         GYe0Rq7LdJxmU462FhKq+Q8MaMG9T5R7vTMa9atzWeYd55nqgs8HP3uIRNUMETJrbW1f
         0icBO32UgF70Wk8+TvL15Qf8t1cdt6EMh4wQLfx4yw61idh5GgE+U+lJVVKEdImyo72G
         x4JVWiIEQfDXJMlN2AwuPXp0kvZq6N/waTgn28tsw2jVJJoGdutMopr/uuw/iQZICmS6
         YU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7uJCwOXevc3AyI7lWZC3RUDZR5Y6Ndzzd9RybpHzjy4=;
        b=cHq3CMIeX1OHFl+e1hZzzBkYmlmIC38rj3lPCPMw3p/zAuAi/YOiYm0c00kRLYV52n
         04Nd+lfK/nIdjAR8scR5yDlX+s3GiA+Va6XCi+GmBX/utyvBfGnJsblLmy6GDshphaeM
         EGZJP0fxnZjWd3ClV3OV3OoBPUxrzZrx734FFe4u9GC3cIhMFV3zBCOj62jR7eLoSDqY
         2dc0cK2lgq+Sciia2QtWYWbWzWQnM67tPd9TBREDaFs++snCqXwHmweW+akMPbaHpqZR
         VXa/Rb7F8Uzk3wDwixnhTUZAhLunPgyMgUlk+z7WSx7kcx7uav5Tio8qn4Lt+bNwk49u
         gX0Q==
X-Gm-Message-State: APjAAAXLEwdCnuf26nz72OHlz3XUlyLpHfCi2mWdEM109qNVhanrofEY
        Yk7K1HoOckO9At81WMP9NYmRqIDoOCo=
X-Google-Smtp-Source: APXvYqweWIhGvd8MriTQBSVGTR5SV5YIQW/7iwDKTTwI+35ZHdRkA7M8r/HFOsLIFk5ACMfPuXjVog==
X-Received: by 2002:adf:e906:: with SMTP id f6mr21350537wrm.258.1581936457677;
        Mon, 17 Feb 2020 02:47:37 -0800 (PST)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id m3sm352361wrs.53.2020.02.17.02.47.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Feb 2020 02:47:37 -0800 (PST)
Subject: Re: [PATCH 1/2] nvmem: core: add nvmem_cell_read_common
To:     Yangtao Li <tiny.windzz@gmail.com>, linux-kernel@vger.kernel.org
References: <20200126195619.27596-1-tiny.windzz@gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <51801309-1be7-d5a6-197a-f36b85293aac@linaro.org>
Date:   Mon, 17 Feb 2020 10:47:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200126195619.27596-1-tiny.windzz@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 26/01/2020 19:56, Yangtao Li wrote:
> Now there are nvmem_cell_read_u16 and nvmem_cell_read_u32.
> They are very similar, let's strip out a common part.
> 
> And use nvmem_cell_read_common to simplify their implementation.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
>   drivers/nvmem/core.c | 54 ++++++++++++++++----------------------------
>   1 file changed, 19 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c

Applied both,

thanks,
srini
