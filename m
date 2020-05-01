Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE72C47254
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 598AC21775
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 21:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="D8WrYKrr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgEAV3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 17:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgEAV3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 17:29:22 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9691C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 14:29:21 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id h6so5393911qvz.8
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 14:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WJSxCtUrQ4kbv8PP6ebxsDg8QOID1HZc/ULg/GKvJlA=;
        b=D8WrYKrrFN3udsD0VgK1xx4C9GIV4kL38qjZF50x4kbItrsynRr8+ZrIXxtMSK3Urn
         yBnFHKDZxe6JUAPzCMqktSXvf3IrDQNU8F9kwmtpg7bf1xxsgSIUOyAskggSfpPK3b8z
         GqI7k3Nl5cgI8MChemP/HfDxgTa7rbf4GSclSMnRR5l00LHo3vTZbYgDb+0SmO9dblA7
         47R4nkXfwxO1yKsSrOhWr9RVewkel6yVSJguRlzWShCI8FNxG6iIW7WmOgWChiyZsl5L
         Gh6KqpGH5lfs+t1T2KXrtRCWQXypG2aqu9hjnVeEmWLrs7iXwvFA1gXl9u4IjtFFi+V8
         p/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WJSxCtUrQ4kbv8PP6ebxsDg8QOID1HZc/ULg/GKvJlA=;
        b=dzJYzFMBLt3YFKP3ZEYtJt/TuTZOGMDfZb8vYHP4Jw5q8MwTMP0NR577U6EtGEfF+V
         Dm9Pp+bnTVZo5Ppa/C9Kz+KE2NMGsxSjA0ELo/3fsI74jdlMid1z8I5nYYcildCrpSpI
         OoeYAMs3bkCYo9awxPKNzpOeHfv3/9k/yKYCO7DLe/3QEucxwJcTBOpmwvtmRoFKfbvd
         JiMs0ipJCFGmBs4SMPuL0nWlAotLIUfu2CK6atOmJ05sx470ZilEeIkzibUTzZZcOabA
         VzYySTMkdt2eITWeb8uGpw5ME08DUVAxWeLBW8fNrKjfXIW5uqI2DsaWA3TqyQZaz0yv
         uYQg==
X-Gm-Message-State: AGi0PuYpVOlZMwaD/8qX0YsJkJ60Qdj3dzsEPSlCIkg965v8soN0dwRZ
        Jv/+xO4II0h5qTnjFF2unTRl8A==
X-Google-Smtp-Source: APiQypKthgZJy1bXq0ePWD+aiR6wfk47apKr7P5G8WpkjIgDoImhnTRPKotO/I9RsAvYTC+h347F1w==
X-Received: by 2002:a0c:f90c:: with SMTP id v12mr5927106qvn.21.1588368561078;
        Fri, 01 May 2020 14:29:21 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id y6sm3493568qky.133.2020.05.01.14.29.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2020 14:29:20 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] mm: slub: add panic_on_error to the debug facilities
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200501211540.71216-1-aquini@redhat.com>
Date:   Fri, 1 May 2020 17:29:19 -0400
Cc:     Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, iamjoonsoo.kim@lge.com,
        rientjes@google.com, penberg@kernel.org, cl@linux.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <21CF143C-B9D1-4D3F-A875-370924265593@lca.pw>
References: <20200501211540.71216-1-aquini@redhat.com>
To:     Rafael Aquini <aquini@redhat.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 1, 2020, at 5:15 PM, Rafael Aquini <aquini@redhat.com> wrote:
>=20
> Sometimes it is desirable to override SLUB's debug facilities
> default behavior upon stumbling on a cache or object error
> and just stop the execution in order to grab a coredump, at
> the error-spotting time, instead of trying to fix the issue
> and report in an attempt to keep the system rolling.
>=20
> This patch introduces a new debug flag SLAB_PANIC_ON_ERROR,
> along with its related SLUB-machinery, in order to extend
> current slub_debug facilites and provide the aforementioned
> behavior override.

Instead of adding those things everywhere. How about adding something =
like panic_on_taint? Then, you could write specific taint flags you are =
interested in to that file because slab_bug() will taint it =
TAINT_BAD_PAGE.=
