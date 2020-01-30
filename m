Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E91C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 15:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4A5A20678
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 15:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgA3PMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 10:12:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:41466 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726996AbgA3PMR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 10:12:17 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6CF3EB146;
        Thu, 30 Jan 2020 15:12:16 +0000 (UTC)
Date:   Thu, 30 Jan 2020 07:02:06 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Ilya Dryomov <idryomov@gmail.com>
Cc:     Ceph Development <ceph-devel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH] rbd: optimize barrier usage for Rmw atomic bitops
Message-ID: <20200130150206.gdqn3bspghd2xtwz@linux-p48b>
References: <20200129181253.24999-1-dave@stgolabs.net>
 <CAOi1vP-75uoBBsnX262WoVL_jNreiSgnGmtytDKcsUE==ny2Jw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAOi1vP-75uoBBsnX262WoVL_jNreiSgnGmtytDKcsUE==ny2Jw@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jan 2020, Ilya Dryomov wrote:

>I don't think these barriers are needed at all.  I'll remove them.

Even better, thanks.
