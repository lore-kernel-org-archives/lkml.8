Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D79C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90EB622B4B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:16:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="k3nY8FAT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730532AbgHTRP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 13:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730490AbgHTRPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 13:15:37 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23191C061385;
        Thu, 20 Aug 2020 10:15:27 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0c060044fc628f6f806d19.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:600:44fc:628f:6f80:6d19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5E64C1EC03CF;
        Thu, 20 Aug 2020 19:15:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1597943724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=vKmqzspNFgqlKgscTSJ8NWWh/MNhmcmcJfDXPcKbT1g=;
        b=k3nY8FAT9c8XXhtkWm5XTXfDBTll5csquTTop2JB53IaQkGD1YmzGhvbiRSeRewbwpXswZ
        SQP8mNMUwxJUtugASmSXOFB001R3jS74TohlirB5PO10RTrDPyLvcpKMMeJdLAcdDTYnSI
        s426S8HnRszxmDRUbbxpev8qg7TP++g=
Date:   Thu, 20 Aug 2020 19:15:18 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc:     linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony.luck@intel.com, x86@kernel.org,
        Smita.KoralahalliChannabasappa@amd.com
Subject: Re: [PATCH] x86/mce: Increase maximum number of banks to 64
Message-ID: <20200820171518.GB17271@zn.tnic>
References: <20200820170624.1855825-1-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200820170624.1855825-1-Yazen.Ghannam@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 05:06:24PM +0000, Yazen Ghannam wrote:
> From: Akshay Gupta <Akshay.Gupta@amd.com>
> 
> ...because future AMD systems will support up to 64 MCA banks per CPU.
> 
> MAX_NR_BANKS is used to allocate a number of data structures, and it is
> used as a ceiling for values read from MCG_CAP[Count]. Therefore, this
> change will have no functional effect on existing systems with 32 or
> fewer MCA banks per CPU.

Of course it will, grep for MAX_NR_BANKS and look at all those bitmaps
and arrays which get defined with MAX_NR_BANKS size. With your change,
they will double in size.

How much does vmlinux size grow with your change?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
