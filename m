Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60321C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 20:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EECA21532
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 20:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q9jSqcl9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgFQURP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 16:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbgFQURO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 16:17:14 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D60C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 13:17:13 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id y17so1445280plb.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 13:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=f/zTJhdatEqLBfSYNcdO1If3TDUmj7o382cxxIHdBfU=;
        b=Q9jSqcl9aMW6eVrCIUWsJrgL3ZTltl3LoBJx2e6hUDHUpBqDcjBZeEINAd7wdVWhTu
         AxKO8x6CAHjx9qOL/X2adEfxZGtZ2c5FyVgmnOh5vCjTEGUwO+6trcQYwvaKizTUF+9h
         CD0EpvHFaXF+ZU7eV8dabBIhP9bavlZWPe7rA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=f/zTJhdatEqLBfSYNcdO1If3TDUmj7o382cxxIHdBfU=;
        b=nb6WsNYCP+ZBHPpFC9x8QmD+/3KPInBSpqRSwU5icW5LjfH7lrvpILh7sOD7jpUs1g
         lZYMAP2PwwebHSBYfMi+EYwsJyCUtztVwNjB5rfXMFJ2nFejB0I6K4N0iOTvkVYnCWLU
         cvAiGKp/Bg6WVEXhLo50aoHOsbXkK39fVjKv6TzlmZuFL7POOcf8TQy88l3ROr1l0UyN
         eX20wgD75j2BxO0Ha2CjR1NUeL6AUp3JUbrBznHk1ZKVfNRY5/hTJzcy7cLHPVILyDUl
         7sMwAKFVlkQFT/sW7Ay4ZjJd4njPwXDvjwe3sIpvJXH4H7mK8KKF07ueMpX3DxQk0WrY
         iT2A==
X-Gm-Message-State: AOAM5328iIB9miNsbA6UNDUB2LzsoYveEuzZMnQGqvN/OyM7w8Xa8kj+
        +zhFmCfU3mO2sNj3Q/c3cLvthQ==
X-Google-Smtp-Source: ABdhPJwoAng1nwunsT6f92eKG0oR1crDmJirw+H8je0Ny4o0eZWTOFchd77/xL3gv+yshR7IPBRejQ==
X-Received: by 2002:a17:90a:c258:: with SMTP id d24mr713016pjx.137.1592425033476;
        Wed, 17 Jun 2020 13:17:13 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id q92sm378725pjh.12.2020.06.17.13.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 13:17:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200617113851.607706-4-alexandru.elisei@arm.com>
References: <20200617113851.607706-1-alexandru.elisei@arm.com> <20200617113851.607706-4-alexandru.elisei@arm.com>
Subject: Re: [PATCH v5 3/7] arm64: perf: Remove PMU locking
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     mark.rutland@arm.com, Julien Thierry <julien.thierry@arm.com>,
        Peter Zijlstra <peterz@infradead.org>, maz@kernel.org,
        Jiri Olsa <jolsa@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, catalin.marinas@arm.com,
        Namhyung Kim <namhyung@kernel.org>, will@kernel.org
To:     Alexandru Elisei <alexandru.elisei@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Wed, 17 Jun 2020 13:17:12 -0700
Message-ID: <159242503203.62212.1690942414916053920@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alexandru Elisei (2020-06-17 04:38:47)
> From: Julien Thierry <julien.thierry@arm.com>
>=20
> The PMU is disabled and enabled, and the counters are programmed from
> contexts where interrupts or preemption is disabled.
>=20
> The functions to toggle the PMU and to program the PMU counters access the
> registers directly and don't access data modified by the interrupt handle=
r.
> That, and the fact that they're always called from non-preemptible
> contexts, means that we don't need to disable interrupts or use a spinloc=
k.

Maybe we should add a lockdep assertion that the code isn't preemptible?
I.e. add a cant_sleep() call? Or is it more that we don't need locking
because we're just doing register accesses and don't need to protect
those accesses from each other?
