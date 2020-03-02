Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF22EC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 13:37:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E3B121D56
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 13:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgCBNh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 08:37:58 -0500
Received: from sym2.noone.org ([178.63.92.236]:39072 "EHLO sym2.noone.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727702AbgCBNh6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 08:37:58 -0500
Received: by sym2.noone.org (Postfix, from userid 1002)
        id 48WLn00jDYzvjc1; Mon,  2 Mar 2020 14:37:55 +0100 (CET)
Date:   Mon, 2 Mar 2020 14:37:55 +0100
From:   Tobias Klauser <tklauser@distanz.ch>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jslaby@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] pty: define and set show_fdinfo only if procfs is
 enabled
Message-ID: <20200302133755.tne3x7tibad4vmiq@distanz.ch>
References: <20200302104954.2812-1-tklauser@distanz.ch>
 <20200302105153.GA39968@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302105153.GA39968@kroah.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-02 at 11:51:53 +0100, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> On Mon, Mar 02, 2020 at 11:49:53AM +0100, Tobias Klauser wrote:
> > Follow the pattern used with other *_show_fdinfo functions and only
> > define and use pty_show_fdinfo if CONFIG_PROC_FS is set.
> 
> if proc_fs is not set, it will not be used anyway, right?

Right, it should never get called.

> I'd rather keep #ifdef out of the .c files than add this.  How much
> memory does it save, and are you using a system without procfs that
> needs this savings?

The savings are marginal, so no I don't strictly need this. I just
figured all other *_show_fdinfo functions in the tree are #ifdef'ed in
the same way and it would be nice to be consistent.

Thanks
