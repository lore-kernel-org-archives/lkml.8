Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0C6C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 20:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 929E922D02
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 20:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596488227;
	bh=ioAaLukKTrijk4ocD2pI0AsCHOBKhdMM0s3SVbC8gpI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=aInnGguK+5q3wu4+ZyYNhQOlXHh1L4vfFuDpmxpRyQr5Z2VUb7p8xHudv+b3tvz0j
	 E6IMToufrqSJCRUVI4Nkp9oVzYWD1bjrqQ6y+0Zt/VptjSJsmUDWZn3iflYWsMQ0aS
	 kjr1oeyI87THY/co6e21eYRsWvSg1OeXpO6chJIc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728705AbgHCU5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 16:57:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:36000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727003AbgHCU5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 16:57:05 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2961F22C9F;
        Mon,  3 Aug 2020 20:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596488225;
        bh=ioAaLukKTrijk4ocD2pI0AsCHOBKhdMM0s3SVbC8gpI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JqSxVqPbaU9vmBNgaPLSR58vvYbbd6M2DWvpdUfCASRgXmAWQEgl5H2tCqMavhOPw
         ywGoCWqsiG2Gm29GMcCALmE1pWLPhecxzsfdk8k8GIxr7s8//4u5t1qs9hVtzMbd1p
         9JMLAAg9VLrwzdnUZqoVGTOTTH6ovOneyGDYIPYE=
Date:   Mon, 3 Aug 2020 13:57:03 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jiri Pirko <jiri@resnulli.us>
Cc:     Moshe Shemesh <moshe@mellanox.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Jiri Pirko <jiri@mellanox.com>,
        Vasundhara Volam <vasundhara-v.volam@broadcom.com>
Subject: Re: [PATCH net-next RFC 01/13] devlink: Add reload level option to
 devlink reload command
Message-ID: <20200803135703.16967635@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200803141442.GB2290@nanopsycho>
References: <20200728135808.GC2207@nanopsycho>
        <464add44-3ab1-21b8-3dba-a88202350bb9@intel.com>
        <20200728114458.762b5396@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <d6fbfedd-9022-ff67-23ed-418607beecc2@intel.com>
        <20200728130653.7ce2f013@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <04f00024-758c-bc19-c187-49847c24a5a4@mellanox.com>
        <20200729140708.5f914c15@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <3352bd96-d10e-6961-079d-5c913a967513@mellanox.com>
        <20200730161101.48f42c5b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <0f2467fd-ee2e-1a51-f9c1-02f8a579d542@mellanox.com>
        <20200803141442.GB2290@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Aug 2020 16:14:42 +0200 Jiri Pirko wrote:
> >devlink dev reload [ net-ns-respawn { PID | NAME | ID } ] [ driver-param-init
> >] [ fw-activate [ --live] ]  
> 
> Jakub, why do you prefer to have another extra level-specific option
> "live"? I think it is clear to have it as a separate level. The behaviour
> of the operation is quite different.

I was trying to avoid having to provide a Cartesian product of
operation and system disruption level, if any other action can
be done "live" at some point.

But no strong feelings about that one.

Really, as long as there is no driver-specific defaults (or as 
little driver-specific anything as possible) and user actions 
are clearly expressed (fw-reset does not necessarily imply
fw-activation) - the API will be fine IMO.
