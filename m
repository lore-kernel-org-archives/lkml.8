Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A9DC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 13:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4B6E20829
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 13:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MyBBjcmz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729348AbgG3N6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 09:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728427AbgG3N6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 09:58:31 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2A20C061574;
        Thu, 30 Jul 2020 06:58:30 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t6so743642pjr.0;
        Thu, 30 Jul 2020 06:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mIipcQcsNus43SZVB9mtCWFwwmFX5veapSYlA1TJ5pc=;
        b=MyBBjcmztL6rS00dWBrTgFvOcfiopMNWHODT5ev6J0SCiVYrEgMSdoU5XTTYsow7TH
         s2wlF919OZ55Uy7Tdk4r6Ld01EgdG45xyRpYY+TPOzd4UcrK01nPu+G4xhtLxNfXoKA4
         jKcD+I9DvmQsp5bRpTLujuhZTEWj970IzbfT+zdtYLCGWAX4GV2vuQel5mr0jgepYtGy
         hk0gKxOte3lgrk3FKi/K5d8U5cMWM8MdtsVvCIKCWXKrwVDmbCZvbBX/k3uMsr9Qvn2p
         JlYyrobC+UxoSlHs/+7uwyhEJvXPgI89La1yhXW+GFKp14xSn+Afj/KhCbgm/PPO27mc
         ddvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=mIipcQcsNus43SZVB9mtCWFwwmFX5veapSYlA1TJ5pc=;
        b=QBhSJtvJedhQyZW61O2dyg5eBweS9U/YpPRsNFS9nb1dl2jAUfvVk9D8AVsIQh9tYM
         CTonzcjT1NykmB3bEshSKdjNPIbMnaGkgaFVPWlGJlRXEYuKBPZiEfJYi6dtDOiGeFMH
         +a+e+PObxE7jpFSXTDvk2ID5VxyapW3P6FG4HcCrpJ06Y5V57AI6BxDVnPVsuAI3j6oA
         o/80QsXPWRlda9J+MsPabFjhjYLv0D906cE/6b/60j8TTBXrsjI5rXG0nmkgwf2kTYqR
         lTWul95rZwB9+fZXdY1S7DZnrk7Y0kDyGu6WIx334l0CpWPZSqhgYtXu9crn4JCmuogw
         zYrw==
X-Gm-Message-State: AOAM530iMlJ/VxP7OuGwCa11tPitVmqwD3XD7B6OeES934ib/0oQ8aPG
        T+DV/lowHWGkY5tXFFF5sZkGH0ns
X-Google-Smtp-Source: ABdhPJyqt8MgBXqAsAGOUGNcj45gjmo9+1JX7Jkm0/TNzTydK2auXAbpQqYjL7/UZe/ODvT006zVPQ==
X-Received: by 2002:a17:902:7005:: with SMTP id y5mr30519251plk.342.1596117510007;
        Thu, 30 Jul 2020 06:58:30 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d22sm6419696pgm.93.2020.07.30.06.58.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2020 06:58:28 -0700 (PDT)
Subject: Re: [PATCH v2] usb: typec: tcpm: Migrate workqueue to RT priority for
 processing events
To:     Badhri Jagan Sridharan <badhri@google.com>, hdegoede@redhat.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20200724020551.2737376-1-badhri@google.com>
 <20200729145309.GA3490882@kroah.com>
 <CAPTae5+JbpzC7qzznXFqLPL-KrPzHLaHsJXj29Bx-jW1zEPEAQ@mail.gmail.com>
 <f7fe51da-5dd7-5065-b5c7-426bf8e07c29@roeck-us.net>
 <CAPTae5JMaxa5ZVZG=DKshYVoeedon1KvH2coygCa4dRS8qKAxg@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <c5b3fc7f-fec1-6fa2-d0d8-d2777f4f7e88@roeck-us.net>
Date:   Thu, 30 Jul 2020 06:58:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAPTae5JMaxa5ZVZG=DKshYVoeedon1KvH2coygCa4dRS8qKAxg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/20 8:37 PM, Badhri Jagan Sridharan wrote:
> Hi Guenter,
> 
> I see that Hans is saying that he has submitted some patch here.
> https://lore.kernel.org/lkml/65f27abc-69c8-3877-be5b-e5e478153af9@redhat.com/
> But, haven't found the actual patches yet !
> 

