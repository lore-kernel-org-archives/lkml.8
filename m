Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F00DC0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 23:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BC4E2074B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 23:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583968081;
	bh=mIDvbT395T9PcLGcQ6KRb4uh0b+8YxZmC7DZ0lz0z9k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=fGYocShB1oTumER7p+Jqa+LTh4NfJsSfyqP1pKHwnxD/uPUBi0X4XPzFpLgeSSfOc
	 ICPR0QeHq2NT9j1dQRSfnSRy2Dy7nFxur0HckHQ2u6xjxewESudUiKIkKTwFCy6a/0
	 vTHOViAt6cNcVDRs62zLKhCV0uTm1u0FOn4rOSIU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731477AbgCKXIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 19:08:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:34992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726194AbgCKXH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 19:07:59 -0400
Received: from kicinski-fedora-PC1C0HJN (unknown [163.114.132.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6BDD2074A;
        Wed, 11 Mar 2020 23:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583968079;
        bh=mIDvbT395T9PcLGcQ6KRb4uh0b+8YxZmC7DZ0lz0z9k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cjI4HeSPHugHZPP4u8BtUuVscx+iaCimCG5vpifg3sFUC8yIxuMmk53S4Cpirdh/Y
         SrvVfsMEqR+h4z/ZSfPwLBw3WStOFe7YaBALAt+QJ4OiRP86iqrjH4TWFjjRpUvK6L
         wB/L3Ma0QPsvxge2MVzzJuqPcv/EXbkdFOrw24OU=
Date:   Wed, 11 Mar 2020 16:07:57 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 08/15] ethtool: set device private flags with
 PRIVFLAGS_SET request
Message-ID: <20200311160757.3e5c1395@kicinski-fedora-PC1C0HJN>
In-Reply-To: <ee141a0bfbe5f6fe1ada537e0f0f1001100eaee5.1583962006.git.mkubecek@suse.cz>
References: <cover.1583962006.git.mkubecek@suse.cz>
        <ee141a0bfbe5f6fe1ada537e0f0f1001100eaee5.1583962006.git.mkubecek@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Mar 2020 22:40:43 +0100 (CET) Michal Kubecek wrote:
> Implement PRIVFLAGS_SET netlink request to set private flags of a network
> device. These are traditionally set with ETHTOOL_SPFLAGS ioctl request.
> 
> Signed-off-by: Michal Kubecek <mkubecek@suse.cz>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>
