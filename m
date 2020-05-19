Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4107C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 14:26:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7E8920709
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 14:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589898365;
	bh=boYqNgFwlXUKiPwvvJJXpwr400FQfOFd/ekPF0S0brI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=l28NDgXw0nuZEUst0sIHU/PT7/S962aNnpajJFSUoya/k7LRY8/OETUPXiLspxMmb
	 f7CG37BKBE6W9YV6b0KtVEiIgH3VYcTJD2KNWxX1H/JHoID7mmnkBJF97Zx+qzIYgj
	 /XklqBXXu+F+7apFV5eaw8w8OQEf6TwuLy60Ry5M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbgESO0F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 10:26:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:57868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726880AbgESO0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 10:26:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF11020825;
        Tue, 19 May 2020 14:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589898363;
        bh=boYqNgFwlXUKiPwvvJJXpwr400FQfOFd/ekPF0S0brI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sv5z+OUiRKIG6nUlqWKNXJUpCm3oZCfGCKKBfHFoyshjC7PRLEDjtd7yoPL5KxGxr
         71mVHieKEVAI7R5yW4uNkF4NNX+eGpshVV9vN7KhljityIlohmIR0x0gcELQEQzN4+
         Va1B7L9568Tvu56mbbseukJ/Pu+rSG46U9vvQ/qk=
Date:   Tue, 19 May 2020 16:24:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [git pull] habanalabs pull request for kernel 5.8
Message-ID: <20200519142448.GA635386@kroah.com>
References: <20200519130924.GA27366@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519130924.GA27366@ogabbay-VM>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 04:09:24PM +0300, Oded Gabbay wrote:
> Hello Greg,
> 
> This is the pull request for habanalabs driver for kernel 5.8.
> 
> This pull-request finally contains the code to handle the GAUDI ASIC. It
> contains both minor changes to the common code of the driver and of course
> the GAUDI-specific code, which is similar to the GOYA-specific code.
> 
> In addition, there is a new feature for command submission of signals and
> wait for signals through the driver. And of course other improvements.
> 
> Please see the tag message for more details on what this pull request
> contains.

Wow, 90k more new lines, not much sharing between the different ASICs :(

Anyway, now pulled and pushed out, thanks.

greg k-h
