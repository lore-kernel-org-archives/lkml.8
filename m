Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F68C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA68C24685
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="AZlRYSAY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbgAVNJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:09:21 -0500
Received: from mail.skyhub.de ([5.9.137.197]:51960 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727022AbgAVNJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:09:20 -0500
Received: from zn.tnic (p200300EC2F0CAE008532B502E47E7E30.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:ae00:8532:b502:e47e:7e30])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5470E1EC0C8A;
        Wed, 22 Jan 2020 14:09:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1579698559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=fiJdEoUI2YsKETVpruXUSeMCYWF5Rxs25aSR/XuICwc=;
        b=AZlRYSAYElPGRJsZjMKoFrVLVdaTH8CqoVSrAntkUJBAsmftoDmzxh53Z03plYaXe+1EsR
        ySAbbuguUP/n6P4oPj9Pkmv/OP5UrLlGzSg+UInc2rxWGpGmkbObO329cFh5UyK1HrBulG
        wjmgetEkfItif1CZwDdCY+jomDNfjoY=
Date:   Wed, 22 Jan 2020 14:09:13 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, luto@kernel.org
Subject: Re: [PATCH 0/3] [RFC] x86: start the MPX removal process
Message-ID: <20200122130913.GA20584@zn.tnic>
References: <20190705175317.1B3C9C52@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190705175317.1B3C9C52@viggo.jf.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 05, 2019 at 10:53:17AM -0700, Dave Hansen wrote:
> This series is also available here, and will get some additional 0day
> testing to ensure no funkiness:
> 
> 	git://git.kernel.org/pub/scm/linux/kernel/git/daveh/x86-mpx.git mpx-remove-201907
> 
> While there's no rocket science in here, this is probably not ready
> to be pulled until 0day has the weekend to churn on it.

And whoops, half a year passed. :-)

Should we try removing it again? This time I won't stop until it's gone.
:-)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