https://patchwork.kernel.org/project/linux-usb/list/?series=318719

Guenter

> Thanks,
> Badhri
> 
> On Wed, Jul 29, 2020 at 8:03 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> On 7/29/20 7:28 PM, Badhri Jagan Sridharan wrote:
>>> Hi Greg,
>>>
>>> Sure just sent the new patch v3.
>>>
>>> Patch applies cleanly on my end. So wondering what I am missing.
>>
>> I expected your patch to conflict with Hans' patch series.
>> Maybe those are in a different tree/branch ?
>>
>> Guenter
>>
>>> Just in case if you are still noticing merge conflicts.
>>>
>>> Here is the git log of my local tree:
>>> 633198cd2945b7 (HEAD -> usb-next-1) usb: typec: tcpm: Migrate workqueue to RT priority for processing events
>>> fa56dd9152ef95 (origin/usb-next) Merge tag 'usb-serial-5.9-rc1' of https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-next
>>> 25252919a1050e xhci: dbgtty: Make some functions static
>>> b0e02550346e67 xhci: dbc: Make function xhci_dbc_ring_alloc() static
>>> ca6377900974c3 Revert "usb: dwc2: override PHY input signals with usb role switch support"
>>> 09df709cb5aeb2 Revert "usb: dwc2: don't use ID/Vbus detection if usb-role-switch on STM32MP15 SoCs"
>>> 17a82716587e9d USB: iowarrior: fix up report size handling for some devices
>>> e98ba8cc3f8a89 Merge tag 'usb-for-v5.9' of git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb <http://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb> into usb-next
>>> c97793089b11f7 Merge 5.8-rc7 into usb-next
>>> 92ed301919932f (tag: v5.8-rc7, origin/usb-linus, origin/main) Linux 5.8-rc7
>>>
>>> Was comparing against https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/log/?h=usb-next
>>>
>>> Thanks,
>>> Badhri
>>>
>>> On Wed, Jul 29, 2020 at 7:53 AM Greg Kroah-Hartman <gregkh@linuxfoundation.org <mailto:gregkh@linuxfoundation.org>> wrote:
>>>
>>>     On Thu, Jul 23, 2020 at 07:05:51PM -0700, Badhri Jagan Sridharan wrote:
>>>     > "tReceiverResponse 15 ms Section 6.6.2
>>>     > The receiver of a Message requiring a response Shall respond
>>>     > within tReceiverResponse in order to ensure that the
>>>     > sender’s SenderResponseTimer does not expire."
>>>     >
>>>     > When the cpu complex is busy running other lower priority
>>>     > work items, TCPM's work queue sometimes does not get scheduled
>>>     > on time to meet the above requirement from the spec.
>>>     > Moving to kthread_work apis to run with real time priority.
>>>     > Just lower than the default threaded irq priority,
>>>     > MAX_USER_RT_PRIO/2 + 1. (Higher number implies lower priority).
>>>     >
>>>     > Further, as observed in 1ff688209e2e, moving to hrtimers to
>>>     > overcome scheduling latency while scheduling the delayed work.
>>>     >
>>>     > TCPM has three work streams:
>>>     > 1. tcpm_state_machine
>>>     > 2. vdm_state_machine
>>>     > 3. event_work
>>>     >
>>>     > tcpm_state_machine and vdm_state_machine both schedule work in
>>>     > future i.e. delayed. Hence each of them have a corresponding
>>>     > hrtimer, tcpm_state_machine_timer & vdm_state_machine_timer.
>>>     >
>>>     > When work is queued right away kthread_queue_work is used.
>>>     > Else, the relevant timer is programmed and made to queue
>>>     > the kthread_work upon timer expiry.
>>>     >
>>>     > kthread_create_worker only creates one kthread worker thread,
>>>     > hence single threadedness of workqueue is retained.
>>>     >
>>>     > Signed-off-by: Badhri Jagan Sridharan <badhri@google.com <mailto:badhri@google.com>>
>>>
>>>     This doesn't apply against my usb-next branch at all.
>>>
>>>     Can you rebase and resend?
>>>
>>>     Remember to collect the reviewed-by tags as well when you do so.
>>>
>>>     thanks,
>>>
>>>     greg k-h
>>>
>>

