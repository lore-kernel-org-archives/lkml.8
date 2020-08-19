Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3822C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 00:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B47D82075E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 00:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597795815;
	bh=gIc/1QSGdJOTxbuS4FOF8Wzc4rCVAAIAQlMVG6PZujg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=RVjgGNZ6D3hlmrgPKqWcWKllQJewVgLQKt9PxJVRrNcMIKoXrZv4B8Y7LKP5dmDyn
	 ZpV/10P6URBoKjsMi07cmSqTcXKvaAfmsn0RstUZdEJ5M5xO2/2FKTPzyN024yVX4J
	 R2t2r9rW8tW0BXY0tC/u+1YMjDfZBAnhmtATY1UM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbgHSAKO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 20:10:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:37368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726698AbgHSAKN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 20:10:13 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4145F20709;
        Wed, 19 Aug 2020 00:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597795812;
        bh=gIc/1QSGdJOTxbuS4FOF8Wzc4rCVAAIAQlMVG6PZujg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=z21pevWHoJnYGD2YnEH6De6N5Uv/egoCH2DrAhTu1D2uVgErjjKoNnAd5cebQtyPo
         QokRdN7BbXy+KvF/UN9N6cANgMwgsgogpDG4kYAz6B8J6xsHncd2sOrfx0f3CnoQr5
         IJdTbDYSXIsTbX9IG3/UebV+K23AzfQu1eiJvzek=
Date:   Tue, 18 Aug 2020 17:10:10 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Moshe Shemesh <moshe@nvidia.com>
Cc:     Jiri Pirko <jiri@resnulli.us>, Moshe Shemesh <moshe@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jiri Pirko <jiri@mellanox.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next RFC v2 01/13] devlink: Add reload action option
 to devlink reload command
Message-ID: <20200818171010.11e4b615@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <3ed1115e-8b44-b398-55f2-cee94ef426fd@nvidia.com>
References: <1597657072-3130-1-git-send-email-moshe@mellanox.com>
        <1597657072-3130-2-git-send-email-moshe@mellanox.com>
        <20200817163612.GA2627@nanopsycho>
        <3ed1115e-8b44-b398-55f2-cee94ef426fd@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Aug 2020 12:10:36 +0300 Moshe Shemesh wrote:
> On 8/17/2020 7:36 PM, Jiri Pirko wrote:
> > Mon, Aug 17, 2020 at 11:37:40AM CEST, moshe@mellanox.com wrote:  
> >> Add devlink reload action to allow the user to request a specific reload
> >> action. The action parameter is optional, if not specified then devlink
> >> driver re-init action is used (backward compatible).
> >> Note that when required to do firmware activation some drivers may need
> >> to reload the driver. On the other hand some drivers may need to reset  
> > Sounds reasonable. I think it would be good to indicate that though. Not
> > sure how...  
> 
> Maybe counters on the actions done ? Actually such counters can be 
> useful on debug, knowing what reloads we had since driver was up.

Wouldn't we need to know all types of reset of drivers may do?

I think documenting this clearly should be sufficient.

A reset counter for the _requested_ reset type (fully maintained by
core), however - that may be useful. The question "why did this NIC
reset itself / why did the link just flap" comes up repeatedly.
