Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA7C9C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 06:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3FB8206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 06:33:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="Z4nDe29Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgD2GdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 02:33:22 -0400
Received: from ozlabs.org ([203.11.71.1]:39857 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726158AbgD2GdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 02:33:21 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49BpcF3W3jz9sSl;
        Wed, 29 Apr 2020 16:33:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
        t=1588141999; bh=3MKZzbOxV7CZNMIIu+rSiDhnp5u7vnphPsD8HQA8wEU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Z4nDe29ZwLxjR5q8UZrt43rf3HI+UXJI4Qv80xc4hFTm9Ohhfomp65bwGqNZCZAb+
         WNjaEHfky/Hguil8WFXRH5Eub3FuVzDhKzHVF0dU7iRTbKB1p+pT7oAjM5pL3ODtY4
         Foo1vHiVPOS9UiCaKAQ/zA7PEt7FG4edcizX/Y/voDxjIsuy4lhqJP5AkaL6ubp3ap
         33bx/2otMrJJ/cVRzDrZJpVG2RG5C9zLy0ce78TKCkeHls5PubHHZ4ZoEnghbTnJh/
         CAhXPrwqOTSk5UK4FObUuxAjZUKfciLaJNbZZnxax30DJeMceYpwc5r5CHErd/bu6s
         hCQJ4Ya1niVUw==
Message-ID: <2014678ca837f6aaa4cf23b4ea51e4805146c36d.camel@ozlabs.org>
Subject: Re: [RFC PATCH] powerpc/spufs: fix copy_to_user while atomic
From:   Jeremy Kerr <jk@ozlabs.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 29 Apr 2020 14:33:13 +0800
In-Reply-To: <20200429061514.GD30946@lst.de>
References: <20200427200626.1622060-2-hch@lst.de>
         <20200428120207.15728-1-jk@ozlabs.org> <20200428171133.GA17445@lst.de>
         <e1ebea36b162e8a3b4b24ecbc1051f8081ff5e53.camel@ozlabs.org>
         <20200429061514.GD30946@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

> And another one that should go on top of this one to address Al's other
> compaint:

Yeah, I was pondering that one. The access_ok() is kinda redundant, but
it does avoid forcing a SPU context save on those errors.

However, it's not like we really need to optimise for the case of
invalid addresses from userspace. So, I'll include this change in the
submission to Michael's tree. Arnd - let me know if you have any
objections.

Cheers,


Jeremy


