Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5506AC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 02:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 164A920842
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 02:16:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="W4gWmzY+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731642AbgDACQY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 22:16:24 -0400
Received: from ozlabs.org ([203.11.71.1]:39733 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731427AbgDACQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 22:16:23 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48sVDj1rJCz9sSM;
        Wed,  1 Apr 2020 13:16:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1585707381;
        bh=6H4dJVI9SZD7xHWGgoeySLOGZhVXjnt00eYoMPTKebI=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=W4gWmzY+y/WMKE7YTdt0643Yql+sIBSKLoyp1fQhPwJGYPXwwJrnUE3ZOrVpYI1Td
         ur+5K1IzUkvFPwx+VF/iKQbxL2rR/te8JrfODxsWvPnJN+QejX3/V/XmaoylMBtj+A
         +yo2YZO9B2rdynITB+dOFOq4Zkr6H0LKNDB4vmXD5QIeJOmYVCZuJqEg9n1LglsuN7
         E1GHIi+fN0JntV36kZfV/xFMZd3O1Zxkh5FCbU7pF3EL9nv+IkfaBDf3Pw+GAkgyZR
         wiNmuIpT98WgG6yiE8RVaqwUynS6KnW3JuqCDwDYd6bM7Cw4TWJBAXhKPIfKU8AFB0
         3DrD7TWrE18hg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Arnd Bergmann <arnd@arndb.de>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michal Simek <michal.simek@xilinx.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2 07/11] powerpc/xmon: Remove PPC403 and PPC405
In-Reply-To: <CAK8P3a2Q5gmcyjo03QoDMNO-xEWXDjhW8ScUsGGRWVKgVXj5_g@mail.gmail.com>
References: <698e9a42a06eb856eef4501c3c0a182c034a5d8c.1585640941.git.christophe.leroy@c-s.fr> <38de0c6caceb052a23e039378dc491fe66cea371.1585640942.git.christophe.leroy@c-s.fr> <CAK8P3a2Q5gmcyjo03QoDMNO-xEWXDjhW8ScUsGGRWVKgVXj5_g@mail.gmail.com>
Date:   Wed, 01 Apr 2020 13:16:30 +1100
Message-ID: <87ftdouf0h.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:
> On Tue, Mar 31, 2020 at 9:49 AM Christophe Leroy
> <christophe.leroy@c-s.fr> wrote:
>>
>> xmon has special support for PPC403 and PPC405 which were part
>> of 40x platforms.
>>
>> 40x platforms are gone, remove support of PPC403 and PPC405 in xmon.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>  arch/powerpc/xmon/ppc-opc.c | 277 +++++++-----------------------------
>>  arch/powerpc/xmon/ppc.h     |   6 -
>
> These files are from binutils, and may get synchronized with changes there
> in the future. I'd suggest leaving the code in here for now and instead removing
> it from the binutils version first, if they are ready to drop it, too.

Yes those files are almost direct copies of the binutils versions, and
we'd like to keep it that way to ease future synchronisation of changes.

cheers
