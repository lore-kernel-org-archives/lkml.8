Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308CAC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:49:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F404321D95
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 19:49:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="rOYHKIk2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgHETtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728308AbgHEQys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:54:48 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AD6C034613
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 05:48:27 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z18so37008562wrm.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 05:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LM1Oj6CMy+UaQUy6SY0cJrL8H1cD8DIwTKTLLUxm8GE=;
        b=rOYHKIk2WUpgZa45oMbWh2DnljJ5I+n+pazqzyVsDFmp6noTkD4zpRRBr+2skUktXm
         rRB/zrjgE9MMR44w5chRNM32rHnHBmDlARXh4uTjNtxk1cnVUH7KmtQ+kTXtUWA1serr
         VDY75YQnXce7fJEwpsfcBZf8/EIfeVnQTNDQvMibMjKW4Wy42NZUYaIH4+Df0gLy7Sge
         3ZgD1cclW+hpFCg5mOoYvsVL/XH+a/3tKmKLIAS1489rI/Sbs1su05BP4dRcdSTaq524
         oHeM7ommoBXcMvVGQImg96ZDrBdihNboMA26O9BeGI6f5ixLZloh58Uc1cvwoMrcqQKt
         uBrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LM1Oj6CMy+UaQUy6SY0cJrL8H1cD8DIwTKTLLUxm8GE=;
        b=JSqq+dsCXmRDZanFQ8csqUbP+u+SCzRanB1SxLEMFAN8JEZSGLMQdUsdFhJ5kX874j
         SGnUUzpWavX/8l+B9o/nRT3LejE4PeeR4ToVcpekkQdq6TPjA1Z0b21es3rST8MmcDqi
         qCXH8LODKcOe7P5CntvNBwCm/I6H3Hmm5PMV7NyPyK1Hq0z6Es0Rx8UNihxgdWXz088D
         MnFCp/j0kZfNP4ByHQMSJ3XXzE7VQzUF94vkDBKfoURdhwc+M4+rEgflTGfIQ0EFb8z2
         4rw5FcOIieyg6ZOfmOcRPa6akCn+lao/RXzRcjjczbRi6cQWd3pnNXW/KkZPVDKAmGjT
         kegg==
X-Gm-Message-State: AOAM531sxPkV/g1pNnfaOnPip6fLt9jJ82gNFuajUfw8LJSRqhtVZWBL
        +k41RHajXV43GJ7Owabas5uTs/A9
X-Google-Smtp-Source: ABdhPJwns0f79W21zd+CDXGFbNlaOdl5o/pkTTuvMe3TQVysVA42W5WFRn7lvo0y+ImDfuf99D7wYA==
X-Received: by 2002:a5d:6401:: with SMTP id z1mr2639637wru.272.1596631704839;
        Wed, 05 Aug 2020 05:48:24 -0700 (PDT)
Received: from [192.168.1.20] ([213.122.218.185])
        by smtp.googlemail.com with ESMTPSA id 8sm2777286wrl.7.2020.08.05.05.48.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2020 05:48:24 -0700 (PDT)
Subject: Re: PATCH: rtsx_pci driver - don't disable the rts5229 card reader on
 Intel NUC boxes
From:   Chris Clayton <chris2553@googlemail.com>
To:     =?UTF-8?B?5ZCz5piK5r6EIFJpY2t5?= <ricky_wu@realtek.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "philquadra@gmail.com" <philquadra@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <862172f0-cd23-800c-27b1-27cb49e99099@googlemail.com>
 <a9a94d7f-4873-7a10-4911-f3c760257c5c@googlemail.com>
 <5729c72bbc2740d3917619c85e2fde58@realtek.com>
 <20200804074831.GB1761483@kroah.com>
 <11e224ca299b48f1bea07082f2ff7c00@realtek.com>
 <0afbd711-0bda-d9a3-138d-5c713b4e2ed9@googlemail.com>
 <19de15c2f07d447dace6bea483d38159@realtek.com>
 <152ef6c0-f3c0-bb67-4175-adced3c720cd@googlemail.com>
 <e1c295f28e3d4bdd8c78dfd3a5ed398c@realtek.com>
 <68b9bdd2-a05e-7fb0-ec9a-70b03e0c5289@googlemail.com>
