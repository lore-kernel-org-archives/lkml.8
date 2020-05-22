Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B35DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 04:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 401AD2073B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 04:22:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590121351;
	bh=/QRtu1E1NSMc8JFEnQUW1G07ufTt5859/T+sz2ryKl8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=W4jXf0JQhyV8TzanhtNkjFcEZGX7sje4Y520giLuWkz7GFr260He5HGOCSG/TlK+O
	 zuxM3H2ZQkZrTlI/kKAQxJfbT2cuuZ0SMUGirEATK/sablCF3gUye+M0/yMGKYsidA
	 zq/xQETOVFau5rq/mvGAK2tumgRmV8NQgzt1qc0I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbgEVEWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 00:22:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:40542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725921AbgEVEWa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 00:22:30 -0400
Received: from coco.lan (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D089206DD;
        Fri, 22 May 2020 04:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590121350;
        bh=/QRtu1E1NSMc8JFEnQUW1G07ufTt5859/T+sz2ryKl8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=D+MqBo/sT0ezZqNSR//NUhT+ll/VDzGsrO8hzrUSPFLlsXrqnkOkL2ysxYcbHb0Cd
         etx5nwkBuq61T5GBYBY+YvSGzkWCStjCywr7YVX5uaoNLmkx8+c3njI6OJKJkbxcj+
         gJDlB0HxzPGyjFQk8QYmAPU1ZFna2+2X9KDMbpDk=
Date:   Fri, 22 May 2020 06:22:25 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH 02/14] docs: add bus-virt-phys-mapping.txt to core-api
Message-ID: <20200522062225.6f73d811@coco.lan>
In-Reply-To: <20200515115321.6e00ba57@lwn.net>
References: <cover.1588345503.git.mchehab+huawei@kernel.org>
        <ccd32aa5231b0e235a555fdecc4c0d274e5a6161.1588345503.git.mchehab+huawei@kernel.org>
        <20200515115321.6e00ba57@lwn.net>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 15 May 2020 11:53:21 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> On Fri,  1 May 2020 17:37:46 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > This describes an old interface used prior the new DMA-API
> > interfaces. Add it to the core-api guide, just after the
> > DMA stuff.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  .../bus-virt-phys-mapping.rst}                                   | 0
> >  Documentation/core-api/index.rst                                 | 1 +
> >  2 files changed, 1 insertion(+)
> >  rename Documentation/{bus-virt-phys-mapping.txt => core-api/bus-virt-phys-mapping.rst} (100%)  
> 
> For this one, I think we should maybe just delete the file.  It contains a
> warning from *20 years ago* saying not to use it, and talks about
> functions like isa_readl() that haven't existed i the kernel for some
> time.  Is there any reason to keep dragging it around?

Except for "keeping it for historical reasons" (as mentioned at the
file), I don't see any reason why to keep it.

It might be useful if someone wants to port some OOT code based on
a legacy kernel.

Yet, if you prefer to just trash it, I'm ok with that.

Thanks,
Mauro
