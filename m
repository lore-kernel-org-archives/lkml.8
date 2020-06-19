Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37C4C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 18:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92BD52100A
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 18:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387556AbgFSSaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 14:30:03 -0400
Received: from smtprelay0024.hostedemail.com ([216.40.44.24]:45746 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731628AbgFSSaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 14:30:02 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id E136F181219B0;
        Fri, 19 Jun 2020 18:30:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: whip03_3f001d726e1b
X-Filterd-Recvd-Size: 1692
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Fri, 19 Jun 2020 18:30:00 +0000 (UTC)
Message-ID: <f6102c402ae3f4232aebf4e102953f21fdb86cf6.camel@perches.com>
Subject: Re: [PATCH 1/2] drivers: cdrom: fix all errors reported by
 checkpatch
From:   Joe Perches <joe@perches.com>
To:     Simao Gomes Viana <devel@superboring.dev>,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>
Date:   Fri, 19 Jun 2020 11:29:59 -0700
In-Reply-To: <20200619180834.8032-1-devel@superboring.dev>
References: <20200619180834.8032-1-devel@superboring.dev>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-06-19 at 20:08 +0200, Simao Gomes Viana wrote:
> This fixes all errors that scripts/checkpatch.pl
> reports about drivers/cdrom/*.c and a lot of warnings
> as well. I skipped warnings that I don't know whether
> fixing them will break anything.

This is too many changes in a single patch to verify
them easily.

If you really want to change this file, and it's likely
not particularly necessary, I suggest that you send a
patch series that where each patch individually does:

1: Horizontal whitespace only changes
   o Trim trailing whitespace
   o Add alignment whitespace
   o Add operator spacing whitespace
2: Vertical whitespace changes if any
3: Convert embedded assignments to multiple lines
4: Comment style updates

And whatever other specific style changes necessary
to properly and easily identify them as correct.