Message-ID: <20da8b4b-8426-9568-c0f1-4d1c2006c53f@googlemail.com>
Date:   Wed, 5 Aug 2020 13:48:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <68b9bdd2-a05e-7fb0-ec9a-70b03e0c5289@googlemail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricky

On 05/08/2020 06:51, Chris Clayton wrote:
> Thanks, Ricky.
> 
> On 05/08/2020 03:35, 吳昊澄 Ricky wrote:
>>
>>
>>> -----Original Message-----
>>> From: Chris Clayton [mailto:chris2553@googlemail.com]
>>> Sent: Tuesday, August 04, 2020 7:52 PM
>>> To: 吳昊澄 Ricky; gregkh@linuxfoundation.org
>>> Cc: LKML; rdunlap@infradead.org; philquadra@gmail.com; Arnd Bergmann
>>> Subject: Re: PATCH: rtsx_pci driver - don't disable the rts5229 card reader on
>>> Intel NUC boxes
>>>
>>>
>>>
>>> On 04/08/2020 11:46, 吳昊澄 Ricky wrote:
>>>>> -----Original Message-----
>>>>> From: Chris Clayton [mailto:chris2553@googlemail.com]
>>>>> Sent: Tuesday, August 04, 2020 4:51 PM
>>>>> To: 吳昊澄 Ricky; gregkh@linuxfoundation.org
>>>>> Cc: LKML; rdunlap@infradead.org; philquadra@gmail.com; Arnd Bergmann
>>>>> Subject: Re: PATCH: rtsx_pci driver - don't disable the rts5229 card reader on
>>>>> Intel NUC boxes
>>>>>
>>>>>
>>>>>
>>>>> On 04/08/2020 09:08, 吳昊澄 Ricky wrote:
>>>>>>> -----Original Message-----
>>>>>>> From: gregkh@linuxfoundation.org [mailto:gregkh@linuxfoundation.org]
>>>>>>> Sent: Tuesday, August 04, 2020 3:49 PM
>>>>>>> To: 吳昊澄 Ricky
>>>>>>> Cc: Chris Clayton; LKML; rdunlap@infradead.org; philquadra@gmail.com;
>>>>> Arnd
>>>>>>> Bergmann
>>>>>>> Subject: Re: PATCH: rtsx_pci driver - don't disable the rts5229 card reader
>>> on
>>>>>>> Intel NUC boxes
>>>>>>>
>>>>>>> On Tue, Aug 04, 2020 at 02:44:41AM +0000, 吳昊澄 Ricky wrote:
>>>>>>>> Hi Chris,
>>>>>>>>
>>>>>>>> rtsx_pci_write_register(pcr, FPDTL, OC_POWER_DOWN,
>>>>> OC_POWER_DOWN);
>>>>>>>> This register operation saved power under 1mA, so if do not care the 1mA
>>>>>>> power we can have a patch to remove it, make compatible with NUC6
>>>>>>>> We tested others our card reader that remove it, we did not see any side
>>>>> effect
>>>>>>>>
>>>>>>>> Hi Greg k-h,
>>>>>>>>
>>>>>>>> Do you have any comments?
>>>>>>>
>>>>>>> comments on what?  I don't know what you are responding to here, sorry.
>>>>>>>
>>>>>> Can we have a patch to kernel for NUC6? It may cause more power(1mA) but
>>> it
>>>>> will have more compatibility
>>>>>>
>>>>>
>>>>> Ricky,
>>>>>
>>>>> I don't understand why you want to completely remove the code that sets up
>>> the
>>>>> 1mA power saving. That code was there
>>>>> even before your patch (bede03a579b3b4a036003c4862cc1baa4ddc351f), so I
>>>>> assume it benefits some of the Realtek card
>>>>> readers. Before your patch however, rtsx_pci_init_ocp() was not called for the
>>>>> rts5229 reader, but the patch introduced
>>>>> an unconditional call to that function into rtsx_pci_init_hw(), which is run for
>>> the
>>>>> rts5229. That is what now disables
>>>>> the card reader.
>>>>>
>>>>> Now, I don't know whether other cards are affected, although I don't recall
>>>>> seeing any reported as I searched the kernel
>>>>> and ubuntu bugzillas for any analysis of the problem. I know this is not what
>>> the
>>>>> patch I sent does, but having thought
>>>>> about it more, seems to me that the simplest fix is to skip the new call to
>>>>> rtsx_pci_init_ocp() if the reader is an rts5229.
>>>>>
>>>>
>>>> Because we are thinking about if others our card reader that not belong A
>>> series(my ocp patch coverage) also on NUC6 platform maybe have the same
>>> problem...
>>>>
>>>
>>> OK. What if we do make the new call but only for the card readers that are in the
>>> A series? Are they the ones that have
>>> PID_5nnn defines in include/linux/rtsx_pci.h? Or is there another simple way of
>>> identifying that a reader is a member of
>>> the A series?
>>>
>>> I'm thinking of something like:
>>> static bool rtsx_pci_is_series_A(pcr)
>>> {
>>> 	unsigned short device = pcr->pci->device;
>>>
>>> 	return device == PID524A || device == PID_5249 || device == PID_5250 ||
>>> device == PID_525A
>>> 			|| device == PID_525A || device == PID_5260 || device ==
>>> PID_5261;
>>> }
>>>
>>> then in rtsx_pci_init_hw() change the unconditional call to:
>>>
>>> 	if rtsx_pci_is_series_A(pcr)
>>> 		rtsx_pci_init_ocp();
>>>
>>> Does that seem OK?
>>>
>> Previously, I want to remove
>> else {
>> 		/* OC power down */
>> 		rtsx_pci_write_register(pcr, FPDCTL, OC_POWER_DOWN,
>> 			OC_POWER_DOWN);
>> }
>> Because in our A-series card Reader we already assigned option->ocp_en to 1 in self init_params() , this is an easy way to fix this problem
>>
> 
> Ah, OK. I'll prepare the patch and send it to you once I've tested it.
> 

