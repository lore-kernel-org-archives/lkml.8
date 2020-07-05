Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BC2C433E2
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 18:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70D4320708
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 18:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wowana.me header.i=@wowana.me header.b="Ye8SGNdc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgGESAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 14:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727856AbgGESAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 14:00:10 -0400
X-Greylist: delayed 564 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 05 Jul 2020 11:00:09 PDT
Received: from mx1.volatile.bz (mx1.volatile.bz [IPv6:2001:67c:2db8:301:138:0:101:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F2AC061794
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jul 2020 11:00:09 -0700 (PDT)
Received: from mahin.wowana.me (unknown [IPv6:2001:67c:2db8:301:1845::2])
        by mx1.volatile.bz (Postfix) with ESMTPSA id B94DF4E7;
        Sun,  5 Jul 2020 17:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wowana.me; s=default;
        t=1593971441; bh=bSmlbJyHSCXLfi+Y6gH6+D6+oj2SR366tyTPTaadWy4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References;
        b=Ye8SGNdcjLPDZsaSQcm65BclPp1Q4z1zdGR4HRjwcDJ+MQFHZDa53Jilbamfb8Wtw
         3XZunKgbB2GzDEcOsoWWXDz8y0DJMXU4SjyVGvluekEX0eVVauHG8NHqTaomq6Zq5R
         AC2DvGzMSPl42Sd9FAp9uRtjySWuCXzNShDb5TKY=
Date:   Sun, 5 Jul 2020 17:50:31 +0000
From:   opal hart <opal@wowana.me>
To:     Dave Airlie <airlied@gmail.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Chris Mason <clm@fb.clm>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        tech-board-discuss@lists.linuxfoundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>
Subject: Re: [Ksummit-discuss] [Tech-board-discuss] [PATCH] CodingStyle:
 Inclusive Terminology
Message-ID: <20200705175031.4d7fa711@mahin.wowana.me>
In-Reply-To: <CAPM=9tyjdzU-O2nAWFngGSE=aSfUsaRer9x3bk8hpyhCOX0Bew@mail.gmail.com>
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
        <1593897917.7058.11.camel@HansenPartnership.com>
        <CAPM=9tyjdzU-O2nAWFngGSE=aSfUsaRer9x3bk8hpyhCOX0Bew@mail.gmail.com>
Organization: Volatile
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Face: &TPnio^VF7_~k^se;yA:fep*U;:Kzv1Q3'cYEY/#q"NyebT}po2wD}dNr}JF,f?%"Dh}(dq1C(0[dS`.(SJ2CDil=W'B9>O7p^P-+|v6Tj}|EJg8.&>YXtniHyR:=nf1,HE(NWu#C.GW
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Jul 2020 09:39:29 +1000
Dave Airlie <airlied@gmail.com> wrote:

> I don't totally agree on that, because like the CoC discussion, people
> need concrete examples. People need reasons, saying simply "be
> inclusive" doesn't work.

Which people? because so far the only people I've seen take these
terminologies out of computing context, are those who are only voicing
their "concern" out of bad faith, as well as those who fall for the
concern-trolling bait. The meta-discussion serves to stir up noise and
waste time that's better spent on other things.

History pains, sure, but I believe it serves no justice to erase every
trace of bad things that happened in history. That includes use of
words tangentially related to such events.

-- 
wowaname <https://wowana.me/pgp.xht>
