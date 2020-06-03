Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B46C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 07:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D20320674
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 07:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j5zLCboq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726054AbgFCHfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 03:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgFCHfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 03:35:11 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19423C05BD43
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 00:35:11 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id m7so533222plt.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 00:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a0uAEKUPj5s/C3AmfM0zbUvPo0nW2J6CY0cZs/p797o=;
        b=j5zLCboqBy9fsb5WOvJkQ0wDsTZT6PSpoeAbd6mmuHRpW04G5yS2w4er8h9ZlpJU6B
         yGso/trwW+xxXiiiYPFmTJyHXhIbnXdq8K2MS3qn8Ix7sBI8vPmKxV2RnlWWpBFxV4PL
         gyMkrJxSDvx00RdjSE658LNSHyB4afYMtfLvRCksHVpFCcnUsAASFDWzhls2ClSVqMA5
         WL0tEJv8ZMuaIcOfZ7lAYN4jQgipZ2VLAMJeXz/Uo8ls9hdRWTfy3jbOy2iFTx9DZMBN
         hnCxEnra2TWzREj9QAzGJWa0Koz4P1mXSP6DrtZlvnH8LL92Z4Pus1Qgy69LlGB63lPD
         5QKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a0uAEKUPj5s/C3AmfM0zbUvPo0nW2J6CY0cZs/p797o=;
        b=BfOaUFpSsxJ3+2ZYKq3QGJCtgqrAsUCH2vV0SxORH/MHQaWsnX1LYPzmyhHQl8dtl+
         t2qfq+leaVlzmu65H9RoVzTM5Ctnowhy4qo9UNx1brL3Q1LS8K9ERp0/cGH9YSkxmULS
         aR7MGkzDt4Iqty0VnG3WFCj77Zw/xf3xB7idGssdzZjlI6g3gRkPXtW18iuafzsw0US2
         RTUISsoGlbCLLAxS84BfSnaVS80dUDVtpXCIXwDtDgvYZOR6aTsH9qhzgsdsA2O1YUGl
         wQiNWCy6I+9qdPJvXv4cKA/Zm1VYKYn3FAkaplq3w1+Brw/zHYnKUinA3ZOq7Pj/YVaW
         RdEw==
X-Gm-Message-State: AOAM530Fp9QO7xPsdUvF8tYtIp4wPsAzxdBvudJH3mMrrJWdrGUBcB2M
        hFEAJymcyb2ka/dq7Z/8nPg=
X-Google-Smtp-Source: ABdhPJxcz2xWQ64axdZLz2bkSkIOFn6YX+4btHjtMB/FSiF2MoCcsfDPcfqFHv/xkXgBq+nqxjUJdA==
X-Received: by 2002:a17:902:b78a:: with SMTP id e10mr15926003pls.201.1591169710519;
        Wed, 03 Jun 2020 00:35:10 -0700 (PDT)
Received: from [192.168.1.60] (59-120-186-245.HINET-IP.hinet.net. [59.120.186.245])
        by smtp.gmail.com with ESMTPSA id 17sm1159828pfn.19.2020.06.03.00.35.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2020 00:35:09 -0700 (PDT)
Subject: Re: [PATCH 1/1] driver core: Fix unbalance probe_count in
 really_probe()
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>, peter_hong@fintek.com.tw,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Ji-Ze Hong (Peter Hong)" <hpeter+linux_kernel@gmail.com>
References: <20200603064509.32736-1-hpeter+linux_kernel@gmail.com>
 <CAMuHMdV3sNojXqaxLmVjK3ziGugd3cWEKfLXikDwvaOmocTCzQ@mail.gmail.com>
From:   "Ji-Ze Hong (Peter Hong)" <hpeter@gmail.com>
Message-ID: <65b25d4b-39ad-e5be-ecfd-39bdc7ae9458@gmail.com>
Date:   Wed, 3 Jun 2020 15:35:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdV3sNojXqaxLmVjK3ziGugd3cWEKfLXikDwvaOmocTCzQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Geert Uytterhoeven 於 2020/6/3 下午 03:13 寫道:
> Hi Ji-Ze,
> 
> If devres_head is not empty, you have a serious problem on your system,
> as those resources may be in an unknown state (e.g. freed but still in
> use).  While I had missed the probe_count imbalance when implementing
> the original change, it may actually be safer to not decrease
> probe_count, to prevent further probes from happening.  But I guess it
> doesn't matter: if you get here, your system is in a bad state anyway.

We want to fix the shutdown/reboot freeze issue and bisect to this
patch and found if the probe_count != 0, the PC will stuck with
wait_for_device_probe() with shutdown/reboot forever. So we just
change the increment after return -EBUSY.

In this case, it maybe 8250_PNP & serial 8250 platform driver resources
conflict. I'll try to dump more message to debug.

IMO, the shutdown/reboot operation should not block.


>> with serial8250 platform driver. e.g. AOPEN DE6200. The conflict boot
>> dmesg below:
>>
>>          Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
>>          00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 921600) is a 16550A
>>          00:04: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 921600) is a 16550A
>>          00:05: ttyS2 at I/O 0x3e8 (irq = 5, base_baud = 921600) is a 16550A
>>          serial8250: ttyS3 at I/O 0x2e8 (irq = 3, base_baud = 921600) is a 16550A
>>
>> Reboot/Shutdown will freeze in wait_for_device_probe(), message as
>> following:
>>          INFQ: task systemd-shutdown: 1 blocked for more than 120 seconds.
> 
> Now, how did you get to this state, i.e. which driver triggered the
> "Resources present before probing" message? Because that is the root
> issue that must be fixed, and the probe_count imbalance is IMHO just a
> red herring.
> 

Sorry for lost important dmesg:

Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
00:03: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 921600) is a 16550A
00:04: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 921600) is a 16550A
00:05: ttyS2 at I/O 0x3e8 (irq = 5, base_baud = 921600) is a 16550A
serial8250: ttyS3 at I/O 0x2e8 (irq = 3, base_baud = 921600) is a 16550A
platform serial8250: Resources present before probing
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

-- 
With Best Regards,
Peter Hong
