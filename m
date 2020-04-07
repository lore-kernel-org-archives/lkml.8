Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF208C2BA16
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 06:31:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CB3F2072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 06:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgDGGbo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 02:31:44 -0400
Received: from nautica.notk.org ([91.121.71.147]:47617 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbgDGGbo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 02:31:44 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 4A516C009; Tue,  7 Apr 2020 08:31:42 +0200 (CEST)
Date:   Tue, 7 Apr 2020 08:31:27 +0200
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     L29Ah <l29ah@cock.li>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net
Subject: Re: [GIT PULL] 9p update for 5.7
Message-ID: <20200407063127.GA30642@nautica>
References: <20200406110702.GA13469@nautica>
 <CAHk-=whVEPEsKhU4w9y_sjbg=4yYHKDfgzrpFdy=-f9j+jTO3w@mail.gmail.com>
 <20200406164057.GA18312@nautica>
 <20200407021626.cd3wwbg7ayiwt4ry@l29ah-x201.l29ah-x201>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200407021626.cd3wwbg7ayiwt4ry@l29ah-x201.l29ah-x201>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

L29Ah wrote on Tue, Apr 07, 2020:
> In fact i would prefer disabling the full reads unconditionally, but
> AFAIR some userspace programs might interpret a short read as EOF (and
> also would need to check the logic that motivated the kernel-side
> looping).

Willy is correct there we can't just do that, way too many applications
would break.

I think O_NONBLOCK on regular files is a good compromise, let's not go
overboard :)

-- 
Dominique
