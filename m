Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D42C2D0EC
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 19:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D956720730
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 19:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="fDKhO9pv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgDGT4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 15:56:19 -0400
Received: from mail.skyhub.de ([5.9.137.197]:58508 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726884AbgDGT4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 15:56:18 -0400
Received: from zn.tnic (p200300EC2F0B270035AFF05F0368BCDC.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:2700:35af:f05f:368:bcdc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7DA731EC0CE0;
        Tue,  7 Apr 2020 21:56:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1586289377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=V/DDGmOm+RmdqBcU/4wt8FGOQ/8Tb5/FxFT3W/HQuv0=;
        b=fDKhO9pvxMVLstKJAABVp59ag9OKGAGEXW99qizJ+RReJMZe0dk0w2TPPXCLF7lNcuEtF1
        ho53xwPFBstFXPVajyd36O4MmlYjSPP+YQpe20Y4HEYiloR4TRnueAGInfzhIVzr9cwjk8
        qkOrYUNzJk9qyVAq8yOEiObmArb70R4=
Date:   Tue, 7 Apr 2020 21:56:14 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Yazen Ghannam <Yazen.Ghannam@amd.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/9 v3] New way to track mce notifier chain actions
Message-ID: <20200407195613.GF9616@zn.tnic>
References: <20200212204652.1489-1-tony.luck@intel.com>
 <20200407163414.18058-1-bp@alien8.de>
 <3908561D78D1C84285E8C5FCA982C28F7F5D49A9@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7F5D49A9@ORSMSX115.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 07:53:56PM +0000, Luck, Tony wrote:
> It passes my smoke tests (uncorrectable error consumed by application and
> uncorrectable error consumed by mcsafe_memcpy()).

That, of course, is even better, thanks for testing!

> Tested-by: Tony Luck <tony.luck@intel.com>

Thx, I'll queue the whole pile next week.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
