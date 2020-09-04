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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A520DC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 03:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78E692073B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 03:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crU4Qd6Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbgIDDti (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 23:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729550AbgIDDtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 23:49:33 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F7CC061244;
        Thu,  3 Sep 2020 20:49:33 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id z15so519508plo.7;
        Thu, 03 Sep 2020 20:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r9i8umvaVSCytJM5iVtoZF4CvYGhoyV2FUivwOerO4A=;
        b=crU4Qd6Z2+DAAeZF1HTd0p3YNhtJUieOOImq0TqKNBWzEAAr8RwBu5zYvd1ltMPhCZ
         heSOuQ0zSAXKsjn9i6Hq+r+XK6noMsY4+wgTMzmUHMSqzTKo34VHo7xZF7suyjwmfUn8
         TJV++BfiA0JQyGQfrzZxXK1nfN2Re5TKJoRqQkzQdX8PXenJaAzrVhzkjho11cn2nqKZ
         6Rwe1E1LSEFAEpfnl1N/tu/1oGEqLZBj+Khq4YclQAjyKuOPgn/TYdi83L2gbtLCIY7X
         PGhaAskoS3vC0g21NXgOsoVRsF2NxQaukKgCwBZl56SvXksVeBvC4wp1ly48RLRUaka4
         7rHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r9i8umvaVSCytJM5iVtoZF4CvYGhoyV2FUivwOerO4A=;
        b=sDCMoND+eZqQEOm7YAGUlVF0Ata9QX4LaTRkZOJPmHEjJuCGpi1O6Hjt/pAYWPWbL6
         zEckN4ir7tLTeiAjksadLP2Hq5+wOY9ONCDddV9wOPeADKLytfSl5QyE/5KWoxyRh0Th
         7wi/FwcdPtpAsjLADUcq5FX96OLGzb/LBjvk5Dudj+5Z1i9zHIcBv380PdOMrLyKibR9
         y7JvYv9+XYWiLBbOUJH+oVFdDTK0Zo7DZl97/Ypc8esOwR0MiVPk554yFJv0eEFrO6eE
         fTLf9H70ODDR/jfCTvGa+kwHJx3PxFTqWZtw0kar1jYVcqUpE/xWqge0zBmdGTTEMLiu
         Ayhg==
X-Gm-Message-State: AOAM530u2/IR76VD+URpNWv6Ylpq/19U4lNUo0mjtUeXPjad6aK5kyM+
        UY79EV1qhTdOSh50m3BXCdU=
X-Google-Smtp-Source: ABdhPJxaTmX1TKvxuvR4aSt7UoimXF7486URqY05IsKTArsai2OPCHITVNeEHzzBYlPb4MGSdwAcig==
X-Received: by 2002:a17:90a:ae15:: with SMTP id t21mr6402232pjq.224.1599191372722;
        Thu, 03 Sep 2020 20:49:32 -0700 (PDT)
Received: from [10.230.30.107] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id g9sm4802550pfr.172.2020.09.03.20.49.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 20:49:32 -0700 (PDT)
Subject: Re: [PATCH v2 03/11] usb: gadget: bdc: prefer pointer dereference to
 pointer type
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
 <1597923046-12535-3-git-send-email-chunfeng.yun@mediatek.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <4146418d-14a1-08ae-b387-944f6625e56c@gmail.com>
Date:   Thu, 3 Sep 2020 20:49:30 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <1597923046-12535-3-git-send-email-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/20/2020 4:30 AM, Chunfeng Yun wrote:
> Prefer kzalloc(sizeof(*bd_table)...) over
> kzalloc(sizeof(struct bd_table)
> 
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
