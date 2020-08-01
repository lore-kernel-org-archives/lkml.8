Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AAADC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 08:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF7E420716
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 08:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgHAIQh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 04:16:37 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:6145 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbgHAIQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 04:16:37 -0400
X-Originating-IP: 50.39.163.217
Received: from [127.0.0.1] (50-39-163-217.bvtn.or.frontiernet.net [50.39.163.217])
        (Authenticated sender: josh@joshtriplett.org)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id C7AFB240005;
        Sat,  1 Aug 2020 08:16:33 +0000 (UTC)
Date:   Sat, 01 Aug 2020 01:16:30 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     Christoph Hellwig <hch@lst.de>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: inherit TAINT_PROPRIETARY_MODULE v2
In-Reply-To: <20200801065308.GA1930@lst.de>
References: <20200730061027.29472-1-hch@lst.de> <20200731201146.GA34345@localhost> <20200801065308.GA1930@lst.de>
Message-ID: <10747512-3CA1-49BE-85CE-BA5C46C16E76@joshtriplett.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On July 31, 2020 11:53:08 PM PDT, Christoph Hellwig <hch@lst.de> wrote:
>[note: private reply now to start a flame fest with the usual suspects]

[You still CCed LKML.]

>On Fri, Jul 31, 2020 at 01:11:46PM -0700, josh@joshtriplett.org wrote:
>> Christoph Hellwig wrote:
>> > we've had a bug in our resolution of _GPL modules since day one, that
>> > is a module can claim to be GPL licensed and use _GPL exports, while
>> > it also depends on symbols from non-GPL modules.  This is used as a
>> > circumvention of the _GPL exports by using a small shim module using
>> > the _GPL exports and the other functionality.
>> 
>> This looks great. You might also consider doing the reverse: if a module
>> imports any EXPORT_SYMBOL_GPL symbols, any symbols that module in turn
>> exports shouldn't be importable by any module that doesn't explicitly
>> claim to be GPL-compatible. Effectively, if a module imports any
>> EXPORT_SYMBOL_GPL symbols, all of its exported symbols would then be
>> treated as EXPORT_SYMBOL_GPL.
>> 
>> This would catch the case of attempting to "wrap" EXPORT_SYMBOL_GPL
>> symbols in the other direction, by re-exporting the same or similar
>> functions to another module. (This would help catch mistakes, not just
>> intentional malice.)
>
>I'd personally 100% agree with that, but I'd rather clear it with Linus
>privately first.  This would basically make most of the usual
>modular subsystems unavailable to proprietary modules as all of them
>use _GPL driver core exports, and I suspect he'd cave into the screaming.

As a start, what about applying that logic specifically to out-of-tree modules? That would address the shim problem. The justification would be that in-tree modules have at least gone through some level of review on what they're exporting.

(Standard disclaimer: suggesting enhancements to the symbol licensing framework should not be taken as implicit endorsement of any legitimacy for non-GPL-compatible modules.)

