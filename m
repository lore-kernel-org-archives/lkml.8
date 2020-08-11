Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C15CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 23:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DD9D2073E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 23:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgHKXrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 19:47:40 -0400
Received: from smtprelay0143.hostedemail.com ([216.40.44.143]:59418 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726143AbgHKXrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 19:47:39 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id E6ABC18027463;
        Tue, 11 Aug 2020 23:47:38 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: hose67_3c0d1e026fe6
X-Filterd-Recvd-Size: 1725
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Tue, 11 Aug 2020 23:47:37 +0000 (UTC)
Message-ID: <98383342041c87a8d50fe9cef486a687c50af248.camel@perches.com>
Subject: Re: [PATCH 0/3] mtd: lpddr: Fix bad logic bug in print_drs_error
From:   Joe Perches <joe@perches.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Date:   Tue, 11 Aug 2020 16:47:36 -0700
In-Reply-To: <cover.1588013366.git.gustavo@embeddedor.com>
References: <cover.1588013366.git.gustavo@embeddedor.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-04-27 at 14:00 -0500, Gustavo A. R. Silva wrote:
> Hi,
> 
> This series aims to fix a bad logic bug in print_drs_error, which is
> tagged for -stable.  The series also include some formatting fixups.

AFAICT: This series is still not applied to any tree.

Can someone please apply it?

https://lore.kernel.org/linux-mtd/cover.1588016644.git.gustavo@embeddedor.com/

> Thanks
> 
> Gustavo A. R. Silva (3):
>   mtd: lpddr: Fix bad logic in print_drs_error
>   mtd: lpddr: Replace printk with pr_notice
>   mtd: lpddr: Move function print_drs_error to lpddr_cmds.c
> 
>  drivers/mtd/lpddr/lpddr_cmds.c | 33 +++++++++++++++++++++++++++++++++
>  include/linux/mtd/pfow.h       | 32 --------------------------------
>  2 files changed, 33 insertions(+), 32 deletions(-)
> 

