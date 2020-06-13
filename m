Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE3FC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 17:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C0742078A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 17:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="jjhW0IgQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgFMRDY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 13:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgFMRDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 13:03:23 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD45C03E96F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 10:03:21 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id w3so12002809qkb.6
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 10:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=TVoF46ZTp3UNeAoEv5PyfO7EYExBt4O+bZ/7yxKofXw=;
        b=jjhW0IgQ5iypg/RAK65TJNtp969dLa6vQ9x2xTLeqLtYLtF5kW/dsxRMMU7Se8MRuM
         HESFz0USBa+Az+ganFw6KppBpdAjqcirv8FzCsXfw+Dex9jW3woqoVsRjGkgsLpF8ib1
         H45UmGZYF+Wv3bIwZHOM+8nHKe2qO42woDE+gQdAmvDHQOMN+dS7trEQVrbqAnat/Urx
         vLr4UFJSo1FCfuJcYzV7r6yMkXLfGjiDwjrEMR5O7y/V0DnTkLcilSQAkxtNMfg6vlCu
         2lQ/FVGxXEexTsFs58UHDozXyZxsK0zIEceGviLzVPQL3fkia/v+viAALAiF/Kwtblhk
         fVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=TVoF46ZTp3UNeAoEv5PyfO7EYExBt4O+bZ/7yxKofXw=;
        b=um9h0bdo7rCXIhiOSdyD8dlOHY7BAVjGlPudpXxtkSrzOGWHhi8Zfh13R6ljY6B8VG
         WBcz722CDvrYdRFq4DWpE8fQw2H6fF2i3ITBwCCO4O4KGzOuxIUZ5yq3TTeexrx/ePlF
         lZLuiVHZrEDwio8395JjC9hQUacQqp8tNVHv7atBPZIvAygrJFh67dzv4M5LO7lK0Y+q
         KY51OvHvK/CdREGei4PCSDbqzoN+WQ9pXFmgoirAyngqXPKt/vc/vhyBK6ml/7MkqSMp
         EulEvX/Oo4ygMgfElw0BcsumSlzhP+SLbL10Q9b/c03BOAXORy32X+BPWRFMsQInG3Z1
         Oqqw==
X-Gm-Message-State: AOAM531JooAEUX3jGOmM8910BGiCzWmEKoyIcJwdnGjXYvfQcl78eH35
        8YdfC6KtUQ1+iQJ390Lz8FrsLg==
X-Google-Smtp-Source: ABdhPJxL/peZzHm9lHbgK/Wk0caaFbOcx/W4LEUeSo4fOOmG1PgUC9LfcvhBECo3kquzmr8NOBHO6w==
X-Received: by 2002:a05:620a:21cc:: with SMTP id h12mr8301162qka.194.1592067800115;
        Sat, 13 Jun 2020 10:03:20 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id c191sm6627234qke.114.2020.06.13.10.03.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jun 2020 10:03:19 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: AMD SME + KASAN = doom
Date:   Sat, 13 Jun 2020 13:03:18 -0400
Message-Id: <E41B9DFC-F407-4C6A-BCFB-6E3E6B72BA0C@lca.pw>
References: <20200613155449.GB3090@zn.tnic>
Cc:     Thomas.Lendacky@amd.com, brijesh.singh@amd.com, tglx@linutronix.de,
        glider@google.com, peterz@infradead.org, dvyukov@google.com,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
In-Reply-To: <20200613155449.GB3090@zn.tnic>
To:     Borislav Petkov <bp@suse.de>
X-Mailer: iPhone Mail (17F80)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 13, 2020, at 11:54 AM, Borislav Petkov <bp@suse.de> wrote:
>=20
> $ head arch/x86/mm/Makefile
> # SPDX-License-Identifier: GPL-2.0
> # Kernel does not boot with instrumentation of tlb.c and mem_encrypt*.c
> KCOV_INSTRUMENT_tlb.o                   :=3D n
> KCOV_INSTRUMENT_mem_encrypt.o           :=3D n
> KCOV_INSTRUMENT_mem_encrypt_identity.o  :=3D n
>=20
> KASAN_SANITIZE_mem_encrypt.o            :=3D n
> KASAN_SANITIZE_mem_encrypt_identity.o   :=3D n
>=20
> so something else needs to be de-KASAN-ed too.

Okay, I=E2=80=99ll try to figure out what else needs to be done.

>=20
> For now flip your Subject: AMD SME - KASAN =3D boot.

Which is a bit of shame because KASAN is proved useful for testing and at th=
e same time SME could flags some issues with drivers like megasas_raid (wher=
e the driver will do a  firmware dump during the boot which I plan to debug m=
ore a bit later).=
