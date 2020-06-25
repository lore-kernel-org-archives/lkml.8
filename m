Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593BDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 21:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2164320768
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 21:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ODWrabi6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405768AbgFYVO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 17:14:56 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55152 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404016AbgFYVOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 17:14:55 -0400
Received: from zn.tnic (p200300ec2f0ed100d8d4e97d1105ac1f.dip0.t-ipconnect.de [IPv6:2003:ec:2f0e:d100:d8d4:e97d:1105:ac1f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7C86A1EC03D6;
        Thu, 25 Jun 2020 23:14:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1593119694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=dXxVfxv7f3F5/PiC22toYmhLfZrwalx+qVjBPwz2Dvg=;
        b=ODWrabi6owFfOhAtTV4fO/MRr6wwEEONMqy6WkwxfUD0IGwFQpDbsj4LFwsBj4qFB5GUUb
        rtzBZJFKXeP+U/jpuDwqDc58bzMJZVYDcr9A2vUXXdAKtf6lPKHtPWt+k0AGtH8YzNJNeI
        mqNvdOyuK2t/JrDgJx5NrWOMkSIfqEA=
Date:   Thu, 25 Jun 2020 23:14:53 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Daniel Gutson <daniel.gutson@eclypsium.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Ability to read the MKTME status from userspace (patch
 v2)
Message-ID: <20200625211453.GS20319@zn.tnic>
References: <20200625211029.34733-1-daniel.gutson@eclypsium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200625211029.34733-1-daniel.gutson@eclypsium.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 06:10:29PM -0300, Daniel Gutson wrote:
> The intent of this patch is to provide visibility of the
> MKTME status to userspace. This is an important factor for
> firmware security related applilcations.
> 
> Changes since v1:
> * Documentation/ABI/stable/securityfs-mktme-status (new file)
> * include/uapi/misc/mktme_status.h (new file)
> * Fixed MAINTAINER title.
> * cpu.h: added values to the enumerands
> * Renamed the function from get_mktme_status to mktme_get_status
> * Improved Kconfig help
> * Removed unnecessary license-related lines since there is a SPDX line
> * Moved pr_fmt macro before the includes
> * Turned global variables (mktme_dir, mktme_file) as static
> * Removed BUFFER_SIZE macro
> * No longer returning -1 for error, but using the previously error.
> * No more pr_info for the normal behavior.
> * Renamed this from a kernel driver to a kernel module.

No, we don't want a module driver which, as Dave explained, tells you
exactly nothing whether encryption is actually enabled on the system.
Didn't that become clear from the thread last time?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
