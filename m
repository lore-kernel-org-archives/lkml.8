Return-Path: <SRS0=/Won=67=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C734CC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 22:32:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A84C3206D8
	for <linux-kernel@archiver.kernel.org>; Sun, 17 May 2020 22:32:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="dbef1oYS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgEQWcU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 May 2020 18:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbgEQWcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 May 2020 18:32:20 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FD9C05BD09
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 15:32:20 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id o19so6626593qtr.10
        for <linux-kernel@vger.kernel.org>; Sun, 17 May 2020 15:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=LP9STx9KAcYlT8EP1YvHTa404NbzvXbgRc01RV/FwMQ=;
        b=dbef1oYSgsywx0nRRPaRjclSurSGt2ltZblZbzEF8WGCLA/WGus+ApCpA19E/BJsH7
         EJJRRcIsHLYTccHRnvRp4Fcn2ifdXAz1IJ6q5lyk0Cobo297LAde+SD/GLiXUCYgSXja
         xSIc+GF6larmGSM/On/7SFyzFQwUiny2WbixNGv90DZPBwrDNeXASP8JgmWVWyBaTzjp
         8Vi9q2N6XF33JpO8V0/m2M81dyGgRzEX4bPQDkR2JfYxj++vN4Dz3SjGf3O3UBZ+re2v
         f0z0nbGpUqbGaTmtG9fts1psmWlpBe3Yee1ZG71phAmkenDmW7POCgq93paPVcenQpb2
         MSLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=LP9STx9KAcYlT8EP1YvHTa404NbzvXbgRc01RV/FwMQ=;
        b=g9w9QZstT2ruWoISZ0D+X7cEJkc8e2ENrFb4/vgayo8njWibZT/6x/1+Az0ukjqmdG
         Y19oz4f0UjGkDYLn0GdfG77KABNnvD+53l7ym5xJew4nD3rvl/jqOxgUL9wT/qzBIpHu
         3w3LiJmlKmiZ6y+VMrzUFwQ7zK9JnJTI6eLl6DQ3HcQOMBG2w7S3KMPKpxa7Dz7iS5qB
         qhtPusc0igqAZl2eZ49RhuM43qGLdruUHsSVDh8gI/pGaqdBhljiya7YCdMcSnN+N9YG
         w5N/fzqG9So3QVZDvWvVcCbbtHiwFpK3/pix3LogV0Te5H3NcznIFlUSoYs/BJW0VKAg
         KlOg==
X-Gm-Message-State: AOAM532mKeNLmvSghfZHoxbYz0dRv06D4JAYaXFfLqQUKbEL+kut/z0k
        XIhilVrGMssRGfnrp5AzWfnXxMrYkYMcFQ==
X-Google-Smtp-Source: ABdhPJxmOEz8m9V23l2wkXWPvlMuVGuXS44oaQFkcTEO1iLU4sNQowz4sZbAxTj4SdguIK1s6HeXKQ==
X-Received: by 2002:ac8:4d96:: with SMTP id a22mr8799313qtw.10.1589754739300;
        Sun, 17 May 2020 15:32:19 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id y21sm6945437qkb.95.2020.05.17.15.32.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 May 2020 15:32:18 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: Kmemleak infrastructure improvement for task_struct leaks and call_rcu()
Date:   Sun, 17 May 2020 18:32:17 -0400
Message-Id: <DBDDABA2-C24E-49F4-85D7-F5B354B8E5C7@lca.pw>
References: <20200513095939.GA2719@gaia>
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
In-Reply-To: <20200513095939.GA2719@gaia>
To:     Catalin Marinas <catalin.marinas@arm.com>
X-Mailer: iPhone Mail (17E262)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 13, 2020, at 5:59 AM, Catalin Marinas <catalin.marinas@arm.com> wro=
te:
>=20
> I guess we don't need the full stack trace. About 4 function calls to
> the refcount modification should be sufficient to get an idea.

That should work. I will probably only have cycles to code this after v5.7 i=
s released (have to fight with regression bugs in linux-next first), so feel=
 free to beat me to it.=
