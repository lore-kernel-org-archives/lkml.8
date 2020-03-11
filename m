Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	RDNS_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25228 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729809AbgCKQeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 12:34:11 -0400
Received: by mail-wr1-f72.google.com with SMTP id v6so1173123wrg.22
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 09:34:05 -0700 (PDT)
From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: Updating cypress/brcm firmware in linux-firmware for
 CVE-2019-15126
To: chi-hsien.lin@cypress.com,
        Christopher Rumpf <Christopher.Rumpf@cypress.com>,
        Chung-Hsien Hsu <cnhu@cypress.com>
Cc: linux-firmware@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <93dba8d2-6e46-9157-d292-4d93feb8ec1a@redhat.com>
 <c2f75e84-6c8d-f4f0-bcc6-5fb2b662de33@redhat.com>
 <3cf961a6-56c8-81fb-3bf9-fc36e2601d2c@cypress.com>
Message-ID: <0a5933fc-ae5f-07fa-2e36-8924ea5c2b27@redhat.com>
Date: Wed, 11 Mar 2020 17:34:02 +0100
MIME-Version: 1.0
In-Reply-To: <3cf961a6-56c8-81fb-3bf9-fc36e2601d2c@cypress.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 3/5/20 4:50 AM, Chi-Hsien Lin wrote:
> (+Chris)
> 
> On 03/04/2020 7:45, Hans de Goede wrote:
>> Hi,
>>
>> On 2/26/20 11:16 PM, Hans de Goede wrote:
>>> Hello Cypress people,
>>>
>>> Can we please get updated firmware for
>>> brcm/brcmfmac4356-pcie.bin and brcm/brcmfmac4356-sdio.bin
>>> fixing CVE-2019-15126 as well as for any other affected
>>> models (the 4356 is explicitly named in the CVE description) ?
>>>
>>> The current Cypress firmware files in linux-firmware are
>>> quite old, e.g. for brcm/brcmfmac4356-pcie.bin linux-firmware has:
>>> version 7.35.180.176 dated 2017-10-23, way before the CVE
>>>
>>> Where as https://community.cypress.com/docs/DOC-19000 /
>>> cypress-fmac-v4.14.77-2020_0115.zip has:
>>> version 7.35.180.197 which presumably contains a fix (no changelog)
>>
>> Ping?
>>
>> The very old age of the firmware files in linux-firmware is really
>> UNACCEPTABLE and very irresponsible from a security POV. Please
>> fix this very soon.
>>
>> If you do not reply to this email I see no choice but to switch
>> the firmwares in linux-firmware over to the ones from the SDK which
>> you do regularly update, e.g. those from:
>> https://community.cypress.com/docs/DOC-19000
>>
>> Yes those are under an older, slightly different version of the Cypress
>> license, which is less then ideal, but that license is still acceptable
>> for linux-firmware (*) and since you are not providing any updates to
>> the special builds you have been doing for linux-firmware you are
>> really leaving us no option other then switching to the SDK version
>> of the firmwares.
> 
> Hans,

<snip>

> Chris owns the Cypress firmware upstream strategy and will explain our going-forward strategy to you.

Ping? It has been a week and we have not heard anything from Chris about this yet?

Regards,

Hans

