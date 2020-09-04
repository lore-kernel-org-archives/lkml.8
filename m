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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBED5C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 03:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9140A20748
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 03:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8MVbo1P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbgIDDwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 23:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729584AbgIDDwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 23:52:03 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F57C061244;
        Thu,  3 Sep 2020 20:52:01 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d22so3875425pfn.5;
        Thu, 03 Sep 2020 20:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N6xRq1i2ZIJ2hKOpLEHhIn0ng/VBDSD16NJ/S5zJgog=;
        b=d8MVbo1Pysn28ePWKuVBfEhI8H7+LGEROm41dRgHcp6Olv0343S5sxa9NALyK09MBU
         6Dh16XNo8Cvfyh32VXOWgS+6OHMkP+6rY+FDrRjJxLdsWya+R+sCInvX+kZZ4Wqp1dVg
         5V0k0L/nKUJPMfRusazKsZvUdo9Upljd3Fejh3331JMIl+skxC4/78WMANYSWKmL+CJ3
         PfyeGaiilhRPXx8SicZgh17261FLnULqmqPw6uNzlkek/Bdrob4FZjiW8vCdgvSV6Y10
         Qy9jPKYmiGog9Hu0n5PSAUudP+zbgon2Jg3QOykh/1aBgVkNut//G/FC2GfaEqt7blVb
         5WnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N6xRq1i2ZIJ2hKOpLEHhIn0ng/VBDSD16NJ/S5zJgog=;
        b=pS8xqUKwIYott7v6GvWWxzIbXgY7Eh+LYCe8HprukFY/FkwtW5cmFvNmwJLVhnikRm
         VacZVocTpJ6ycsFqJWK+Xd9aEyItZ/VOEzQehpCVoIuZbvxm17WYRKMRwfbnUtsP8yK9
         C7sJWvmSY1RNMvrfKmGZRAlrddiTGW5y0TCuvWV2yMGLA7HGIN7hDoQi04fIPQjpMzfV
         H7sApEbTBpA3M+vbcJfmMzxFYT4iuLQZhWPCgngFO1M9oVy/iCfRGQD5pyIYSKiU+j9w
         5T4Xnlo7Z8Fl5+NBHAX5jU9LInNoHXKkU5lEXJ/E8pHyCsSk+UCLAGLWbZYJ6980FAI5
         NJ3A==
X-Gm-Message-State: AOAM531uk3dCSbZ7hM/dTgGFtvLUzRXIrf0NDDgP/z2XHV4WPioOVilC
        R7fyMub5rkQNeL/IViCeIM4=
X-Google-Smtp-Source: ABdhPJxafdDiCNSaciw2SgcO6QNZKpZPsCklgXLdgOyD556caEaZJcVeehtiVpdF75EFR7kHrCH6eA==
X-Received: by 2002:a62:87c6:0:b029:13c:1611:652e with SMTP id i189-20020a6287c60000b029013c1611652emr5024090pfe.14.1599191521307;
        Thu, 03 Sep 2020 20:52:01 -0700 (PDT)
Received: from [10.230.30.107] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 187sm4923852pfx.174.2020.09.03.20.51.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 20:52:00 -0700 (PDT)
Subject: Re: [PATCH v2 08/11] usb: gadget: bdc: use the BIT macro to define
 bit filed
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
 <1597923046-12535-8-git-send-email-chunfeng.yun@mediatek.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <ea2d82e6-cf23-20e0-1f3f-628510bf3087@gmail.com>
Date:   Thu, 3 Sep 2020 20:51:57 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <1597923046-12535-8-git-send-email-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/20/2020 4:30 AM, Chunfeng Yun wrote:
> Prefer using the BIT macro to define bit fileds
> 
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
