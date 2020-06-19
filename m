Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742C8C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 13:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CAF3206F1
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 13:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMObCSL9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732786AbgFSNZm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 09:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729080AbgFSNZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 09:25:41 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6D0C06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 06:25:41 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id 190so5564921vsr.9
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 06:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pe441WW1LSRPBER/VEbJr71Ehe68Su2JNokTKHgWsUo=;
        b=NMObCSL95MeDllpzNfH0ZIZFI9gkF+Nq9ikx+KgYGOL3YrPBj/NyGTy2yXCVZra3RT
         odLX1nmh3+/D9YyhGWxoWFmSXi0CcCCnfZfyp5PE9jo9Cp3ncOGKRZf4qXKgWtBdewAB
         tpu/HZho1v755nKSNN66unfqcGKPukGGUbUSk1QlOUG8TajVCebhjLeATKFjFx8vQtSX
         8n5LKY/u8XRsMX0DU5ia8SG1wNir9yV0p5oJkAqAJ6X9v5aRtdsGVNSbDf1XCRdYwW1w
         l3GEtlxQQ86ncH2xy+0Fd8ABfZxgPRs+JMRxvBnE1Ql2W3uDSeN07n/NHDfiVfXxZ5ET
         TH9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pe441WW1LSRPBER/VEbJr71Ehe68Su2JNokTKHgWsUo=;
        b=uP3LPqt577KHsKxFZr9RVZlRS0gjYLJyNQ/hpfL3cJaby5T60v1sasfi8nIo2TaDji
         O54onsC6pLC+KP+5NAclI8L0PBo40DfoI6ERGP5rb7RxkQLFitlzIuHWABALKzdklJgy
         VF7w3Fj7FRnk9aNrBaNQbVtkcYIVylfpizfEvzWv1Cua5EMC9wN0mcJMEkQgns5uNktr
         stYn91N3x7qcUY9R4tY4ZYKGXScy3czgfb45gZwC0CuTX4bvWuD8ng2G5qFVKImQHJHN
         E2rSXChgsJ2qwhHHPm6PUkmpfttpkE7ESMnCVWS5EJsNzmG6dS7p0KI5JRJ82FA8YzR9
         cxZw==
X-Gm-Message-State: AOAM532CRGq2ly175ZSSNNawr8Okd02SDkmn8W3xAnsNrII6S3W+sxY9
        aItgHXefxy8H/mRk8RWKRYolj5bdka/qL3qUcig=
X-Google-Smtp-Source: ABdhPJzrnULhvbYSHWb4G/lzbbPmR2mlw4laspTNJshTGQvru6rETCFSB0YjIa3VA6ykCwQjvSV8DCHN4XQduCEVb04=
X-Received: by 2002:a67:f595:: with SMTP id i21mr7602571vso.3.1592573140318;
 Fri, 19 Jun 2020 06:25:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200618210215.23602-1-daniel.gutson@eclypsium.com>
 <589c89ae-620e-36f8-2be5-4afc727c2911@intel.com> <CAFmMkTHNxSN_uWtm63TdkGxj44NXQQKEOmATXhjA=4DSCS92kQ@mail.gmail.com>
 <23babf62-00cb-cb47-bb19-da9508325934@intel.com>
In-Reply-To: <23babf62-00cb-cb47-bb19-da9508325934@intel.com>
From:   Richard Hughes <hughsient@gmail.com>
Date:   Fri, 19 Jun 2020 14:25:28 +0100
Message-ID: <CAD2FfiFbGdf5uKmsc14F4ZuuCUQYFwfnirn=Y0fu2F0=njvWug@mail.gmail.com>
Subject: Re: [PATCH] Ability to read the MKTME status from userspace
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Daniel Gutson <daniel@eclypsium.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jun 2020 at 00:52, Dave Hansen <dave.hansen@intel.com> wrote:
> It doesn't tell you if your data is encrypted.

Sorry for the perhaps naive question, but I thought MKTME was
essentially full physical memory encryption?

Richard
