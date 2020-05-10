Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 244B0C54E8B
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 19:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 097872098B
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 19:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbgEJTYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 15:24:24 -0400
Received: from mailscanner01.zoner.fi ([84.34.166.10]:53974 "EHLO
        mailscanner01.zoner.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729113AbgEJTYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 15:24:23 -0400
X-Greylist: delayed 545 seconds by postgrey-1.27 at vger.kernel.org; Sun, 10 May 2020 15:24:22 EDT
Received: from www25.zoner.fi (www25.zoner.fi [84.34.147.45])
        by mailscanner01.zoner.fi (Postfix) with ESMTPS id 4096440C20;
        Sun, 10 May 2020 22:15:05 +0300 (EEST)
Received: from mail.zoner.fi ([84.34.147.244])
        by www25.zoner.fi with esmtp (Exim 4.93.0.4)
        (envelope-from <lasse.collin@tukaani.org>)
        id 1jXrPv-0002j1-VD; Sun, 10 May 2020 22:15:15 +0300
Date:   Sun, 10 May 2020 22:15:07 +0300
From:   Lasse Collin <lasse.collin@tukaani.org>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Dongyang Zhan <zdyzztq@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Possible memory leak in unxz()
Message-ID: <20200510221507.53c65961@tukaani.org>
In-Reply-To: <daf2f87a-155c-0836-cf82-0b409b860d6d@infradead.org>
References: <CAFSR4csKYu95qak02h_sAH6Rpa13PUtHUZ+7Z7Vd7tmBQCNaqg@mail.gmail.com>
        <daf2f87a-155c-0836-cf82-0b409b860d6d@infradead.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 5/3/20 12:23 AM, Dongyang Zhan wrote:
> > I am a security researcher, my name is Dongyang Zhan. I found a
> > potential bug.

Thank you for looking for bugs!

On 2020-05-03 Randy Dunlap wrote:
> On 5/3/20 12:23 AM, Dongyang Zhan wrote:
> > /lib/decompress_unxz.c forgets to free the pointer 'in', when  the
> > statement if (fill == NULL && flush == NULL) is true.  
> 
> Adding xz contributor to email.
> 
> I think that you are correct. (I am looking at 5.7-rc4.)
> 
> However, I don't see any calls to __decompress() in the
> Linux kernel that pass a first argument of NULL, so while
> the code in unxz() could be fixed, we aren't currently leaking
> any memory AFAICT.

The supposedly leaked memory is allocated only when in == NULL, and
it's not freed when fill == NULL && flush == NULL. However, "in" and
"fill" must never be NULL at the same time if the caller is following
the decompress_fn API defined in include/linux/decompress/generic.h. So
there is no leak.

Some implementations of the API explicitly check for input == NULL &&
fill == NULL while some don't. E.g. decompress_unlz4.c checks it but in
addition it seems to also reject the case where input != NULL && fill
!= NULL. Perhaps that combination isn't used anywhere but it is allowed
by the API ("input" would be a temporary buffer for "fill"). I think
the decompress_fn API is more complex than it looks at glance.

-- 
Lasse Collin  |  IRC: Larhzu @ IRCnet & Freenode
