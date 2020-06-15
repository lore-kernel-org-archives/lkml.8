Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B11AEC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 854E5207DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 13:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592229284;
	bh=ohYD5YEEUkwR1cjJIWDxCNuJ78W5DcalNKlGQB+JmV8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=evh3O909wTc28gHaHh2f3bYqc3jFY8T0coxeYNQwylMpabVsTezR4HPJT42Gkumo5
	 7p6QY/dL64oXWo4SVBDr21xMjYxHrTlbVoObV6I8Ut0pmPa/iL5NzjjBXOs0VqnlxC
	 HF7+9Q8zbCxB3bVzmqZ+2HywLOIYWEv+RBSneJLo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730225AbgFONyn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 09:54:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:58614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729875AbgFONym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 09:54:42 -0400
Received: from coco.lan (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27470207DA;
        Mon, 15 Jun 2020 13:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592229281;
        bh=ohYD5YEEUkwR1cjJIWDxCNuJ78W5DcalNKlGQB+JmV8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Kv9C5jdlKXSmD9WL1j8JU5xrxwcuwUIlrqLeAgGClD2OunfhRm+4EiYtIIZu2TBKq
         y3GNAn3oP8me1vqanDbKOyJhCn5W30OoOmOPl9+O9QbhQsTZQ0DH7+OQ7zrXJaHzaA
         vgDrC4PCXafIDloESuFcpjaQQRXugHdSZCOZWUTM=
Date:   Mon, 15 Jun 2020 15:54:37 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Daniel Kiss <daniel.kiss@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] Documentation: fix malformed table in
 filesystems/proc.rst
Message-ID: <20200615155437.619facac@coco.lan>
In-Reply-To: <20200615072217.0e59ea63@lwn.net>
References: <016e5a38-5289-9111-05bb-7d0aa0cce5a5@infradead.org>
        <20200615085305.275a7b24@coco.lan>
        <a9634ff3-fc33-0d2b-959b-bd3dd79600bf@infradead.org>
        <20200615072217.0e59ea63@lwn.net>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 15 Jun 2020 07:22:17 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> On Sun, 14 Jun 2020 23:54:26 -0700
> Randy Dunlap <rdunlap@infradead.org> wrote:
> 
> > On 6/14/20 11:53 PM, Mauro Carvalho Chehab wrote:  
> > > Em Sun, 14 Jun 2020 20:33:22 -0700
> > > Randy Dunlap <rdunlap@infradead.org> escreveu:
> > >     
> > >> From: Randy Dunlap <rdunlap@infradead.org>
> > >>
> > >> Fix malformed table in "proc.rst" by dropping a needless hyphen ('-').
> > >>
> > >> Documentation/filesystems/proc.rst:548: WARNING: Malformed table.
> > >> Text in column margin in table line 29.
> > >>
> > >> Fixes: 424037b77519 ("mm: smaps: Report arm64 guarded pages in smaps")
> > >> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> > >> Cc: Daniel Kiss <daniel.kiss@arm.com>
> > >> Cc: Mark Brown <broonie@kernel.org>
> > >> Cc: Catalin Marinas <catalin.marinas@arm.com>    
> > > 
> > > I submitted an identical patch on Jan, 3.     
> > 
> > OK. Well, that's disappointing IMHO.  
> 
> Sorry if I have caused disappointment.
> 
> In any case, that's *June*, not January,

Sorry for the typo! Yeah, I meant *June*. 

> In any case, that's *June*, not January, that the patch was submitted.  I
> didn't apply it because, since the problem didn't come through docs-next,
> it didn't apply there.  Now that docs-next is caught up with 5.8-rc1 I can
> apply such things again...

Yeah, those malformed table are very likely due to merge conflicts on 
patches for v5.8.

Thanks,
Mauro
