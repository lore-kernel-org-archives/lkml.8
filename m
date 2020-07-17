Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BB9C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 06:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BFFC20704
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 06:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UcWSde9m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgGQGfk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 02:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbgGQGfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 02:35:39 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93257C061755;
        Thu, 16 Jul 2020 23:35:39 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t6so5029984plo.3;
        Thu, 16 Jul 2020 23:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gwfq2Oxnavl7ucChVlkUgRf4q/G8QkxmRXdasojjQEM=;
        b=UcWSde9mqcOsFM12e753OtPLogtcKFEIjVxKho2ZZHHRsen7/0it0e3x5Ej2nd02qx
         dgQrKJd6/BTb0roveOioOX+w5q7jjZKlqdXqCCfqMZUbi/3v4NfwzXm5GnQvH1aW5snx
         6dAeFHPIc4/1gSONpBnHuWW74CjkKT3L2afM6L5CszFN0HjoKlzTOdUQLbLMak4u+y8Z
         ozJSZP+Uucwe5r50PEcmmwbma7JPB4xOtTMSmSdsY9YPHfhu0U/3qL4AG4ON1zhWULHA
         q7sTqc8+py3csCc/4+4S4hkKZimvCyGDXod7lSurX846anVBdli+InkhwFXrKxIRu9tv
         KrfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gwfq2Oxnavl7ucChVlkUgRf4q/G8QkxmRXdasojjQEM=;
        b=UJY/AgrW/pQ+r1YbmxjYrEoiEDaT7d081a0ya+whUF1jE6sQIBYiwREuYQlRvfqEzu
         AhEY/X6T0VwJRrev5sWBmSLVEdwKPE61WwEzqmpumlKZVEOB/xd1YTmnJs6L41ddbfbf
         OBi/NgkGu98YOEW5OKx0MGgC5OJSFUmaadiFamSXfuKcX7AnNwL1NJxLfguBGlqvRwn/
         DfMiIQRAoD9N1oSL8PS/61GRkdstdhsxOxZx0S7aK5d+RN0XyFOHrwia2i2cnIp/aE5d
         nxJhNekc1KAIeYYPEW5gmoFJREtF3YedPXLHu4HkimgWl5EgqKeDoFjUOQYhxOWMngJ3
         PSZA==
X-Gm-Message-State: AOAM531lItgcIqTv4htaQuurTXsv0jyjd2rJicZVGkiSmfMvGa2H3oBV
        xTMwDneJquQ0gmosw3OgYj8S+HDoLLQ=
X-Google-Smtp-Source: ABdhPJxtN1Vjhd2BgVIrdYDppeOqBR78bHX7M1q3xx9lwOs4t90Zdmls8Mvd1xkCHLk+6GbVRLh1cw==
X-Received: by 2002:a17:902:c206:: with SMTP id 6mr6813084pll.268.1594967738704;
        Thu, 16 Jul 2020 23:35:38 -0700 (PDT)
Received: from ?IPv6:2404:7a87:83e0:f800:800a:c89f:4095:5d45? ([2404:7a87:83e0:f800:800a:c89f:4095:5d45])
        by smtp.gmail.com with ESMTPSA id z1sm6687788pgk.89.2020.07.16.23.35.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2020 23:35:38 -0700 (PDT)
Subject: Re: [PATCH] exfat: change exfat_set_vol_flags() return type void.
To:     youngjun <her0gyugyu@gmail.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200715135000.86155-1-her0gyugyu@gmail.com>
From:   Tetsuhiro Kohada <kohada.t2@gmail.com>
Message-ID: <cb125a5c-7e3f-2480-8a20-55805ec554ef@gmail.com>
Date:   Fri, 17 Jul 2020 15:35:22 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200715135000.86155-1-her0gyugyu@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/07/15 22:50, youngjun wrote:
> exfat_set_vol_flags() always return 0.
> So, change function return type as void.

On the contrary, I think it should be fixed to return an appropriate error.


> @@ -114,7 +113,7 @@ int exfat_set_vol_flags(struct super_block *sb, unsigned short new_flag)
>   	 * if this volume has been mounted with read-only
>   	 */
>   	if (sb_rdonly(sb))
> -		return 0;
> +		return;

Some other FileSystems return -EROFS.
exfat-fs may also need to return it.
(If so, the caller will also need to be modified)


>   	p_boot->vol_flags = cpu_to_le16(new_flag);
>   
> @@ -128,7 +127,7 @@ int exfat_set_vol_flags(struct super_block *sb, unsigned short new_flag)
>   
>   	if (sync)
>   		sync_dirty_buffer(sbi->boot_bh);
> -	return 0;
> +	return;

Shouldn't the execution result be returned when sync_dirty_buffer() is executed?


BR
---
Tetsuhiro Kohada <kohada.t2@gmail.com>
