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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C658FC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 03:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86D5220578
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 03:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D//pq24z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbgIDDwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 23:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729550AbgIDDwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 23:52:45 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 175F5C061244;
        Thu,  3 Sep 2020 20:52:44 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y6so534167plt.3;
        Thu, 03 Sep 2020 20:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VvSpWCtLeTgX2Zx+CTqO44Oc9ZtJWYEJgi7S5Gg+F+Q=;
        b=D//pq24zw/pLfyx4maLjLfQ2lDUCmLfZIrixpT98Wu8GASO9f9vuVwrx0f1N1qlX1w
         YqVenwj86pFYV/M/r3ukmeXThynu19mRVAysI8G/vM1jijsn1Izw80UFcaDclrNdW/PI
         bM3ThpKHqrMK/ncstGB9iOUnR3UrmxFHVIVdixqAi1fOU/6vFMbNI+Tusesi7dfM6rWY
         JkuqXSy5+Hx29rYCFAciwVsccWgabdIffrcsSrZrhvTTPw5Vd3jjw9ETdso048+ADvsA
         uugPwym1ZNzWPNxXL6lr1EDMLSoVKL2Y9PIu/yezuk8iC2zTxi+MxIzod9KEdiDcHtRn
         KX4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VvSpWCtLeTgX2Zx+CTqO44Oc9ZtJWYEJgi7S5Gg+F+Q=;
        b=JwrVnGkel7xQoG2RseNNGhhOdMiC6dyYKGMibjceq+OgO5k9uFyisibs2bBPAh+rIh
         +PbldQk1vYysqKCVEAEggxBoAwrmrbLLoSNKgu9X77F2pv9TS12wQe08epHGIU3GdIde
         FrOvOVonJfyXgzpEfZq87adWPLWYScL/rs1DKBH99Jx71K0dB3+Hzbp9FpvmI0/JrCSB
         AYyn4RAL2iDBxAvKVDQzKQXoWsPGqQMxJUhkA8E08ikKR36eRDkklmYcZSGoKSjh73Ts
         KiTymi9Eh5H3wfPHwF3GY+wdgk0NoIRTSREvrKnNN7SacEFXTt+867M6lhdV/4z7UERV
         nreg==
X-Gm-Message-State: AOAM5330okc39joK3UJOGf3atM5OlhIaHoQCI+yTaxS02gYDbrMG/suT
        /Ocsp++EmKIdTpTMJ91RGW4=
X-Google-Smtp-Source: ABdhPJyPpWgFNMgaWgZ1pBVMj3Sq4TQT/soa1h/DJjgZy4i7vCeAoxj/zISjbwyzKuU1XQou06cPJw==
X-Received: by 2002:a17:902:7808:: with SMTP id p8mr6858602pll.122.1599191563632;
        Thu, 03 Sep 2020 20:52:43 -0700 (PDT)
Received: from [10.230.30.107] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id k20sm4799735pfu.197.2020.09.03.20.52.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 20:52:42 -0700 (PDT)
Subject: Re: [PATCH v2 11/11] usb: gadget: bdc: fix checkpatch.pl repeated
 word warning
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
 <1597923046-12535-11-git-send-email-chunfeng.yun@mediatek.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <c3fc8267-b4f4-21af-8319-fa5b17216c52@gmail.com>
Date:   Thu, 3 Sep 2020 20:52:40 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <1597923046-12535-11-git-send-email-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/20/2020 4:30 AM, Chunfeng Yun wrote:
> fix the warning:
> WARNING:REPEATED_WORD: Possible repeated word: 'and'
> 
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
