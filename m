Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63EC4C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 12:26:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4389D2074B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 12:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgG3M0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 08:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbgG3M0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 08:26:53 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC7AC061794;
        Thu, 30 Jul 2020 05:26:53 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 185E83C8; Thu, 30 Jul 2020 14:26:49 +0200 (CEST)
Date:   Thu, 30 Jul 2020 14:26:45 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Mike Stunes <mstunes@vmware.com>
Cc:     "x86@kernel.org" <x86@kernel.org>, Joerg Roedel <jroedel@suse.de>,
        "hpa@zytor.com" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        Kees Cook <keescook@chromium.org>,
        David Rientjes <rientjes@google.com>,
        Cfir Cohen <cfir@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Martin Radev <martin.b.radev@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v5 00/75] x86: SEV-ES Guest Support
Message-ID: <20200730122645.GA3257@8bytes.org>
References: <20200724160336.5435-1-joro@8bytes.org>
 <B65392F4-FD42-4AA3-8AA8-6C0C0D1FF007@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B65392F4-FD42-4AA3-8AA8-6C0C0D1FF007@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Thu, Jul 30, 2020 at 01:27:48AM +0000, Mike Stunes wrote:
> Thanks for the updated patches! I applied this patch-set onto commit
> 01634f2bd42e ("Merge branch 'x86/urgent’”) from your tree. It boots,
> but CPU 1 (on a two-CPU VM) is offline at boot, and `chcpu -e 1` returns:
> 
> chcpu: CPU 1 enable failed: Input/output error
> 
> with nothing in dmesg to indicate why it failed. The first thing I thought
> of was anything relating to the AP jump table, but I haven’t changed
> anything there on the hypervisor side. Let me know what other data I can
> provide for you.

Hard to tell, have you enabled FSGSBASE in the guest? If yes, can you
try to disable it?

Regards,

	Joerg
