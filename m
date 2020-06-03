Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC8BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 17:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CC7820674
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 17:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sdX+JwtT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbgFCRTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 13:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbgFCRTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 13:19:19 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD581C08C5C0;
        Wed,  3 Jun 2020 10:19:18 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id k22so2700482qtm.6;
        Wed, 03 Jun 2020 10:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding:content-disposition;
        bh=c3PA6afDzT37PULo8XPopHFW72TeaOHGUdh70JjkqiQ=;
        b=sdX+JwtTOcSHDVPHCkMe3RL2Avi5w5XjmGvJTDmBiuSiH/lVHfjf06rb/McSeB2f1y
         6n0wM9n93BczgqRcmt4tjBHKbNOJr/w6dU91qnY8TUo2+EJTzWlauPLMwCS3Q0fnq71u
         br5f7+wBAnq6Ry84pbxwpMKmrb0AatZQijY+yvLGQ0Bjj8YUmayw9mgsBiWwLYPgqE2C
         Rzh041ULMdM5eoEQCUW0xdslGONs74PEPTLu2BZG2GScWoaOuPffn8TZqxBF9yhG/R0W
         NJYaKHhG4gTs34oPNKj8GjMJPSJNoh8iSCc7zCn71dpURbCfLY0OhYQHXvVDEQgV0S9e
         I31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding
         :content-disposition;
        bh=c3PA6afDzT37PULo8XPopHFW72TeaOHGUdh70JjkqiQ=;
        b=EcRPKYRU5XxCoC/IVVgga06Zx/gN6SC7V3CJ60DeM971HgtGhIv6fBUzSf9qtXgZyF
         AQ65+CSCnxdz3iPDVwzhT+a938N2oX+Ny6ddwMFUiE7UiFJgM3up7Z17eupXLHBjLMZ9
         reVM9uhf2kvOkV2vJpEwtbHBDRzAJ9U5vxo2nX/H07GyXBK+HZD1g2su06kyhUaYk1zZ
         k8K3M4LgWeW4Bxlg0eIkt4MOhtz6YN1fIT/V2KwgXvK3K0D6vHAygeK9beHeHo0ne0tw
         6k4/YqgucjhZFO/e+X88ynWURbEy8UYv7YcZl0AQGsnGHT7ISm00UH8NAlwVNBo9xOFV
         nEKQ==
X-Gm-Message-State: AOAM530laInOWj3rXs8BxLYF8TdWFt78gKKjwb+q8KxJadU5RHWxttGx
        5MI+ytRkfkawS6FrFLkmoDNU3WGbR2g=
X-Google-Smtp-Source: ABdhPJx/268/0e/0dxYlk5ju8LFOP+rpnP7Zq32iFPqUjNzVKdGOt7cuVBFRIvNO0CVYSpgbyp8jFA==
X-Received: by 2002:ac8:450a:: with SMTP id q10mr358265qtn.328.1591204757842;
        Wed, 03 Jun 2020 10:19:17 -0700 (PDT)
Received: from dwls-dell ([2804:14d:72b1:8920:a2ce:f815:f14d:bfac])
        by smtp.gmail.com with ESMTPSA id u205sm2019632qka.81.2020.06.03.10.19.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jun 2020 10:19:17 -0700 (PDT)
Date:   Wed, 3 Jun 2020 14:19:12 -0300
From:   "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     "=?utf-8?Q?mchehab+huawei=40kernel.org?=" <mchehab+huawei@kernel.org>,
        "=?utf-8?Q?sean=40mess.org?=" <sean@mess.org>,
        "=?utf-8?Q?kstewart=40linuxfoundation.org?=" 
        <kstewart@linuxfoundation.org>,
        "=?utf-8?Q?allison=40lohutok.net?=" <allison@lohutok.net>,
        "=?utf-8?Q?tglx=40linutronix.de?=" <tglx@linutronix.de>,
        "=?utf-8?Q?linux-media=40vger.kernel.org?=" 
        <linux-media@vger.kernel.org>,
        "=?utf-8?Q?linux-kernel-mentees=40lists.linuxfoundation.org?=" 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        "=?utf-8?Q?linux-kernel=40vger.kernel.org?=" 
        <linux-kernel@vger.kernel.org>
Message-ID: <3273ABE6-71E6-4FCE-9901-E02A87B3F48F@getmailspring.com>
In-Reply-To: <deb6b49a-5f50-1d40-6577-84fe787150ec@linuxfoundation.org>
References: <deb6b49a-5f50-1d40-6577-84fe787150ec@linuxfoundation.org>
Subject: Re: [RFC, WIP, v6 02/10] media: vidtv: implement a tuner driver
X-Mailer: Mailspring
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shuah, thanks for reviewing this!

>> From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
> 
> Are you using git send-email to send patches. Why do have this
> From line in here? Same comment on all other patches in this series.

I am using 'git format-patch --to=[...] --cc=[...]' and then 'git send-email'.

Git format-patch usually adds these two lines for every patch it generates:
  1 From f966b0ea574a36b96ddfb8a8a716b174bc150eba Mon Sep 17 00:00:00 2001
  2 From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>

I have no idea whether these are necessary, so I just leave them there :)
The first line is specially weird.


As for this:

>> +	switch (c->delivery_system) {
> 
> Add indetation for the below:
> 
>> +	case SYS_DVBT:
>> +	case SYS_DVBT2:
>> +		valid_freqs = config.vidtv_valid_dvb_t_freqs;
>> +		array_sz    = ARRAY_SIZE(config.vidtv_valid_dvb_t_freqs);
>> +		break;

I am not sure I understand. Indenting the case statements leads to a
checkpatch complaint: 

>SWITCH_CASE_INDENT_LEVEL: switch and case should be at the
>same indent

And the actual statements under 'case' are already indented.

Thanks
- Daniel
