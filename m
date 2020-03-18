Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72AA0C4332D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 22:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34F0120752
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 22:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ha7+5huB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbgCRWHD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 18:07:03 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:50876 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726704AbgCRWHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 18:07:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584569220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=14t4HjIQMqA+ULzOv7X6FcxbMiKkPDMaZzG1d8eZBno=;
        b=Ha7+5huB0PpV++aeB71d1WWTDLJnHuPpwscLC5/YvropvClrEYF6P3cyW0yxwIfEVMgqBd
        hFd6Qe/NvlyEkOW8Mbsdev0sDMO2dGSLThK4Wxtc38VVuwqEvFXyXwDfKPf4xMxDicys70
        rMDaX8OrCmr19ZhV9FOX43ACr6gGdRg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-NyPZxzzdO3CDcetCpgyJxw-1; Wed, 18 Mar 2020 18:06:32 -0400
X-MC-Unique: NyPZxzzdO3CDcetCpgyJxw-1
Received: by mail-wr1-f70.google.com with SMTP id w11so13036615wrp.20
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 15:06:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=14t4HjIQMqA+ULzOv7X6FcxbMiKkPDMaZzG1d8eZBno=;
        b=c86bduqYx8FJjd1MhClobkenssrDSr2Sg+QXQuayjIfoNN1GJGVwbldIRxbA+FkIQ1
         jOfIFQ7ao9g3CmII3cWVyDhKhwKbyakHU1NoSG7ZAoMmw9q/yA8mXtsHnch3/6umQJo+
         bDhRpHesGGLXbqbfJtZXvFuTLqqoimyCDuJPqQs5jOPWYNIXJ05SDEz1NWKUw98PVOV+
         GFz7Pc6lswM5ntlI715YtWzK2TSJs31JYxsDR9Yd7lFDUY0vxTyk7zu9++76pILk66Lb
         VYra79cMnF/mJLzFe/hL5WioQrDXBfK5i0nGBA2y7S+pgqKi++UDqJ/F8xI0xyFnmgXk
         fAvg==
X-Gm-Message-State: ANhLgQ2FtJ/pH2LR9blLxgg8izcUglfOuTzzOAk/Zbo0rU+SxeZNg7yF
        k1O8cOsVxD2eCfPMxegV1CxEP0pTVnvfIi5MVsFliu1Fn27lSrlhHrX+Li8e7Gg70JBtqo8LqaW
        jEpqNLwA+O5408k38V6yuHUQi
X-Received: by 2002:a05:6000:10c6:: with SMTP id b6mr65441wrx.130.1584569191393;
        Wed, 18 Mar 2020 15:06:31 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vshXi2bFCTY0GiaK4KHLwbxxmTP/J7PmFuoSbyu55J8ItmB/ndud1KHLF+/1Ov96kHePRHVEA==
X-Received: by 2002:a05:6000:10c6:: with SMTP id b6mr65417wrx.130.1584569191098;
        Wed, 18 Mar 2020 15:06:31 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
        by smtp.gmail.com with ESMTPSA id t126sm200794wmb.27.2020.03.18.15.06.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Mar 2020 15:06:30 -0700 (PDT)
Subject: Re: Updating cypress/brcm firmware in linux-firmware for
 CVE-2019-15126
From:   Hans de Goede <hdegoede@redhat.com>
To:     Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Chirjeev Singh <Chirjeev.Singh@cypress.com>,
        Chung-Hsien Hsu <cnhu@cypress.com>,
        Christopher Rumpf <Christopher.Rumpf@cypress.com>
List-Id: <linux-firmware.lore.kernel.org>
Cc:     linux-firmware@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <93dba8d2-6e46-9157-d292-4d93feb8ec1a@redhat.com>
Message-ID: <f7f5076f-d799-7c5c-90e9-3ad781ef96a9@redhat.com>
Date:   Wed, 18 Mar 2020 23:06:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <93dba8d2-6e46-9157-d292-4d93feb8ec1a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

