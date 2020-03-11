Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB30CC0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 23:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A76422074E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 23:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583967813;
	bh=nerGpGSqb1bVgXz3AXLEREZpxZhw40DVrFu3hBlsHY8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=2UQMGXvh925WNVNyWzZ2Ls9n7Q1pigvoQ4kZ6T3d5iZSm+EH9qXSDv697CQKwfYca
	 wxvHQyUvJ9uKerMsaP3zp0KH3xjiFOA4pUhzQ2iDWY1qbx9t+XAX/orKexLaTVKRR5
	 SmvXCXqqymPLNTIalDqtTBuWfgnh8fUbmBQMnhfQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731457AbgCKXDc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 19:03:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:34100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729739AbgCKXDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 19:03:32 -0400
Received: from kicinski-fedora-PC1C0HJN (unknown [163.114.132.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EA6D20691;
        Wed, 11 Mar 2020 23:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583967811;
        bh=nerGpGSqb1bVgXz3AXLEREZpxZhw40DVrFu3hBlsHY8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LSLZLPiWRpeQEuw7cm5vdjTNxSwO7A6zCYhY4FC99HB3sCW087atXm4mIkCzF24CP
         a3I7VL2xqCbr8hdK3dWabVKauziGWNxh5qkM90FDTo2RNaj1gvcA8TD5lb4ATfZOEY
         pzoqWY7HJo3naTqTR5v8J7ybcFNHbE4D5BGTP5x8=
Date:   Wed, 11 Mar 2020 16:03:29 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 07/15] ethtool: provide private flags with
 PRIVFLAGS_GET request
Message-ID: <20200311160329.7f838b8a@kicinski-fedora-PC1C0HJN>
In-Reply-To: <1658adf064ca5d7d17bfb3c40f5dc88ea83295b1.1583962006.git.mkubecek@suse.cz>
References: <cover.1583962006.git.mkubecek@suse.cz>
        <1658adf064ca5d7d17bfb3c40f5dc88ea83295b1.1583962006.git.mkubecek@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Mar 2020 22:40:38 +0100 (CET) Michal Kubecek wrote:
> Implement PRIVFLAGS_GET request to get private flags for a network device.
> These are traditionally available via ETHTOOL_GPFLAGS ioctl request.
> 
> Signed-off-by: Michal Kubecek <mkubecek@suse.cz>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
