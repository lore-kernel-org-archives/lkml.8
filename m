Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347FAC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 08:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AC4B20885
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 08:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NiT/3X7F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731230AbgFSI0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 04:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730849AbgFSI0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 04:26:22 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED11C06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 01:26:22 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id v11so4198711pgb.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 01:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=WXQ7rs75ysSuFXnqcpZI4RQbdQAod6KuSMFSARqJDrQ=;
        b=NiT/3X7FtCjDbvhves0ttBJCo44g1c7YJKgUI/62LwHAz5JWAnZ8cfG+J7idLiekNp
         L9T9P46EfV7B9fRtZ3f9BomcD1exZhuQmng35FSpTmqK1cOg81XgaM+bkCz+BRoCA6FT
         YEIfg8/09/MUz3Jo0uFYLoKnlx5vjx+Vrse58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=WXQ7rs75ysSuFXnqcpZI4RQbdQAod6KuSMFSARqJDrQ=;
        b=k2Z/6CrcWfxRhhvnkTkM4E12pIdnEDkCEzsVk5oEsRz1Lj1ak/0pr2lFYKLX+FFBnC
         jMhj0TLdgBqnUr4Mxp8ro3gDDO1SyM+7rL99/E9tC24vxg6ZcV3nGLnAsnz0Tq/cyd1d
         ny+oQ3qRWueatam4aVm12+BQr2dp3QzXKwdnMmyi6b+M0fvpuGnQqixrAA5Clo4F0wy0
         u7MaZcufZJhawKtKSz2u8gNObjWVkVV9bq0dLBhwVJxjw6T3iXAAnyfmSyBSC2gPVXtc
         yxRx2o75PLp7K8B99m3dAx8puzlyptf3K4M7k2Xw8012jHOaebKStJCriIKvPxNggrpJ
         yATA==
X-Gm-Message-State: AOAM532jQAWX8Zu4EfmJgVxaDM1JHTcNvLujW7bewo2UQvP5BLaPAgW5
        eXTZSlMeoJyvaJRC4t3MUcn1ug==
X-Google-Smtp-Source: ABdhPJzf9EWOeMIjHS06RooaLfY53xadIU9NuVnJQfCmehzesRrSQLbdUlX5VUm3pG0zXTw/ZgG90w==
X-Received: by 2002:a63:e00b:: with SMTP id e11mr2108298pgh.75.1592555181824;
        Fri, 19 Jun 2020 01:26:21 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id g19sm5091669pfo.209.2020.06.19.01.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 01:26:21 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <bca9a873-3e69-f68d-2266-5f82704580d1@arm.com>
References: <20200617113851.607706-1-alexandru.elisei@arm.com> <20200617113851.607706-3-alexandru.elisei@arm.com> <159242468708.62212.1739215996563155762@swboyd.mtv.corp.google.com> <bca9a873-3e69-f68d-2266-5f82704580d1@arm.com>
Subject: Re: [PATCH v5 2/7] arm64: perf: Avoid PMXEV* indirection
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     mark.rutland@arm.com, Julien Thierry <julien.thierry@arm.com>,
        Peter Zijlstra <peterz@infradead.org>, maz@kernel.org,
        Jiri Olsa <jolsa@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, catalin.marinas@arm.com,
        Namhyung Kim <namhyung@kernel.org>, will@kernel.org,
        Julien Thierry <julien.thierry.kdev@gmail.com>
To:     Alexandru Elisei <alexandru.elisei@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Fri, 19 Jun 2020 01:26:20 -0700
Message-ID: <159255518036.62212.17118495764504925359@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alexandru Elisei (2020-06-18 03:51:08)
> On 6/17/20 9:11 PM, Stephen Boyd wrote:
> > Quoting Alexandru Elisei (2020-06-17 04:38:46)
> >> From: Mark Rutland <mark.rutland@arm.com>
> >> @@ -433,8 +494,9 @@ static u64 armv8pmu_read_counter(struct perf_event=
 *event)
> >> =20
> >>  static inline void armv8pmu_write_evcntr(int idx, u64 value)
> >>  {
> >> -       armv8pmu_select_counter(idx);
> >> -       write_sysreg(value, pmxevcntr_el0);
> >> +       u32 counter =3D ARMV8_IDX_TO_COUNTER(idx);
> > Might be a good idea to make ARMV8_IDX_TO_COUNTER a static inline
> > function that has a return type of u32. I had to go check the code to
> > make sure it wasn't something larger.
>=20
> Architecturally, there are at most 32 counter registers, which would fit =
in an s8,
> so I don't think type checking would really help us here.

Ok. It would have saved me a few seconds while reading the code, but I
guess if I hold the architecture in my head I'll be ok too.
