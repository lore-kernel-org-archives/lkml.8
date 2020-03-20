Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C8FC4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 21:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 292E320724
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 21:16:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="hb8w3WLL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbgCTVQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 17:16:26 -0400
Received: from mail.skyhub.de ([5.9.137.197]:40192 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbgCTVQZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 17:16:25 -0400
Received: from zn.tnic (p200300EC2F0A5A0095ADC0D452E3E28B.dip0.t-ipconnect.de [IPv6:2003:ec:2f0a:5a00:95ad:c0d4:52e3:e28b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A0B741EC0664;
        Fri, 20 Mar 2020 22:16:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1584738983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=6FUnR1+rgqh8bg7YQgyAaQ2EQLlBeDx2vaZ0dVmL6EI=;
        b=hb8w3WLL9sXj9bDqN+8ilS7w7Iu0KvsDqjfaTE79LwgC3reIMlBV+bekoHrcPLf0vRYpEo
        CTZxNQFpCzsLD63kbrrzGM9LSi/vKX+o5aoNYnCzMsVk2GpcD517adZjLhvV1kd4/v6OrI
        FSetEuGJdpVPg5eYKBYVtuclnqumGTU=
Date:   Fri, 20 Mar 2020 22:16:31 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Alexey Makhalov <amakhalov@vmware.com>
Cc:     "linux-x86_64@vger.kernel.org" <linux-x86_64@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Juergen Gross <jgross@suse.com>
Subject: Re: [PATCH 0/5] x86/vmware: Steal time accounting support
Message-ID: <20200320211631.GI23532@zn.tnic>
References: <20200320203443.27742-1-amakhalov@vmware.com>
 <20200320205929.GH23532@zn.tnic>
 <A9A30A6C-F5C3-45ED-8225-07EFF4F6E8E4@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <A9A30A6C-F5C3-45ED-8225-07EFF4F6E8E4@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 09:06:57PM +0000, Alexey Makhalov wrote:
> I didn't receive any response first time. I'm not on the list.

The mail was sent to you directly:

Date: Fri, 13 Mar 2020 14:17:42 +0100
From: Borislav Petkov <bp@alien8.de>
To: Alexey Makhalov <amakhalov@vmware.com>
....

Perhaps in your spam folder.

Did you, per chance, receive this reply:

https://marc.info/?l=linux-virtualization&m=158403993331603&w=2

?

> Thanks for reporting i386 issue. I'll address it in v2.

Thx.

Btw, please do not top-post.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
