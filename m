Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F97FC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 10:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AEF320770
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 10:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="eJyQsthw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgCRKcS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 06:32:18 -0400
Received: from mail.skyhub.de ([5.9.137.197]:34660 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727572AbgCRKcQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 06:32:16 -0400
Received: from zn.tnic (p200300EC2F0B45003CD01F459A0D41B0.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:4500:3cd0:1f45:9a0d:41b0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B61581EC0BEA;
        Wed, 18 Mar 2020 11:32:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1584527534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=/OV7bmNavmDBih6YnNCbo6Axh98P53HfUokcmUccP4E=;
        b=eJyQsthwWLJ1NZsg/zzf7W7rIbrR0am8FVcd3r3fx87R4zQWkT9yUQbKNyjISfj7D/4MXg
        vQRkAl3dWGsd/0lA9BGDdA3A07fM4sXRwRJZBRLsf50R+EHhqR0MW74+c+efxRg72y0mTj
        w+MiKfos/nnKYx7aBvdOYxMexQTIcbc=
Date:   Wed, 18 Mar 2020 11:32:19 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Xiaoyao Li <xiaoyao.li@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/cpufeatures: make bits in cpu_caps_cleared[] and
 cpu_cpus_set[] exclusive
Message-ID: <20200318103219.GA4377@zn.tnic>
References: <20200318061624.150313-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200318061624.150313-1-xiaoyao.li@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 02:16:24PM +0800, Xiaoyao Li wrote:
> In apply_forced_caps(), cpu_caps_set[] overrides cpu_caps_cleared[], so
> that setup_clear_cpu_cap() cannot clear one cap if setup_force_cpu_cap()
> sets the cap before it.

Context pls: what is the observation, what are you trying to do,
reproducer, etc?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
