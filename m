Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB8CFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98A6E20671
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="VOSTfDei"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729834AbgEUOmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 10:42:33 -0400
Received: from mail4.protonmail.ch ([185.70.40.27]:43359 "EHLO
        mail4.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728256AbgEUOmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 10:42:32 -0400
Date:   Thu, 21 May 2020 14:42:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1590072151;
        bh=5QT3ozfWcrDejI0SGJuAQmXXo/lvctQ8f3juXhOhWLc=;
        h=Date:To:From:Cc:Reply-To:Subject:In-Reply-To:References:From;
        b=VOSTfDeiTZAhLr1uwY3qopK9+8Po5cvojbSeN5TiLsIQrFQAC4mygWQjt0lMVQxfa
         b0teiU5S5ySrgdGRsXwAp3xOennTBF+QVO9ck+j/kpxlihB4SD3QSuGpPTKYGy7ys/
         VI3bc8ouTV/gBOeM9yBzh0iSMGVwZs+YAV1xHJ/A=
To:     Thomas Gleixner <tglx@linutronix.de>
From:   Krzysztof Piecuch <piecuch@protonmail.com>
Cc:     "linux-kernel\\\\\\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo\\\\\\@redhat.com" <mingo@redhat.com>,
        "bp\\\\\\@alien8.de" <bp@alien8.de>,
        "hpa\\\\\\@zytor.com" <hpa@zytor.com>,
        "x86\\\\\\@kernel.org" <x86@kernel.org>,
        "rafael.j.wysocki\\\\\\@intel.com" <rafael.j.wysocki@intel.com>,
        "drake\\\\\\@endlessm.com" <drake@endlessm.com>,
        "viresh.kumar\\\\\\@linaro.org" <viresh.kumar@linaro.org>,
        "juri.lelli\\\\\\@redhat.com" <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "mzhivich\\\\\\@akamai.com" <mzhivich@akamai.com>,
        "malat\\\\\\@debian.org" <malat@debian.org>
Reply-To: Krzysztof Piecuch <piecuch@protonmail.com>
Subject: Re: [PATCH] x86/tsc: Add tsc_early_khz command line parameter overriding early TSC calibration
Message-ID: <lOHOPnM3pobUS8nKbA1uWAJqWkHj3CaQtmiaYCrf-2Bn13RZgsl8FWyKyGSCgLfIQIPeHP71CZT2lGZmUMFJBFhLtIpQeilTINbv54SrRvw=@protonmail.com>
In-Reply-To: <87h80at4gt.fsf@nanos.tec.linutronix.de>
References: <O2CpIOrqLZHgNRkfjRpz_LGqnc1ix_seNIiOCvHY4RHoulOVRo6kMXKuLOfBVTi0SMMevg6Go1uZ_cL9fLYtYdTRNH78ChaFaZyG3VAyYz8=@protonmail.com>
 <WIxfn1FPETITrmzdhnFHwujR0uEbHZ44PWZgmtRAzmj4rJ4wfzQUbcSWMtneOk0p7HkbJubs0z1BSLaBY3IXJarup8Ukw7Kv0WWYNgPk5bo=@protonmail.com>
 <87h80at4gt.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, February 1, 2020 8:52 PM, Thomas Gleixner <tglx@linutronix.de>=
 wrote:
> It's in my backlog and todo list

Hi, I just wanted to check if there's an ETA on this?

Thanks,
Krzysztof Piecuch
