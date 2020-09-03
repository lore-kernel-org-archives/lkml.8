Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E88A0C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 16:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 928B3206A5
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 16:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="bEpWIzHe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbgICQzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 12:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgICQzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 12:55:37 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D3DC061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 09:55:36 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0d7a00e86b50da0ecac743.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:7a00:e86b:50da:eca:c743])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 101CD1EC0472;
        Thu,  3 Sep 2020 18:55:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1599152135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=OPLKDPg36zeWZWe6d3dsjH2xBLWDSt7X8K+c+Hl/bOU=;
        b=bEpWIzHe3bAC0D37QeSHaxowNs23STJ3pPgtRincOzsFA4Sq/fSWgvohTrWlv9rTfXQrlr
        IFANXHaT3iRVchu7ehzARXIQ6f5t+IZvTuOy80HZhleImgEWxWmFQoziOXoQKiywI0nvwc
        NZHIwazOM0AexBG/Nt2l3KdKvLj0sgM=
Date:   Thu, 3 Sep 2020 18:55:30 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Youquan Song <youquan.song@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFD PATCH] x86/mce: Make sure to send SIGBUS even after losing
 the race to poison a page
Message-ID: <20200903165530.GE5462@zn.tnic>
References: <20200827163205.23096-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200827163205.23096-1-tony.luck@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 09:32:05AM -0700, Tony Luck wrote:
> The #MC used to win that race and the page was taken offline and SIGBUS
> sent to the task.
> 
> Changes to how Linux processes machine checks now mean that:
> a) Linux will offline the page based on the UCNA siganture in the
>    CMCI handler.

Let's see if that logic makes sense: if #MC offlines the page and sends
SIGBUS but CMCI only offlines the page, isn't it only logical for the
CMCI to *also* send the SIGBUS too, after having offlined the page?

I.e., both should do the proper and full recovery action. Just sayin...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
