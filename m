Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F12C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 14:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EBC720772
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 14:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbgF1Oxo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 10:53:44 -0400
Received: from smtprelay0032.hostedemail.com ([216.40.44.32]:35450 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726090AbgF1Oxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 10:53:44 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id C1D57180A7A94;
        Sun, 28 Jun 2020 14:53:43 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: son96_2a15f4c26e67
X-Filterd-Recvd-Size: 1599
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Sun, 28 Jun 2020 14:53:42 +0000 (UTC)
Message-ID: <09010c9aa795a8dcbd4408ceb2a39ddc57c85037.camel@perches.com>
Subject: Re: [REPORT] False positive errors found while using
 scripts/checkpatch.pl
From:   Joe Perches <joe@perches.com>
To:     B K Karthik <bkkarthik@pesu.pes.edu>,
        Andy Whitcroft <apw@canonical.com>,
        linux-kernel@vger.kernel.org
Date:   Sun, 28 Jun 2020 07:53:41 -0700
In-Reply-To: <20200628140046.imqmf5vy2vvbwkzo@pesu-pes-edu>
References: <20200628140046.imqmf5vy2vvbwkzo@pesu-pes-edu>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-06-28 at 10:00 -0400, B K Karthik wrote:
> The following are reported while using checkpatch.pl on 
> drivers/staging/fbtft/fbtft-bus.c
> 
> ERROR: space prohibited before that close parenthesis ')'
> #65: FILE: drivers/staging/fbtft/fbtft-bus.c:65:
> +define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
> 
> ERROR: space prohibited before that close parenthesis ')'
> #67: FILE: drivers/staging/fbtft/fbtft-bus.c:67:
> +define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
> 
> These are false positives as correcting these issues breaks the build.

Thanks, there's no capability to recognize this in checkpatch.
checkpatch is not a compiler.

Perhaps a reasonable solution is to add a comment around the
macro uses that show it's an unusual case.



