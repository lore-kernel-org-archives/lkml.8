Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE9C4C33CAA
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 14:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFCA920678
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 14:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729143AbgATOWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 09:22:20 -0500
Received: from mx2.suse.de ([195.135.220.15]:55564 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726942AbgATOWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 09:22:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 19BA7B077;
        Mon, 20 Jan 2020 14:22:18 +0000 (UTC)
Date:   Mon, 20 Jan 2020 15:22:17 +0100
From:   Jean Delvare <jdelvare@suse.de>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org,
        Wolfram Sang <wsa@the-dreams.de>,
        Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/26] docs: i2c: i2c-protocol: remove unneeded colons
 from table
Message-ID: <20200120152217.5f290971@endymion>
In-Reply-To: <20200120143852.02b2c185@endymion>
References: <20200105224006.10321-1-luca@lucaceresoli.net>
        <20200105225012.11701-1-luca@lucaceresoli.net>
        <20200105225012.11701-9-luca@lucaceresoli.net>
        <20200120143852.02b2c185@endymion>
Organization: SUSE Linux
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ah, actually...

On Mon, 20 Jan 2020 14:38:52 +0100, Jean Delvare wrote:
> On Sun,  5 Jan 2020 23:49:55 +0100, Luca Ceresoli wrote:
> > These colons are not needed: the columns already nicely separate the
> > symbold from their description. They are also inconsistently preceded by

... you have a typo there, s/symbold/symbols/.

> > whitespace.
> > 
> > Remove the colons completely to simplify and clean up.
> > 
> > Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> > ---
> >  Documentation/i2c/i2c-protocol.rst | 18 +++++++++---------
> >  1 file changed, 9 insertions(+), 9 deletions(-)
> > (...)  
> 
> Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support
