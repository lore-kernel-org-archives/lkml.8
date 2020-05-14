Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCAA3C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 980542065F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 19:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mEnsvt67"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728991AbgENTFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 15:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728661AbgENTFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 15:05:46 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5C5C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 12:05:46 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id s21so3768602ejd.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 12:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3tnon885BClw24KtSQO83UeeP0neoUdjMWWIznWI9/0=;
        b=mEnsvt67Bs+ijyGbEbYpmFzdKllOnYkYg2wqyJn5b8oZl+W2YcNusKGLRP9+Zv71aD
         bvnpNRlwm3n+nu/MfpFkeS29wmAqit1EIdY/5xYvN2+YHW5w1w9QzfKUAhu1z//b5FyV
         k7dGKz/gm2cwJDUdsjcAGnnZvIUs7DSgpSuU6dsJTiO54rNsE0omiR6rvOq+1m4zvUKk
         N2zTBxT+XyvQS/pazILhd2ryi6MMD4lCcnDv7gM9ufWdCfkhqBBALDBfJo5ZiNRNFLMF
         xssG0X9eIu48mho9U/h+tzq0gpyyTRyeOIE9nztgGi41aWzm4DOSTjaKMqC54Fvnv3Gb
         KttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3tnon885BClw24KtSQO83UeeP0neoUdjMWWIznWI9/0=;
        b=P955lVx1hdF0l2I7gicVl+l9u2DQAjSNSIf0FxVots2Su74VB+fuG0KNH6bZnimsp9
         44aLX2ECjXXAcorA/bf/dKnCGspOltaDayguc5wAvBuzhUxX0ZHxlPnDFkA160bb8UTb
         +BT0JM4Nk/8KwHqy0dIn/9BPSLdFMZn4cFy9MUnusIwVCqEmkhlidLt/qUqQJm4mQwYW
         BYYpbN2Ubi41zCnxrjc7QU2aNloU1c9Vbah0qBgfIEFxXPESyHl9jxTKK52s+PtYXUiw
         +Wj/ySyAHagDCRNLmcxA9YT6Atk9TAf2fG0PVcxn+ww1q8Pm+6Ff/NMlEx5SyyJUIu1B
         Fi8Q==
X-Gm-Message-State: AOAM533PI1BMU+NDBc2HuhA8kv7QDsjzG6O2DLUohPIeP50M51tLIGrb
        /MnWIedkdyPRsVoGUXZJmCEPgjarbSvUA7eupQYshtOiwoDMWQ==
X-Google-Smtp-Source: ABdhPJyXoPpJjnDEyX65MLtuSaVojJUla6uGMFPpeIL9qaCZ9kWwHdMrb4GwEnIrg9s40Ca65adiOCj7stM0y7lKZ6c=
X-Received: by 2002:a17:906:724b:: with SMTP id n11mr5455125ejk.355.1589483144432;
 Thu, 14 May 2020 12:05:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200421215316.56503-1-jarkko.sakkinen@linux.intel.com> <20200508190813.GP27052@linux.intel.com>
In-Reply-To: <20200508190813.GP27052@linux.intel.com>
From:   Seth Moore <sethmo@google.com>
Date:   Thu, 14 May 2020 12:05:32 -0700
Message-ID: <CAJsHiNx0jnx_zwCuNecci7opgCkxg-FB8UpYvnmubjWdM3fXZQ@mail.gmail.com>
Subject: Re: [PATCH v29 00/20] Intel SGX foundations
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-sgx@vger.kernel.org, akpm@linux-foundation.org,
        dave.hansen@intel.com, nhorman@redhat.com, npmccallum@redhat.com,
        "Huang, Haitao" <haitao.huang@intel.com>,
        andriy.shevchenko@linux.intel.com, tglx@linutronix.de,
        kai.svahn@intel.com, bp@alien8.de, josh@joshtriplett.org,
        luto@kernel.org, kai.huang@intel.com,
        David Rientjes <rientjes@google.com>, cedric.xing@intel.com,
        puiterwijk@redhat.com, Anna Sapek <asapek@google.com>,
        Conrad Parker <conradparker@google.com>,
        Keith Moyer <kmoy@google.com>,
        Yaozhang Xu <yaozhangx@google.com>,
        Chen Chen <chenalexchen@google.com>,
        Christian Ludloff <ludloff@google.com>,
        Carmen Hanish <cyhanish@google.com>,
        Kevin Yap <ikeviny@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 8, 2020 at 12:08 PM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> Adding some Google folks to the party.

Thanks, Sean.

> On Wed, Apr 22, 2020 at 12:52:56AM +0300, Jarkko Sakkinen wrote:
> > Intel(R) SGX is a set of CPU instructions that can be used by applications
> > to set aside private regions of code and data. The code outside the enclave
> > is disallowed to access the memory inside the enclave by the CPU access
> > control.
> >
> > There is a new hardware unit in the processor called Memory Encryption
> > Engine (MEE) starting from the Skylake microacrhitecture. BIOS can define
> > one or many MEE regions that can hold enclave data by configuring them with
> > PRMRR registers.
> >
> > The MEE automatically encrypts the data leaving the processor package to
> > the MEE regions. The data is encrypted using a random key whose life-time
> > is exactly one power cycle.
> >
> > The current implementation requires that the firmware sets
> > IA32_SGXLEPUBKEYHASH* MSRs as writable so that ultimately the kernel can
> > decide what enclaves it wants run. The implementation does not create
> > any bottlenecks to support read-only MSRs later on.
> >
> > You can tell if your CPU supports SGX by looking into /proc/cpuinfo:
> >
> >       cat /proc/cpuinfo  | grep sgx

We applied the v29 patches to Linux 5.6.0, then tested on Xeon(R) E-2186G
with Asylo (http://asylo.dev).

Looks good. All Asylo tests pass.

Tested-by: Seth Moore <sethmo@google.com>
