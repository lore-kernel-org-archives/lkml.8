Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E2EC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 12:44:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E4802088E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 12:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593693876;
	bh=z4WEJ5Hsxfu7qusUUGh6nlSscD0yPifHc1h20biJqGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PEROqXm6+c+LS9vrs1/NrJNcqkxDxbc6D91rqD6nXx/Mja2VXhCGf4XwY1F7x+khl
	 Z+7VVTbtzufG/aZSakwOT8u5qWwSS7TrcX0Lzc/ssRuFsPJAjJecQL44deCVjPmjsU
	 V6pmiGdu575wH2Yyd+7glrhGONwDjB2cTmuAeec8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbgGBMof (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 08:44:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:48638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728808AbgGBMoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 08:44:34 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4009720885;
        Thu,  2 Jul 2020 12:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593693873;
        bh=z4WEJ5Hsxfu7qusUUGh6nlSscD0yPifHc1h20biJqGk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JIxIoN4C7RW3jqu40wTnpeGXh0QwXkvEQOm8JJcXv7ql7bYh0e9VzsinHisKnOxEk
         TAwwwmT8pzUqWsYX3IBxAWOYDUWfTrrx1H/z0pGK+fEBFQK8NPgfObDhs20MJqjKmA
         s5Wcuj1B4iAZgSg9pHQUcVWB5OLia2U9Ij9rg44A=
Date:   Thu, 2 Jul 2020 14:44:37 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 0/6] devres: provide and use devm_krealloc()
Message-ID: <20200702124437.GC1882489@kroah.com>
References: <20200629065008.27620-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629065008.27620-1-brgl@bgdev.pl>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 08:50:02AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Regular krealloc() obviously can't work with managed memory. This series
> implements devm_krealloc() and adds the first user with hope that this
> helper will be adopted by other drivers currently using non-managed
> krealloc().
> 
> Some additional changes to the code modified by main patches are included.

I've applied the first 4, the other two I had questions on.

thanks,

greg k-h
