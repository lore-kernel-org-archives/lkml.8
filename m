Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5E9C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 07:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90F4D20738
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 07:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="VSxbzCRm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728316AbgEUH0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 03:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgEUH0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 03:26:07 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8DAC061A0E;
        Thu, 21 May 2020 00:26:07 -0700 (PDT)
Received: from zn.tnic (p200300ec2f0c82002db258470e3f635c.dip0.t-ipconnect.de [IPv6:2003:ec:2f0c:8200:2db2:5847:e3f:635c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A7B311EC02B1;
        Thu, 21 May 2020 09:26:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1590045964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Jljlzrbe6Cwi8pmzDsl0C5++jb9+/KEj29n629dTZKI=;
        b=VSxbzCRmWCEe1ed3hI2g/V77fa5/yViTapiMajoyKHz39l8IWQw56zWCkidnqoTcGYjdrP
        Mz0jukKM9Glxyvn2aQwfdliWFDnCd6MOm13YoIuqo2P00V35xyKDMVh/Ocdadm7RTtUz+f
        wokIuL8M8j7JPVoNK+6KBkgDxRjRICw=
Date:   Thu, 21 May 2020 09:25:58 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Marco Elver <elver@google.com>
Cc:     Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-tip-commits@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>
Subject: Re: [tip: locking/kcsan] READ_ONCE: Use data_race() to avoid KCSAN
 instrumentation
Message-ID: <20200521072557.GA10099@zn.tnic>
References: <20200511204150.27858-18-will@kernel.org>
 <158929421358.390.2138794300247844367.tip-bot2@tip-bot2>
 <20200520221712.GA21166@zn.tnic>
 <CANpmjNPsEMF8qq4qHoJEDb8mi211QzXODvnakh2fj3BOw+56MQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANpmjNPsEMF8qq4qHoJEDb8mi211QzXODvnakh2fj3BOw+56MQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 12:30:39AM +0200, Marco Elver wrote:
> This should be fixed when the series that includes this commit is applied:
> https://lore.kernel.org/lkml/20200515150338.190344-9-elver@google.com/

Yap, that fixes it.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