On 2/26/20 11:16 PM, Hans de Goede wrote:
> Hello Cypress people,
> 
> Can we please get updated firmware for
> brcm/brcmfmac4356-pcie.bin and brcm/brcmfmac4356-sdio.bin
> fixing CVE-2019-15126 as well as for any other affected
> models (the 4356 is explicitly named in the CVE description) ?
> 
> The current Cypress firmware files in linux-firmware are
> quite old, e.g. for brcm/brcmfmac4356-pcie.bin linux-firmware has:
> version 7.35.180.176 dated 2017-10-23, way before the CVE
> 
> Where as https://community.cypress.com/docs/DOC-19000 /
> cypress-fmac-v4.14.77-2020_0115.zip has:
> version 7.35.180.197 which presumably contains a fix (no changelog)

Chris from Cypress has replied privately to me because of some
email issues, with the request to relay the information he
wrote here:

On 3/18/20 6:54 PM, Christopher Rumpf wrote:

 >  Cypress' CLM upstream policy is currently fragmented, as you have indicated.
 > The 43340 and 43362 have embedded CLM upstreamed yet no other Cypress parts
 > have done so and only deliver the firmware.bin files.  Cypress' customers
 > have been OK to follow this technote
 > https://www.cypress.com/documentation/application-notes/an225347-cypress-wi-fi-clm-regulatory-manual
 > which requires users to contact Cypress support to obtain the best performing
 > Country Locale Matrix (CLM) for the Wi-Fi module and targeted regions.
 > Such a model is of course not ideal for the open source community or for
 > what we  call “the broad market” as it requires an extra human to human
 > interaction that at the end of the day may reduce the user's time to
 > market and ability to independently move forward.
 >
 >  As I am sure you are aware, Cypress’ Embedded CLM = Wi-Fi Firmware +
 > regional regulatory database + RF settings (NVRAM).  The Wi-Fi Firmware is
 > static across all projects however the regional regulatory database and the
 > RF settings are implementation specific.  Previously the hesitation to
 > release a "worldwide generic embedded CLM” was because the regional
 > regulatory and RF settings are not tuned correctly for the implementation's
 > characteristics and the project may experience sub-par connectivity
 > performance or even perceived defects (such as power, RF, robustness).
 >
 > In the long term Cypress will be investing in additional tooling to automate
 > these steps, perhaps even as part of the project's config or build step.
 >
 > In the short term Cypress is considering these two actions:
 >
 > 1. For all active upstreamed Cypress parts, Cypress will upstream a
 >    "worldwide generic embedded CLM”.  These Embedded CLMs won’t be tuned for
 >    specific project’s regional or RF settings and customers may still need
 >    to reach out to Cypress support but at least they will be able to use the
 >    Cypress firmware in the linux-firmware repo right out of the box.

Note Chris later send me some clarification on this point:

On 3/18/20 10:29 PM, Christopher Rumpf wrote:
 > One clarification here! Regarding the short term solution -
 > the delivery may not be “embedded clm”.  It may be three different artifacts
 > which are meant to service the broad market. The Cypress R&D team will decide
 > the specifics of how to address the technical implementation to deliver the
 > worldwide clm.

The below is a continuation of Chris' original email:

 >  2. Cypress will add some more documentation in our READMEs and other
 >     supporting docs that discusses the risks which
 >     "worldwide generic embedded CLM” brings.  Customers can then make
 >     their own decision to engage with Cypress support which will depend
 >     on the characteristics of their project, I would imagine.
 >
 > Cypress would be able to implement these actions for the next release train
 > which will be posted somewhere around end of June (pending any impact due
 > to the coronavirus).
 >
 > Would these short and long term solutions meet the needs of the
 > linux-firmware community?  If no, may we collaborate more?

Chris, if I understand you correctly then the plan would result in the Cypress
maintained firmwares in linux-firmware being in sync (being the same versions
but with a more generic CLM) with the firmwares Cypress releases as part of
their SDK; and the first time we would see this in sync. release of Cypress
maintained firmwares would be around June. Correct?

This sounds very good to me.

I do have one question though, you describe the firmware as consisting of
3 parts: The actual firmware, the Country Locale Matrix and the NVRAM.

Currently linux-firmware contains firmwares with a generic CLM embedded
in them. But AFAIK the nvram-s are device-model/project specific (more so
then the CLM-s I believe) and normally the nvram is actual part of the
device and read by the kernel driver?  The one exception to this is the
nvram files for some SDIO boards. Recent kernels have code to load
the nvram files for these SDIO boards using a device-model specific
name and the linux-firmware repository contains community contributed
NVRAM files for various device-models. Would this change with the
new firmware versions ?

Regards,

Hans

