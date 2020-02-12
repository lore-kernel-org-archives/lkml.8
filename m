Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53A9C47409
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A824C20873
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728884AbgBLJ2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 04:28:05 -0500
Received: from foss.arm.com ([217.140.110.172]:57894 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728696AbgBLJ2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 04:28:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E75D430E;
        Wed, 12 Feb 2020 01:28:03 -0800 (PST)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.71])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5C2143F6CF;
        Wed, 12 Feb 2020 01:28:02 -0800 (PST)
Date:   Wed, 12 Feb 2020 09:28:00 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Hector Marco-Gisbert <hecmargi@upv.es>,
        Will Deacon <will.deacon@arm.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Jann Horn <jannh@google.com>,
        Russell King <linux@armlinux.org.uk>, x86@kernel.org,
        kernel-hardening@lists.openwall.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 6/7] arm64, elf: Disable automatic READ_IMPLIES_EXEC
 for 64-bit address spaces
Message-ID: <20200212092800.GD488264@arrakis.emea.arm.com>
References: <20200210193049.64362-1-keescook@chromium.org>
 <20200210193049.64362-7-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210193049.64362-7-keescook@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 11:30:48AM -0800, Kees Cook wrote:
> With arm64 64-bit environments, there should never be a need for automatic
> READ_IMPLIES_EXEC, as the architecture has always been execute-bit aware
> (as in, the default memory protection should be NX unless a region
> explicitly requests to be executable).
> 
> Suggested-by: Hector Marco-Gisbert <hecmargi@upv.es>
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
