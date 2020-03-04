Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1FDAC3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 09:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B35CA20732
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 09:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NRwhYCNq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729036AbgCDJ3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 04:29:54 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:51252 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727734AbgCDJ3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 04:29:54 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0249TjrZ089014;
        Wed, 4 Mar 2020 03:29:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583314185;
        bh=e4PeKRutmxnsEKHu3OypTkMAaV/T5qt4QEtP5s9vREY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=NRwhYCNqFvnyVPvKcBbdSJ4y9Do84BhAPnsMR6jbwPeQnDU8yGH+b/oun+IpeBj2X
         5eL2geZEQ9ZtIHFY4ok0Zs/4qX7iXRYK3zGVTSUUQlIl8yPA3xjnxLxD17yC6KyD57
         5jvdRlix0BTsyJIb1f2rM4fJeTlS0YaEIHlLPMcE=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0249Tjn1002490;
        Wed, 4 Mar 2020 03:29:45 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 4 Mar
 2020 03:29:44 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 4 Mar 2020 03:29:44 -0600
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0249TfK1079733;
        Wed, 4 Mar 2020 03:29:42 -0600
Subject: Re: [PATCH v1] usb:gadget: Fix issue with config_ep_by_speed
 function.
To:     Pawel Laszczak <pawell@cadence.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Jayshri Dajiram Pawar <jpawar@cadence.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "balbi@kernel.org" <balbi@kernel.org>
CC:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jbergsagel@ti.com" <jbergsagel@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>, "nm@ti.com" <nm@ti.com>,
        "peter.chen@nxp.com" <peter.chen@nxp.com>,
        Rahul Kumar <kurahul@cadence.com>,
        Sanket Parmar <sparmar@cadence.com>
References: <1581502748-22464-1-git-send-email-jpawar@cadence.com>
 <c722e1c3-7aee-11a6-295f-fb183c611300@synopsys.com>
 <BYAPR07MB47098648C28E5E4BB9B78DCADD150@BYAPR07MB4709.namprd07.prod.outlook.com>
 <7ef4b9c5-8694-4d8e-2866-95ec11546bec@synopsys.com>
 <BYAPR07MB47093444129A8EEB734F4F2EDD150@BYAPR07MB4709.namprd07.prod.outlook.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <d00da996-1254-87c4-8c58-3ca76561f398@ti.com>
Date:   Wed, 4 Mar 2020 11:29:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <BYAPR07MB47093444129A8EEB734F4F2EDD150@BYAPR07MB4709.namprd07.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pawel,

