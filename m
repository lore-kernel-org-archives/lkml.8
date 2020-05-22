Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83ECC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 16:03:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A93162070A
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 16:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="FDO1NMHh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730782AbgEVQDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 12:03:07 -0400
Received: from mail.skyhub.de ([5.9.137.197]:45830 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730434AbgEVQDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 12:03:04 -0400
Received: from zn.tnic (p200300ec2f0d4900b09f96a43b2d9a69.dip0.t-ipconnect.de [IPv6:2003:ec:2f0d:4900:b09f:96a4:3b2d:9a69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1C2261EC02DD;
        Fri, 22 May 2020 18:03:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1590163383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=csSB0914Hrh/0IU4/pqgjvgE7wKnM+aJVmgN6mu2PUQ=;
        b=FDO1NMHhN1dknm/vy0RpBLWpZYWFufOWVu2bVB1sePypQCadpOXztqhqu+7sx3RTw1gavi
        i1RzOmCOPmTYw06gocNmrJXdCdgyso28Byssl5uXjK7zUuQ4Vo+/mVjf+NHdIkAFuYcoHO
        CPfxrRSGN5WXwWhSl9KIGu71H7qV3XU=
Date:   Fri, 22 May 2020 18:02:55 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Alexander Monakov <amonakov@ispras.ru>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org, Yazen Ghannam <yazen.ghannam@amd.com>,
        Brian Woods <brian.woods@amd.com>,
        Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH 1/3] x86/amd_nb: add AMD family 17h model 60h PCI IDs
Message-ID: <20200522160255.GG28750@zn.tnic>
References: <20200510204842.2603-1-amonakov@ispras.ru>
 <20200510204842.2603-2-amonakov@ispras.ru>
 <20200522144527.GA172805@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200522144527.GA172805@roeck-us.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 07:45:27AM -0700, Guenter Roeck wrote:
> I didn't see a response from any of the x86 maintainers,

It is on a TODO list and will be handled soon.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
