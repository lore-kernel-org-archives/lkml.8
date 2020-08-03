Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E212C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5443207FC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbgHCVgN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 17:36:13 -0400
Received: from ms.lwn.net ([45.79.88.28]:42968 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgHCVgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 17:36:13 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 545D12D3;
        Mon,  3 Aug 2020 21:36:13 +0000 (UTC)
Date:   Mon, 3 Aug 2020 15:36:12 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     <ksummit-discuss@lists.linuxfoundation.org>,
        "tech-board-discuss@lists.linuxfoundation.org\" <tech-board-discuss@lists.linuxfoundation.org>"@lwn.net
Subject: Linux Foundation 2020 Technical Advisory Board election: call for
 nominations
Message-ID: <20200803153612.24ef78d9@lwn.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The election for the Linux Foundation Technical Advisory Board (TAB) will
be held virtually during the 2020 Kernel Summit and Linux Plumbers
Conference, August 24-28 2020.  Nominations for candidates interested in
serving on the TAB are currently being sought.

The TAB serves as the interface between the kernel development community
and the Linux Foundation, advising the Foundation on kernel-related
matters, helping member companies learn to work with the community, and
working to resolve community-related problems before they get out of hand.
We also support the Code of Conduct committee in their mission.

Over the last year, matters tended to by the TAB include proposals for
developer workflow improvement, overseeing the Linux Plumbers Conference,
moving toward more inclusive terminology in the kernel, and more.  Minutes
from TAB meetings can be found here:

	https://git.kernel.org/pub/scm/docs/tab/tab.git/tree/minutes

The board has ten members, one of whom sits on the Linux Foundation board
of directors.  Half of the board (five members) is elected every year to
serve a two-year term.  The members whose terms are expiring this year are:

	Chris Mason (chair)
	Dan Williams
	Kees Cook
	Laura Abbott
	Olof Johansson

The remaining members' terms will expire in 2021:

	Greg Kroah-Hartman
	Jonathan Corbet
	Sasha Levin
	Steven Rostedt
	Ted Ts'o
	
Anyone is eligible to stand for election; simply send your nomination to:

	tech-board-discuss@lists.linux-foundation.org

With your nomination, please include a short (<= 200 words) candidate
statement focusing on why you are running and what you hope to accomplish
on the TAB. We will be collecting these statements and making them publicly
available.

The deadline for receiving nominations is 9:00AM GMT-4 (US/Eastern) on
August 24 (the first day of Kernel Summit). Due to the use of
electronic voting, this will be a hard deadline!

As always, please let us know if you have questions (the TAB can be reached
at tech-board@lists.linuxfoundation.org), and please do consider running.