On 14/02/2020 21:55, Pawel Laszczak wrote:
>>
>> Pawel Laszczak wrote:
>>> Hi,
>>>
>>>> Hi,
>>>>
>>>> Jayshri Pawar wrote:
>>>>> This patch adds additional parameter alt to config_ep_by_speed function.
>>>>> This additional parameter allows to improve this function and
>>>>> find proper usb_ss_ep_comp_descriptor.
>>>>>
>>>>> Problem has appeared during testing f_tcm (BOT/UAS) driver function.
>>>>>
>>>>> f_tcm function for SS use array of headers for both  BOT/UAS alternate
>>>>> setting:
>>>>>
>>>>> static struct usb_descriptor_header *uasp_ss_function_desc[] = {
>>>>>            (struct usb_descriptor_header *) &bot_intf_desc,
>>>>>            (struct usb_descriptor_header *) &bot_uasp_ss_bi_desc,
>>>>>            (struct usb_descriptor_header *) &bot_bi_ep_comp_desc,
>>>>>            (struct usb_descriptor_header *) &bot_uasp_ss_bo_desc,
>>>>>            (struct usb_descriptor_header *) &bot_bo_ep_comp_desc,
>>>>>
>>>>>            (struct usb_descriptor_header *) &uasp_intf_desc,
>>>>>            (struct usb_descriptor_header *) &bot_uasp_ss_bi_desc,
>>>>>            (struct usb_descriptor_header *) &uasp_bi_ep_comp_desc,
>>>>>            (struct usb_descriptor_header *) &uasp_bi_pipe_desc,
>>>>>            (struct usb_descriptor_header *) &bot_uasp_ss_bo_desc,
>>>>>            (struct usb_descriptor_header *) &uasp_bo_ep_comp_desc,
>>>>>            (struct usb_descriptor_header *) &uasp_bo_pipe_desc,
>>>>>            (struct usb_descriptor_header *) &uasp_ss_status_desc,
>>>>>            (struct usb_descriptor_header *) &uasp_status_in_ep_comp_desc,
>>>>>            (struct usb_descriptor_header *) &uasp_status_pipe_desc,
>>>>>            (struct usb_descriptor_header *) &uasp_ss_cmd_desc,
>>>>>            (struct usb_descriptor_header *) &uasp_cmd_comp_desc,
>>>>>            (struct usb_descriptor_header *) &uasp_cmd_pipe_desc,
>>>>>            NULL,
>>>>> };
>>>>>
>>>>> The first 5 descriptors are associated with BOT alternate setting,
>>>>> and others are associated  with UAS.
>>>>>
>>>>> During handling UAS alternate setting f_tcm drivr invokes
>>>>> config_ep_by_speed and this function sets incorrect companion endpoint
>>>>> descriptor in usb_ep object.
>>>>>
>>>>> Instead setting ep->comp_desc to uasp_bi_ep_comp_desc function in this
>>>>> case set ep->comp_desc to bot_uasp_ss_bi_desc.
>>>>>
>>>>> This is due to the fact that it search endpoint based on endpoint
>>>>> address:
>>>>>
>>>>>            for_each_ep_desc(speed_desc, d_spd) {
>>>>>                    chosen_desc = (struct usb_endpoint_descriptor *)*d_spd;
>>>>>                    if (chosen_desc->bEndpoitAddress == _ep->address)
>>>>>                            goto ep_found;
>>>>>            }
>>>>>
>>>>> And in result it uses the descriptor from BOT alternate setting
>>>>> instead UAS.
>>>>>
>>>>> Finally, it causes that controller driver during enabling endpoints
>>>>> detect that just enabled endpoint for bot.
>>>>>
>>>>> Signed-off-by: Jayshri Pawar <jpawar@cadence.com>
>>>>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>>>>> ---
>>>>>     drivers/usb/gadget/composite.c               | 46 ++++++++++++++------
>>>>>     drivers/usb/gadget/function/f_acm.c          |  7 +--
>>>>>     drivers/usb/gadget/function/f_ecm.c          |  7 +--
>>>>>     drivers/usb/gadget/function/f_eem.c          |  4 +-
>>>>>     drivers/usb/gadget/function/f_fs.c           |  3 +-
>>>>>     drivers/usb/gadget/function/f_hid.c          |  4 +-
>>>>>     drivers/usb/gadget/function/f_loopback.c     |  2 +-
>>>>>     drivers/usb/gadget/function/f_mass_storage.c |  5 ++-
>>>>>     drivers/usb/gadget/function/f_midi.c         |  2 +-
>>>>>     drivers/usb/gadget/function/f_ncm.c          |  7 +--
>>>>>     drivers/usb/gadget/function/f_obex.c         |  4 +-
>>>>>     drivers/usb/gadget/function/f_phonet.c       |  4 +-
>>>>>     drivers/usb/gadget/function/f_rndis.c        |  7 +--
>>>>>     drivers/usb/gadget/function/f_serial.c       |  4 +-
>>>>>     drivers/usb/gadget/function/f_sourcesink.c   | 11 +++--
>>>>>     drivers/usb/gadget/function/f_subset.c       |  4 +-
>>>>>     drivers/usb/gadget/function/f_tcm.c          | 36 +++++++--------
>>>>>     drivers/usb/gadget/function/f_uac1_legacy.c  |  2 +-
>>>>>     drivers/usb/gadget/function/f_uvc.c          |  5 ++-
>>>>>     drivers/usb/gadget/function/u_audio.c        |  4 +-
>>>>>     include/linux/usb/composite.h                |  2 +-
>>>>>     21 files changed, 99 insertions(+), 71 deletions(-)
>>>>>
>>>> I think we should create a new function and keep the old
>>>> config_ep_by_speed() for default alt-setting (e.i. have
>>>> config_ep_by_speed calls the new function with default alt-setting 0).
>>>> This way, we can keep compatibility with old function drivers and
>>>> minimize changes. At least that's what we did.
>>>>
>>> I don't think we need the separate function.
>>> If we set last parameter alt=0 then this function will work in the same way as old one.
>>>
>>
>> I wasn't talking about that. This patch modifies the
>> config_ep_by_speed() parameters, which requires to make a change to
>> every function driver of the kernel, and all in a single patch. This
>> makes it difficult to backport this fix. The only function driver that
>> you really need this fix for is f_tcm because of the stream eps right?
>>
>> You could just add a function like
>>
>>     int config_ep_by_speed_and_alt(struct usb_gadget *g, struct
>>     usb_function *f, unsigned int alt, struct usb_ep *_ep);
>>
>>
>> Then redefine config_ep_by_speed() to use it
>>
>>     int config_ep_by_speed(struct usb_gadget *g,
>>                            struct usb_function *f,
>>                            struct usb_ep *_ep)
>>     {
>>             return config_ep_by_speed_and_alt(g, f, 0, _ep);
>>     }
>>
>> This way, 1) you can split this patch, 2) you only need to make a fix to
>> f_tcm, 3) this fix can be backported much easier.
>>
>> Anyways, this is just a suggestion. It's up to the maintainers to decide.
> 
> Thanks for clarification, now I got it. In my opinion, both solution has pros and cons
> 1. Original patch.
> cons: introduce many change in many files
> pros:  we have only single API function - simpler Gadget Subsystem API
> 
> 2. using config_ep_by_speed_and_alt
> cons: minimal impact to other files.
> pros: introduce the new API function which in fact could be  omitted.
> 

I would vote for 2.

> It's only my personal opinion :) .
> 
> Felipe and Greg what is you opinion ?
> 
> Best Regards,
> Pawel
> 
>>
>> BR,
>> Thinh
> 

-- 

cheers,
-roger

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
