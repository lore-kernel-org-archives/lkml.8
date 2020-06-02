Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81B4C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 14:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81DF720757
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 14:57:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DNt1iq/3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgFBO5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 10:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbgFBO5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 10:57:21 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D07C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 07:57:21 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id m2so9190547otr.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 07:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=4E5ES1iIxunkqkGCzXCb8Ygxe+sM/Ttr8cZagYtaHxU=;
        b=DNt1iq/3JW2hVPJxcMSHdu1l2GoXlHN8qRgBm8MgRvLWdBLsoO21j2Oh7PMn5uT7en
         ZYcXGblzcknydUYlC4eXTx+1STVo3gcTAwqwrJc71JMX2eQf15Bf+u75qSj9Qeu3ncd/
         dHIti8EnJHWLS+hn8uAu1lPqoCcwHBtmfot4bDYTW03M7n0545NkBFN3cmXFSJPFaVjb
         zH4HoWHLx+efcADFHNjesPvCneN/cSGTfHMHdTj828BqpUk6WYQr1E+CGOy9eA2pKnRo
         bcbC3dE5laV/281k3nW9Jan1ljZmg4OV7l8LgdWaoK2kyGfxBVN4CsbPX6z+gDOaN0g4
         mGBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4E5ES1iIxunkqkGCzXCb8Ygxe+sM/Ttr8cZagYtaHxU=;
        b=GW9FXy+0eIA7YMLrFkm8Hm5oKaZ1gQ3Srng44V/rGA7k74XGQIVn9a65Kriq/TyCrr
         vCp8qg75Ap+l1GKlVOhxAphkKBGif70N4H8kk09hArMtTfptn9vEvxdS6k4L7e7vmocH
         +RHGJ5blhLMF3Lkv93oTG0TLSBUj0FTI1xyBC0L985eRfPWD9TXg/3sIBXXTd5JaLHRC
         eqWVclkL+bKIwwWbkbG3uh0K4JG1sBUxFi5Bk+/KYznfQ5RiqQaIsZS/XSUhgiv3U7Rl
         SouLJKjOEdvjNsXgRKnWBqZ5ygiVNx2Up8pJuTPPXOE+Jhz4yA50XGzHydLrzmVzQAbR
         ss7Q==
X-Gm-Message-State: AOAM533nfObIq/RrexirSD0JKNpvMnlOaINFvu778LvI+m9abVox2AF/
        Y1ToJ5VaXoskzqXvCjm4mkGZufn/
X-Google-Smtp-Source: ABdhPJwboolo886T/Rg3BzW+ssdxPJ/UF8A0AeLFgJjU2EKNTii9069g4ZX/ru365HkhBVya1RcWoQ==
X-Received: by 2002:a05:6830:549:: with SMTP id l9mr12691971otb.129.1591109840971;
        Tue, 02 Jun 2020 07:57:20 -0700 (PDT)
Received: from localhost.localdomain (cpe-24-31-245-230.kc.res.rr.com. [24.31.245.230])
        by smtp.gmail.com with ESMTPSA id v132sm745711oif.6.2020.06.02.07.57.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 07:57:19 -0700 (PDT)
Subject: Re: [PATCH] staging: rtl8712: switch to common ieee80211 headers
To:     Pascal Terjan <pterjan@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20200601202410.124593-1-pterjan@google.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <e668fc72-9103-70cd-e545-095e88c53dcf@lwfinger.net>
Date:   Tue, 2 Jun 2020 09:57:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200601202410.124593-1-pterjan@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/20 3:24 PM, Pascal Terjan wrote:
> This patch switches to <linux/ieee80211.h> and <net/cfg80211.h> and
> deletes a lot of duplicate definitions plus many unused ones.
> 
> Non obvious changes:
> - struct ieee80211_ht_cap is different enough that I preferred to keep
>    (and rename) it for now.
> - mcs_rate in translate_scan was not read after being set, so I deleted
>    that part rather than using the renamed struct
> - WLAN_CAPABILITY_BSS is replaced with WLAN_CAPABILITY_ESS which is the
>    corresponding one with same value
> 
> Signed-off-by: Pascal Terjan <pterjan@google.com>

This patch does not apply to the staging repo, current mainline, or 
wireless-drivers-next. Where did you intend it to go? Staging is the correct tree.

Larry
