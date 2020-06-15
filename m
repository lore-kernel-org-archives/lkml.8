Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C25C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 20:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FAE82074D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 20:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="XyChLv1Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731525AbgFOUpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 16:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729692AbgFOUpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 16:45:49 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D533C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 13:45:49 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id g18so13773190qtu.13
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 13:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6NB11slt87BU+4xj4RQk4kGC454YPuIt0Wk8mlOD8qk=;
        b=XyChLv1QYsXD5ZuVVF4fG9lmqfNx/h8JnfCH2w2aLZmyMfg9fW63/yqx3dTabIZAL9
         Q3EN4/VBshdINKbNRUouJBzlsurFl6ppvkSQPivADTlfTNbZ2dBdRYCooQtDBi91uBX3
         fCDFeTuxjseCMpFGuxlKN+UO1Wpkv27H3zh6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6NB11slt87BU+4xj4RQk4kGC454YPuIt0Wk8mlOD8qk=;
        b=NoP6OPqFGEVt/7M8c6SroCvXBwDM3acYXTeSi2CUkJax0L6pxeCSXqEmL1F5n3oSlu
         uKMMWH/EByrXLAFAL9egYWMcIuEAN4txJdWLn7BcBcANUO5T5HneSVZ1hj+xjMFNOCLU
         bTyvjwhh28GYwhZ1Jc180mfTfo3Xff6aJ1yc4MW22GBVW4G2PTiQGiwHNUK/1CrhNJva
         aN/A4cAmaQkJXpuZKZblGxF9pvrxaGew2otLe3s3FBBSF66iziVN+9792xPd5LwPmeI+
         c1s5zOzQ1vvcpy69hNtYG+0JQ2Ofu2Kln6msJEqfT0IypHSC3yMRsigFgaKBvmuO4uRA
         tVJQ==
X-Gm-Message-State: AOAM5309mulypZ2XE5AAkSQxPihJMmGENR3FQUsLEje6ewKdWB7AzXVZ
        RaUrW3hasHmgAlFK81oOtQJTg365BkaTCUi17kvYKw==
X-Google-Smtp-Source: ABdhPJzS1j33q5F3QlrW3xLt0Lv+QX+HY5yC7a9+YDWovc8HBDcoIFoVVwjf5cJk1ADPwQiREl5cykqHZfnxVpdlK8c=
X-Received: by 2002:ac8:43ce:: with SMTP id w14mr17451952qtn.80.1592253948476;
 Mon, 15 Jun 2020 13:45:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200615190119.382589-1-drc@linux.vnet.ibm.com>
In-Reply-To: <20200615190119.382589-1-drc@linux.vnet.ibm.com>
From:   Michael Chan <michael.chan@broadcom.com>
Date:   Mon, 15 Jun 2020 13:45:36 -0700
Message-ID: <CACKFLimd0a=Y8WyvqCt4BD7SU_Cg1vQ=baKs6-uPv0dZuCm=mw@mail.gmail.com>
Subject: Re: [PATCH] tg3: driver sleeps indefinitely when EEH errors exceed eeh_max_freezes
To:     David Christensen <drc@linux.vnet.ibm.com>
Cc:     Netdev <netdev@vger.kernel.org>,
        Siva Reddy Kallam <siva.kallam@broadcom.com>,
        Prashant Sreedharan <prashant@broadcom.com>,
        Michael Chan <mchan@broadcom.com>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 12:01 PM David Christensen
<drc@linux.vnet.ibm.com> wrote:
>
> The driver function tg3_io_error_detected() calls napi_disable twice,
> without an intervening napi_enable, when the number of EEH errors exceeds
> eeh_max_freezes, resulting in an indefinite sleep while holding rtnl_lock.
>
> The function is called once with the PCI state pci_channel_io_frozen and
> then called again with the state pci_channel_io_perm_failure when the
> number of EEH failures in an hour exceeds eeh_max_freezes.
>
> Protecting the calls to napi_enable/napi_disable with a new state
> variable prevents the long sleep.

This works, but I think a simpler fix is to check tp->pcierr_recovery
in tg3_io_error_detected() and skip most of the tg3 calls (including
the one that disables NAPI) if the flag is true.
