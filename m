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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4778EC43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 03:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B80920578
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 03:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmA3kU4T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729824AbgIDDwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 23:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729550AbgIDDw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 23:52:29 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14513C061244;
        Thu,  3 Sep 2020 20:52:29 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id y6so533934plt.3;
        Thu, 03 Sep 2020 20:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=D8+dXqlq7CKk0oGRc6xGzRKcimFBOeMe8F+MCDfQRRo=;
        b=gmA3kU4TWCQikM00zN05xdt8pvCTIlIo2eld9t6I53hbZbjeWZs540D5QwYw9RUzd/
         mXDOQLNzaohNpG6Mk+3a07L+6YTpYtytDQrV1Mz1WJ80FTCMDKyEUw+918NpYGdzspLY
         o5Ke6zNLbMS+UDgf6oeJRGsNADSDCBmUV9M/OlQoRiRNRpz2e5P+h1OjZpY+B7dmOJbD
         R/oEIOO+zleg6647KpFBOwMYDveuLtcLiTsUf1C1o9JMEcsnSNBJ+SdaH3bkEFyBaO74
         3nsRhlv5jvhDGzfLYXMOYEBoaO3+vqdXr0BQWziELCA5t73e9/ERFPyJ46syOG0ziHJM
         wTzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=D8+dXqlq7CKk0oGRc6xGzRKcimFBOeMe8F+MCDfQRRo=;
        b=bqgb63seocqcegDW0xYZkEMRsqL0Kp+4n3w/PUA1HUKKB6Ij35xXmX9CkAZL9pvAi9
         Kba+urq/TcbN486D8IFGeeZKhFTAjNadnjyC1s/sd7PFSahaH9Ed3IJ927gwmE2Z7f/5
         L/dvR4V0aegyHYHZDeWUlL5lnhTFAT7F6d/ZjuUpg5n3EtaJI8wdeHVldHtGVho8q8TH
         C7/3WE4Qb7KNFXCfbM0C1/g1CvGOMMyEfGfZV7BTHtmVq0a4U8J1jkfEFFDi1o3zOAcF
         7FegS9GnvMr5wIymEeLK/jQw3FVuMR1uYiHEA5xp845qeV9ftfk2UFo0vF8vMl3jxKDo
         v85g==
X-Gm-Message-State: AOAM531UvLxGwkFhAmK6XGf67F4hRhH1krNK8o/wm+oMGSqzED6aydG/
        /B+dY62jC7SKmcahIxIeDnY=
X-Google-Smtp-Source: ABdhPJwOSSrfcreYOMbh7Tq5PAzkMTqnCDtvKkRUYfeT541l5BaHSPFTYA0FvUIbahv+r9MBpurdYg==
X-Received: by 2002:a17:90a:c917:: with SMTP id v23mr6100864pjt.97.1599191548405;
        Thu, 03 Sep 2020 20:52:28 -0700 (PDT)
Received: from [10.230.30.107] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id a27sm4686215pfk.52.2020.09.03.20.52.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 20:52:27 -0700 (PDT)
Subject: Re: [PATCH v2 10/11] usb: gadget: bdc: fix checkpatch.pl spacing
 error
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
 <1597923046-12535-10-git-send-email-chunfeng.yun@mediatek.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <18a38804-e68b-389e-02b6-2769e74d3f9a@gmail.com>
Date:   Thu, 3 Sep 2020 20:52:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <1597923046-12535-10-git-send-email-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/20/2020 4:30 AM, Chunfeng Yun wrote:
> fix checkpatch.pl error:
> ERROR:SPACING: space prohibited before that ','
> 
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
