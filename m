Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEAB4C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 11:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BECF20791
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 11:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599220338;
	bh=oA5ZpR+IKkziVuvdJ8WZUrJXW1JY9oaKsUJTFfY4zeU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=C17G8b1NQO+B5lDRuR4Uh+dvm9jDU2XgDjJzxEJsA94cx6/vjNfFvsB7Z5W5xSd/Q
	 +jd93KP+dgSRyPSR0+POOqZw/mlA1y/rKQLIP0b+OpE99ZDKp50bMGI1UuNMywPRFj
	 vesqVmijn4Md161tWBukOqTgYm/x7hrbxsLCx640=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730113AbgIDLwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 07:52:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:55428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728588AbgIDLwO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 07:52:14 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 21F1F20791;
        Fri,  4 Sep 2020 11:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599220332;
        bh=oA5ZpR+IKkziVuvdJ8WZUrJXW1JY9oaKsUJTFfY4zeU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zUoYImby912duewe/56eTe5zDCRF5BcFmxPk5+YnftYJWyD7iTprdp22tCWQXtuDw
         U5n69uRBPwh9crIeS1bHk9o42fVO75AynfR88s9aqZ4ZS7Fv6e5OpSmI8eDpyouHoB
         g4jexx9s3AyNzdrC1vBq5L3DR49v7DHDYu8L73Xw=
Date:   Fri, 4 Sep 2020 13:52:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] interconnect fixes for 5.9
Message-ID: <20200904115231.GA2964473@kroah.com>
References: <20200904114850.4306-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904114850.4306-1-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 02:48:50PM +0300, Georgi Djakov wrote:
> Hello Greg,
> 
> Here is a small pull request with interconnect fixes for 5.9-rc. Please
> take them into char-misc-linus when possible.
> 
> Thanks,
> Georgi
> 
> The following changes since commit f75aef392f869018f78cfedf3c320a6b3fcfda6b:
> 
>   Linux 5.9-rc3 (2020-08-30 16:01:54 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.linaro.org/people/georgi.djakov/linux.git tags/icc-5.9-rc4

Pulled and pushed out,t hanks,

greg k-h
