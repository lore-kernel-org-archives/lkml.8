Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D463C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 17:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C989206DC
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 17:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="FoiVyEyj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729227AbgHKRUW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 13:20:22 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:13485 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729103AbgHKRUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 13:20:19 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4BR02n3kC7z2F;
        Tue, 11 Aug 2020 19:20:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1597166417; bh=F5nSKhsvjTUBtJwjPwtJQjJY6T+oLbmyqCMMSTuSdBk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FoiVyEyj9CRAC+t3ymS7qShiDnTaG8Zq9HkYLyOEhohmJMGhNBHjXAsBRazhzol6m
         eb1de1scOQrn5lk9V+rjZDLe1MFQ960476vCnJRUYUt3DGGRkLFTj2Opao0L+TisBP
         wzonj57r0yWtBz4vK1Rscq9+nvWkZxMgJCuySOcVpgMYLha/kznxDThD3eSmAKJikX
         UMVv47nQGrAWO/CfHBA50O6hpaXTn3+aDr2KMhZ//0lh/Rp4UzBmowb85DcW98LV3K
         dvqHzYd8vrIusRB3ZH81rNKzk3BCTg1ly2qGC9OFMotpPBF8pp6hs2UX0EbbapqNEX
         R8OBVRSk1YbwQ==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Tue, 11 Aug 2020 19:20:15 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Vladimir Zapolskiy <vz@mleia.com>
Subject: Re: [PATCH 1/7] regulator: push allocation in
 regulator_init_coupling() outside of lock
Message-ID: <20200811172015.GA21273@qmqm.qmqm.pl>
References: <cover.1597107682.git.mirq-linux@rere.qmqm.pl>
 <b305adf8bcde9417cdd5c9d84ef5ed99541f0e2c.1597107682.git.mirq-linux@rere.qmqm.pl>
 <0d61983a-ed11-e5c1-f2c8-954e5ae330f4@gmail.com>
 <b27219ff-6cd8-399b-5710-cb5c2d99b21f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b27219ff-6cd8-399b-5710-cb5c2d99b21f@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 07:27:43PM +0300, Dmitry Osipenko wrote:
> 11.08.2020 18:59, Dmitry Osipenko пишет:
> > 11.08.2020 04:07, Michał Mirosław пишет:
> >> Allocating memory with regulator_list_mutex held makes lockdep unhappy
> >> when memory pressure makes the system do fs_reclaim on eg. eMMC using
> >> a regulator. Push the lock inside regulator_init_coupling() after the
> >> allocation.
> > ...
> > 
> > Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> On the other hand, couldn't it be better to just remove taking the
> list_mutex from the regulator_lock_dependent()?
> 
> I think the list_mutex is only needed to protect from supply/couple
> regulator being removed during of the locking process, but maybe this is
> not something we should worry about?

This is what I would like to see in the end, but it requires more
thought, at least around interaction with regulator_resolve_coupling()
and the regulator removal.

Best Regards,
Michał Mirosław
