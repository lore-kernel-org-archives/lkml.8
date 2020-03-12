Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC734C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 20:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76F222071C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 20:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584046100;
	bh=ZI4Bg1MD+pI9PXRwSGVnZabYq2MtwwKRuB4sTOUbi7k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=YdujHxE8nFSXITmL9wN0mNnlU6ORFgz2Ssz0v49rsvuj7Eh6HvduHafWA/NFHoC6c
	 tKxP0QK/+lAmoRrHsOlgSytSXf9bI3V7cuVwurSOE4BtJ3LNJLKgAy6daLEYmcD7ab
	 /3oJbyOyxkHzUyiPrQtawiEuz2FNaxl03qjBPHbA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgCLUsT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 16:48:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:38318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726312AbgCLUsT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 16:48:19 -0400
Received: from kicinski-fedora-PC1C0HJN (unknown [163.114.132.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 066ED205F4;
        Thu, 12 Mar 2020 20:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584046098;
        bh=ZI4Bg1MD+pI9PXRwSGVnZabYq2MtwwKRuB4sTOUbi7k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xDqPpAA5UC8+z7uHh9c3GcR4cK1gUvkQ0bxidmGQ1Xd9RUbxc4/PQfpWm930NN0uY
         R5k+NilTRNzRB5TQrMcUs6PwGVBtfDOxbjeBr2rH93llJDVSqhyaf1tK8yDikvSeVq
         K6l84s0xQFeq4p4lNhmA5AZ3bFnvh+R4YVeaRoY0=
Date:   Thu, 12 Mar 2020 13:48:15 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 10/15] ethtool: provide ring sizes with
 RINGS_GET request
Message-ID: <20200312134815.6d9372d6@kicinski-fedora-PC1C0HJN>
In-Reply-To: <9a21d15cfd2453fd594be39a1e8a3416e0973bab.1584043144.git.mkubecek@suse.cz>
References: <cover.1584043144.git.mkubecek@suse.cz>
        <9a21d15cfd2453fd594be39a1e8a3416e0973bab.1584043144.git.mkubecek@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Mar 2020 21:08:23 +0100 (CET) Michal Kubecek wrote:
> Implement RINGS_GET request to get ring sizes of a network device. These
> are traditionally available via ETHTOOL_GRINGPARAM ioctl request.
> 
> Omit attributes for ring types which are not supported by driver or device
> (zero reported for maximum).
> 
> v2: (all suggested by Jakub Kicinski)
>   - minor cleanup in rings_prepare_data()
>   - more descriptive rings_reply_size()
>   - omit attributes with zero max size
> 
> Signed-off-by: Michal Kubecek <mkubecek@suse.cz>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
