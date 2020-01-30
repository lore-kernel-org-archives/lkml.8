Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A37E9C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 19:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5317D20658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 19:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="xTVum6uC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbgA3TKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 14:10:09 -0500
Received: from mail-40130.protonmail.ch ([185.70.40.130]:16031 "EHLO
        mail-40130.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727448AbgA3TKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 14:10:09 -0500
Date:   Thu, 30 Jan 2020 19:10:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1580411406;
        bh=B793CPK7LFZlogFfXtw3UaxaxhpPATfXTFrDbkKkc18=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:
         Feedback-ID:From;
        b=xTVum6uCmTJ+JCOIv6JPfPZachOF+tuUjb97ymAqmThugbzSW9Y68ynTokTLqUpLb
         oneS9WeREjHNj7S3xdV12+3udnxVpMXUN6pkNKNmau7w9kHncJrjeyW4jrASxRYHw3
         CZvPGDYpXIUmPRd3vq0vFEUD5zSGFUwNpIcygOoA=
To:     "linux-kernel\\@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Krzysztof Piecuch <piecuch@protonmail.com>
Cc:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo\\@redhat.com" <mingo@redhat.com>,
        "bp\\@alien8.de" <bp@alien8.de>, "hpa\\@zytor.com" <hpa@zytor.com>,
        "x86\\@kernel.org" <x86@kernel.org>,
        "rafael.j.wysocki\\@intel.com" <rafael.j.wysocki@intel.com>,
        "drake\\@endlessm.com" <drake@endlessm.com>,
        "viresh.kumar\\@linaro.org" <viresh.kumar@linaro.org>,
        "juri.lelli\\@redhat.com" <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "mzhivich\\@akamai.com" <mzhivich@akamai.com>,
        "malat\\@debian.org" <malat@debian.org>,
        "piecuch@protonmail.com" <piecuch@protonmail.com>
Reply-To: Krzysztof Piecuch <piecuch@protonmail.com>
Subject: Re: [PATCH] x86/tsc: Add tsc_early_khz command line parameter overriding early TSC calibration
Message-ID: <WIxfn1FPETITrmzdhnFHwujR0uEbHZ44PWZgmtRAzmj4rJ4wfzQUbcSWMtneOk0p7HkbJubs0z1BSLaBY3IXJarup8Ukw7Kv0WWYNgPk5bo=@protonmail.com>
In-Reply-To: <O2CpIOrqLZHgNRkfjRpz_LGqnc1ix_seNIiOCvHY4RHoulOVRo6kMXKuLOfBVTi0SMMevg6Go1uZ_cL9fLYtYdTRNH78ChaFaZyG3VAyYz8=@protonmail.com>
References: <O2CpIOrqLZHgNRkfjRpz_LGqnc1ix_seNIiOCvHY4RHoulOVRo6kMXKuLOfBVTi0SMMevg6Go1uZ_cL9fLYtYdTRNH78ChaFaZyG3VAyYz8=@protonmail.com>
Feedback-ID: krphKiiPlx_XKIryTSpdJ_XtBwogkHXWA-Us-PsTeaBSrzOTAKWxwbFkseT4Z85b_7PMRvSnq3Ah7f9INXrOMw==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can I please have some feedback on this patch?


Kind regards,
Krzysztof Piecuch

