Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C653C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0512821D7E
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731200AbgIIRMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 13:12:09 -0400
Received: from netrider.rowland.org ([192.131.102.5]:36189 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1730302AbgIIPdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:33:12 -0400
Received: (qmail 818535 invoked by uid 1000); 9 Sep 2020 10:11:09 -0400
Date:   Wed, 9 Sep 2020 10:11:09 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     gregkh@linuxfoundation.org, gustavoars@kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] usb: host: ehci-sched: Remove ununsed function
 tt_start_uframe()
Message-ID: <20200909141109.GC817244@rowland.harvard.edu>
References: <20200909134405.34036-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909134405.34036-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 09, 2020 at 09:44:05PM +0800, YueHaibing wrote:
> commit b35c5009bbf6 ("USB: EHCI: create per-TT bandwidth tables")
> left behind this, remove it.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Acked-by: Alan Stern <stern@rowland.harvard.edu>
