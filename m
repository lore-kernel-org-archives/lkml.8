Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3DB1C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 19:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0F0920716
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 19:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599162447;
	bh=SztiM9bLtjK/S3/3zF0JjscGA8TaQ7JRlygw0bg5dWQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=v5ArDDKud59MGLfsMYZvKuYCSqHvJZ8rrpZZL/UaDSitOUYoG8+oMpPIY9KSDkJID
	 7N0HBeReuGtyhioJZLgyl/qGQU4d4OIpP76GQ4v96s3JNa8wCyjjSV8dzldPd2MO5A
	 MrECRPA8Qsv2AAC2dZOFocMKuQfrgBl2VYdW4WKY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbgICTr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 15:47:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:48718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728304AbgICTrW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 15:47:22 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37B9B20716;
        Thu,  3 Sep 2020 19:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599162441;
        bh=SztiM9bLtjK/S3/3zF0JjscGA8TaQ7JRlygw0bg5dWQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xIVtI7wIrf2GwuUc4ZV65x8fMXsPFo++tXgM0y00uN/5zth1jivqHxywy+g60BuIE
         AJWYzv4XXLMzrl2/ca6h/QL9HTN79KOWByYcEQGTsjuKW5KGpwa61iLxbByLXVdaoH
         306m76JXsc0HHS68btrkEsCFe4LbxJR1y1BtdNDU=
Date:   Thu, 3 Sep 2020 12:47:19 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jiri Pirko <jiri@resnulli.us>
Cc:     Moshe Shemesh <moshe@nvidia.com>,
        Moshe Shemesh <moshe@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next RFC v3 01/14] devlink: Add reload action option
 to devlink reload command
Message-ID: <20200903124719.75325f0c@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200903055729.GB2997@nanopsycho.orion>
References: <1598801254-27764-1-git-send-email-moshe@mellanox.com>
        <1598801254-27764-2-git-send-email-moshe@mellanox.com>
        <20200831121501.GD3794@nanopsycho.orion>
        <9fffbe80-9a2a-33de-2e11-24be34648686@nvidia.com>
        <20200902094627.GB2568@nanopsycho>
        <20200902083025.43407d8f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <20200903055729.GB2997@nanopsycho.orion>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Sep 2020 07:57:29 +0200 Jiri Pirko wrote:
> Wed, Sep 02, 2020 at 05:30:25PM CEST, kuba@kernel.org wrote:
> >On Wed, 2 Sep 2020 11:46:27 +0200 Jiri Pirko wrote:  
> >> >? Do we need such change there too or keep it as is, each action by itself
> >> >and return what was performed ?    
> >> 
> >> Well, I don't know. User asks for X, X should be performed, not Y or Z.
> >> So perhaps the return value is not needed.
> >> Just driver advertizes it supports X, Y, Z and the users says:
> >> 1) do X, driver does X
> >> 2) do Y, driver does Y
> >> 3) do Z, driver does Z
> >> [
> >> I think this kindof circles back to the original proposal...  
> >
> >Why? User does not care if you activate new devlink params when
> >activating new firmware. Trust me. So why make the user figure out
> >which of all possible reset option they should select? If there is 
> >a legitimate use case to limit what is reset - it should be handled
> >by a separate negative attribute, like --live which says don't reset
> >anything.  
> 
> I see. Okay. Could you please sum-up the interface as you propose it?

What I proposed on v1, pass requested actions as a bitfield, driver may
perform more actions, we can return performed actions in the response.

Then separate attribute to carry constraints for the request, like
--live.

I'd think the supported actions in devlink_ops would be fine as a
bitfield, too. Combinations are often hard to capture in static data.
