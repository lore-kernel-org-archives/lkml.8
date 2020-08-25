Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8796C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 14:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A5E42072D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 14:39:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgHYOjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 10:39:53 -0400
Received: from netrider.rowland.org ([192.131.102.5]:52555 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726186AbgHYOjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 10:39:47 -0400
Received: (qmail 367187 invoked by uid 1000); 25 Aug 2020 10:39:46 -0400
Date:   Tue, 25 Aug 2020 10:39:46 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Himadri Pandya <himadrispandya@gmail.com>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        USB list <linux-usb@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH] net: usb: Fix uninit-was-stored issue in asix_read_cmd()
Message-ID: <20200825143946.GA365901@rowland.harvard.edu>
References: <20200823082042.20816-1-himadrispandya@gmail.com>
 <CACT4Y+Y1TpqYowNXj+OTcQwH-7T4n6PtPPa4gDWkV-np5KhKAQ@mail.gmail.com>
 <20200823101924.GA3078429@kroah.com>
 <CACT4Y+YbDODLRFn8M5QcY4CazhpeCaunJnP_udXtAs0rYoASSg@mail.gmail.com>
 <20200823105808.GB87391@kroah.com>
 <CACT4Y+ZiZQK8WBre9E4777NPaRK4UDOeZOeMZOQC=5tDsDu23A@mail.gmail.com>
 <20200825065135.GA1316856@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825065135.GA1316856@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 08:51:35AM +0200, Greg Kroah-Hartman wrote:
> At first glance, I think this can all be cleaned up, but it will take a
> bit of tree-wide work.  I agree, we need a "read this message and error
> if the whole thing is not there", as well as a "send this message and
> error if the whole thing was not sent", and also a way to handle
> stack-provided data, which seems to be the primary reason subsystems
> wrap this call (they want to make it easier on their drivers to use it.)
> 
> Let me think about this in more detail, but maybe something like:
> 	usb_control_msg_read()
> 	usb_control_msg_send()
> is a good first step (as the caller knows this) and stack provided data
> would be allowed, and it would return an error if the whole message was
> not read/sent properly.  That way we can start converting everything
> over to a sane, and checkable, api and remove a bunch of wrapper
> functions as well.

Suggestion: _read and _send are not a natural pair.  Consider instead
_read and _write.  _recv and _send don't feel right either, because it
both cases the host sends the control message -- the difference lies
in who sends the data.

Alan Stern
