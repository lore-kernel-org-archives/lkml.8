Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D421C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:44:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B20F20663
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="AVLg3ibs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731688AbgF2UoC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731618AbgF2TOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:14:01 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01E7C08EA4E
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jun 2020 23:04:07 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49wH4P2XnSz9sQt;
        Mon, 29 Jun 2020 16:04:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1593410645;
        bh=rCQ9UWEaL81XNzFf+M1vO61UGj8xcpAMew6CAkzUbAk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=AVLg3ibs8WXrZB52xgAmxhuUhTrrl91U87AEtJTXKj6vaOb8oXaq4spqIRIDf2J7H
         SljLkVTjrk/Du/nMPasTChhWfwrJCg0TPVJNlKe6H0b4Z6c5SAdnk1Cxf61RLO55CH
         b0omNwc8V1f5uZ5q9vawgcdtCcyWuO//8naB3E4/+UBcFrc/j988kDH3GZ2nxI8ZVs
         XP1bPqb1q84mE2omSa2SYatDH868N1hjI0VBKBJkyG4ntlLezVSB67jYpzxgH+ruYd
         reeEN21hJFfhjxwjqZXeaNqEPdhw23fqHesy+RG1WJqXBp8L0ixbjtKx2SK9eS1S5t
         jY1oOW42I/0Sw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Bin Meng <bmeng.cn@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Bin Meng <bin.meng@windriver.com>
Subject: Re: [PATCH v2] powerpc: Drop CONFIG_MTD_M25P80 in 85xx-hw.config
In-Reply-To: <CAEUhbmUj4iC1+4Y=93zpj+aCBqU1ySOHXvQgJHmxNx__UWduCQ@mail.gmail.com>
References: <1588394694-517-1-git-send-email-bmeng.cn@gmail.com> <CAEUhbmUj4iC1+4Y=93zpj+aCBqU1ySOHXvQgJHmxNx__UWduCQ@mail.gmail.com>
Date:   Mon, 29 Jun 2020 16:06:20 +1000
Message-ID: <87ftae8kyr.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bin Meng <bmeng.cn@gmail.com> writes:
> On Sat, May 2, 2020 at 12:45 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>>
>> From: Bin Meng <bin.meng@windriver.com>
>>
>> Drop CONFIG_MTD_M25P80 that was removed in
>> commit b35b9a10362d ("mtd: spi-nor: Move m25p80 code in spi-nor.c")
>>
>> Signed-off-by: Bin Meng <bin.meng@windriver.com>
>>
>> ---
>>
>> Changes in v2:
>> - correct the typo (5xx => 85xx) in the commit title
>>
>>  arch/powerpc/configs/85xx-hw.config | 1 -
>>  1 file changed, 1 deletion(-)
>>
>
> It seems this patch isn't applied anywhere. Ping?

I'll grab it.

cheers
