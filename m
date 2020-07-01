Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E826DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8386207D0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M3oGG8PM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731768AbgGAPHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 11:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731505AbgGAPHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 11:07:18 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC934C08C5C1;
        Wed,  1 Jul 2020 08:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=L3kKHrtugZdZaaaEA+9AzSKVijtsEP+fouPlZ1lpYfo=; b=M3oGG8PMqN8K4FAu523qeKzcLi
        tHyOZRIc6eTPCI0K6yfu4vYkiSWAvtg202r3Vgi3ToycReduqU3rLS7McoJ/IuVVNyIO0YkjoZvmR
        emSVuipiCA9+6KQfBEXqwTm2+at/qnA/R/45dtwZPohMzoqcaxFf34qSWq3PrwTabTLNPIsoaz3Dq
        Gwuxns2WspMRje0MiJs1H4yQi6N2qMaXJ4Vg3YMN72sbB1cLSEKyIlRBoeeK81tF/aVsC1uPwl18F
        cY5EIypqviPOAqksyBeYzoWXVA1u0gH2A8tztZHuoQGnHAeTk+cbdWzOJIkkPZeDKm7vDweKRy2XX
        tRKt7rqg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqeKO-00064z-3z; Wed, 01 Jul 2020 15:07:12 +0000
Subject: Re: [v2] Documentation: Coccinelle: fix typos and command example
To:     Markus Elfring <Markus.Elfring@web.de>, linux-doc@vger.kernel.org,
        Coccinelle <cocci@systeme.lip6.fr>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Julia Lawall <julia.lawall@lip6.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Michal Marek <michal.lkml@markovi.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jonathan Corbet <corbet@lwn.net>
References: <0616dd0c-bb86-be2b-3dc6-1c695a92c3ca@infradead.org>
 <c2c1dec0-2bd1-b0e2-1aa4-38d0e954d5ba@web.de>
 <efc8b0c9-db3b-3c9c-d876-897b53a9e278@infradead.org>
 <2a3940de-6a81-1aff-8109-53c1c5a6aa1b@web.de>
 <f2aaa91a-f935-bc2d-26f2-712576c1bbd7@infradead.org>
 <2f80fb10-dc7f-29be-dc3e-2715f8bafc6d@web.de>
 <dfa2ed9f-fe68-58d1-c3d0-ac436f9bee09@infradead.org>
 <648d287e-3636-1858-1439-103d317f8571@web.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <34065299-03cf-5b62-db37-0acc9830be72@infradead.org>
Date:   Wed, 1 Jul 2020 08:07:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <648d287e-3636-1858-1439-103d317f8571@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/1/20 8:02 AM, Markus Elfring wrote:
>>>>> How do you think about to use the following command variant
>>>>> for the adjustment of the software documentation?
>>>>>
>>>>> +    make C=1 CHECK='scripts/coccicheck' 'path/to/file.o'
>>>>
>>>> I don't understand the reason for that change...
>>
>> IOW, your "patch" needs justification and/or explanation. It was missing that info.
> 
> I hope that the clarification of the presented questions can result into
> relevant information.
> 
> 
>>> Is our understanding still incomplete for the support of source code checking parameters
>>> by the make script?
>>>
>>> * Will software analysis be performed in addition to the desired compilation
>>>   of a source file (according to the selected object file)?
>>>
>>> * How do you think about to trigger only the generation of analysis results
>>>   for a single file?
>>
>> Do I need to remove that line from the patch?
> 
> I propose to adjust it another bit.
> The desired change agreement might need further communication efforts.
> 
> 
>> Feel free to submit patches, not just comments.
> 
> Would you like to integrate any more details from the running patch review?

I am satisfied with the current patch.

No doubt that any documentation can be improved, almost ad infinitum,
but I'm not trying to do that. I'm trying not to do that.


-- 
~Randy

