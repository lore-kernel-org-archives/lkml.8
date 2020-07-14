Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A23DBC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 21:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68A0420674
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 21:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YfslfIQX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgGNV5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 17:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgGNV5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 17:57:11 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D3AC061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 14:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=JIt3Ae9F/kZhyCF5QZvbdMIjxIyoLl2rwNBgtFMNQRY=; b=YfslfIQXTcYIAVg9OPPVDupPJM
        /VtOcybkDTVk2IkuBc8Yfd5HL+S2g+2QFTz1mPds7wPHdt5MWBsH/fbN/NpNWL/ccEpeVx8BzfTXA
        bAyYyAI2oXiBSXiExLvc5Ggu2QJ/g8sKGHH8WBMx6nnQ+bX0eSGWWjQQHKqwAjFxEWa9YzF+O4Yrm
        E5XUlrGioP/beBOw812vMzkKvzbw6qNAWhQ3pZWWiUkYTZdUvfxWd0UYNmAVnJ9x+pDX5I9eFvNrr
        ImksVHkvXKJtUPXobrSq89wFkxuGkf2mBXWO6/uvdTw4k233lvjXF7VdAYneP5bde8PPtqQsNtZpo
        Ak2coXyA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jvSvA-0000jK-Qr; Tue, 14 Jul 2020 21:57:05 +0000
Subject: Re: [PATCH] CREDITS: remove link http://www.dementia.org/~shadow
To:     Jonathan Corbet <corbet@lwn.net>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     torvalds@linux-foundation.org, ribalda@kernel.org,
        viro@zeniv.linux.org.uk, mchehab+samsung@kernel.org,
        luis.f.correia@gmail.com, geert+renesas@glider.be,
        paulburton@kernel.org, cyphar@cyphar.com, martink@posteo.de,
        davej@codemonkey.org.uk, linux-kernel@vger.kernel.org
References: <20200713114321.783f0ae6@lwn.net>
 <20200714193805.49746-1-grandmaster@al2klimov.de>
 <20200714154708.71b3efe2@lwn.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <083564e4-3099-15d0-9f18-04a8657a0885@infradead.org>
Date:   Tue, 14 Jul 2020 14:56:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200714154708.71b3efe2@lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/20 2:47 PM, Jonathan Corbet wrote:
> On Tue, 14 Jul 2020 21:38:05 +0200
> "Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:
> 
>> Rationale:
>> The way it redirects looks like a fallback from a dead URL to a generic one.
>>
>> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
>> ---
>>  Yes, I noted that some of the links removed by these "CREDITS: remove link:"
>>  patches have email addresses with the same domain nearby.
>>
>>  Don't worry, I'll take care of them together with all other
>>  dead email addresses - but not right now.
>>
>>
>>  CREDITS | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/CREDITS b/CREDITS
>> index 0787b5872906..92ad22b7ef56 100644
>> --- a/CREDITS
>> +++ b/CREDITS
>> @@ -483,7 +483,6 @@ D: Intel Wireless WiMAX Connection 2400 SDIO driver
>>  
>>  N: Derrick J. Brashear
>>  E: shadow@dementia.org
>> -W: http://www.dementia.org/~shadow
> 
> So thanks for addressing these.  That said, I do wonder if this is quite
> the right thing to do.  I'm assuming that the old sites still exist in the
> wayback machine somewhere, and somebody might actually want to find them.
> Pity the poor anthropologist researching the origins of the the
> billion-line, free-software kernels widely used in the 2500's...
> 
> So maybe we should either mark it as "[BROKEN]" or make a direct link into
> the wayback machine instead?  That would enable the suitably motivated to
> go after the content that once existed.
> 
> Thoughts anybody?

I'm not going to be much help here: I like either of Jon's suggestions
better than just deleting that line.

-- 
~Randy

