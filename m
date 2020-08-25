Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF898C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 18:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EF7E2076C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 18:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726580AbgHYSTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 14:19:38 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:38548 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgHYSTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 14:19:34 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 3FB271C0BB9; Tue, 25 Aug 2020 20:19:31 +0200 (CEST)
Date:   Tue, 25 Aug 2020 20:19:30 +0200
From:   Pavel Machek <pavel@denx.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 4.19 09/71] btrfs: sysfs: use NOFS for device creation
Message-ID: <20200825181930.GA989@bug>
References: <20200824082355.848475917@linuxfoundation.org>
 <20200824082356.348762357@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824082356.348762357@linuxfoundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> From: Josef Bacik <josef@toxicpanda.com>
> 
> Dave hit this splat during testing btrfs/078:

...

> CC: stable@vger.kernel.org # 4.14+

This commit is in mainline, as a47bd78d0c44621efb98b525d04d60dc4d1a79b0, but is not marked
as such.

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
