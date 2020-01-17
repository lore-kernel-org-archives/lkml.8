Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2C1C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 04:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9595C21582
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 04:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="SeZnFLr1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729669AbgAQEv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 23:51:57 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:42002 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbgAQEv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 23:51:57 -0500
Received: by mail-pf1-f193.google.com with SMTP id 4so11346662pfz.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 20:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=InISBspkm5MQykXQvlAo8sKTZ869qG5tJNqMQexJDfE=;
        b=SeZnFLr11e9J3ss8CpgxQB/FABiTdtguktnz817wTD5muKgDsvSpMHASyBB6DtgJUR
         D3eKauyzQ0foumq7ch4A7b3Eh0z/j0UyokSwkVe2vkgr2aKZR170T7/LhcXfLWU54Ytm
         1w04JvL1k5wYnOmTdw/dtH2IfGUzQbdBy6xuBcf76P5eguPMCJj5CjO9UhNWLtSAF/bT
         oQLJmq8U1gyXY2KWCWVT84hCn97ssgpyABSkRdrV9tEHvm3He8z+78o6Z75hdI9TG2Fw
         Byq2t2EWc2mig2JnyJVY7mSkfafpc3BDXbSJrUUsPfHdexqU86Altk8IOjnwjgK+Pf9M
         H8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=InISBspkm5MQykXQvlAo8sKTZ869qG5tJNqMQexJDfE=;
        b=NwQkg54+WE6jRqNFFu7AQPYTutEgvwbercZIrpAaGUF8b3926ODO0ft+Tpm9FowtvH
         Ud1PeNYt3dgUiAf20ofUQQYa0o5hhnHJc77y6MTOG9r1TlPcQZn/AyRGUDg18XqhsXX+
         pEeajouYywEpvOieJzhVtt/zBFBNNZW0ttGLN+6I1Gneub27FhdFlfBsIFpzAa92N7SL
         3d1AsRUYmVIgNeEAjAYjlz7oFfwLKQCdU2iYsC/JjYnL/qmKY7OTLMiRE0VQGJaKtEg0
         K8x2xavQL+K3DD5/RyCF37RDv09wSL4N0ZiAe8qMiSxHmMO2tKlaq3CyhOKXmc6WR8e2
         KQrA==
X-Gm-Message-State: APjAAAVhS0Ne1n3DNrEOGuc0LsUS9av0aAteu54tz3Ob3KovPiqGTCRN
        4M3gfRdOXhjPnBU1q9iakESxGA==
X-Google-Smtp-Source: APXvYqy3jnFjxJoPk3kDPPclsSt6jkMc0480DqviIff0jlHDXtVzAyKbiiN8uiS9aJYVHNR9jAMouw==
X-Received: by 2002:aa7:9484:: with SMTP id z4mr1140430pfk.88.1579236716245;
        Thu, 16 Jan 2020 20:51:56 -0800 (PST)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id s18sm27326510pfh.179.2020.01.16.20.51.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jan 2020 20:51:55 -0800 (PST)
Subject: Re: [PATCH v3 0/3] ata: ahci_brcm: Follow-up changes for BCM7216
To:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     bcm-kernel-feedback-list@broadcom.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Tejun Heo <tj@kernel.org>, Jaedon Shin <jaedon.shin@gmail.com>,
        "open list:LIBATA SUBSYSTEM (Serial and Parallel ATA drivers)" 
        <linux-ide@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <20200107183022.26224-1-f.fainelli@gmail.com>
 <d32d1c1e6f32eeed811fa00e1b5d8ca121eea70f.camel@pengutronix.de>
 <33d3589b-accf-04c2-5527-5a0f9c632d0b@broadcom.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <cca98d8c-4308-9fe8-5192-863851702369@kernel.dk>
Date:   Thu, 16 Jan 2020 21:51:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <33d3589b-accf-04c2-5527-5a0f9c632d0b@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/20 9:44 PM, Florian Fainelli wrote:
> 
> 
> On 1/8/2020 1:25 AM, Philipp Zabel wrote:
>> Hi Florian,
>>
>> On Tue, 2020-01-07 at 10:30 -0800, Florian Fainelli wrote:
>>> Hi Jens, Philipp,
>>>
>>> These three patches are a follow-up to my previous series titled: ata:
>>> ahci_brcm: Fixes and new device support.
>>>
>>> After submitting the BCM7216 RESCAL reset driver, Philipp the reset
>>> controller maintained indicated that the reset line should be self
>>> de-asserting and so reset_control_reset() should be used instead.
>>>
>>> These three patches update the driver in that regard. It would be great if
>>> you could apply those and get them queued up for 5.6 since they are
>>> directly related to the previous series.
>>>
>>> Changes in v3:
>>> - introduced a preliminary patch making use of the proper reset control
>>>   API in order to manage the optional reset controller line
>>> - updated patches after introducing that preliminary patch
>>
>> The third patch could be simplified by storing the rescal reset control
>> in a separate struct member and relying on the optional reset control
>> API more. This is just a suggestion though, the series looks fine as-is.
>>
>> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> 
> Thanks! Jens is that good for you?

Can you re-send against the current branch and include the reviewed-bys
from here as well?


-- 
Jens Axboe

