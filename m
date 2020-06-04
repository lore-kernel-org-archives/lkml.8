Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACC2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 15:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98CC820823
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 15:03:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729210AbgFDPDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 11:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728638AbgFDPDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 11:03:38 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0EEC08C5C0;
        Thu,  4 Jun 2020 08:03:38 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jgrP5-0033lc-U6; Thu, 04 Jun 2020 15:03:35 +0000
Date:   Thu, 4 Jun 2020 16:03:35 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        netdev@vger.kernel.org
Subject: Re: [PATCH RFC] uaccess: user_access_begin_after_access_ok()
Message-ID: <20200604150335.GG23230@ZenIV.linux.org.uk>
References: <20200602084257.134555-1-mst@redhat.com>
 <20200603014815.GR23230@ZenIV.linux.org.uk>
 <20200603011810-mutt-send-email-mst@kernel.org>
 <20200603165205.GU23230@ZenIV.linux.org.uk>
 <20200604054516-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604054516-mutt-send-email-mst@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 06:10:23AM -0400, Michael S. Tsirkin wrote:

> 	stac()
> 	for (i = 0; i < 64; ++i) {
> 	 get_user(flags, desc[i].flags)
unsafe_get_user(), please.
> 	 smp_rmb()
> 	 if (!(flags & VALID))
> 		break;
> 	 copy_from_user(&adesc[i], desc + i, sizeof adesc[i]);
... and that would raw_copy_from_user() (or unsafe_copy_from_user(),
for wrapper that would take a label to bugger off to)
> 	}
> 	clac()
