Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10758C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 10:47:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC84A20770
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 10:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="EEmB5Xjx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730104AbgIDKqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 06:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729932AbgIDKqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 06:46:24 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E3FC061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 03:46:19 -0700 (PDT)
Received: from zn.tnic (p200300ec2f131b00c5b24da9f43f22b9.dip0.t-ipconnect.de [IPv6:2003:ec:2f13:1b00:c5b2:4da9:f43f:22b9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 54D5D1EC041D;
        Fri,  4 Sep 2020 12:46:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1599216376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=yPJugJqFGVd7DGiX3Ze09pKTCbZkA/2aWPz9M3tRlYQ=;
        b=EEmB5Xjxm9eUEfTUI0PJoVxVgsPc78Xyl8dGUJViqpzZ8P+odl00ubn+IcpesNHR9xKXRP
        R2MRmBn2JQQreW0ZCIaVN6mc6vPJAlKNyTOu382e1rC4wgP55V5/cGiQrn0nJPzr/lrKcZ
        0ikHq4jzPVXjsliPyUUQw0juq47em0g=
Date:   Fri, 4 Sep 2020 12:46:14 +0200
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
Message-ID: <20200904104614.GE21499@zn.tnic>
References: <1598540794-132666-1-git-send-email-fenghua.yu@intel.com>
 <1598540794-132666-2-git-send-email-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1598540794-132666-2-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just a nitpick in case you have to send a new version or the committer
of this one can fixup the prefix here:

> Subject: Re: [PATCH v7 1/9] iommu: Change type of pasid to u32

		drm, iommu: Change type ...


On Thu, Aug 27, 2020 at 08:06:26AM -0700, Fenghua Yu wrote:
> PASID is defined as a few different types in iommu including "int",
> "u32", and "unsigned int". To be consistent and to match with uapi
> definitions, define PASID and its variations (e.g. max PASID) as "u32".
> "u32" is also shorter and a little more explicit than "unsigned int".
> 
> No PASID type change in uapi although it defines PASID as __u64 in
> some places.

...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
