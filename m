Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33047C0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 22:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25C1E2074B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 22:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583967397;
	bh=0hcCwLr76Y1HrvSf0R8uI0eUyHi0rxL8GhpK18dgQEo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=a4MLGrS3aEed1mpZHT1Ca70FVchYMIUF2a8Kw4qm95EhxZy+uw1f9nw01qEVWDotW
	 io9eznlolZ4LvM/e6Fv4JN5eQBA5WRAhqcAF2URxlnfcF3M08QxAooPhA5ZZ/qcl1Q
	 XwfhB9pZKbi+6PVHM+D80DH8EUKpsunEAGoqG9DA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731442AbgCKW4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 18:56:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:57364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731369AbgCKW4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 18:56:35 -0400
Received: from kicinski-fedora-PC1C0HJN (unknown [163.114.132.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7C8520749;
        Wed, 11 Mar 2020 22:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583967395;
        bh=0hcCwLr76Y1HrvSf0R8uI0eUyHi0rxL8GhpK18dgQEo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tPnsfiDyJsW5WEF+WkzlAvGp57GzDEn/TDYqZBZ3gTLb/qSlNOHKYVHPzTPMBApJ/
         QZa0LyrM9NUFT47l7Q6v/KzMMSW2s+mZuWYC2TINpdwWT1HAN75hWY4PtQ3DjL3SS4
         YSebbhUJmj8KOx68C1iWfC9FpGM/2ZutN18Vx4v4=
Date:   Wed, 11 Mar 2020 15:56:32 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        Jiri Pirko <jiri@resnulli.us>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        John Linville <linville@tuxdriver.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 05/15] ethtool: set netdev features with
 FEATURES_SET request
Message-ID: <20200311155632.4521c71b@kicinski-fedora-PC1C0HJN>
In-Reply-To: <4fda0f27da984254c3df3c9e58751134967036c9.1583962006.git.mkubecek@suse.cz>
References: <cover.1583962006.git.mkubecek@suse.cz>
        <4fda0f27da984254c3df3c9e58751134967036c9.1583962006.git.mkubecek@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Mar 2020 22:40:28 +0100 (CET) Michal Kubecek wrote:
> +	if (!(req_info.flags & ETHTOOL_FLAG_OMIT_REPLY)) {
> +		bool compact = req_info.flags & ETHTOOL_FLAG_COMPACT_BITSETS;

is req_info->flags validated anywhere to make sure users get an error
when they set a bit unrecognized by the kernel? :S
