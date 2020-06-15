Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2D3C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 14:53:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 785ED20644
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 14:53:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SlV5EozB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730756AbgFOOx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 10:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730613AbgFOOx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 10:53:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748E5C061A0E;
        Mon, 15 Jun 2020 07:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=8o15lOc1lDE+izueLOJdR6PR6C+0mzzoK26JzWEPT2U=; b=SlV5EozBrBJwoKZWtH98UnaCl2
        x6SKNalZBE/ZcWUtN/3ZjTGWOVk84a8M9LuojCopndPU5I03J8KuBdgQXLmQITQHf1n7G5e1z7kPm
        hRrj5FufRJS03gnqBb116hMma7ykDaKy0XKjeDQQFyGTwl87Fu8LiVDO/JzZwNVdOgY2hAP/3kRdZ
        fZ8bkhWZvHi9JrGJJZqZxjf6vBUWBwc4Q1A5vnALY/4GCdfDaEzxPwKQQUUXSiL4gb3DcfJISIfWe
        o3Ciln1ibEQHhOQmFlIGKsNUjuqIaUOPVK9DqxSElFKii1FOT7wPK8XSt2Abr6jXLYvMyM30FtboN
        QY+rxM6Q==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkqUH-00015g-R8; Mon, 15 Jun 2020 14:53:25 +0000
Subject: Re: [PATCH] Documentation: fix malformed table in
 filesystems/proc.rst
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Daniel Kiss <daniel.kiss@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
References: <016e5a38-5289-9111-05bb-7d0aa0cce5a5@infradead.org>
 <20200615085305.275a7b24@coco.lan>
 <a9634ff3-fc33-0d2b-959b-bd3dd79600bf@infradead.org>
 <20200615072217.0e59ea63@lwn.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <abf43ec1-fe06-fb5e-12e4-66c64e09b125@infradead.org>
Date:   Mon, 15 Jun 2020 07:53:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200615072217.0e59ea63@lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/20 6:22 AM, Jonathan Corbet wrote:
> On Sun, 14 Jun 2020 23:54:26 -0700
> Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>> On 6/14/20 11:53 PM, Mauro Carvalho Chehab wrote:
>>> Em Sun, 14 Jun 2020 20:33:22 -0700
>>> Randy Dunlap <rdunlap@infradead.org> escreveu:
>>>   
>>>> From: Randy Dunlap <rdunlap@infradead.org>
>>>>
>>>> Fix malformed table in "proc.rst" by dropping a needless hyphen ('-').
>>>>
>>>> Documentation/filesystems/proc.rst:548: WARNING: Malformed table.
>>>> Text in column margin in table line 29.
>>>>
>>>> Fixes: 424037b77519 ("mm: smaps: Report arm64 guarded pages in smaps")
>>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>>> Cc: Daniel Kiss <daniel.kiss@arm.com>
>>>> Cc: Mark Brown <broonie@kernel.org>
>>>> Cc: Catalin Marinas <catalin.marinas@arm.com>  
>>>
>>> I submitted an identical patch on Jan, 3.   
>>
>> OK. Well, that's disappointing IMHO.
> 
> Sorry if I have caused disappointment.

No problem. I read Jan and not June.

> In any case, that's *June*, not January, that the patch was submitted.  I
> didn't apply it because, since the problem didn't come through docs-next,
> it didn't apply there.  Now that docs-next is caught up with 5.8-rc1 I can
> apply such things again...

thanks.
-- 
~Randy

