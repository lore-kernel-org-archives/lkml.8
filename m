Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0580C433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 19:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E2B92083B
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 19:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="EA0jU5vE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbgIDTpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 15:45:31 -0400
Received: from mail.skyhub.de ([5.9.137.197]:46106 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726135AbgIDTpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 15:45:30 -0400
Received: from zn.tnic (p200300ec2f131b006df6c51daec86255.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:1b00:6df6:c51d:aec8:6255])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9B8D61EC0114;
        Fri,  4 Sep 2020 21:45:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1599248728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=vB+ybE+kkqXuAF0v4q3TxJ7d/Liqr1Zea2a13Znuo4A=;
        b=EA0jU5vEPigic5zsezj/bTzy2dNcvK9QlpCr5EUzEQjML9j4I/AcseqXvAzW3bVyIhRcyf
        IKpT6lxMZ1Hgi9FrlO8LCGojXGkFybZ4xG/gxX1irwPGA16TeotNq6cE97oM9yhcTouk/e
        naPWP9/LTIU2vC2N8VwucEBL6eYDNqw=
Date:   Fri, 4 Sep 2020 21:45:19 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, iommu@lists.linux-foundation.org
Subject: Re: [PATCH v7 1/9] iommu: Change type of pasid to u32
Message-ID: <20200904194519.GA22577@zn.tnic>
References: <1598540794-132666-1-git-send-email-fenghua.yu@intel.com>
 <1598540794-132666-2-git-send-email-fenghua.yu@intel.com>
 <20200904104614.GE21499@zn.tnic>
 <20200904160613.GA412013@otcwcpicx6.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200904160613.GA412013@otcwcpicx6.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04, 2020 at 04:06:13PM +0000, Fenghua Yu wrote:
> Thank you very much for your review!

I'm not done with my review yet.

> Could you please consider to commit the series?

Fenghua, how long are you doing kernel development? When do patches get
considered for inclusion? I'm sure you know the answer...

> I can send out v8 with the subject "drm," change if you want me to do
> so.

Pls be patient until I/we are done with the review.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
