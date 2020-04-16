Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 329A7C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 01:07:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF92C206A2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 01:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586999244;
	bh=UI4M0an9OkbdhL+z1BRG1hDVzizwYVRuyM+a3tTMfCo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YrIrROw6I+c0jBszYeL47xZ+rz9p7oQchGcXuIIsf2Fk5UrWnSN+S59QK7mVc4p/E
	 F/MWAwbc4wv/yOmSjJh1s3EYC399eS+8dErmNfIXRMqPZMMMtvPm85qVv+jCbc2zqB
	 zI1oNRuvS5YAG+AGlsdi6wh5p7ZXwDtaT0hKKHw0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406100AbgDPBHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 21:07:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:44574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405983AbgDPBHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 21:07:16 -0400
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 624ED2076D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 01:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586999234;
        bh=UI4M0an9OkbdhL+z1BRG1hDVzizwYVRuyM+a3tTMfCo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bfyhq9sqF7FRuWxkywlklaOcV7ssGH8RVZT1Ekf6iCGXmt7jSTgRKH5syW7f2hO8D
         nHctgiFDGfwKraDSkgphU02cdNZqBmn7M4Yskyl89BwlhJVNNd0mhozqzl60aEedcZ
         Tj/pYUEOw2d+fOqoGtVvwtaQzW1OyPT81jfiEwOM=
Received: by mail-wm1-f52.google.com with SMTP id g12so2983346wmh.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 18:07:14 -0700 (PDT)
X-Gm-Message-State: AGi0PuZ0AbRV/DrcOFdMDAp/u5WtlMOVWLZ3BMlJLWk47Cri515WKx28
        EG+DHHYgHSdUyMQUb2rPsJs+nVhP6koaDcE9aasSrg==
X-Google-Smtp-Source: APiQypJzorwgF6ubmFP/zRrR2ERVcZVr+7PihlCqYgHYoUSj9t/7JpVkQeE3O+1q2nyilBACGOANcrSWDpPQ/Y6TgEU=
X-Received: by 2002:a1c:4186:: with SMTP id o128mr1971946wma.21.1586999232899;
 Wed, 15 Apr 2020 18:07:12 -0700 (PDT)
MIME-Version: 1.0
References: <a5b07aa9-96ea-a9b5-13db-e5dcbd7760e6@intel.com>
 <BEA3CCB8-5127-4E6A-9696-E293C00BFA82@amacapital.net> <CABV8kRxqcCmPKtX3DDOf+47Re1hO1gMeUPhCd6HtDP0-SpcSBw@mail.gmail.com>
 <CALCETrVmsWZ+w6C4RV50DWoL0Qaiy+S6BtXr=QKQEg3MYgAc6w@mail.gmail.com> <CABV8kRxfMNxzy8r2P4GKj-22i+GMj=VDfPWAZB-VSgfrsQsjCA@mail.gmail.com>
In-Reply-To: <CABV8kRxfMNxzy8r2P4GKj-22i+GMj=VDfPWAZB-VSgfrsQsjCA@mail.gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 15 Apr 2020 18:07:01 -0700
X-Gmail-Original-Message-ID: <CALCETrWTDrcynTwpWZ6u6JXRL1rz6_vakLK7=BqMjCPCkQ+9dg@mail.gmail.com>
Message-ID: <CALCETrWTDrcynTwpWZ6u6JXRL1rz6_vakLK7=BqMjCPCkQ+9dg@mail.gmail.com>
Subject: Re: [RFC PATCH v2] x86/arch_prctl: Add ARCH_SET_XCR0 to set XCR0 per-thread
To:     Keno Fischer <keno@juliacomputing.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andi Kleen <andi@firstfloor.org>,
        Kyle Huey <khuey@kylehuey.com>,
        "Robert O'Callahan" <robert@ocallahan.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 5:10 PM Keno Fischer <keno@juliacomputing.com> wrote:
>
> > (why would you want to record with an unusual XCR0?)
>

Hmm.  I don't personally have a strong objection to allowing XCR0 to
be overridden as long as it's done reasonably sanely.  And maybe
requires a sysctl to be enabled.

Would it make matters easier if tasks with nonstandard XCR0 were not
allowed to use ptrace() at all?  And if ARCH_SET_XCR0 were disallowed
if the caller is tracing anyone?
