Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B815C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 13:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB67A20873
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 13:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbgBLNWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 08:22:32 -0500
Received: from 8bytes.org ([81.169.241.247]:53860 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725887AbgBLNWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 08:22:31 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id B828620E; Wed, 12 Feb 2020 14:22:29 +0100 (CET)
Date:   Wed, 12 Feb 2020 14:22:20 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     x86@kernel.org, hpa@zytor.com, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Jiri Slaby <jslaby@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Juergen Gross <JGross@suse.com>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 50/62] x86/sev-es: Handle VMMCALL Events
Message-ID: <20200212132220.GI20066@8bytes.org>
References: <20200211135256.24617-51-joro@8bytes.org>
 <DC865D59-CAD2-4D1C-919B-1C954B1EFFB1@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DC865D59-CAD2-4D1C-919B-1C954B1EFFB1@amacapital.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 04:14:53PM -0800, Andy Lutomirski wrote:
> 
> How about we just don’t do VMMCALL if we’re a SEV-ES guest?  Otherwise
> we add thousands of cycles of extra latency for no good reason.

True, but I left that as a future optimization for now, given the size
the patch-set already has. The idea is to add an abstraction around
VMMCALL for the support code of the various hypervisors and just do a
VMGEXIT in that wrapper when in an SEV-ES guest. But again, that is a
separate patch-set.

Regards,

	Joerg
