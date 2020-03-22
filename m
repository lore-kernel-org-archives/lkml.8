Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8C1BC54FCF
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 12:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73A752073C
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 12:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584881693;
	bh=ihnqjjFBQHTjqmZQrYET48sBcNIirEsBefwMBQ//JyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=H5Ok/V/9wUY42ili9+fRh9DOg6np7Hg7p/1Gs/rZYE/bj8Qfeaq1/7WWoHwymgKs7
	 Lh+9BvNxpio+iLrZ4UzyD3NSVvsdtu0KR1xbP6312ds/PbcMDAaxdB/FxsC8EQyGVT
	 vUBdC3f/WFhGg8ZRnOBfKLBeRpAytwiZntoOIbSA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgCVMyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 08:54:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:47392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725970AbgCVMyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 08:54:52 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6CA6C2072E;
        Sun, 22 Mar 2020 12:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584881691;
        bh=ihnqjjFBQHTjqmZQrYET48sBcNIirEsBefwMBQ//JyM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aB7nJ4DWaAJFUsQzsoZBASx9grOxujp+SdYHdk+VNC179htMuyphkkg8sNnNKjx5O
         ZyVsj4BihNja0EghmQDJ5prAfv8rfYLsNcOufLwZLCzgfKvO6tFdV2b7v0H6qisMq4
         /fxMuQqhnUW+WZU9LMDnHe+EysSfH2KLrCDv462Q=
Date:   Sun, 22 Mar 2020 08:54:50 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 5.5 05/41] ARM: dts: imx6dl-colibri-eval-v3: fix
 sram compatible properties
Message-ID: <20200322125450.GN4189@sasha-vm>
References: <20200316023319.749-1-sashal@kernel.org>
 <20200316023319.749-5-sashal@kernel.org>
 <20200316072143.GT14211@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200316072143.GT14211@localhost>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 08:21:43AM +0100, Johan Hovold wrote:
>On Sun, Mar 15, 2020 at 10:32:43PM -0400, Sasha Levin wrote:
>> From: Johan Hovold <johan@kernel.org>
>>
>> [ Upstream commit bcbf53a0dab50980867476994f6079c1ec5bb3a3 ]
>>
>> The sram-node compatible properties have mistakingly combined the
>> model-specific string with the generic "mtd-ram" string.
>>
>> Note that neither "cy7c1019dv33-10zsxi, mtd-ram" or
>> "cy7c1019dv33-10zsxi" are used by any in-kernel driver and they are
>> not present in any binding.
>>
>> The physmap driver will however bind to platform devices that specify
>> "mtd-ram".
>>
>> Fixes: fc48e76489fd ("ARM: dts: imx6: Add support for Toradex Colibri iMX6 module")
>> Cc: Sanchayan Maity <maitysanchayan@gmail.com>
>> Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>> Cc: Shawn Guo <shawnguo@kernel.org>
>> Signed-off-by: Johan Hovold <johan@kernel.org>
>> Reviewed-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
>> Signed-off-by: Shawn Guo <shawnguo@kernel.org>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>Greg has already dropped this one from the stable queues once on my
>request, so please do not add it back.

I'll drop it, thanks!

-- 
Thanks,
Sasha
