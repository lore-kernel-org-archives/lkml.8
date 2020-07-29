Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51EB3C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 17:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38D0E2075D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 17:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgG2RGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 13:06:44 -0400
Received: from verein.lst.de ([213.95.11.211]:52991 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbgG2RGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 13:06:44 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 27EC368AFE; Wed, 29 Jul 2020 19:06:43 +0200 (CEST)
Date:   Wed, 29 Jul 2020 19:06:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 6/7] modules: return licensing information from
 find_symbol
Message-ID: <20200729170642.GB2279@lst.de>
References: <20200729062711.13016-1-hch@lst.de> <20200729062711.13016-7-hch@lst.de> <20200729164759.GA17594@linux-8ccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729164759.GA17594@linux-8ccs>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 06:48:00PM +0200, Jessica Yu wrote:
> Just a small nit. Most of module.c uses license rather than licence -
> could we unify the spelling to remain consistent? Sigh, American vs.
> British English.. :)

Sure, I can fix that up.
