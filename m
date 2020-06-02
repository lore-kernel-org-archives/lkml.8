Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DB7C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 02:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58D982073B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 02:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591063827;
	bh=D9+DhHL3sK80bJoX2x75L8U/xMOiFssEJfNRjohaEpI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=T16h7wOew6vFXCqQRvL5vxi3Pi5mBlO7LFBx9IBqs2Veek1gudwittXzl+qGuGxFX
	 RtizP6QF8+XZVS9JfiTVYaN+L9KuB41fWE8OW4a+XS6f/VimwIcR727xgYepJe0rkm
	 U1pfIYLZVVco6GQmKIe8RxUi19m4eOdVs8ZfgYMg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgFBCK0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 22:10:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:33888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725841AbgFBCK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 22:10:26 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D417020734;
        Tue,  2 Jun 2020 02:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591063825;
        bh=D9+DhHL3sK80bJoX2x75L8U/xMOiFssEJfNRjohaEpI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oBIHKeU+SzS/J8BnPmRRp+TrUUL+WoikahoTv9G2+GFxXeo2T8iHHpZd0XtjcP2yO
         kew5oQ0h+g6jsHNU7U2PbSEFUvZ2HDAUAoG2ZUtGOp0QjhqkyiOWg4glij51kxNbyz
         NNFpu7qKg/xsUSRmnKgLgbGRcqSystEy1yYus8tU=
Date:   Mon, 1 Jun 2020 22:10:23 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Kevin Locke <kevin@kevinlocke.name>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 4.19 38/95] Input: i8042 - add ThinkPad S230u to i8042
 nomux list
Message-ID: <20200602021023.GN1407771@sasha-vm>
References: <20200601174020.759151073@linuxfoundation.org>
 <20200601174026.880387783@linuxfoundation.org>
 <20200601213852.GD17898@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200601213852.GD17898@amd>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 01, 2020 at 11:38:52PM +0200, Pavel Machek wrote:
>Hi!
>
>> Odds of a BIOS fix appear to be low: 1.57 was released over 6 years ago
>> and although the [BIOS changelog] notes "Fixed an issue of UEFI
>> touchpad/trackpoint/keyboard/touchscreen" in 1.58, it appears to be
>> insufficient.
>>
>> Adding 33474HU to the nomux list avoids the issue on my system.
>
>This patch is known bad, and is reverted as a step 93/ in this
>series. I believe it would be better to remove this and the revert
>before -stable kernel is released.

Good point, I'll drop both. Thanks!

-- 
Thanks,
Sasha
