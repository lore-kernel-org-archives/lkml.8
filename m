Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C894C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 03:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0B42206EB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 03:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SIRhBzc9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727797AbgEDD6F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 23:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbgEDD6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 23:58:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21747C061A0E
        for <linux-kernel@vger.kernel.org>; Sun,  3 May 2020 20:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description;
        bh=+OROLZS0Nu6tDBEkHr8N8/CLWS2Ua8zrfFXn7uV44cs=; b=SIRhBzc9xhTkn34ZB5v8mEQt7M
        drV08fpCuWQxzTJrfchKZTtUl3tGd3WhJFPcjQB2Iizn1KRWq63purk4ygvbnXJ66Ja9lcTgBvw0f
        BSr7NDyhnYo6/mAQU1piQCROJGn4Fzlk81X518rCJOA1EWsl2QHewgzqmAOLY6zRMeOeswa5x5U0C
        i2+MKT5HJtV0mOqu/G8QyCimRCqiMIhK1Ywd0J3P998ACBWAoBrXGiCFKfHR+eXkPW52HVNQvXAmp
        ySAbLXHkJkHvhlXz9l4MjJadr2NSavg3A/Q+ahik0sF8zsEfYyCzQA35mz/gYBJHwmUa+dbKJUJ1T
        ip6oKJ1Q==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVSF2-00021G-AH; Mon, 04 May 2020 03:58:04 +0000
Subject: Re: Possible memory leak in unxz()
To:     Dongyang Zhan <zdyzztq@gmail.com>, linux-kernel@vger.kernel.org,
        Lasse Collin <lasse.collin@tukaani.org>
References: <CAFSR4csKYu95qak02h_sAH6Rpa13PUtHUZ+7Z7Vd7tmBQCNaqg@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <daf2f87a-155c-0836-cf82-0b409b860d6d@infradead.org>
Date:   Sun, 3 May 2020 20:58:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAFSR4csKYu95qak02h_sAH6Rpa13PUtHUZ+7Z7Vd7tmBQCNaqg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/20 12:23 AM, Dongyang Zhan wrote:
> Hi,
> 
> I am a security researcher, my name is Dongyang Zhan. I found a potential bug.
> 
> I hope you can help me to confirm it.
> 
> Thank you.
> 
> Possible memory leak in Linux 4.10.17. The function unxz() in

It would be more helpful if you could focus on more recent/current
source code.  If someone makes a patch for current source code and
it needs to be backported to older kernels, then that would [normally]
happen.

> /lib/decompress_unxz.c forgets to free the pointer 'in', when  the
> statement if (fill == NULL && flush == NULL) is true.

Adding xz contributor to email.

I think that you are correct. (I am looking at 5.7-rc4.)

However, I don't see any calls to __decompress() in the
Linux kernel that pass a first argument of NULL, so while
the code in unxz() could be fixed, we aren't currently leaking
any memory AFAICT.


> Source code and comments:
> 
> if (in == NULL) {
> must_free_in = true;
> in = malloc(XZ_IOBUF_SIZE);
> if (in == NULL)
> goto error_alloc_in;
> }
> 
> b.in = in;
> b.in_pos = 0;
> b.in_size = in_size;
> b.out_pos = 0;
> 
> if (fill == NULL && flush == NULL) {
> ret = xz_dec_run(s, &b); // When this statement is true, it will jumps
> to the switch statement. But the allocated 'in' is not freed before
> return.
> } else {
> .....
> }
> .....
> switch (ret) {
> case XZ_STREAM_END:
> return 0;
> 
> case XZ_MEM_ERROR:
> /* This can occur only in multi-call mode. */
> error("XZ decompressor ran out of memory");
> break;
> 
> case XZ_FORMAT_ERROR:
> error("Input is not in the XZ format (wrong magic bytes)");
> break;
> 
> case XZ_OPTIONS_ERROR:
> error("Input was encoded with settings that are not "
> "supported by this XZ decoder");
> break;
> 
> case XZ_DATA_ERROR:
> case XZ_BUF_ERROR:
> error("XZ-compressed data is corrupt");
> break;
> 
> default:
> error("Bug in the XZ decompressor");
> break;
> }
> 
> return -1;
> ....

thanks.
-- 
~Randy

