Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFBECC352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 06:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DBB92173E
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 06:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="o4qkGfUU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729725AbgBMGKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 01:10:00 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38206 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgBMGKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 01:10:00 -0500
Received: from zn.tnic (p200300EC2F07F600C900F9734EF2E51F.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:f600:c900:f973:4ef2:e51f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 385001EC0C76;
        Thu, 13 Feb 2020 07:09:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1581574199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=TH3guTuF8ik0rTG2tTgMhnQG64Kn6K+XDPaqH7vx/Z4=;
        b=o4qkGfUUEF//F1I7E6hT7xqpGW4gFh4DKwrkTDzZ2TEOKWgvtjZzEiqUaYCI6ICDbHpMV1
        NoioX/KK3ZD3+oIvLJCr2Ii42cwZXhocEfnp7UpGXU5EeN89hAFUdG+bCRuc6B5Yzgj0xq
        hKScz2AzILJ5KMOZDjx67FQIfOfqBwo=
Date:   Thu, 13 Feb 2020 07:09:49 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     "Luck, Tony" <tony.luck@intel.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/5] New way to track mce notifier chain actions
Message-ID: <20200213060949.GA31799@zn.tnic>
References: <20200212204652.1489-1-tony.luck@intel.com>
 <20200212230815.GA3217@agluck-desk2.amr.corp.intel.com>
 <CALCETrXx7ah9c=TYGm3ZXvwUnoJkDHP1vbuqaudih9fik5W9_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrXx7ah9c=TYGm3ZXvwUnoJkDHP1vbuqaudih9fik5W9_A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 09:52:39PM -0800, Andy Lutomirski wrote:
> I HATE notifier chains for exceptions, and I REALLY HATE NOTIFY_STOP.
> I don't suppose we could rig something up so that they are simply
> notifiers (for MCE and, eventually, for everything) and just outright
> prevent them from modifying the processing?

As in: they all get executed unconditionally and there's no NOTIFY_STOP
and if they're not interested in the notification, they simply return
early?

Hohumm, sounds nicer.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
