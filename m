Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993B7C3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D9D620722
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 14:02:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=forissier-org.20150623.gappssmtp.com header.i=@forissier-org.20150623.gappssmtp.com header.b="nBKtrCgl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbgDTOCM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 10:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726871AbgDTOCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 10:02:11 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED51C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 07:02:11 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id z6so11559356wml.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 07:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=forissier-org.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C3AAiW6fB4UzASXmN81Qmx72AYCFjPIxhjt/E9LL6Tc=;
        b=nBKtrCglOe3rthYdcp1D+92M8Fda87hw/LnYcjdq2dlJOg11Cotem+LkcQ2gSbIuO2
         i19JtDDxfDgQ4eex2f8W7W/akRc4DnQ/x55p+rgvwTCc4rVWDcm7FFOgnymrUICraapy
         GtNI/J05eNnuqHWm85/ehe4gzvdEGM4ZottEcgKhlZX7R5RfVE6O2UxQFXqHqwG5R2T9
         KUYCw3GgwB/vyiIYOstcGMYkoCWydo4wyhPG5519BJZba0FfFSuZ5QhEZR7AEOdK7K83
         3v2r1r3lTuNZdBDI6WYLMp+FDtYDjed7NZDlwalOVCsjZ5mp07JlMYQX9iwjtFjuvy+j
         JetQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C3AAiW6fB4UzASXmN81Qmx72AYCFjPIxhjt/E9LL6Tc=;
        b=VerQAap8S85YcJ/9vubJ8t6MfXyTjf7gPlWn5WdOQy7dbeYt98BW4H9VT5kQtY+FVZ
         Txp7dJlzfEhy+m4CUbIJV6feCBidIRyoYdrQJOdS6Yweo3xZOcErjrYpiExPoWWWDwbC
         8MwZLUtFJhlec+4IHlIhG6cDhFtWfv3kdRjfIFFOYv53BsW74ZBetzexf0POxBeJ894l
         GSCwK5VccLgrfQCBkXKBeTNU1JFMDJUB2C9lbBVoo6hvB/BrjS/v63VyfV2Nq2k3bXHM
         vK7FilqA4wPy6wq9W/bNn5UOK0is41cyZG6nmuP60JZZzBUiC0eMKhIvaSpqp2+HPSVg
         b7gQ==
X-Gm-Message-State: AGi0PuaNWWCQhCEv4d9D74zDvCGD0twumyYMPgf/HyhkyDfM1c/7YrUP
        L0mz43nnaWfbXFZHlyDvZ/2cYZdyT7kjhije
X-Google-Smtp-Source: APiQypIhqWGjovuBYxz8umFi65PmN5L+WMJC0VBHi4ZsrFQ79/Pe8bfrAwY5ZAP0eedUmgaO1dJTTA==
X-Received: by 2002:a1c:2383:: with SMTP id j125mr17744213wmj.6.1587391330205;
        Mon, 20 Apr 2020 07:02:10 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:3cb:7bb0:214b:4b7c:7462:3102? ([2a01:e0a:3cb:7bb0:214b:4b7c:7462:3102])
        by smtp.gmail.com with ESMTPSA id i129sm1652954wmi.20.2020.04.20.07.02.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Apr 2020 07:02:09 -0700 (PDT)
Subject: Re: [PATCH v6 2/2] tee: add private login method for kernel clients
To:     Sumit Garg <sumit.garg@linaro.org>, jens.wiklander@linaro.org
Cc:     tee-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        stuart.yoder@arm.com, daniel.thompson@linaro.org
References: <1585286988-10671-1-git-send-email-sumit.garg@linaro.org>
 <1585286988-10671-3-git-send-email-sumit.garg@linaro.org>
From:   Jerome Forissier <jerome@forissier.org>
Message-ID: <de12c5b1-4875-93d1-6d94-374d34f7e0b2@forissier.org>
Date:   Mon, 20 Apr 2020 16:02:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <1585286988-10671-3-git-send-email-sumit.garg@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/27/20 6:29 AM, Sumit Garg wrote:
> There are use-cases where user-space shouldn't be allowed to communicate
> directly with a TEE device which is dedicated to provide a specific
> service for a kernel client. So add a private login method for kernel
> clients and disallow user-space to open-session using GP implementation
> defined login method range: (0x80000000 - 0xBFFFFFFF).
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  drivers/tee/tee_core.c   | 7 +++++++
>  include/uapi/linux/tee.h | 9 +++++++++
>  2 files changed, 16 insertions(+)

Reviewed-by: Jerome Forissier <jerome@forissier.org>

Thanks,
-- 
Jerome
