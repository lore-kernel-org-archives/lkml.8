Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B01C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 01:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 089742078C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 01:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594861308;
	bh=H0H1cfpKnnKuRaYYxUYCzxKrgJeczTSwegc9TcO0VAs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=fqQWhmL381Gv16c+s3RjAyxpIuOr/seZqUwyiVKyznf/2gdhtLp3xX4PNbfexowY2
	 CT4SZN3n2xvC9NacadV1qpot16ngDfXbVIFcLIBEN6W4RrDioyR6Z7Kltb5XjsBeym
	 kK2oDZc8ixTqsLK70C9g0n7ks1KyvOGp2aXVslNY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbgGPBBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 21:01:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:37218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726479AbgGPBBq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 21:01:46 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CADCD2078C;
        Thu, 16 Jul 2020 01:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594861306;
        bh=H0H1cfpKnnKuRaYYxUYCzxKrgJeczTSwegc9TcO0VAs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QSv1YLr1usVlJCw6XJOYCwZrbBpoj49kSi0E7j03zq9o84atnIeHjJEBjoM6hbFtR
         dIr4hDDPgdHhGE6HzJp1ys9PZHDacnckoeShXBvXqxNQq2tjSAoXUrY5ks5BuqkdBL
         NE8V+XPYjeFo40cdmba3AVHi/zaDUCps0R127rjA=
Date:   Wed, 15 Jul 2020 18:01:44 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Paolo Pisati <paolo.pisati@canonical.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: net: ip_defrag: modprobe missing
 nf_defrag_ipv6 support
Message-ID: <20200715180144.02b83ed5@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200714124032.49133-1-paolo.pisati@canonical.com>
References: <20200714124032.49133-1-paolo.pisati@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jul 2020 14:40:32 +0200 Paolo Pisati wrote:
>  #
>  # Run a couple of IP defragmentation tests.
>  
> +modprobe -q nf_defrag_ipv6
> +
>  set +x
>  set -e
>  

Any reason you add this command before set -e ?

It seems we want the script to fail if module can't be loaded.
