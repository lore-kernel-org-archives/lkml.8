Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 800CFC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 20:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66CD7208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 20:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgGaULx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 16:11:53 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:33977 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgGaULx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 16:11:53 -0400
Received: from localhost (50-39-163-217.bvtn.or.frontiernet.net [50.39.163.217])
        (Authenticated sender: josh@joshtriplett.org)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 671BF10000D;
        Fri, 31 Jul 2020 20:11:48 +0000 (UTC)
Date:   Fri, 31 Jul 2020 13:11:46 -0700
From:   josh@joshtriplett.org
To:     Christoph Hellwig <hch@lst.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: inherit TAINT_PROPRIETARY_MODULE v2
Message-ID: <20200731201146.GA34345@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730061027.29472-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> we've had a bug in our resolution of _GPL modules since day one, that
> is a module can claim to be GPL licensed and use _GPL exports, while
> it also depends on symbols from non-GPL modules.  This is used as a
> circumvention of the _GPL exports by using a small shim module using
> the _GPL exports and the other functionality.

This looks great. You might also consider doing the reverse: if a module
imports any EXPORT_SYMBOL_GPL symbols, any symbols that module in turn
exports shouldn't be importable by any module that doesn't explicitly
claim to be GPL-compatible. Effectively, if a module imports any
EXPORT_SYMBOL_GPL symbols, all of its exported symbols would then be
treated as EXPORT_SYMBOL_GPL.

This would catch the case of attempting to "wrap" EXPORT_SYMBOL_GPL
symbols in the other direction, by re-exporting the same or similar
functions to another module. (This would help catch mistakes, not just
intentional malice.)

- Josh Triplett
