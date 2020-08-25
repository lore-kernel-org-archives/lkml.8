Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18F17C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 12:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFD6420767
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 12:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbgHYMuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 08:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729688AbgHYMuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 08:50:14 -0400
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22556C061574;
        Tue, 25 Aug 2020 05:50:14 -0700 (PDT)
Received: from uucp by ganesha.gnumonks.org with local-bsmtp (Exim 4.89)
        (envelope-from <laforge@gnumonks.org>)
        id 1kAYOq-0007MY-8y; Tue, 25 Aug 2020 14:50:04 +0200
Received: from laforge by localhost.localdomain with local (Exim 4.94)
        (envelope-from <laforge@gnumonks.org>)
        id 1kAYKw-00GSwf-7o; Tue, 25 Aug 2020 14:46:02 +0200
Date:   Tue, 25 Aug 2020 14:46:02 +0200
From:   Harald Welte <laforge@gnumonks.org>
To:     Kenneth Chan <kenneth.t.chan@gmail.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] panasonic-laptop: take over maintainership
Message-ID: <20200825124602.GZ3822842@nataraja>
References: <20200825101341.5699-1-kenneth.t.chan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825101341.5699-1-kenneth.t.chan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 06:13:41PM +0800, Kenneth Chan wrote:
> Take over maintaniership of panasonic-laptop from Harald Welte.
> 
> 
> Signed-off-by: Kenneth Chan <kenneth.t.chan@gmail.com>

Acked-by: Harald Welte <laforge@gnumonks.org>

-- 
- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.org/
============================================================================
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)
