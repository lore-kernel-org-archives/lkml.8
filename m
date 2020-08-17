Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27ECEC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05669207DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 07:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597649537;
	bh=fI2xohAfSHjIqvFALJhAdlHjA2a5yEZRlwkW5jJfIC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MlYUy5Jc7jP+VoRns1FP60KJbkgdj2CSlQJn6xAV8nc/V+kHV3kRIxbFIZiCh1dQC
	 K5LCkCk64Ju1Ri9GM3OMLCkR7KEXt9uX8UAQ118usZ8fLmTu0k9aOHRO4u3kLR9JYw
	 qNS2CVQ5LfZwNYEZ8BdjaQOzxLRvv7e3U8H6At14=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbgHQHcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 03:32:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:36750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725765AbgHQHcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 03:32:13 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D8B5F20758;
        Mon, 17 Aug 2020 07:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597649533;
        bh=fI2xohAfSHjIqvFALJhAdlHjA2a5yEZRlwkW5jJfIC8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lbAE8R2O9jhQWgwMn5XRuoTomwPebQNLSSfjwAoxT5vd8fWHFk2ipjUi20AOLPzIa
         9eycSu2SvcmWwyivJKQwy0uCg/2mrTGudlA70qJDh3hdnyu6qQqdC4yod6nwBZOcGE
         NqaUvq/XL6svoTZvLhU+Kp1zzeHAXbZ0XG/PLn94=
Date:   Mon, 17 Aug 2020 09:32:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     devel@driverdev.osuosl.org, devicetree@vger.kernel.org,
        Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        linuxarm@huawei.com, Wei Xu <xuwei5@hisilicon.com>,
        linux-kernel@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, mauro.chehab@huawei.com,
        Lee Jones <lee.jones@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 00/44] SPMI patches needed by Hikey 970
Message-ID: <20200817073232.GA372202@kroah.com>
References: <cover.1597647359.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1597647359.git.mchehab+huawei@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 09:10:19AM +0200, Mauro Carvalho Chehab wrote:
> Hi Greg,
> 
> This patch series is part of a work I'm doing in order to be able to support
> a HiKey 970 board that I recently got on my hands.

Do you feel this is good enough for me to add to my tree now?  Or do you
want me to wait a bit?

thanks,

greg k-h
