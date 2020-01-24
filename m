Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D034FC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 16:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B14B820709
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 16:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390460AbgAXQzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 11:55:00 -0500
Received: from ms.lwn.net ([45.79.88.28]:46198 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387674AbgAXQy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 11:54:59 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 188F32D6;
        Fri, 24 Jan 2020 16:54:59 +0000 (UTC)
Date:   Fri, 24 Jan 2020 09:54:57 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: nvdimm: use ReST notation for subsection
Message-ID: <20200124095457.33cee77e@lwn.net>
In-Reply-To: <20200118153620.8276-1-lukas.bulwahn@gmail.com>
References: <20200118153620.8276-1-lukas.bulwahn@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Jan 2020 16:36:20 +0100
Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

> The ACPI Device Specific Methods (_DSM) paragraph is intended to be a
> subsection of the Submit Checklist Addendum section. Dan Williams however
> used Markdown notation for this subsection, which does not parse as
> intended in a ReST documentation.
> 
> Change the markup to ReST notation, as described in the Specific
> guidelines for the kernel documentation section in
> Documentation/doc-guide/sphinx.rst.
> 
> Fixes: 47843401e3a0 ("libnvdimm, MAINTAINERS: Maintainer Entry Profile")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Jonathan, please pick this small doc fixup.

Applied, thanks.

jon
