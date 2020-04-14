Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 605B4C2BB85
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 03:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EE9D2072D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 03:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KsKjd1kT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404947AbgDNDyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 23:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728841AbgDNDyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 23:54:09 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDE0C0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 20:54:09 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id o127so11850104iof.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 20:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ou7sPaeQnH1fiZWbpYfpKPp578BHz2/53EHQUMJ28qw=;
        b=KsKjd1kTdDBUsdPUOvD/rQMazJ1aa9sm/3VPhy41JsP7jr4phl7U8diMsIpuxvKSWw
         hDKba+88qk5QhDJZI31GQLXWdxqJZRupnfu0lqHG56BJw/yO1TVhH+5cm2wrpZkTtGEM
         z9A5K4QjZQgXRB+KYpeUGWY/jo8O8WB4qFteBg4KVwQRxwGSO+tgStl0dbNyFUfug23E
         4E5wQ1zHBVswp5e75X5nHNiL/ZBBGaioZQ2ZpF6SUp0Qm6CY/Dj9dVZm+oxCX11zvJWb
         XePiePnl9ObDZQWOdiImoudrxgfPR1ZmEG2jED2u+UTuTkC15vd80pKDXk6wMC5CDwL7
         op5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ou7sPaeQnH1fiZWbpYfpKPp578BHz2/53EHQUMJ28qw=;
        b=mdZEzt9tIYYqKbd2xaZbKo4SIKCxtmIFpFrP7uo5/yId9RBTgIYXVBzyjpBnK4XZkN
         AbAzhiTeO9TA8K5kfLpBtf3vbWNp313fnWa+l2qQCkugPjmNifXSwFFSyXP1bqV+NqPw
         0PfT5JsMV3uEpYbyOGUIWtKu3Xry9PSLt7gTfi1Aw4kFPZ4X/Mhq+QbWHwVJ3w4MnAso
         lSJhLwpyYqJtFIktF5MBdvfnMQENf/hz1jmr4UruvmHRMT3O3lMERWM0IzUjiAvfXO74
         ZqVTfWhaFEuVOt5xIEpakGUEtS6ctc29W4zzd882ckTFCHquqE0vuUK9moeyHYsRHXcX
         3qrw==
X-Gm-Message-State: AGi0PuZDJyeLyoHp0LB/XGa3ysv8YPgAserMk9Tv9btfvfHeugRTViRZ
        JluVnTfdYBiTr3CFbM/topunJ8ISfpGrzY6b8pP4Qw==
X-Google-Smtp-Source: APiQypKX9CgulmoRJFUZ483VPGpN9M7xFoE7JTd5SdG1HdHttjAuBjbYEUa5jMgYJ976q1s87Ck1J4jTe2q2KMKMTu0=
X-Received: by 2002:a6b:3989:: with SMTP id g131mr19440338ioa.202.1586836448578;
 Mon, 13 Apr 2020 20:54:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200414020953.255364-1-matthewgarrett@google.com> <1ba40c555115e5a2770e95b974096016fbfc3606.camel@intel.com>
In-Reply-To: <1ba40c555115e5a2770e95b974096016fbfc3606.camel@intel.com>
From:   Matthew Garrett <mjg59@google.com>
Date:   Mon, 13 Apr 2020 20:53:57 -0700
Message-ID: <CACdnJut0MkQerQbMeaqDz81iaeQRvdgqw2MpTvNOi_1ch06qGw@mail.gmail.com>
Subject: Re: [PATCH V2 1/3] thermal/int340x_thermal: Export GDDV
To:     "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "Aram, Nisha" <nisha.aram@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 8:33 PM Pandruvada, Srinivas
<srinivas.pandruvada@intel.com> wrote:
> Anything changed in v2 series?

Sorry, forgot to explain the diffs. Patch 2 in V2 was passing the
wrong value to sysfs_attr_init(), but I didn't notice during testing
because that's a macro that does nothing unless a specific debug flag
is set. The kernel build bot noticed. Only difference is passing the
correct argument there.
