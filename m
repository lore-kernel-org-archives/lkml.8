Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5658EC2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 16:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24F1F20771
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 16:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="QnHtRl1I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgDQQr6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 12:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgDQQr5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 12:47:57 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E643C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 09:47:57 -0700 (PDT)
Received: from zn.tnic (p200300EC2F0DA800E4C79D2AFB615CD3.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:a800:e4c7:9d2a:fb61:5cd3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B4AF91EC0D3D;
        Fri, 17 Apr 2020 18:47:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1587142075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=FCU1ViNPxFajLYOar19owAYDLtdfc2H3nd+CBF8pBL4=;
        b=QnHtRl1In+NVSc/JRGBMNJMvMmFm7i4McmUyvpe9rGbA9DEo72leQbaVxJ/COIVx8d1iAs
        td4QgglihW/Wi2V5qUcZeUXt7HXQTqfQJvSfW8FZ7Bt5nWQ9bZqea6PnHCc51GvpxAxfTM
        BRPZrvZcsKB5cWBXoB4musvec6VMdOQ=
Date:   Fri, 17 Apr 2020 18:47:52 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     James Morse <james.morse@arm.com>
Cc:     Reinette Chatre <reinette.chatre@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>
Subject: Re: [PATCH v3] x86/resctrl: Preserve CDP enable over cpuhp
Message-ID: <20200417164752.GF7322@zn.tnic>
References: <20200221162105.154163-1-james.morse@arm.com>
 <8d84868f-4045-8d69-ed45-d0f0629ba25c@intel.com>
 <a411323a-2439-5d30-2106-2e3598e9a8c7@intel.com>
 <20200417141841.GD7322@zn.tnic>
 <e762a1c9-b13a-cc8c-e945-292218af418b@intel.com>
 <2030b4e2-bf52-592c-ac67-ddc2aa5f918c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2030b4e2-bf52-592c-ac67-ddc2aa5f918c@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 17, 2020 at 04:33:10PM +0100, James Morse wrote:
> Is the CC-stable still required? I've seen a 'Fixes' tag on its own
> cause patches to get picked up...

AFAIK that is the ultimate plan but it does not happen for every patch
ATM. It will though, eventually. IOW, currently, if you want a patch in
stable, make sure to Cc it. :)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
