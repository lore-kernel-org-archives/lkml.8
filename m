Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3BDC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 11:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46C482067C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 11:00:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbgHQK72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 06:59:28 -0400
Received: from muru.com ([72.249.23.125]:40508 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728301AbgHQK7A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 06:59:00 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 26A7980A3;
        Mon, 17 Aug 2020 10:58:58 +0000 (UTC)
Date:   Mon, 17 Aug 2020 13:59:26 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>, od@zcrc.me,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] usb: musb: Fix runtime PM race in musb_queue_resume_work
Message-ID: <20200817105926.GF2994@atomide.com>
References: <20200809125359.31025-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200809125359.31025-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Paul Cercueil <paul@crapouillou.net> [200809 12:54]:
> musb_queue_resume_work() would call the provided callback if the runtime
> PM status was 'active'. Otherwise, it would enqueue the request if the
> hardware was still suspended (musb->is_runtime_suspended is true).
> 
> This causes a race with the runtime PM handlers, as it is possible to be
> in the case where the runtime PM status is not yet 'active', but the
> hardware has been awaken (PM resume function has been called).
> 
> When hitting the race, the resume work was not enqueued, which probably
> triggered other bugs further down the stack. For instance, a telnet
> connection on Ingenic SoCs would result in a 50/50 chance of a
> segmentation fault somewhere in the musb code.
> 
> Rework the code so that either we call the callback directly if
> (musb->is_runtime_suspended == 0), or enqueue the query otherwise.

Yes we should use is_runtime_suspended, thanks for fixing it.
Things still work for me so:

Reviewed-by: Tony Lindgren <tony@atomide.com>
Tested-by: Tony Lindgren <tony@atomide.com>
