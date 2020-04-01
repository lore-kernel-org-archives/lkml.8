Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E97C2D0E7
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ACAC20678
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 10:25:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732203AbgDAKZg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 06:25:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34744 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbgDAKZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 06:25:36 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jJaYo-0007Zr-6G; Wed, 01 Apr 2020 12:25:26 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id C88B61040D2; Wed,  1 Apr 2020 12:25:25 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: linux-next: build warning after merge of the tip tree
In-Reply-To: <20200401085753.617c1636@canb.auug.org.au>
References: <20200330134746.627dcd93@canb.auug.org.au> <20200401085753.617c1636@canb.auug.org.au>
Date:   Wed, 01 Apr 2020 12:25:25 +0200
Message-ID: <877dyzv6y2.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:
> Hi all,
>
> On Mon, 30 Mar 2020 13:47:46 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>
>> Hi all,
>> 
>> After merging the tip tree, today's linux-next build (arm
>> multi_v7_defconfig) produced this warning:
>> 
>> kernel/futex.c: In function 'do_futex':
>> kernel/futex.c:1676:17: warning: 'oldval' may be used uninitialized in this function [-Wmaybe-uninitialized]
>>  1676 |   return oldval == cmparg;
>>       |          ~~~~~~~^~~~~~~~~
>> kernel/futex.c:1652:6: note: 'oldval' was declared here
>>  1652 |  int oldval, ret;
>>       |      ^~~~~~
>> 
>> Introduced by commit
>> 
>>   a08971e9488d ("futex: arch_futex_atomic_op_inuser() calling
>>   conventions change")

Huch?
 
>> but I don't see how it makes this difference :-(

Me neither. Which compiler version?

I'm using arm-linux-gnueabi-gcc (Debian 8.3.0-2) 8.3.0 which does not
show that oddity.

Thanks,

        tglx

