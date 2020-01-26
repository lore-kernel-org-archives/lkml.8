Return-Path: <SRS0=fzvl=3P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6812C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 17:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93C8020702
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jan 2020 17:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="WXhtVuCc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgAZRUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jan 2020 12:20:02 -0500
Received: from mail.skyhub.de ([5.9.137.197]:35196 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbgAZRUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jan 2020 12:20:02 -0500
Received: from zn.tnic (p200300EC2F25DF00BC613C117BE1B9E7.dip0.t-ipconnect.de [IPv6:2003:ec:2f25:df00:bc61:3c11:7be1:b9e7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DE8BB1EC0B86;
        Sun, 26 Jan 2020 18:20:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1580059201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=n7aSfQAjmPocxoYvQlfxhkiRM5ozfGvvTpJJo0eEO6M=;
        b=WXhtVuCcheWjdviXuCfy4VcWr/pVU8bUs6GWnc8GXbZce4mAqsmFcfwE2Vgoko2HDiLzIW
        h6ut3htAmXO6/t2XtASvLEV+avpuEuj0vK5EfMQVvPL53CiDD+kDWzdeUrLFSxN6Og7YfA
        t+N6Ei92L0HCBNBPlds1gOIZFkyUd9o=
Date:   Sun, 26 Jan 2020 18:19:56 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        x86 <x86@kernel.org>
Subject: Re: [tip: core/rcu] rcu: Enable tick for nohz_full CPUs slow to
 provide expedited QS
Message-ID: <20200126171956.GB5714@zn.tnic>
References: <157994897654.396.5667707782512768142.tip-bot2@tip-bot2>
 <20200125131425.GB16136@zn.tnic>
 <20200125161050.GE2935@paulmck-ThinkPad-P72>
 <20200125175442.GA4369@zn.tnic>
 <20200125194846.GF2935@paulmck-ThinkPad-P72>
 <20200126014318.GA5122@paulmck-ThinkPad-P72>
 <20200126112540.GA5714@zn.tnic>
 <20200126152831.GK2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200126152831.GK2935@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 26, 2020 at 07:28:31AM -0800, Paul E. McKenney wrote:
> And thank you for finding this and for the testing!
> 
> May I add your Tested-by?

Sure, thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
