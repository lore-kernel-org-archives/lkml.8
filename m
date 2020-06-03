Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E868AC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 17:42:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB31F2053B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 17:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="gk244yjd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgFCRmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 13:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbgFCRmq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 13:42:46 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BACC08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 10:33:31 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id j12so1856693lfh.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 10:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=RiYI0t+KrBvaJgMcqUi2332VvHKyX88P2wlQysjVLXM=;
        b=gk244yjdaq9AeMPc0x74cYRwy2EEkQH/A2o2vAvYivtoPifzXZ4zIPTJxNnt6AEms3
         lnpu4id+cI4xfoV50YJ3gBY/KHwO5czVFEAW3yZvg2XLVI0C+9X1+Ckei58TxH5yrgfU
         PF13oW+pEFgFc9YI47rXwqVQRStTEWiZL8fC7FVTh8rSr0KJdluA2FI89xLVmbfQ+NEW
         wlgPHeXOEVwRUcFUMyqo37mmdKmoeKXeGMAoiKXHwA/4WYa5strDvITPRW9Rem2vUDvL
         zNBIpLEJlrIhR0I1My/Ub2bW9Sw0qyMOt/HBDths765G9kyJoGaQBb+35SazRc8zZLjg
         m+LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RiYI0t+KrBvaJgMcqUi2332VvHKyX88P2wlQysjVLXM=;
        b=WhNf2uH+FRGKAwHj9wPL56tx6nFivDR9FFoGBVMYulRijweWUJ8dZYea3IpxhRL+T9
         fLdE6w0yQlhiEU1pGSPQ8z0QcHG/JgJQimPhyShrEyM4MTfqgncOVLE2q6JWYi589rVg
         b0VER97T8t8vqF30E7YTqfcq1b6TAvln1OCVKGTce2ZXi0j75zKrhVCmVAFAPoSOWbLf
         /DYEEVYAyprLdBdZekx4Wvglg1bWlOCSU4sus4L6SS6HF0v3jrFiDul56iq0JI0+23fL
         g6YW/VEUYFtjvrJ35XyIXwv+JMlgIpCE3LbdBp6XOd1TBrv86N+3xsUyghC+SQVu8mnN
         MJ3g==
X-Gm-Message-State: AOAM532PYzQGfnHrXu8DGJyBVeYMyO1G1T4a1n+wkf3rDUTgUOti0Zoo
        Gk5E3r+s7i+A8qzkinWP+RfsWQ==
X-Google-Smtp-Source: ABdhPJxlDbpPhvBO2HwzpUWB+mZRWd3ea7bAmLgctD4jOZItUkkhqH0olCiHDFJagt7e80KPbSXkjA==
X-Received: by 2002:ac2:489a:: with SMTP id x26mr297287lfc.111.1591205609563;
        Wed, 03 Jun 2020 10:33:29 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:448d:774a:2057:6699:2c75:847d? ([2a00:1fa0:448d:774a:2057:6699:2c75:847d])
        by smtp.gmail.com with ESMTPSA id q8sm815921lfo.13.2020.06.03.10.33.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2020 10:33:28 -0700 (PDT)
Subject: Re: [PATCH v3] usb: host: xhci-mtk: avoid runtime suspend when
 removing hcd
To:     Macpaul Lin <macpaul.lin@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        stable@vger.kernel.org
Cc:     Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        Macpaul Lin <macpaul.lin@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-usb@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <ebd32a2b-c4ba-8891-b13e-f6c641a94276@linux.intel.com>
 <1591189767-21988-1-git-send-email-macpaul.lin@mediatek.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <b2f3aa9f-a592-0e8c-f897-f5d885fb9740@cogentembedded.com>
Date:   Wed, 3 Jun 2020 20:33:24 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <1591189767-21988-1-git-send-email-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On 03.06.2020 16:09, Macpaul Lin wrote:

> When runtime suspend was enabled, runtime suspend might happened

    Happen.

> when xhci is removing hcd. This might cause kernel panic when hcd
> has been freed but runtime pm suspend related handle need to
> reference it.
> 
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> Reviewed-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
[...]

MBR, Sergei
