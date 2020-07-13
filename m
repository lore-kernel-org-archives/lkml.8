Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D27C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 05:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D0A72068F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 05:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VsPMs39W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbgGMFXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 01:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgGMFX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 01:23:28 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADE7C061794
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 22:23:28 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id m9so5522153pfh.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 22:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:references:in-reply-to:mime-version:message-id
         :content-transfer-encoding;
        bh=8HTpo0rLAbXQ9sJmED8h5spUCrEX7xc2cH23pVXei/c=;
        b=VsPMs39WKpM0JSOhcFGXdH9t/tCGCCpJEGsF1vTCw8+UNA5nMg6xZPPEZzO/anZPpC
         rzhUt+jLNHMlV7n/IMmqTgltf3WX7SfGPMpwDEvjb7nZ3mIcJpAbeZQqOxAvX7HLc94C
         8jSCVmUWSZ8cwecHfZz9HrTB3fB9MHrdVoxMQ66rZ9uHC/G1uMKcllLeMFJG6uvG9T/k
         zYMNxqQQLGq1QPgHvsYrwhEmdOrmDLTlrP/KUuw5Zar+SLbi4SDKEDZan8K/yyrTepnI
         qpbAh8QOiOjJYTbKlsN7Lv+d7QI1yDlFn6sPrT8f1ChKaQosFxOK9LNTcGI3EGidJy7H
         vTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=8HTpo0rLAbXQ9sJmED8h5spUCrEX7xc2cH23pVXei/c=;
        b=mlpjJMtgO+bA8Xe3E29qx4ptvqyhg7sg6JRON/i/PqRKiZeBGIH00Y5YRBkgfcV1uR
         POnKX88Z40B/l6v51meYTEyQh9uLhGu1ciW6MYIhhyfPzmnKPrjFjmyjjj0hghtnsOWs
         qGGKAFo84QUTTQnP4Y10cxf5uQQNJMtSCZjOXqKS/yuXzTjUsRanTFMkjCGzoDnlSAoU
         ZODlXgiP8+AS31ypK0icVsMKeIJZ1u9Q/YGVV34CBZvWZV670vgyPTAhuV+JhE+Ex6SM
         6nPCOlWYyNAD7vMU5SbYfy3gVNKP4308NgVFUpeJrCg1ytn9MEAV484XwvtkpwFDBxeU
         IE8w==
X-Gm-Message-State: AOAM530yHYQURrbU+2nHVAsHIrZpbKBsGO96kand7oDNj5tJMBOwlCCe
        qK5688IlWkzKFUk7BznrG5g=
X-Google-Smtp-Source: ABdhPJwJbVRh3lz7pO+zhlE9p9BHDFomi7Q38ZynCP+xUInus4jUuggHpQQg9GCais0r5Nr6eovRdA==
X-Received: by 2002:a63:5412:: with SMTP id i18mr54386771pgb.63.1594617807820;
        Sun, 12 Jul 2020 22:23:27 -0700 (PDT)
Received: from localhost (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id 16sm13359573pjb.48.2020.07.12.22.23.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2020 22:23:27 -0700 (PDT)
Date:   Mon, 13 Jul 2020 15:23:21 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 0/3] Power10 basic energy management
To:     benh@kernel.crashing.org, ego@linux.vnet.ibm.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        mikey@neuling.org, mpe@ellerman.id.au, paulus@samba.org,
        pratik.r.sampat@gmail.com,
        Pratik Rajesh Sampat <psampat@linux.ibm.com>,
        ravi.bangoria@linux.ibm.com, svaidy@linux.ibm.com
References: <20200710052207.12003-1-psampat@linux.ibm.com>
In-Reply-To: <20200710052207.12003-1-psampat@linux.ibm.com>
MIME-Version: 1.0
Message-Id: <1594617564.57k8bsyfd0.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Pratik Rajesh Sampat's message of July 10, 2020 3:22 pm:
> Changelog v1 --> v2:
> 1. Save-restore DAWR and DAWRX unconditionally as they are lost in
> shallow idle states too
> 2. Rename pnv_first_spr_loss_level to pnv_first_fullstate_loss_level to
> correct naming terminology
>=20
> Pratik Rajesh Sampat (3):
>   powerpc/powernv/idle: Exclude mfspr on HID1,4,5 on P9 and above
>   powerpc/powernv/idle: save-restore DAWR0,DAWRX0 for P10
>   powerpc/powernv/idle: Rename pnv_first_spr_loss_level variable
>=20
>  arch/powerpc/platforms/powernv/idle.c | 34 +++++++++++++++++----------
>  1 file changed, 22 insertions(+), 12 deletions(-)

These look okay to me, but the CPU_FTR_ARCH_300 test for=20
pnv_power9_idle_init() is actually wrong, it should be a PVR test=20
because idle is not completely architected (not even shallow stop=20
states, unfortunately).

It doesn't look like we support POWER10 idle correctly yet, and on older
kernels it wouldn't work even if we fixed newer, so ideally the PVR=20
check would be backported as a fix in the front of the series.

Sadly, we have no OPAL idle driver yet. Hopefully we will before the
next processor shows up :P

Thanks,
Nick
