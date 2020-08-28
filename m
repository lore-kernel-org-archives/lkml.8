Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB85C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 10:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FE7620B80
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 10:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598612345;
	bh=rjZypWluC3Z+0CKZrQYlk1u8h96BQiwRSfDDFzLsSrY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=JDPXblYg1DCT5bnHonp0F2fEvNC5q+DP/DxunLK7qzgFdh9RU90bkfZjtUH/o1OJh
	 /YdxkyS1XvAVeF9ZS7aHmO9J4zg0ljEjaQcQsATrgxHbopRhxVKFlVBlobocMRXoQP
	 sjGa4GZWLvq6lVL5Ym3atGgtaCoIldojTuHgScyk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbgH1K66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 06:58:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:38748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728709AbgH1K4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 06:56:38 -0400
Received: from coco.lan (ip5f5ad5b5.dynamic.kabel-deutschland.de [95.90.213.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3A50212CC;
        Fri, 28 Aug 2020 10:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598612196;
        bh=rjZypWluC3Z+0CKZrQYlk1u8h96BQiwRSfDDFzLsSrY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vVBfArYz6PjmjeUtkP6jFnF8y1EU1esU5tYJuMtNILCjafM0mFVvXDDLE2kXQUt6u
         MMC7GBhrMZ1wtVwLQwIKPH9AmfuYeeJU8lhXbRzCKyNanzqu8gh00HsIUE3+nRz9lJ
         fxCw2QxA+YMScNZ3d754YN9k2rqHmqomEnXtmbL0=
Date:   Fri, 28 Aug 2020 12:56:31 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        linux-renesas-soc@vger.kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, sakari.ailus@iki.fi,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Niklas =?UTF-8?B?U8O2ZGVybHVuZA==?= 
        <niklas.soderlund@ragnatech.se>
Subject: Re: [PATCH] MAINTAINERS: Fix sort order for RDACM20
Message-ID: <20200828125631.4a95c2fa@coco.lan>
In-Reply-To: <bc0882a9-0479-acd9-1a3f-af286b9c8314@ideasonboard.com>
References: <20200716102552.1390223-1-kieran.bingham+renesas@ideasonboard.com>
        <bc0882a9-0479-acd9-1a3f-af286b9c8314@ideasonboard.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, 28 Aug 2020 10:57:11 +0100
Kieran Bingham <kieran.bingham@ideasonboard.com> escreveu:

> Hi Mauro,
> 
> I see the fixes branch is open now ... could you pick this one up
> please? Or do I need to send a pull request?

No need. Already picked it. Yet, something like that can be merged
via the normal tree. No need to apply it under fixes.

Regards,
Mauro
