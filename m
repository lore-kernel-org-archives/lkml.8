Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E67FC2D0EB
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DEF220781
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 20:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585512441;
	bh=6gW15nHRmZi9kJRZ+wslHaL5YVXBiL6L3/KmKALt4gI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=q9QBUva2yAQaJU2XlsEsqwUXiyYjsCoN/lcORSOt9OX8Ek2gXD3bXwZeZ+DbHM6Ca
	 Ym6+MKvZhbidr2M2oeurR3Q30dqSH5KO3nVBhFWBb/6Oi61an7FElWwarr5ZCEnsdB
	 jaCs5h8IcwQ3KZkSK7yQ+nvpPKghnnGc0qFW9UJE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728728AbgC2UHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 16:07:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:60750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727933AbgC2UHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 16:07:19 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0023C206E6;
        Sun, 29 Mar 2020 20:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585512439;
        bh=6gW15nHRmZi9kJRZ+wslHaL5YVXBiL6L3/KmKALt4gI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pkJfwNpcaU/+xqy3GjZPdZ3iwL1FK4PkH/vr9jDfrisJt7uB7NrU1pS8xn6bLjEhk
         755fLQqr2Zi9YsmOE7uTpXEZRBJnDExPe0BUgxcDLir1p1d75MJSiLPBHioO2jwCdD
         SmynOjBHZfBEKoPreEaZlUsUxGjjZernYCkCY8i0=
Date:   Sun, 29 Mar 2020 16:07:17 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Martin Volf <martin.volf.42@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>, linux-i2c@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.4 49/73] i2c: i801: Do not add ICH_RES_IO_SMI
 for the iTCO_wdt device
Message-ID: <20200329200717.GD4189@sasha-vm>
References: <20200318205337.16279-1-sashal@kernel.org>
 <20200318205337.16279-49-sashal@kernel.org>
 <20200319073021.wh2b7kumxgbj5wkf@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200319073021.wh2b7kumxgbj5wkf@katana>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 08:30:21AM +0100, Wolfram Sang wrote:
>
>> [wsa: complete fix needs all of http://patchwork.ozlabs.org/project/linux-i2c/list/?series=160959&state=*]
>
>Please take care of the line above if you want to backport. I don't
>think the dependencies are suitable for stable, so they don't have the
>stable tag.

I'll drop it, thanks!

-- 
Thanks,
Sasha
