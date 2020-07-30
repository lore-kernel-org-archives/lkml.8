Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C447C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 16:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82EA92082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 16:31:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729998AbgG3Qbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 12:31:46 -0400
Received: from verein.lst.de ([213.95.11.211]:56543 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726275AbgG3Qbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 12:31:46 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id B667468BEB; Thu, 30 Jul 2020 18:31:42 +0200 (CEST)
Date:   Thu, 30 Jul 2020 18:31:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 22/23] fs: default to generic_file_splice_read for
 files having ->read_iter
Message-ID: <20200730163142.GA22875@lst.de>
References: <20200707174801.4162712-1-hch@lst.de> <20200707174801.4162712-23-hch@lst.de> <20200730000544.GC1236929@ZenIV.linux.org.uk> <20200730070329.GB18653@lst.de> <20200730150826.GA1236603@ZenIV.linux.org.uk> <20200730152046.GA21192@lst.de> <20200730161701.GB1236603@ZenIV.linux.org.uk> <20200730162219.GC1236603@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730162219.GC1236603@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 05:22:19PM +0100, Al Viro wrote:
> FWIW, none of the dubious (and outright broken) cases I've found go anywhere
> near that.  And it definitely won't help tun/tap...

Then I'm missing something obvious - what is the problem with tun/tap?
