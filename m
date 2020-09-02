Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF01C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F64220767
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599060724;
	bh=1yFSuoH/C7lnmRudCqwmn4PxNv6Wotrb39IdIF3mqF8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=MlFX7Folx/DTNy8oR0N+tA/XK6ICr8h2XPAYAhBDL4DdW5JEr+jHZKZaAULigYy0b
	 DK/uX2nWdEqPvcMXuyNZFaEmObLwfBhtp7jQe1aAMBel4pxVqEELiK9VpHffE6IDzW
	 n4mysR/RqJzGfFf7GxMne46DnOTxD7xMphIBAfCI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728291AbgIBPcD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:32:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:56342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726625AbgIBPa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:30:27 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AC1CA207D3;
        Wed,  2 Sep 2020 15:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599060627;
        bh=1yFSuoH/C7lnmRudCqwmn4PxNv6Wotrb39IdIF3mqF8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TAkKjmUb9ADt8b940JXfKW/NzoXeUaE+tXnHyz8gTVCnQnnYi8VhCJhM5wRuLPsx2
         ATM94eUjJrL5KbjR4uCcpIA/HAIdo6LP49EFLukgREoCjZd/RYIhfPR5fZ1jiMfKcj
         Hc5NT8QqrG3gkz7q8j7GGRUrLq2ZXVzoHffW3KDs=
Date:   Wed, 2 Sep 2020 08:30:25 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jiri Pirko <jiri@resnulli.us>
Cc:     Moshe Shemesh <moshe@nvidia.com>,
        Moshe Shemesh <moshe@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next RFC v3 01/14] devlink: Add reload action option
 to devlink reload command
Message-ID: <20200902083025.43407d8f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200902094627.GB2568@nanopsycho>
References: <1598801254-27764-1-git-send-email-moshe@mellanox.com>
        <1598801254-27764-2-git-send-email-moshe@mellanox.com>
        <20200831121501.GD3794@nanopsycho.orion>
        <9fffbe80-9a2a-33de-2e11-24be34648686@nvidia.com>
        <20200902094627.GB2568@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Sep 2020 11:46:27 +0200 Jiri Pirko wrote:
> >? Do we need such change there too or keep it as is, each action by itself
> >and return what was performed ?  
> 
> Well, I don't know. User asks for X, X should be performed, not Y or Z.
> So perhaps the return value is not needed.
> Just driver advertizes it supports X, Y, Z and the users says:
> 1) do X, driver does X
> 2) do Y, driver does Y
> 3) do Z, driver does Z
> [
> I think this kindof circles back to the original proposal...

Why? User does not care if you activate new devlink params when
activating new firmware. Trust me. So why make the user figure out
which of all possible reset option they should select? If there is 
a legitimate use case to limit what is reset - it should be handled
by a separate negative attribute, like --live which says don't reset
anything.
