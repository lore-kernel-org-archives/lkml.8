Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA014C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 17:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B12D5218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 17:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="N63dhYa6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbgBMRDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 12:03:15 -0500
Received: from mail.skyhub.de ([5.9.137.197]:48746 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727799AbgBMRDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 12:03:15 -0500
Received: from zn.tnic (p200300EC2F07F6001C43AF432C3E1E0D.dip0.t-ipconnect.de [IPv6:2003:ec:2f07:f600:1c43:af43:2c3e:1e0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 43A141EC0C81;
        Thu, 13 Feb 2020 18:03:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1581613393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=a/qOc8UGN9Gs9dit3F6wtNC2cUbl9u2YAHsJCKykdis=;
        b=N63dhYa66QSHSj6ghUMyvE/Q17i0YJi8Pzz4ZXfd0vB+VpJtKQ1K7vlaItCMSAqzjWFkBi
        ewK87+i+UAGBUXuqI0eAJjjwPDymrMdV3P+FIWbNWqxinCNh+fUnA0fNpzRdNU8V8nVLCQ
        ulbupGDtP/f0EYbUGQawHyM3sEEEziY=
Date:   Thu, 13 Feb 2020 18:03:08 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Tony Luck <tony.luck@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] x86/mce: Fix all mce notifiers to update the
 mce->handled bitmask
Message-ID: <20200213170308.GM31799@zn.tnic>
References: <20200212204652.1489-1-tony.luck@intel.com>
 <20200212204652.1489-5-tony.luck@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200212204652.1489-5-tony.luck@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 12:46:51PM -0800, Tony Luck wrote:
> If the handler took any action to log or deal with the error, set
> a bit int mce->handled so that the default handler on the end of
> the machine check chain can see what has been done.
> 
> [!!! What to do about NOTIFY_STOP ... any handler that returns this
> value short-circuits calling subsequent entries on the chain. In
> some cases this may be the right thing to do ... but it others we
> really want to keep calling other functions on the chain]

Yes, we can kill that NOTIFY_STOP thing in the mce code since it is
nasty.

Then, from the looks of it, there should be a function at the end of
the chain which decides whether to print or not, just by looking at
->handled.

For example, it should not print MCE_HANDLED_CEC or MCE_HANDLED_EDAC,
etc cases. The assumption for the latter being that EDAC does its own
printing. Which then makes me wonder whether MCE_HANDLED_EDAC is enough.

Because this one bit would basically determine whether the error gets
printed or not. Which would mean that all EDAC drivers should print
it...

All I'm saying is, we should think about modalities like that.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
