Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18B7C35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 23:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 746A920838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 23:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZcKoqhVq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbgBFX2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 18:28:43 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:53024 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgBFX2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 18:28:43 -0500
Received: by mail-pl1-f201.google.com with SMTP id c19so145971plz.19
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 15:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=PSJH9GYraFPbhcG+DGJnLRxMg/i8Sc5VCunvDN6ByYQ=;
        b=ZcKoqhVqqTxaA7bcY8f1rBLOLO2Mlig83ZXxynCX61+JalVusJ5YJZuiZQPmpNMDhf
         qxHbsKwEo+cMzNEoJ2u7H+ZwvQOiIb/udcQF70az20a4Bpk0w9WHnpSjajxQ5hB4ijfc
         X2uSaNAiJrkMGCJ/uRZ2BkjsQ5dEpv2kyNN6CGK7P4MIPSBCZlgYMC/VePgg0c9jN7mv
         cpF+JJblF4iEO00UI1S9tHbJ892XOaCfG8gmnOyhdAHFVtTDelqzIBWMwbmKYeFiKZbq
         msmqODnP8qH3gI7v1zwWTLqqsZ5nJoQdPb6O76k76Qni2tEulHYLM68KfzR58nacD8dQ
         BwLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=PSJH9GYraFPbhcG+DGJnLRxMg/i8Sc5VCunvDN6ByYQ=;
        b=MgdxhTLiNROshQqjM3fH6pXADWnOQw6FIK4+p/fRETwTh07+JadfWP4debC/1cMyoE
         CnQ5QwvUE4ta1owPe3/upL5zyQLpHhdgLI8fu7i/IfgyVgWmsIUoFe/a3DdsE0bqF1uU
         rEdvcEfiIGxBznW8aNcpXZuGbvwfklwegwA8sGDzcnCjF6lU0EMxrkhWwiPEqi1w39qB
         EqHqsT15CDINHwEdtGQlo9qGAmoVXojcVwhBuZJrvAM4rNkrtIAJzg6H7EWmc7Yvw3re
         Jnld81srVIJmyJHgCwk+HzvIrNXMPK1FuG2jlu2Zw85BGMmBnALblcxdgr6IsaeXRVk5
         nbmw==
X-Gm-Message-State: APjAAAVY2JNstfO2yrc/zEJa6s9uveeGh4neijCP8iMctTwuLckaB85W
        iBT7LB+/ec6pskC02JO+yFvOeQrM0v6YRFNn1m0=
X-Google-Smtp-Source: APXvYqxU+blpeLlP9bV/bbHLagRRMIGJxCkP2rCxNMXwLELINAyD+jYB2Eb4CHdzI3chcTfQARAPyBxdMqhPAZR0/KI=
X-Received: by 2002:a63:ba03:: with SMTP id k3mr6733096pgf.52.1581031722616;
 Thu, 06 Feb 2020 15:28:42 -0800 (PST)
Date:   Thu,  6 Feb 2020 15:28:40 -0800
In-Reply-To: <20200206200345.175344-1-caij2003@gmail.com>
Message-Id: <20200206232840.227705-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20200206200345.175344-1-caij2003@gmail.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: RE: [PATCH] ASoC: soc-core: fix an uninitialized use
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     caij2003@gmail.com
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org, perex@perex.cz,
        tiwai@suse.com, clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Fixed the uninitialized use of a signed integer variable ret in
> soc_probe_component when all its definitions are not executed. This
> caused  -ftrivial-auto-var-init=pattern to initialize the variable to
> repeated 0xAA (i.e. a negative value) and triggered the following code
> unintentionally.

> Signed-off-by: Jian Cai <caij2003@gmail.com>

Hi Jian,
I don't quite follow; it looks like `ret` is assigned to multiple times in
`soc_probe_component`. Are one of the return values of one of the functions
that are called then assigned to `ret` undefined? What control flow path leaves
`ret` unitialized?
