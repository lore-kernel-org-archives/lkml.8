Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502D8C2BB86
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 14:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 291722082D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 14:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qEUxkTHB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgDJORR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 10:17:17 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36881 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgDJORR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 10:17:17 -0400
Received: by mail-pg1-f193.google.com with SMTP id r4so1041992pgg.4;
        Fri, 10 Apr 2020 07:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=S9YQFX4SpFglrYLDPLCc6f7rGd8ZglNwGTg2V85a1Fo=;
        b=qEUxkTHBLvran8qf1Qwn6S4HMffiCXwct6Clh0UCEwXlHmmKvv0SGBLtSYLRxOR3rY
         /qfQ8TlJVY7H4Laxn6v0KjoY2Ii9IPF3vE752E7CmRFrLS5KMSaixBg9s8WnJeGPny4k
         FdlpRK0OtwhATB32eSQGK1IfRaTB3qC+Jr3G9gZsNAKc7uMj7ZDFCQOYEwptOX9T843W
         Xa4HlsG5HhnKvlZjx63cZNLH9Siro5vvu5AJ8vM0PvOP7Jne6GPUYAySvtrr77Ixeozw
         rRANhXAmHdU/7bLyGxfpG2abJ/Q3+NPm5XCrqJAyCOqi4cf9uZnaXYaVwNvAnRaogQND
         iz/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=S9YQFX4SpFglrYLDPLCc6f7rGd8ZglNwGTg2V85a1Fo=;
        b=gRKCBOKKO1qPpwRoZRqF4m2e7L33AAmBX+SY3emTMJvU89vLfSivhZ3M5bDvnrcTQC
         xXFjVM8gl+j3RE19CjxIchoxSLXBCeuBElYW+6CzlW60hmVb/FucQdZa6T9GnGVnzX54
         WeakzwDUIUyb/otVNzmhQt/RSx3z+SVJCXHp6un9UxRJyckmFEBQC3FB4oxLIj3+n0ol
         ne+0jX1DnmMRmHUxGwjY5EU/NUf5b5tu9orHf5T9/57g0Yd56vCVh9xUFu/drgs6+DAn
         dbxClrC0kh9pHhVXQqvUxkJXAG4id/Zz0JrpZHPPmr7fKMcxIaa27mJt9MZNeihIRQZI
         /BDw==
X-Gm-Message-State: AGi0PuYzmm1rNPB7MbIyCgiSZRJWpK0QevuvH6lQNeIi4qvREbjlISL2
        S+gn6refSUoSQsC4/Sj7OfetHFvW9EA=
X-Google-Smtp-Source: APiQypIcV+o7TpoI/V4DV8iEfnkSgcbSa282dRJEVNqGWkONAyTxeubcBRqxixNo9rIAn+QUY602tQ==
X-Received: by 2002:a65:5606:: with SMTP id l6mr2907086pgs.446.1586528236702;
        Fri, 10 Apr 2020 07:17:16 -0700 (PDT)
Received: from i7.zsun.org ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id c12sm1969191pji.19.2020.04.10.07.17.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2020 07:17:16 -0700 (PDT)
Subject: Re: [PATCH 0/1] Bluetooth: btrtl: Add support for RTL8761B
To:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, icenowy@aosc.io
References: <20200410140010.105317-1-sztsian@gmail.com>
From:   Zamir SUN <sztsian@gmail.com>
Message-ID: <595a5b19-bb32-92c8-2575-d24fcb542df1@gmail.com>
Date:   Fri, 10 Apr 2020 22:17:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200410140010.105317-1-sztsian@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/10/20 10:00 PM, sztsian@gmail.com wrote:
> From: Zamir SUN <sztsian@gmail.com>
> 
> This patch adds support for the RTL8761B USB Bluetooth dongle.
> 
> When I got the RTL8761B dongle, I see it is actually recognised as
> RTL8761A in my system (5.5.15-200.fc31.x86_64 on Fedora). And the
> userspace cannot detect bluetooth devices in such situation.
> 
> [34689.158047] Bluetooth: hci0: RTL: examining hci_ver=0a hci_rev=000b lmp_ver=0a lmp_subver=8761
> [34689.159083] Bluetooth: hci0: RTL: rom_version status=0 version=1
> [34689.159088] Bluetooth: hci0: RTL: loading rtl_bt/rtl8761a_fw.bin
> [34689.159498] Bluetooth: hci0: RTL: loading rtl_bt/rtl8761a_config.bin
> [34689.159522] bluetooth hci0: Direct firmware load for rtl_bt/rtl8761a_config.bin failed with error -2
> [34689.159529] Bluetooth: hci0: RTL: cfg_sz -2, total sz 20204
> [34691.248484] Bluetooth: hci0: command 0xfc20 tx timeout
> 
> With great help from Icenowy Zheng she helped identifying the firmware
> from the vendor-provided Windows driver. After applying this patch along
> with the firmware I am able to use this dongle.
> 
> Note, I don't have RTL8761A device, so I would appreciate if someone
> can help test in case this patch breaks RTL8761A.
> 
> Ziqian SUN (Zamir) (1):
>    Bluetooth: btrtl: Add support for RTL8761B
> 
>   drivers/bluetooth/btrtl.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 

Oh sorry, Self-NAK.
I sent only partial of my patch.

-- 
Zamir SUN
Fedora user
GPG : 1D86 6D4A 49CE 4BBD 72CF FCF5 D856 6E11 F2A0 525E
