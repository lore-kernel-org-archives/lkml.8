Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 360BCC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FA342098B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731384AbgIAQTs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:19:48 -0400
Received: from netrider.rowland.org ([192.131.102.5]:58917 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1732019AbgIAQSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 12:18:50 -0400
Received: (qmail 592026 invoked by uid 1000); 1 Sep 2020 12:18:48 -0400
Date:   Tue, 1 Sep 2020 12:18:48 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     gregkh@linuxfoundation.org, erkka.talvitie@vincit.fi,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC RESEND PATCH 0/1] USB EHCI: repeated resets on full and low
 speed devices
Message-ID: <20200901161848.GF587030@rowland.harvard.edu>
References: <cover.1598887346.git.khalid@gonehiking.org>
 <20200901023117.GD571008@rowland.harvard.edu>
 <0ec31395-56d9-c490-4e42-1c27bbc69df3@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ec31395-56d9-c490-4e42-1c27bbc69df3@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 08:51:14AM -0700, Khalid Aziz wrote:
> >> At the time of failure, when we reach this conditional, token is
> >> either 0x80408d46 or 0x408d46 which means following bits are set:
> >>
> >> QTD_STS_STS, QTD_STS_MMF, QTD_STS_HALT, QTD_IOC, QTD_TOGGLE
> >>
> >> and 
> >>
> >>         QTD_PID = 1
> >>         QTD_CERR = 3
> >>         QTD_LENGTH = 0x40 (64)
> >>
> >> This causes  the branch "(token & QTD_STS_MMF) && (QTD_PID(token) ==
> >> PID_CODE_IN" to be taken and qtd_copy_status() returns EPROTO. This
> >> return value in qh_completions() results in ehci_clear_tt_buffer()
> >> being called:

I didn't mention this before, but that combination of events doesn't 
make sense.  The MMF bit is supposed to get set only for queue heads in 
the periodic list, that is, only for interrupt transactions.  But 
ehci_clear_tt_buffer() doesn't do anything for interrupt endpoints; it 
tests specifically for that right at the start.

Maybe your EHCI controller is setting the MMF bit when it shouldn't.  
The usbmon output will help clear this up.

Or maybe the hubs you are testing don't work right.  That's the only 
reason I can think of for the failures you see with the USB-3 
controller; the way it operates is very different from the way EHCI 
does.

Alan Stern