Please see the patch included below. As you suggested, it removes the code that does the OC power down on card readers
that are not members of your A series. The patch is against a fresh pull of Linus's tree this morning
(v5.8-2768-g4da9f3302615).

I've tested the resultant kernel on my Intel NUC6CAYH box (which contains an NUC66AYB board) and the rts5229 works fine.
I've also tested it on my laptop which also has a card reader supported by the rtsx_pci driver (an RTL8411B) and that
also works fine.

As I mentioned yesterday, I think it's a candidate for the 5.4 ans 5.7 stable series.

Thanks for your patience!

Chris

Signed-off-by: Chris Clayton <chris2553@googlemail.com>

--- a/drivers/misc/cardreader/rtsx_pcr.c        2020-08-05 07:10:21.752072515 +0100
+++ b/drivers/misc/cardreader/rtsx_pcr.c        2020-08-05 07:11:05.568074278 +0100
@@ -1172,10 +1172,6 @@ void rtsx_pci_init_ocp(struct rtsx_pcr *
                        rtsx_pci_write_register(pcr, REG_OCPGLITCH,
                                SD_OCP_GLITCH_MASK, pcr->hw_param.ocp_glitch);
                        rtsx_pci_enable_ocp(pcr);
-               } else {
-                       /* OC power down */
-                       rtsx_pci_write_register(pcr, FPDCTL, OC_POWER_DOWN,
-                               OC_POWER_DOWN);
                }
        }
 }


