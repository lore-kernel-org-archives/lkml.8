Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83F7CC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 21:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B082207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 21:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594933566;
	bh=0OGp5jt38BwSDYZlDxWMbGbrMFb7svBskFO9ftJ6/ws=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=nIgWbb2u4AAZMrJe9V6SMKLrg6bvnsjMH7d/VbtbVgKhZ9uEw2+cZyl5kXJaSjD0m
	 EG0Pt2LxXanxUJwvrqega1ZX7waPchG2THtX87hO/iXJisKqcIdIkCTZkZ+l91EXft
	 CBm5aPB4TyoETJcOAHQf8EHE9Sm7CaRiHQ2S8sV8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgGPVGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 17:06:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:49680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbgGPVGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 17:06:04 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAA47207DD;
        Thu, 16 Jul 2020 21:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594933564;
        bh=0OGp5jt38BwSDYZlDxWMbGbrMFb7svBskFO9ftJ6/ws=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VYsCV73wVHMIzzLWtsqvUDlmUNY2qbo+diEhcLImfD+6+HhNdnsM2cyt8sPG4oAc2
         cjYwDgbfqEKMiokfkxCUsUpQX4c8F8M38E1OvRjFjtxXQCgem5FGuWUHX6O3oRJGpf
         8gftfLx7jQ3poOuMew58AXhuQHe5UoVpbdxpVMRs=
Date:   Thu, 16 Jul 2020 14:06:02 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Fugang Duan <fugang.duan@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Richard Cochran <richardcochran@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>
Subject: Re: [PATCH v3 net] net: fec: fix hardware time stamping by external
 devices
Message-ID: <20200716140602.2a23530b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <87a6zz9owa.fsf@osv.gnss.ru>
References: <20200706142616.25192-1-sorganov@gmail.com>
        <20200714162802.11926-1-sorganov@gmail.com>
        <20200716112432.127b9d99@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <87a6zz9owa.fsf@osv.gnss.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jul 2020 23:38:13 +0300 Sergey Organov wrote:
> > Applied, and added to the stable queue, thanks!  
> 
> Thanks, and I've also got a no-brainer patch that lets this bug fix
> compile as-is with older kernels, where there were no phy_has_hwtstamp()
> function. Dunno how to properly handle this. Here is the patch (on
> top of v4.9.146), just in case:

I see, I'll only add it to 5.7. By default we backport net fixes to
the two most recent releases, anyway. Could you send a patch that will 
work on 4.4 or 4.9 - 5.4 to Greg yourself once this hits Linus's tree
in a week or two?
