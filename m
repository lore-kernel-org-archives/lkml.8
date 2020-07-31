Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6674CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 03:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39655208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 03:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kDOgLFC7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731233AbgGaDJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 23:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730820AbgGaDJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 23:09:15 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BC5C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 20:09:14 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id f9so6439405pju.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 20:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=f2/v5+fU3qjOEHG6dlGJ2Ai/5KmucckFKsswnKWN+Mg=;
        b=kDOgLFC7H+oO/V2p+vFjn6zXQAK4tQjs6WN9nP/nFrtcrWGoESRminNKvY0SJebRXZ
         WFwMDKFO+CL7WVhJoAR7N3bL1R/L9lHtuWXjSF4TcQzyprpGb7lty+KZJEE/1l4cza21
         PZgrr/SJ5nM6gl0s75rDBVPG0W50ipVlpaRwuNltETJrYGv+QYrouiC6QgmdNTd9HAkU
         hBjhQhd9hrJVzg93zX75Bq1l0tqLEhceH98bp0wbQv9sEXG9UpQupvNl3i6ScPceMurJ
         175lOINuDkdBu9m7sYwoOK4z4sHPfEKgGTQo6JPazXXxTn/PwvbSmcC/W6ejBW7cWEjj
         u3gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=f2/v5+fU3qjOEHG6dlGJ2Ai/5KmucckFKsswnKWN+Mg=;
        b=sKqQeapGfYbINDOp29U4QKXwLUMmqNY3T1NS7IxjRyGYXMwqN+VSckdqsGWqGwBkTI
         leE4Oh7Ov/6O5v4FdHKfgmduyjnuSutAo7dHKEQBRwjJqIurcNPZ7Nc+bNJ2QQl68VVy
         JW5vQTmeAUUXU4baY5MQAeWPe1wVrbjCv/dsBwLzPqAYAeihE1Vg3N1gTPPogtsz3i0f
         hcsTqEys6RnrK6bVGdPelT45uO+qeNEWqWXZEMfr2zBELegJyY5h9Zm6PyDitndnUcf4
         u/IlvplAX9JSmaFMYs64juotcy+hQK0bWfJwT8H3fQBSBfrS0A++3SoG+O80ixlKzpVT
         5MZg==
X-Gm-Message-State: AOAM531loSRoZXb3Qy1Zt1+9QTLz4RljLt+Q7ZgHTX5C1PsKPU8slX5h
        ZVR4xstWtv9A844s+NrUrfoyJXW75cA=
X-Google-Smtp-Source: ABdhPJwVBGzh4EjSumD/AU75OUDlVPrLUJ0XzHShnRKNUJs63MTJt0xtZrWA72lgSRI626qn3LW1RQ==
X-Received: by 2002:a62:ac05:: with SMTP id v5mr1908660pfe.8.1596164954382;
        Thu, 30 Jul 2020 20:09:14 -0700 (PDT)
Received: from ?IPv6:240e:362:440:cf00:1d91:fa1:68aa:9a44? ([240e:362:440:cf00:1d91:fa1:68aa:9a44])
        by smtp.gmail.com with ESMTPSA id c134sm7880618pfc.115.2020.07.30.20.09.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2020 20:09:13 -0700 (PDT)
Subject: Re: [PATCH] uacce: fix some coding styles
To:     Kai Ye <yekai13@huawei.com>, linux-accelerators@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com
References: <1596089583-32687-1-git-send-email-yekai13@huawei.com>
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
Message-ID: <a90d4a96-b377-8b24-45a0-c45e5a10dce7@linaro.org>
Date:   Fri, 31 Jul 2020 11:09:02 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1596089583-32687-1-git-send-email-yekai13@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/7/30 下午2:13, Kai Ye wrote:
> 1. delete some redundant code.
> 2. modify the module author information.
>
> Signed-off-by: Kai Ye <yekai13@huawei.com>
Thanks Kai

Acked-by: Zhangfei Gao <zhangfei.gao@linaro.org>

Thanks
