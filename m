Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE030C5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 13:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B18C920767
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 13:56:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hVdKcg9J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgCRN4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 09:56:36 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:41387 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726975AbgCRN4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 09:56:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584539794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UXRpaQxYrO/gvKAeP6md3e48aYoFmEEQesPUZqe43ME=;
        b=hVdKcg9J99qAuN4dTbncKLvgYuxqzR8HQEcE3XZqoaDI0HueuTYiy/Ox4Ot9kBJ9ENfwkq
        CTh66dNiAmhcUc+FKroquiZoRFCUP2f7s8cyhKnfHL5QzTyeeGtT9X1qXLgbf6qHpyl9aU
        1umNioDnJeRAQ3LtA0Fse4BwzF97zgE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-1G3apMiSOleAriC8fayIBQ-1; Wed, 18 Mar 2020 09:56:26 -0400
X-MC-Unique: 1G3apMiSOleAriC8fayIBQ-1
Received: by mail-wm1-f69.google.com with SMTP id x7so1079240wmi.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 06:56:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UXRpaQxYrO/gvKAeP6md3e48aYoFmEEQesPUZqe43ME=;
        b=gg2UIm/plq0dPzWtH0idEKQfa+tNlpvU5hHqCbRhc7bf70/IW3WXOzejFei6n0rTiz
         Lycih+bJuccoz6drQD2Md/vsYPiuHS8vjR1HL8CcVlBlzrPDKd9XA7WJFuwwUvOiuIlw
         7UjApJt9GJ15j2o6+CtLShAMMsOEAnXlRUqBOXn6a+RLRIprULtLiUwERlZYAA5OCsLk
         Y6DCfam/35nsxUrdVDeR+KwaCwUdz1XGNSf7dDcb/TJKeKN6pSPR6bJ0EHbciiBz13DL
         BIswllNDhrx8c4E/9xkfyLtoztiChMFXPOzAN8fXLO4prQBm+Uus4xIO/vIdpuXx59kr
         ahwA==
X-Gm-Message-State: ANhLgQ1HFnTklz8R3fRFZjYogO26pO9OxzV2T6G02Rk8Ju0lym+vDeew
        oB9qgvZJoIFVXtMKav0ZAqUvygxaCemghz83kLK6K+vuJPpfzJ+rv/T7VXpo2pEbuAzTN9OIPtr
        JmXqregKSVnZ8Sb+wFeFKKnux
X-Received: by 2002:a7b:c1da:: with SMTP id a26mr5439584wmj.45.1584539785327;
        Wed, 18 Mar 2020 06:56:25 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtb1764SLhxHnGxs/fPAE7qJ0588Bl0/gSd2uZQ4GBTE49dIlkXOgxGNoiqRP7YGeBsiqCsow==
X-Received: by 2002:a7b:c1da:: with SMTP id a26mr5439564wmj.45.1584539785096;
        Wed, 18 Mar 2020 06:56:25 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
        by smtp.gmail.com with ESMTPSA id w67sm3982303wmb.41.2020.03.18.06.56.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2020 06:56:24 -0700 (PDT)
Subject: Re: [PATCH v12 03/10] firmware: Rename FW_OPT_NOFALLBACK to
 FW_OPT_NOFALLBACK_SYSFS
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Peter Jones <pjones@redhat.com>,
        Dave Olsthoorn <dave@bewaar.me>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-input@vger.kernel.org
References: <20200115163554.101315-1-hdegoede@redhat.com>
 <20200115163554.101315-4-hdegoede@redhat.com>
 <20200124085751.GA2957916@kroah.com>
 <d25d5d6e-0348-b19f-539e-048cfa70d6a6@redhat.com>
 <20200318132741.GA2794545@kroah.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <8fa336bd-339f-40e0-08fe-e6b968736679@redhat.com>
Date:   Wed, 18 Mar 2020 14:56:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200318132741.GA2794545@kroah.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 3/18/20 2:27 PM, Greg Kroah-Hartman wrote:
> On Fri, Jan 24, 2020 at 10:16:48AM +0100, Hans de Goede wrote:
>> Hi,
>>
>> On 1/24/20 9:57 AM, Greg Kroah-Hartman wrote:
>>> On Wed, Jan 15, 2020 at 05:35:47PM +0100, Hans de Goede wrote:
>>>> This is a preparation patch for adding a new platform fallback mechanism,
>>>> which will have its own enable/disable FW_OPT_xxx option.
>>>>
>>>> Note this also fixes a typo in one of the re-wordwrapped comments:
>>>> enfoce -> enforce.
>>>>
>>>> Acked-by: Luis Chamberlain <mcgrof@kernel.org>
>>>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>>>
>>> I've taken this in my tree for now in a quest to try to get others to
>>> pay attention to this series...
>>
>> Thank you.
>>
>> As mentioned before I believe that this series is ready for merging now.
>>
>> Andy Lutomirski had one last change request for v12 of the second
>> patch in the series, specifically to replace the loop searching for
>> the prefix with a memem, but the kernel does not have memmem.
>>
>> Andy, are you ok with v12 as is, given that we don't have memmem ?
>>
>> Assuming Andy is ok with v12 as is, then to merge this we need
>> to probably wait for 5.6-rc1 and then have the x86/efi folks do
>> an immutable branch with the first 2 patches of the series.
> 
> Did this every happen?  Or do I need to dump this all into my tree?

Ard has done a immutable branch with just the 2 patches:

https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/tag/?h=stable-shared-branch-for-driver-tree

I did not see any mails about this being pulled / merged, but I just
checked and this has landed in the tip tree 10 days ago:

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/log/include/linux/efi.h?h=efi/core

So if you merge the stable-shared-branch-for-driver-tree tag and then
merge patches 3-8 of this series (or rather 4-8 since you already
merged 3 IIRC) that would be great.

Regards,

Hans

