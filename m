Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2988DC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7353206E7
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 16:37:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599583036;
	bh=qmVm2cBZbFlDXg2K5rwPxPvrNmapd2esw84x5y2TZFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ypzYiADHqJbEQ9S87AJZK1KORrr4Gmm3d5LMOs3y2/xr/TFEM2NsXbkPklMstOmxn
	 nEHqxD9OcZ62Z7KYOOoP67LC+UDrQScihYooisQcifSoSzNjqlwvDT2fXTm2vTbh1/
	 MBGJBU4eO3n/QxF12OgnnKx5yLvJmV1CDOHXLr1k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732037AbgIHQhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 12:37:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:34254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732021AbgIHQbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:31:38 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E52B206DB;
        Tue,  8 Sep 2020 12:12:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599567145;
        bh=qmVm2cBZbFlDXg2K5rwPxPvrNmapd2esw84x5y2TZFA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NQ7N43mQZ4LkTz66NIKWIOC2tQ5F40LoHwfxM6xc2UuMF2nup3sPRlDg2/4oHVOgE
         ueQDJCcgHx6hagKe8KacN6yDsSoeaI90haVA0MrSWqN19Ht8L0EgNacfxJSXPfOOzo
         XziLjCQjkwu0AgW5+bxQSftlzmQ6q6ckvclcRO5g=
Date:   Tue, 8 Sep 2020 08:12:24 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Lars Melin <larsm17@gmail.com>
Cc:     Kristian Evensen <kristian.evensen@gmail.com>,
        linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>,
        Daniele Palmas <dnlplm@gmail.com>,
        =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Network Development <netdev@vger.kernel.org>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.14 17/33] net: usb: qmi_wwan: add Telit 0x1050
 composition
Message-ID: <20200908121224.GT8670@sasha-vm>
References: <20191026132110.4026-1-sashal@kernel.org>
 <20191026132110.4026-17-sashal@kernel.org>
 <CAKfDRXjjuW4VM03HeVoeEyG=cULUK8ZXexWu48rfFvJE+DD8_g@mail.gmail.com>
 <20200907181552.GN8670@sasha-vm>
 <6e09f3e2-674d-f7c1-e868-c170dff1dbb9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <6e09f3e2-674d-f7c1-e868-c170dff1dbb9@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 07:33:21AM +0700, Lars Melin wrote:
>On 9/8/2020 01:15, Sasha Levin wrote:
>>On Mon, Sep 07, 2020 at 11:36:37AM +0200, Kristian Evensen wrote:
>// snip
>
>>>When testing the FN980 with kernel 4.14, I noticed that the qmi device
>>>was not there. Checking the git log, I see that this patch was never
>>>applied. The patch applies fine, so I guess it was just missed
>>>somewhere. If it could be added to the next 4.14 release, it would be
>>>much appreciated.
>>
>>Interesting, yes - I'm not sure why it's missing. I'll queue it up.
>>
>
>The patch is missing from all 4.x LTS kernels, not only 4.14

Right, it's queued up for all the trees.

-- 
Thanks,
Sasha
