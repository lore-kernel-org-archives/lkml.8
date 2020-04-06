Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C6CFC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 13:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5459C22D6E
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 13:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbgDFNS1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 09:18:27 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33491 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728469AbgDFNS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 09:18:27 -0400
Received: from mail-pl1-f200.google.com ([209.85.214.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jLRdx-0000wM-Cn
        for linux-kernel@vger.kernel.org; Mon, 06 Apr 2020 13:18:25 +0000
Received: by mail-pl1-f200.google.com with SMTP id r4so9941764plo.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 06:18:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yfh8auMdoRigiRys04NLUbX84A9moSV9U1pPae/atro=;
        b=uBN1XJBHO0FhFwipXKbgUEzC81ipRKrQwUb9jGKEKhTmgQUsk0o29s3fC6oD6RTWMT
         OU0loTKq9u7hCQtC2st+WxEs1Cm6JqlR7vNdeGoNcqO/sOSJpdWBggy1e5MYA90kwIRn
         kNaYKqwJmK0WVMuPXanQZ7Cp23vewjCrXaoC2AtzGtRfk8MsBxFBSwyFWwEbkmFj5MG0
         jO56wPDo7gl5f+0zgd8Fkm+rhcNfwreNFzaXV47HmvjegRcrivAxGNktHADS5bvcGLMt
         P1FjSuPvQsNmVrKFx4w5IibMtVgCrsS7+ulufuyGGPHm3PhAYPK7M2mNFvspdimrtLWz
         8aog==
X-Gm-Message-State: AGi0Puarby1UU34D7ZKO+f/5V48QqvTzxRM11UXQ6EzrWfPXqPM50teB
        k+wn1uSrgd1kqT+RyIkbBaPiJZqkddHtxo8Djd3LdhNPIRoV7fFmtWA6EUDudH8tuznWsqtgz1Y
        J2msF+ktSWaTdWmuqiEM/D6FmctOtNRgIdS7XBkO7wA==
X-Received: by 2002:a63:e558:: with SMTP id z24mr20646319pgj.368.1586179103757;
        Mon, 06 Apr 2020 06:18:23 -0700 (PDT)
X-Google-Smtp-Source: APiQypIRNNfP69Byee6DnP3oE8819ZQmmW1WafsLeF6MlX6NhlFtF3wCeXFKCIqmcsiELvOx6719nA==
X-Received: by 2002:a63:e558:: with SMTP id z24mr20646297pgj.368.1586179103368;
        Mon, 06 Apr 2020 06:18:23 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id 135sm11948080pfu.207.2020.04.06.06.18.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2020 06:18:22 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] rtw88: Add delay on polling h2c command status bit
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <87v9mczu4h.fsf@kamboji.qca.qualcomm.com>
Date:   Mon, 6 Apr 2020 21:18:20 +0800
Cc:     Tony Chuang <yhchuang@realtek.com>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:REALTEK WIRELESS DRIVER (rtw88)" 
        <linux-wireless@vger.kernel.org>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <94EAAF7E-66C5-40E2-B6A9-0787CB13A3A9@canonical.com>
References: <20200406093623.3980-1-kai.heng.feng@canonical.com>
 <87v9mczu4h.fsf@kamboji.qca.qualcomm.com>
To:     Kalle Valo <kvalo@codeaurora.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 6, 2020, at 20:17, Kalle Valo <kvalo@codeaurora.org> wrote:
> 
> Kai-Heng Feng <kai.heng.feng@canonical.com> writes:
> 
>> On some systems we can constanly see rtw88 complains:
>> [39584.721375] rtw_pci 0000:03:00.0: failed to send h2c command
>> 
>> Increase interval of each check to wait the status bit really changes.
>> 
>> While at it, add some helpers so we can use standarized
>> readx_poll_timeout() macro.
> 
> One logical change per patch, please.

Will split it into two separate patches.

> 
>> --- a/drivers/net/wireless/realtek/rtw88/hci.h
>> +++ b/drivers/net/wireless/realtek/rtw88/hci.h
>> @@ -253,6 +253,10 @@ rtw_write8_mask(struct rtw_dev *rtwdev, u32 addr, u32 mask, u8 data)
>> 	rtw_write8(rtwdev, addr, set);
>> }
>> 
>> +#define rr8(addr)      rtw_read8(rtwdev, addr)
>> +#define rr16(addr)     rtw_read16(rtwdev, addr)
>> +#define rr32(addr)     rtw_read32(rtwdev, addr)
> 
> For me these macros reduce code readability, not improve anything. They
> hide the use of rtwdev variable, which is evil, and a name like rr8() is
> just way too vague. Please keep the original function names as is.

The inspiration is from another driver.
readx_poll_timeout macro only takes one argument for the op.
Some other drivers have their own poll_timeout implementation,
and I guess it makes sense to make one specific for rtw88.

Kai-Heng

> 
> -- 
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

