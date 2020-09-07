Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86108C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:31:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55A0C20757
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730604AbgIGQbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:31:11 -0400
Received: from netrider.rowland.org ([192.131.102.5]:57643 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1729815AbgIGOY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 10:24:28 -0400
Received: (qmail 762519 invoked by uid 1000); 7 Sep 2020 10:24:27 -0400
Date:   Mon, 7 Sep 2020 10:24:27 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     himadrispandya@gmail.com, dvyukov@google.com,
        linux-usb@vger.kernel.org, perex@perex.cz, tiwai@suse.com,
        linux-kernel@vger.kernel.org, marcel@holtmann.org,
        johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        alsa-devel@alsa-project.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Eli Billauer <eli.billauer@gmail.com>,
        Emiliano Ingrassia <ingrassia@epigenesys.com>,
        Alexander Tsoy <alexander@tsoy.me>,
        "Geoffrey D. Bennett" <g@b4.vu>, Jussi Laako <jussi@sonarnerd.net>,
        Nick Kossifidis <mickflemm@gmail.com>,
        Dmitry Panchenko <dmitry@d-systems.ee>,
        Chris Wulff <crwulff@gmail.com>,
        Jesus Ramos <jesus-ramos@live.com>
Subject: Re: [PATCH 01/10] USB: move snd_usb_pipe_sanity_check into the USB
 core
Message-ID: <20200907142427.GB762136@rowland.harvard.edu>
References: <20200902110115.1994491-1-gregkh@linuxfoundation.org>
 <20200902110115.1994491-2-gregkh@linuxfoundation.org>
 <20200903004553.GA642955@rowland.harvard.edu>
 <20200903073230.GA162335@kroah.com>
 <20200907141634.GA3733019@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907141634.GA3733019@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 04:16:34PM +0200, Greg Kroah-Hartman wrote:
> On Thu, Sep 03, 2020 at 09:32:30AM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Sep 02, 2020 at 08:45:53PM -0400, Alan Stern wrote:

> > > Since this routine is used in only one place in the entire kernel, you 
> > > might as well inline the code there and get rid of the function 
> > > entirely.
> > 
> > Good idea, will do.
> 
> No, wait, the USB sound drivers call it a lot, so it needs to stick
> around for now until we clean that up.

Argh.  I must have run "git grep" from within drivers/usb/core.  My 
mistake.

Alan Stern
