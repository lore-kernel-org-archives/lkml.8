Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8503C54FCB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 12:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4F3B20704
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 12:28:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgDYM2m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 08:28:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:41410 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbgDYM2m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 08:28:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4A503AC52;
        Sat, 25 Apr 2020 12:28:39 +0000 (UTC)
Date:   Sat, 25 Apr 2020 14:28:35 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Mike Stunes <mstunes@vmware.com>
Cc:     joro@8bytes.org, dan.j.williams@intel.com,
        dave.hansen@linux.intel.com, hpa@zytor.com, jgross@suse.com,
        jslaby@suse.cz, keescook@chromium.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, luto@kernel.org,
        peterz@infradead.org, thellstrom@vmware.com,
        thomas.lendacky@amd.com, virtualization@lists.linux-foundation.org,
        x86@kernel.org
Subject: Re: [PATCH] Allow RDTSC and RDTSCP from userspace
Message-ID: <20200425122835.GM30814@suse.de>
References: <20200319091407.1481-56-joro@8bytes.org>
 <20200424210316.848878-1-mstunes@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424210316.848878-1-mstunes@vmware.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On Fri, Apr 24, 2020 at 02:03:16PM -0700, Mike Stunes wrote:
> I needed to allow RDTSC(P) from userspace and in early boot in order to
> get userspace started properly. Patch below.

Thanks, but this is not needed anymore. I removed the vc_context_filter
from the code. The emulation code is now capable of safely handling any
exception from user-space.

Regards,

	Joerg

