Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41728C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 03:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 011B120578
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 03:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="unJgQppA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729811AbgIDDvD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 23:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729582AbgIDDu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 23:50:59 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 004C9C061244;
        Thu,  3 Sep 2020 20:50:58 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id n3so4611142pjq.1;
        Thu, 03 Sep 2020 20:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4urzEhGn5hqssobDIK8yWQdnXlOAEOS8EvsZsVpYUxA=;
        b=unJgQppA06zOr+i/5lbVh8/37wSbu9UyAGsYiVHtrOVMiaivuyDFggzcwBjwWE9486
         C36prs5NCsLNwPTzYU+HswqW9oM9WRdEC1hBnOY6dJRMwEFNDdFJftTOSAQuj/qv0XFQ
         liObP3Qo30j5gZTNS73wLPXTS47i7s1b3F8P6BxVvltDZHOYarHQaowYKZK5yBx7lvM/
         9OMquEkKEQxvyjX6KwHr9nhQCBRaSVO7VzMPpmH0R6OIJq0bV42lA/M1WSgm8aJNL49h
         0iriiCn9BVoffTa28iE/0BHDCmEbEGzS4HMkRyLy5mxf8kqzVqiLHCbwoIOu/SHSEGAY
         uA3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4urzEhGn5hqssobDIK8yWQdnXlOAEOS8EvsZsVpYUxA=;
        b=dqrPet14MOSDZZ6TX8xY8Ioza2hWr+pxsBWZv+zyjkULSddvY9F5Q+teOmJNU7jZsE
         EsVWOARpAL9asNTT70Xbgxufcd9kjuofpfFlnaNTnYvj2+HyYsoRKzczdrQW1/PkiWKv
         g/kNaqD9PiZATnq3dqzMwchaSG41JE3GR/Ai+BzuoDnNWn8bu90DC5KOw93nt9T/qobk
         22WvKani67W5Gu4FSAo2BT//MroZuPWJd5X9wTcHdQ8gidAvCqtmq4DJwED7O8iYuqcr
         1wztTqfPCQNLqX+khz75p0ueDj/i05RbnlQbxjM7CoL8KGpgIVwhWV3YwE0Xnx0xtqev
         111w==
X-Gm-Message-State: AOAM533JwPzZiAiQ4esd16Ib2MF9DBMqHutuQKgkA0Dc5OxerHLjv/u0
        n7b/2bVKo6RfiJFU+fvRdgU=
X-Google-Smtp-Source: ABdhPJzSRvqOf63gxU/n6n9ZHFnZOmVFxEHhne1/T97JN+EH0qLWP6l41omxY+8DCxWGjFIHXsJUHg==
X-Received: by 2002:a17:90b:f01:: with SMTP id br1mr6465421pjb.2.1599191458528;
        Thu, 03 Sep 2020 20:50:58 -0700 (PDT)
Received: from [10.230.30.107] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id u65sm4818759pfb.102.2020.09.03.20.50.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 20:50:57 -0700 (PDT)
Subject: Re: [PATCH v2 07/11] usb: gadget: bdc: avoid precedence issues
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Al Cooper <alcooperx@gmail.com>,
        Sasi Kumar <sasi.kumar@broadcom.com>,
        Peter Chen <peter.chen@nxp.com>,
        Minas Harutyunyan <hminas@synopsys.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <1597923046-12535-1-git-send-email-chunfeng.yun@mediatek.com>
 <1597923046-12535-7-git-send-email-chunfeng.yun@mediatek.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <8bdd213d-e16f-2e91-439e-cc5d26fe3770@gmail.com>
Date:   Thu, 3 Sep 2020 20:50:54 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <1597923046-12535-7-git-send-email-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/20/2020 4:30 AM, Chunfeng Yun wrote:
> Add () around macro argument to avoid precedence issues
> 
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
