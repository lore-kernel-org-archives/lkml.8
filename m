Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F9FAC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 07:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 644932076D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 07:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbgFFH5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 03:57:42 -0400
Received: from verein.lst.de ([213.95.11.211]:60780 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgFFH5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 03:57:42 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0D57868AFE; Sat,  6 Jun 2020 09:57:40 +0200 (CEST)
Date:   Sat, 6 Jun 2020 09:57:39 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Subject: Re: kprobes string reading broken on s390
Message-ID: <20200606075739.GA21557@lst.de>
References: <20200605110533.GA57038@tuxmaker.boeblingen.de.ibm.com> <20200605132541.GB31829@lst.de> <20200606015806.c8f9cafc3c6c52b8854d6cd3@kernel.org> <20200605174433.GA82185@tuxmaker.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605174433.GA82185@tuxmaker.boeblingen.de.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 05, 2020 at 07:44:33PM +0200, Sven Schnelle wrote:
> > Thanks for fixing!
> > This report can be a good changelog.
> > Please resend it with Fixed tag as Christoph said.
> 
> Which SHA1 should the Fixes tag carry? The one from linux-next?

Oh, I thought it had hit mainline already.  If this is just in -mm
there is no need for a fixes tag, just send it to Andrew with the
acks from Masami and me.

Acked-by: Christoph Hellwig <hch@lst.de>
