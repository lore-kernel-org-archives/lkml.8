Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48774C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 12:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 221E12076E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 12:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597668115;
	bh=Okl+Iv03JFQ7TnsrjMTHVsc+oYntS6yP0fCT0KEodq4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=BirtYQo4kBe5Utdv7oZCC2N6OGq7JYiRIN5wgPcIRita3QF6cy7Hhl6EvagA81ogt
	 GBtY/6z6Etq0YMAvwWQIoFW5j5RDR4SJnQun4CwbNBHM20lyCs8tBlo0yFEaD3zz2Q
	 ScPYcJQEpB+n7ioWHTnd5JNL4kCfDn3kHu1xxftw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbgHQMlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 08:41:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:54740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726727AbgHQMlw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 08:41:52 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 480A22072D;
        Mon, 17 Aug 2020 12:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597668111;
        bh=Okl+Iv03JFQ7TnsrjMTHVsc+oYntS6yP0fCT0KEodq4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qxWZVCO/BHOfLyn5I7gJC88rd6e052OVk4pcoN3posYXRJMmdIe6g/6kqRWxghoiz
         1T9QbkfvaEfHv83rrGQir8dPiS8b7Ld86fvyW8/I8NaTPwf1oAXedTs+MDCxZHbRE3
         dIo+4qcaakqh0bkTFcXm7NGnQ0lzeSI85347+aVs=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1k7eST-003ZAU-Ou; Mon, 17 Aug 2020 13:41:49 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 17 Aug 2020 13:41:49 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        Rob Herring <robh@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        kernelci-results@groups.io, gtucker@collabora.com,
        linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        kernel@collabora.com
Subject: Re: mainline/master bisection: baseline.bootrr.rockchip-pcie-probed
 on rk3399-gru-kevin
In-Reply-To: <cc089ea6-2484-7d7c-29a2-cd45daa47817@collabora.com>
References: <5f394e3f.1c69fb81.4accc.4cf0@mx.google.com>
 <0070b9d1-9108-3d26-cb91-bfeb7cb97e9a@collabora.com>
 <cc089ea6-2484-7d7c-29a2-cd45daa47817@collabora.com>
User-Agent: Roundcube Webmail/1.4.7
Message-ID: <b04b51a9130660f40ba7d7e8e7c67167@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: enric.balletbo@collabora.com, guillaume.tucker@collabora.com, robh@kernel.org, tsbogend@alpha.franken.de, jiaxun.yang@flygoat.com, kernelci-results@groups.io, gtucker@collabora.com, linux-kernel@vger.kernel.org, frowand.list@gmail.com, devicetree@vger.kernel.org, robh+dt@kernel.org, kernel@collabora.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-17 11:11, Enric Balletbo i Serra wrote:
> Hi Guillaume et all,
> 
> On 17/8/20 12:02, Guillaume Tucker wrote:
>> Hi,
>> 
>> Please see the bisection report below about a driver probe
>> regression with rockchip-pcie.
>> 
>> Reports aren't automatically sent to the public while we're
>> trialing new bisection features on kernelci.org but this one
>> looks valid.
>> 
> 
> Thank you for make it public. It's nice to see kernelCI catching these 
> things.
> 
>> It seems to be due to this error:
>> 
>>   <6>[   16.842128] rockchip-pcie f8000000.pcie: no vpcie12v regulator 
>> found
>> 
> 
> I just noticed some patches in the ML that might help to fix the issue. 
> It is
> not related to the above message though.

This message is always there, and is harmless (the regulator is 
optional).

> 
> I suspect the following series sent by Marc (cc'ied in this email) will 
> fix the
> issue [1]. I'd expect the patches to land as a fix for this release.

This is indeed related to the rk3399 DT issue, and how the bisected 
patch
only makes it plain that the DT has always been broken. The patches you 
point
to should paper over the problem, and I'd appreciate some feedback on 
them.

There may be a few more systems affected by this issue (at least MTK and 
QC
systems could be affected as well).

         M.
-- 
Jazz is not dead. It just smells funny...
