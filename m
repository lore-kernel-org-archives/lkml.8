Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0F0C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8808922D06
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 17:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbgHER31 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 13:29:27 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:36570 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728371AbgHER0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 13:26:39 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 4A4291C0BD2; Wed,  5 Aug 2020 19:26:31 +0200 (CEST)
Date:   Wed, 5 Aug 2020 19:26:30 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [TECH TOPIC] Planning code obsolescence
Message-ID: <20200805172629.GA1040@bug>
References: <CAK8P3a2PK_bC5=3wcWm43=y5xk-Dq5-fGPExJMnOrNfGfB1m1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2PK_bC5=3wcWm43=y5xk-Dq5-fGPExJMnOrNfGfB1m1A@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I have submitted the below as a topic for the linux/arch/* MC that Mike
> and I run, but I suppose it also makes sense to discuss it on the
> ksummit-discuss mailing list (cross-posted to linux-arch and lkml) as well
> even if we don't discuss it at the main ksummit track.

> * Latest kernel in which it was known to have worked

For some old hardware, I started collecting kernel version, .config and dmesg from
successful boots. github.com/pavelmachek, click on "missy".

Best regards,
									Pavel


(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
