Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E2BC3524A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 06:06:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B3042084E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 06:06:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbgBDGG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 01:06:57 -0500
Received: from verein.lst.de ([213.95.11.211]:59366 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726688AbgBDGG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 01:06:56 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id CB75B68BFE; Tue,  4 Feb 2020 07:06:54 +0100 (CET)
Date:   Tue, 4 Feb 2020 07:06:54 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Valdis =?utf-8?Q?Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>
Cc:     Namjae Jeon <linkinjeon@gmail.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        hch@lst.de, sj1557.seo@samsung.com, pali.rohar@gmail.com,
        arnd@arndb.de, namjae.jeon@samsung.com, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] exfat: update file system parameter handling
Message-ID: <20200204060654.GB31675@lst.de>
References: <297144.1580786668@turing-police>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <297144.1580786668@turing-police>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2020 at 10:24:28PM -0500, Valdis Klētnieks wrote:
> Al Viro recently reworked the way file system parameters are handled
> Update super.c to work with it in linux-next 20200203.
> 
> Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
