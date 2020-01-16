Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0759C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99D702176D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 18:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="M3SoHBtR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395019AbgAPSID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 13:08:03 -0500
Received: from mail.skyhub.de ([5.9.137.197]:40378 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406990AbgAPSH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 13:07:58 -0500
Received: from zn.tnic (p200300EC2F0B2300140B140D62B5CC9C.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:2300:140b:140d:62b5:cc9c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C881F1EC0CD6;
        Thu, 16 Jan 2020 19:07:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1579198076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=KW2w5CooqgG7zpU0vTkX9OBD4qWnzpFrAZgTPF5qpKg=;
        b=M3SoHBtRZX+AR749P5f1ZQLxwYDKhjZ0hVg+xhQ0HV8jS4p/7fH6LoyvX9mbA8CsnAbmIj
        7ElNkBxLWZjgMIp3pNL2K5QSvRVz8OeVNeDV2MztZB4ev8cz7XlKm86Cf0hoclgjiDktiy
        yaVC241z82SWqJjSwtOrATgNG17mk3U=
Date:   Thu, 16 Jan 2020 19:07:48 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, luto@kernel.org,
        pawan.kumar.gupta@linux.intel.com, peterz@infradead.org,
        fenghua.yu@intel.com, vineela.tummalapalli@intel.com,
        linux-kernel@vger.kernel.org, DavidWang@zhaoxin.com,
        CooperYan@zhaoxin.com, QiyuanWang@zhaoxin.com,
        HerryYang@zhaoxin.com
Subject: Re: [PATCH] x86/speculation/spectre_v2: Exclude Zhaoxin CPUs from
 SPECTRE_V2
Message-ID: <20200116180748.GG27148@zn.tnic>
References: <1579146434-2668-1-git-send-email-TonyWWang-oc@zhaoxin.com>
 <87r1zzuy48.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87r1zzuy48.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 06:09:27PM +0100, Thomas Gleixner wrote:
> So the right thing here is to resend both patches as a patch series
> with the conflict properly resolved.

And it is about time you started using --thread and --no-chain-reply-to
with git send-email so that your patchsets are properly threaded. See
the git-send-email(1) if something's still unclear.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
