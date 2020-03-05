Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B6C9C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 14:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B2D820637
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 14:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ckuzOiV4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgCEOA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 09:00:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52075 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725946AbgCEOAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 09:00:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583416824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=REYAw8IXLNs9Tf/q5p/SCoSNcXTUik9NnIPit8ULeAI=;
        b=ckuzOiV4gYobC83DCZdKi0ycdgzo0cNLZPSmgkdj7XC0ary/vxfZ9y2CqgYUP1ATdDhlVo
        KjZno8CGjsN1Lg3pjr6XhjS050tXdDszOnS0kTeIbCKlqVclavHfr7m7ROFaI3fHIpAsIN
        LhmxoTAD9WRQUpChUM8b6sjbjUjCkKI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-hvSTJJlZOh-zYB2Db2leLA-1; Thu, 05 Mar 2020 09:00:22 -0500
X-MC-Unique: hvSTJJlZOh-zYB2Db2leLA-1
Received: by mail-wr1-f69.google.com with SMTP id 72so2346008wrc.6
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 06:00:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=REYAw8IXLNs9Tf/q5p/SCoSNcXTUik9NnIPit8ULeAI=;
        b=tQLImr/k8cGplswHQHt8l4jx1kKMP/ubYSRzOcocIxTm3krR9q4VESAD6LYk18qPxT
         yJKDsvj7k8eZezvBSPSvZqdfah1VRHUFAdrStVMvaD9+U1zhGX3t9tRPUSwMt6pI5lwc
         xkc7XWVXVVmlJtN4g9Pk0z958XrXxgy5QBwMmxjbD5QI51jyN9YOLOh01P/rptr53bA7
         nGtmzjYAeJDQ/9P6VvhFxaHbGcWG/QfktmdQnRz7WXBM1m/TkKMH2u2seWVck7JcGVlK
         zw9+SQBPRBMbvrMv2oJdtqvxyszBEkhRHPWrt7FM5GYHHaoKECIbzdLJX6oIuxv4SI9L
         F3CQ==
X-Gm-Message-State: ANhLgQ0ZmkPPzo91u2pFQ5eHgGl7j4KLL7ttB6U6743wOTs1vZhWq+Jf
        TVH+6b/hy5cmMC8gN7+7M0Ew6O1Mb+EO01I1u6Q739jpeWnqH+MV4wtceBvlvG2aNgd1gCTc7Wu
        1awnsgnBrSMSRx0SZzQeTnYHr
X-Received: by 2002:a05:6000:104f:: with SMTP id c15mr9964895wrx.376.1583416820832;
        Thu, 05 Mar 2020 06:00:20 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtpgbLzB8p/rJAQcpMUSyR7T+t+wKqbw1eij43GDthY7l3e1Uv5a9zNtcXrmhPB10Lozrx0fw==
X-Received: by 2002:a05:6000:104f:: with SMTP id c15mr9964863wrx.376.1583416820573;
        Thu, 05 Mar 2020 06:00:20 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
        by smtp.gmail.com with ESMTPSA id w19sm8707521wmc.22.2020.03.05.06.00.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Mar 2020 06:00:19 -0800 (PST)
Subject: Re: Updating cypress/brcm firmware in linux-firmware for
 CVE-2019-15126
To:     David Woodhouse <dwmw2@infradead.org>, chi-hsien.lin@cypress.com,
        Christopher Rumpf <Christopher.Rumpf@cypress.com>,
        Chung-Hsien Hsu <cnhu@cypress.com>
List-Id: <linux-firmware.lore.kernel.org>
Cc:     linux-firmware@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <93dba8d2-6e46-9157-d292-4d93feb8ec1a@redhat.com>
 <c2f75e84-6c8d-f4f0-bcc6-5fb2b662de33@redhat.com>
 <3cf961a6-56c8-81fb-3bf9-fc36e2601d2c@cypress.com>
 <17ec344e-80c5-02a9-59a3-35789a2eaaf9@redhat.com>
 <40403657934d090d4668916a02878f476b34c9fd.camel@infradead.org>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <e6c7ec6c-8619-1511-8626-70ebdea3cec5@redhat.com>
Date:   Thu, 5 Mar 2020 15:00:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <40403657934d090d4668916a02878f476b34c9fd.camel@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/5/20 10:16 AM, David Woodhouse wrote:
> On Thu, 2020-03-05 at 07:24 +0100, Hans de Goede wrote:
>>> also clm_blob download is not supported in kernels prior to 4.15 so
>>> those files won't work with older kernels.
>>
>> That is a valid concern, I'm not sure what the rules for linux-firmware
>> are with regards to this.
> 
> Not quite sure I understand the problem.
> 
> The rules for Linux firmware are just the same as basic engineering
> practice for loadable libraries.
> 
> If you change the ABI, you change the "soname" of a library, which
> equates to changing the filename of a linux-firmware object.
> 
> So if you make a new file format for the firmware which requires new
> driver support, then you give it a new name. The updated driver can
> attempt to load the old firmware filename as a fallback, if it still
> supports that, or you just have a clean separation between the two.
> 
> The linux-firmware repository then carries *both* files, supporting
> both old and new kernels in parallel.

That is true, adding support to the brcm drivers for that should
be easy enough and backporting that to older still supported drivers
(which already support the separate regulatory db the new firmware
uses) should also be easy enough.

So that removes one concern, leaving just the regulatory concerns.

To be honest I do not completely understand the regulatory concerns
about using the drivers from the SDK.

Chi-hsien, you say that the clm_blob files from the Cypress SDK are
only valid for the Cypress reference designs, but AFAIK the clm_blob
only contains per country regulatory info, so which channels can
be used, how much mW/dB signal strength is allowed in those channels,
etc.  Which I would expect to not change on a per design basis.
Parameters which can change on a per design basis like antenna gain,
are stored in the nvram and not part of the clm_blob (AFAIK).

So I still do not understand why using the clm_blob files files from
the SDK would be a problem? Can you explain this in more detail?

Even if the clm_blob as distributed in the SDK is a problem, then
I believe there should be a way to make a generic clm_blob which
is not tied to the reference designs. The current brcm firmware
files in linux-firmware have such a generic clm_blob builtin,
if one can be builtin, then it should be possible to also create
a generic clm_blob for the newer style firmware where the clm_blob
is a separate binary ?

Note that going this route (combined with different names for the
new style firmware so that we can keep the old files for old kernels)
will mean less work for Cypress. I believe that the current problem
is that Cypress needs to do firmware builds for each chipset twice,
once for the new-style format used inside Cypress' SDK and once for
the old-style format used in linux-firmware. And it seems that there
are not enough resources to do the old-style builds causing the firmware
versions in linux-firmware to lag behind by multiple years!

Regards,

Hans



p.s.

Also note that the Linux 802.11 stack already takes care of only
selecting channels which are allowed in the country where the wifi
card is (as advertised by the access-point). AFAIK by some other
vendors this alone is enough for regulatory concerns and there is
no firmware level country settting.




