Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F650C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 14:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 082B420658
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 14:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qbBhVlVN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729489AbgICO7Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 10:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729102AbgICOHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 10:07:52 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E46C0610E4;
        Thu,  3 Sep 2020 06:54:53 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id y4so3790261ljk.8;
        Thu, 03 Sep 2020 06:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vZF87zSk1oleEIGJMMtf9vb52AVAs8bIBPfRdsKpf5Q=;
        b=qbBhVlVNvPmvqPx5v6F58TSakj6W9nFXHWjRE5NqtqVKAmw1K0JWbEqfA+/gd42S91
         JXUVEaLb+Qfzk7NxCRl2cx+HjSOJu+vak0Cgh8OfdcWhhjCfgpekxBq+wRNMHQePEi8h
         8ZwypTxHgr1tfi6Dy39W4aPoapfsvFO4PJ0dcdZlUCshhuNTCxFoTIg7Lzc//2PyTOnp
         FKi1mTlOqecL8AFYe1fwhDp/o3pRJoPSjqrIwn/ymFoeklQRoHTQIyLu4Bql28tB2alb
         MOodx4J/fpQLZWLDd97dtmOxL9uEb556nMBT5Yw8dgDd/R56+juVdP5ltP/5ASdyHBwT
         ej6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vZF87zSk1oleEIGJMMtf9vb52AVAs8bIBPfRdsKpf5Q=;
        b=raicgMClrd22+iH5Mo574nTj558eGHzEYvzAxyY4okrOAbUVwmf65ToIQTLtSop8e1
         NAI61/2JM7o5U/c2rG/rI9uE//49LrZcN0xvKuKopzrO6+URUVmhKYS12/X2pD8aYSkq
         r1wcJxs/ev5OPFCDK3IfxQrSrb9qu5WrvpcCWxqC5rnujpt88WB4UunhIRj0bnHbxmEv
         OvNmjVMgVT+b07JLgvRgA1mrLSf3K0ikoJTTlqAuDXzitnwanFfL9Q0sKVdQASLFoX9Q
         WaKsvWqqPwMIU2CpGhunX17GYP8psBMowLXdCGLhjx1LPCu049PnBDNHgafDuuTEfqNF
         eQYA==
X-Gm-Message-State: AOAM533mKuVPbLRmP5evj1nC/N9t31HGX89RgAuA+Ol2qiSxeE+5E/uq
        tXUZkzq/mhlii8lWcKYRoTwrqhlfpG0=
X-Google-Smtp-Source: ABdhPJxttIN1R0lpLrPnWhXTqIN++Y7J5bfgO+/vIsXA2S2Frc33+/pts+ZC/vmRHdqA6RYrchDvSA==
X-Received: by 2002:a2e:911:: with SMTP id 17mr1452833ljj.207.1599141291562;
        Thu, 03 Sep 2020 06:54:51 -0700 (PDT)
Received: from [192.168.2.145] (109-252-170-211.dynamic.spd-mgts.ru. [109.252.170.211])
        by smtp.googlemail.com with ESMTPSA id t16sm637505ljo.27.2020.09.03.06.54.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2020 06:54:50 -0700 (PDT)
Subject: Re: [PATCH v3 04/22] i2c: tegra: Don't ignore tegra_i2c_flush_fifos()
 error
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200903005300.7894-1-digetx@gmail.com>
 <20200903005300.7894-5-digetx@gmail.com>
 <CAHp75Vf9P9L1uM+he63D5H+-V3Zwv3jRiKTrXmtB4Sxuk9SC9A@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <60b6b0c7-48fe-4cfa-2408-17b2182e1cc2@gmail.com>
Date:   Thu, 3 Sep 2020 16:54:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vf9P9L1uM+he63D5H+-V3Zwv3jRiKTrXmtB4Sxuk9SC9A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

03.09.2020 14:09, Andy Shevchenko пишет:
> On Thu, Sep 3, 2020 at 3:53 AM Dmitry Osipenko <digetx@gmail.com> wrote:
>>
>> The tegra_i2c_flush_fifos() may fail and transfer should be aborted in
>> this case.
> 
> Sounds like a fix. To add to previous comment, fixes that are likely
> to be backported should have Fixes: tags.

I'll reword the commit title and message in order to make it not to
sound like this is a bug fix. Thanks!
