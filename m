Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 748B1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59D3F207DD
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730315AbgFONWU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 09:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730024AbgFONWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 09:22:20 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF3FC061A0E;
        Mon, 15 Jun 2020 06:22:20 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 16D042BD;
        Mon, 15 Jun 2020 13:22:19 +0000 (UTC)
Date:   Mon, 15 Jun 2020 07:22:17 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Daniel Kiss <daniel.kiss@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] Documentation: fix malformed table in
 filesystems/proc.rst
Message-ID: <20200615072217.0e59ea63@lwn.net>
In-Reply-To: <a9634ff3-fc33-0d2b-959b-bd3dd79600bf@infradead.org>
References: <016e5a38-5289-9111-05bb-7d0aa0cce5a5@infradead.org>
        <20200615085305.275a7b24@coco.lan>
        <a9634ff3-fc33-0d2b-959b-bd3dd79600bf@infradead.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Jun 2020 23:54:26 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> On 6/14/20 11:53 PM, Mauro Carvalho Chehab wrote:
> > Em Sun, 14 Jun 2020 20:33:22 -0700
> > Randy Dunlap <rdunlap@infradead.org> escreveu:
> >   
> >> From: Randy Dunlap <rdunlap@infradead.org>
> >>
> >> Fix malformed table in "proc.rst" by dropping a needless hyphen ('-').
> >>
> >> Documentation/filesystems/proc.rst:548: WARNING: Malformed table.
> >> Text in column margin in table line 29.
> >>
> >> Fixes: 424037b77519 ("mm: smaps: Report arm64 guarded pages in smaps")
> >> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> >> Cc: Daniel Kiss <daniel.kiss@arm.com>
> >> Cc: Mark Brown <broonie@kernel.org>
> >> Cc: Catalin Marinas <catalin.marinas@arm.com>  
> > 
> > I submitted an identical patch on Jan, 3.   
> 
> OK. Well, that's disappointing IMHO.

Sorry if I have caused disappointment.

In any case, that's *June*, not January, that the patch was submitted.  I
didn't apply it because, since the problem didn't come through docs-next,
it didn't apply there.  Now that docs-next is caught up with 5.8-rc1 I can
apply such things again...

jon
