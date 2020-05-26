Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1724C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 08:51:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8425D2073B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 08:51:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731428AbgEZIvu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 04:51:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:43654 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725771AbgEZIvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 04:51:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id B95F4AB3D;
        Tue, 26 May 2020 08:51:51 +0000 (UTC)
Subject: Re: [PATCH] xen: move xen_setup_callback_vector() definition to
 include/xen/hvm.h
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20200520161600.361895-1-vkuznets@redhat.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <dd3925a5-b01f-9381-6711-4f912ac04fb5@suse.com>
Date:   Tue, 26 May 2020 10:51:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200520161600.361895-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.05.20 18:16, Vitaly Kuznetsov wrote:
> Kbuild test robot reports the following problem on ARM:
> 
>>> drivers/xen/events/events_base.c:1664:6: warning: no previous prototype
>    for 'xen_setup_callback_vector' [-Wmissing-prototypes]
> 1664 | void xen_setup_callback_vector(void) {}
> |      ^~~~~~~~~~~~~~~~~~~~~~~~~
> The problem is that xen_setup_callback_vector is a x86 only thing, its
> definition is present in arch/x86/xen/xen-ops.h but not on ARM. In
> events_base.c we have a stub for !CONFIG_XEN_PVHVM but it is not
> declared as 'static'.
> 
> On x86 the situation is hardly better: drivers/xen/events/events_base.c
> doesn't include 'xen-ops.h' from arch/x86/xen/, it includes its namesake
> from include/xen/ so we also get the 'no previous prototype' warning.
> 
> Currently, xen_setup_callback_vector() has two call sites: one in
> drivers/xen/events_base.c and another in arch/x86/xen/suspend_hvm.c. The
> former is placed under #ifdef CONFIG_X86 and the later is only compiled
> in when CONFIG_XEN_PVHVM.
> 
> Resolve the issue by moving xen_setup_callback_vector() declaration to
> arch neutral 'include/xen/hvm.h' as the implementation lives in arch
> neutral drivers/xen/events/events_base.c.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
