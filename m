Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BF2C35E15
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 21:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56BE52176D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 21:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729052AbgBYVUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 16:20:02 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:49686 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728753AbgBYVTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 16:19:52 -0500
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.1.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 62A77200AFA;
        Tue, 25 Feb 2020 21:19:50 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 1D9C420BDB; Tue, 25 Feb 2020 22:11:04 +0100 (CET)
Date:   Tue, 25 Feb 2020 22:11:04 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Brian Gerst <brgerst@gmail.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v2 4/8] x86, syscalls: Refactor SYS_NI macros
Message-ID: <20200225211104.GD3954@light.dominikbrodowski.net>
References: <20200224181757.724961-1-brgerst@gmail.com>
 <20200224181757.724961-5-brgerst@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224181757.724961-5-brgerst@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 01:17:53PM -0500, Brian Gerst wrote:
> Pull the common code out from the SYS_NI macros into a new __SYS_NI macro.
> Also conditionalize the X64 version in preparation for enabling syscall
> wrappers on 32-bit native kernels.

Same comment about naming; looks good otherwise.

Thanks,
	Dominik
