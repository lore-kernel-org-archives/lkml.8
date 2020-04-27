Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577E1C4CECC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 20:09:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A502206D9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 20:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgD0UJq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:09:46 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:49919 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgD0UJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 16:09:46 -0400
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 31D4620003;
        Mon, 27 Apr 2020 20:09:44 +0000 (UTC)
Date:   Mon, 27 Apr 2020 22:09:42 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, Joe Perches <joe@perches.com>
Subject: Re: [PATCH v2 3/3] mtd: lpddr: Move function print_drs_error to
 lpddr_cmds.c
Message-ID: <20200427220942.0bf6b851@xps13>
In-Reply-To: <e0063cbd65f3b47be1db34efc494ea3047634d88.1588016644.git.gustavo@embeddedor.com>
References: <cover.1588016644.git.gustavo@embeddedor.com>
        <e0063cbd65f3b47be1db34efc494ea3047634d88.1588016644.git.gustavo@embeddedor.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

"Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote on Mon, 27 Apr
2020 14:56:08 -0500:

> Function print_drs_error is only used in drivers/mtd/lpddr/lpddr_cmds.c
> so, better to move it there.
> 
> Also, notice that there's no need for inline as the function is used
> once.  Lastly, fix the following checkpatch warning:
> 
> WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
> +static void print_drs_error(unsigned dsr)
> 
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
> Changes in v2:
>  - Remove inline from print_drs_error and update changelog text,
>    accordingly.
> 

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miquèl
