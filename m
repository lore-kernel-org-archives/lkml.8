Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E602C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 03:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C00A2145D
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 03:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599536966;
	bh=1JF9ErwwV+qLjfbssjhvOAA1nzkFV5n0GXMMuBk2Sa8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=MC/KWtNu07JlKmBxfQkA4X3IWOrVY0n0dj8Sy6KvvHPsTYmHnLwq9cUxhXBsQJvF/
	 9itJlnemuBF9vSuoVvK6XCm6lA2p2kSN09vy/LgPLf/JtBUbMwg7xSsi6qWc0qHNTz
	 dRhwtdoYGNaOhLtBCcxjyEnSifk+q24DsJk645lg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbgIHDtZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 23:49:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:43826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728327AbgIHDtY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 23:49:24 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CA1C2080A;
        Tue,  8 Sep 2020 03:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599536963;
        bh=1JF9ErwwV+qLjfbssjhvOAA1nzkFV5n0GXMMuBk2Sa8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kv1F3mm49dkxGSDp+x5x+JDeQbZIzZ6QhGmkLA17nzvHXRe/Tj3cgl1i++Gj2z1Hu
         ogXA/0F7v0FBxAWLSz4vxShs+rbOmhQd2poEqFncqcCW7rYWe2dgAjoWOtdw84GD3u
         wClHz0qCGdRmz9/87u+HV2NPmTPM9AgJnrBA1MYY=
Date:   Mon, 7 Sep 2020 20:49:21 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>
Cc:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the net-next tree
Message-ID: <20200907204921.130dd6ce@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200908130000.7d33d787@canb.auug.org.au>
References: <20200908130000.7d33d787@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Sep 2020 13:00:00 +1000 Stephen Rothwell wrote:
> Hi all,
> 
> After merging the net-next tree, today's linux-next build (powerpc
> ppc64_defconfig) produced this warning:
> 
> net/bridge/br_multicast.c: In function 'br_multicast_find_port':
> net/bridge/br_multicast.c:1818:21: warning: unused variable 'br' [-Wunused-variable]
>  1818 |  struct net_bridge *br = mp->br;
>       |                     ^~
> 
> Introduced by commit
> 
>   0436862e417e ("net: bridge: mcast: support for IGMPv3/MLDv2 ALLOW_NEW_SOURCES report")
> 
> Maybe turning mlock_dereference into a static inline function would help.

Or perhaps provide a better definition of whatever is making the
reference disappear? RCU_LOCKDEP_WARN()?

Thanks for the report!
