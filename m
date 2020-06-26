Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12B1C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70D54207D8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSFQ34nw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729998AbgFZPqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 11:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgFZPqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 11:46:30 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A30C03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 08:46:30 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id p11so4794342pff.11
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 08:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1IrllD1Yz/wPxz1nZ23+yFu+R38wg3L+EigjyaU5xz4=;
        b=XSFQ34nwujYmf/KUjaLr597FPxGyhey/MgnRsuIrByEUb/X2lHvFSM5GFrdufUfLYF
         DX7NYvHDSajIIQJtx53s2NSwcI8PyD9oZQIExmVv/uLF2CMrDWFZdrH3W+UeF5zfm9iI
         1GJ8kYRAQaMTSg9zweAgswfElVyhRsEGpx/HlDdK7erBwIUELGE28aCe+O6u4IRWR38c
         /FZCcU/olrZpH8ljfIlvm7TJGZPjAR4xwAwtjrAiej+rZFOVry//7RkTSzQMDbKNKgGW
         WX8hkZP3BtqNaa70pDt3q8JPSAuudTKoL0XsxVVTb+a2xzQttiCznBghcLf9RukWG2Ky
         GRnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1IrllD1Yz/wPxz1nZ23+yFu+R38wg3L+EigjyaU5xz4=;
        b=IyrY+J+o0WLjcmiSFq9s8MKA3wUi/jAfCxrtl/KmviHqH0E/oWcytB5NrIzlj7v5Uv
         r2Qcm3Kp5fSgNUMacbl6X03NCWEfTJZRoWEBKZaksG/IyqG5cWD88qxG/JSgbpJ/lgYT
         kkdT9eERFq5So8m4HHg6wo3gLLdknojrQ8HtTV6zgoDdONJMgkgyO4cxXf2lf4fbh6No
         iYuZHs2z4E0tD3NPVZqj2YxibkhKSSz2l+QrDaewcwvhFOQK9cEdCznjCevDoqTf65tP
         EB1XCZDES2KQCH66y63jVlJesE44YA7FFuot/eOTb7ewv6FnZXxpOh+tioQbFfN4QCvD
         kklg==
X-Gm-Message-State: AOAM533v0IBiDIBL4FFhrQVPDaqPCue6IWsfcoEuCcwy3GThsBeF9dmJ
        PP8rbpf89IxTZAqAUJydX5o=
X-Google-Smtp-Source: ABdhPJwpN2m97El/kIk1qjDGy0H43y2om8NGwQpPK74u4GDdMQoavbTSURSFfgl8kDAkc2nPR6GX9A==
X-Received: by 2002:a62:1481:: with SMTP id 123mr3331156pfu.92.1593186390277;
        Fri, 26 Jun 2020 08:46:30 -0700 (PDT)
Received: from [192.168.1.3] (ip68-111-84-250.oc.oc.cox.net. [68.111.84.250])
        by smtp.gmail.com with ESMTPSA id u8sm25919953pfh.215.2020.06.26.08.46.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2020 08:46:29 -0700 (PDT)
Subject: Re: [fedora-arm] Banana Pi-R1 - kernel 5.6.0 and later broken - b43
 DSA
To:     Peter Robinson <pbrobinson@gmail.com>
Cc:     Gerhard Wiesinger <lists@wiesinger.com>,
        arm@lists.fedoraproject.org, Chen-Yu Tsai <wens@csie.org>,
        LKML <linux-kernel@vger.kernel.org>, filbar@centrum.cz
References: <912a58ac-6f81-ba22-c79e-f2bf902dae2e@wiesinger.com>
 <CALeDE9N0gbYRKbmoPYF73VNr=Q9UetP+fpYFbhWfVsUZL+GkWA@mail.gmail.com>
 <8e2040e2-9faa-cd95-c474-eb2fa2c7c6c0@gmail.com>
 <CALeDE9OwtiG2cBxeyoDdJ6g9EXZBi6MbS+MNUh-JiVod3o-3xw@mail.gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <fa6bfa1f-10b6-e50f-2685-350e6aecc737@gmail.com>
Date:   Fri, 26 Jun 2020 08:46:28 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CALeDE9OwtiG2cBxeyoDdJ6g9EXZBi6MbS+MNUh-JiVod3o-3xw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/26/2020 2:09 AM, Peter Robinson wrote:
> On Fri, Jun 26, 2020 at 5:42 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
>>
>>
>>
>> On 6/25/2020 4:23 PM, Peter Robinson wrote:
>>>> I'm having troubles with the Banana Pi-R1 router with newer kernels. No
>>>> config changes, config works well since a lot of lernel updates ...
>>>> Banana Pi-R1 is configured via systemd-networkd and uses the DSA
>>>> (Distributed Switch Architecture) with b53 switch. No visible difference
>>>> in interfaces, vlan config, bridge config, etc. Looks like actual
>>>> configuration in the switch in the hardware is broken.
>>>>
>>>> # OK: Last good known version (booting that version is also ok)
>>>> Linux bpi 5.5.18-200.fc31.armv7hl #1 SMP Fri Apr 17 17:25:00 UTC 2020
>>>> armv7l armv7l armv7l GNU/Linux
>>>>
>>>> # NOK: no network
>>>> Linux bpi 5.6.8-200.fc31.armv7hl #1 SMP Wed Apr 29 19:05:06 UTC 2020
>>>> armv7l armv7l armv7l GNU/Linux
>>>>
>>>> # NOK: no network
>>>> Linux bpi 5.6.0-300.fc32.armv7hl #1 SMP Mon Mar 30 16:37:50 UTC 2020
>>>> armv7l armv7l armv7l GNU/Linux
>>>>
>>>> # NOK: no network
>>>> Linux bpi 5.6.19-200.fc31.armv7hl #1 SMP Wed Jun 17 17:10:22 UTC 2020
>>>> armv7l armv7l armv7l GNU/Linux
>>>>
>>>> # NOK: no network
>>>> Linux bpi 5.7.4-200.fc32.armv7hl #1 SMP Fri Jun 19 00:52:22 UTC 2020
>>>> armv7l armv7l armv7l GNU/Linux
>>>>
>>>>
>>>> Saw that there were a lot of changes in the near past in the b53 driver:
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/drivers/net/dsa/b53?h=v5.8-rc1+
>>>
>>> So from your notes above it looks like something regressed between the
>>> 5.5.x series and the 5.6.0 release? If so I'm not sure what the
>>> context of the changed in 5.8 are here. If there's more changes to the
>>> driver in 5.8 dev cycle have you tried one of the Fedora rawhide 5.8
>>> rc1 or rc2 kernel builds to see if that resolves it?
>>
>> See my response to Gerhard, there are changes expected to how the
>> network configuration should be done after:
> 
> It appears your response was off list, and he had follow up questions
> and I don't see a response from you.

Off which list? My response copied all the To and CC list from the
original email:

https://lore.kernel.org/lkml/002b144c-3e71-4418-3a6b-ee17c2ce6b38@gmail.com/raw

(except Maxime's old email which now bounces).

and I have not seen a response for that email.
-- 
Florian
