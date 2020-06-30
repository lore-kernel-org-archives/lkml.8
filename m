Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDE04C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 15:29:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAA0920663
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 15:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Fcu53Yrf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389423AbgF3P3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 11:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389312AbgF3P3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 11:29:22 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD61C061755;
        Tue, 30 Jun 2020 08:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=9buXox3enmJCMZeUtLja7eQwSxRejj91pcuCW8qu+hs=; b=Fcu53YrfMI0lQDRjFxd3Ji0bPY
        53asY+ahsbPRyOQruFE/MYn3DY1yzYodFpWHAlCFI3PET3DtHU3DfJUp+BCZaJqu/WeRdpDfUMNYI
        TricySoyQVzeFxlCmZQRyG9/xw0Gcuy7RSmUm1OOf4LNqq268Tsq9WHwNpeCGwtq5O+bYpMOjry3n
        4fHkCrLqPHihyu1EYS+rBIAwt5SlyHrLx8zKA2ncGKZobi/BkJVh7hpM/cxFcA1pj33/HJ0/zS492
        b/unNNwhaGnL25JAukyT8v2Jb0ugGRExZ1ZVGFSRIq4NwGg46QzDbHGhEQzLz7zioEda0L3SMle0q
        j77Z92Jg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqICC-0006Wy-4v; Tue, 30 Jun 2020 15:29:16 +0000
Subject: Re: mmotm 2020-06-25-20-36 uploaded (objtool warning)
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     akpm@linux-foundation.org, broonie@kernel.org, mhocko@suse.cz,
        sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>, viro@zeniv.linux.org.uk
References: <20200626033744.URfGO%akpm@linux-foundation.org>
 <ec31a586-92d0-8b91-bd61-03e53a5bab34@infradead.org>
 <20200630095920.GU4817@hirez.programming.kicks-ass.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ddd1bd1c-6a22-84d0-caf0-ce71c732f71b@infradead.org>
Date:   Tue, 30 Jun 2020 08:29:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200630095920.GU4817@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/30/20 2:59 AM, Peter Zijlstra wrote:
> On Fri, Jun 26, 2020 at 04:35:08PM -0700, Randy Dunlap wrote:
>> arch/x86/kernel/sys_ia32.o: warning: objtool: cp_stat64()+0x57: call to new_encode_dev() with UACCESS enabled
> 
> That's c120f3b81ede ("x86: switch cp_stat64() to unsafe_put_user()").
> 
> Where __put_user() made sure evaluate 'x' before doing
> __uaccess_begin(), the new code has no such choice.
> 
> The simplest fix is probably something like this.
> 

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  include/linux/kdev_t.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/kdev_t.h b/include/linux/kdev_t.h
> index 85b5151911cf..a840ffef7c19 100644
> --- a/include/linux/kdev_t.h
> +++ b/include/linux/kdev_t.h
> @@ -36,7 +36,7 @@ static inline dev_t old_decode_dev(u16 val)
>  	return MKDEV((val >> 8) & 255, val & 255);
>  }
>  
> -static inline u32 new_encode_dev(dev_t dev)
> +static __always_inline u32 new_encode_dev(dev_t dev)
>  {
>  	unsigned major = MAJOR(dev);
>  	unsigned minor = MINOR(dev);
> @@ -50,7 +50,7 @@ static inline dev_t new_decode_dev(u32 dev)
>  	return MKDEV(major, minor);
>  }
>  
> -static inline u64 huge_encode_dev(dev_t dev)
> +static __always_inline u64 huge_encode_dev(dev_t dev)
>  {
>  	return new_encode_dev(dev);
>  }
> 


-- 
~Randy

