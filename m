Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13112C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 15:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD12C2076C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 15:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598370694;
	bh=+uhEw3b1gTUz8slduurRGvop16JpIs0dqRKz0ZZTDDo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=PdoZdNOKKZtuql0Fbm6xEQqCmv8qaMUhPRDsGLRYD/+SPwbTXAKA9Akd4jtnEjDB4
	 5JEAwArKvoDCqX8HxY1fIdVyS9JN7dAwhAXP0ilmNxvlKyZLbi0cdwnYfkV/1h5XV/
	 0OA1KY9uxUKDrwbPSmP11W+I6cSdLbu7Hba8XpxA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgHYPvc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 11:51:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:34082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726971AbgHYPv3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 11:51:29 -0400
Received: from kicinski-fedora-PC1C0HJN (unknown [163.114.132.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19F6B2067C;
        Tue, 25 Aug 2020 15:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598370689;
        bh=+uhEw3b1gTUz8slduurRGvop16JpIs0dqRKz0ZZTDDo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0Sj/9uvdrKQF9Vu9WBAKh2vfzD3Fe4x6G0+v2AMnUNfoi3HM6Dsxzp+0mW88uNpg2
         tulm14+7IPDfwHPep7T15dfHPtyT052erZLY1MSHi4bBbJZg/khKWUJ4FhiBH6S6RP
         x8Qe3+stLb739yqTedhacEFwqbebiX4Bs2NhLz4I=
Date:   Tue, 25 Aug 2020 08:51:27 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Ahmed Abdelsalam <ahabdels@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jonathan Corbet <corbet@lwn.net>, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrea.mayer@uniroma2.it
Subject: Re: [net-next v5 2/2] seg6: Add documentation for
 seg6_inherit_inner_ipv4_dscp sysctl
Message-ID: <20200825085127.50ba9c82@kicinski-fedora-PC1C0HJN>
In-Reply-To: <20200825121844.1576-1-ahabdels@gmail.com>
References: <20200825121844.1576-1-ahabdels@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Aug 2020 12:18:44 +0000 Ahmed Abdelsalam wrote:
> +	Enable the SRv6 encapsulation to inherit the DSCP value of the inner IPv4 packet.                                                                                                         
> +
> +	Default: FALSE (Do not inherit DSCP)
> +
>  ``conf/default/*``:
>  	Change the interface-specific default settings.
>  

Checkpatch complains about whitespace:

ERROR: trailing whitespace
#24: FILE: Documentation/networking/ip-sysctl.rst:1802:
+seg6_inherit_inner_ipv4_dscp - BOOLEAN                                                                                                                                                                                                                                                                                                        $
