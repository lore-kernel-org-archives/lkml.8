Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB6BFC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3BE92078C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 17:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgDTR1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 13:27:06 -0400
Received: from 216-12-86-13.cv.mvl.ntelos.net ([216.12.86.13]:44446 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgDTR1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 13:27:05 -0400
X-Greylist: delayed 915 seconds by postgrey-1.27 at vger.kernel.org; Mon, 20 Apr 2020 13:27:05 EDT
Date:   Mon, 20 Apr 2020 13:11:49 -0400
From:   Rich Felker <dalias@libc.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-sh@vger.kernel.org, ysato@users.sourceforge.jp,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH 1/2] sh: remove sh5 support
Message-ID: <20200420171149.GB11469@brightrain.aerifal.cx>
References: <20200420123844.3998746-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200420123844.3998746-1-arnd@arndb.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 02:38:43PM +0200, Arnd Bergmann wrote:
> sh5 never became a product and has probably never really worked.
> 
> Remove it by recursively deleting all associated Kconfig options
> and all corresponding files.
> 
> For review purposes, this leaves out the files that can now be
> removed, in particular

Thank you! I haven't reviewed this yet, but if others do before I get
to it I'm happy to go with their opinions. I've been wanting to get
this removed for a long time because cleaning out stuff that's not
used/useful makes it easier to see what needs to be done for sh2/3/4
(rest of DT conversion, mmu support for j-core).

Rich
