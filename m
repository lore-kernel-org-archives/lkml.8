Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E774C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 15:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 685962076A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 15:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cs-cmu-edu.20150623.gappssmtp.com header.i=@cs-cmu-edu.20150623.gappssmtp.com header.b="y9GjytsK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S371247AbgDOPI6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 11:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388223AbgDOPIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 11:08:54 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D49DC061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 08:08:54 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id f13so13346477qti.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 08:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs-cmu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zHjgRngcxp4AR6+D17yxXUy7WIPm1jT5Q+rQhvyf/FI=;
        b=y9GjytsKMQ+oZy9UDO8XhfI+uLUyDw62L1UOqN6vu0FAUq2jz4NHihuZ1/7E8ytw0d
         1VeWL14WK7i2JrRkh4SiL6o/aVMCWcK0rbFoACNEm1faH7Ahf79eigNpdjdf4Z1jD9l9
         SdC+Kv1inHJt9ezk7CoRk+1x6+tlM//a+CnW35QeeeAa+8gRNNFs1kJA5FB1CqqP7/JQ
         QXPB69NxwbKdwQmBrUJJYtDE1uWaAF8DUxQ/e3RxECjGvKa7Oay18MUamu2cRDE0tcl4
         pZWO4vPILwfeZpYbeL5uTut1JiVoczQOPe61MN+bGE+D5Y6Li83xINxWzprCwTOlsDyM
         RVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zHjgRngcxp4AR6+D17yxXUy7WIPm1jT5Q+rQhvyf/FI=;
        b=iRARbHqkV5a16FxFI8pF5C793Bo2XzlphPECVF4JV3Lyf518W6pkANUU+BX1hFqfAz
         q/uYZgWE6CzzNskP55FDHna483ayC6fi4g4k0aiPotx1/9NfxV+GKsLndugX07U1Qv/q
         CqUXbONVJAqYL/BV6FC7PLwX3me31hCvcBFACLbfLehiT7QI3VpEI1wd097exftGSeBZ
         07/M9ZA/DI23kjDaxJBYwh/xoyxWqSu5h9YvEh7lDHtuLt+HUb8bw677u9Ha01p9mo0N
         8AmDVKijQfDpXbBqFxzoNomB9sBtyQNPQK+7+LyNOgabkb4ywzqutzkIrykzjzANG/Wy
         FxlQ==
X-Gm-Message-State: AGi0PuYAqvZYbMn5VLDBcHWNAu0H/OZ6dBbMuN79PHolCse9svHJ4MrW
        XkJ5fKtXFzV99uzq5Yx0Wl6nmKdYTJs=
X-Google-Smtp-Source: APiQypKBqVse0i/useuOKX9XIPZQeNQaGGpsDVaFjEJEOygDSozZAzhTK3chUTvgoREaBZJYXKbWrA==
X-Received: by 2002:ac8:4e2c:: with SMTP id d12mr1849346qtw.204.1586963333213;
        Wed, 15 Apr 2020 08:08:53 -0700 (PDT)
Received: from cs.cmu.edu (tunnel29655-pt.tunnel.tserv13.ash1.ipv6.he.net. [2001:470:7:582::2])
        by smtp.gmail.com with ESMTPSA id i6sm11541894qkk.123.2020.04.15.08.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 08:08:51 -0700 (PDT)
Date:   Wed, 15 Apr 2020 11:08:49 -0400
From:   Jan Harkes <jaharkes@cs.cmu.edu>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 11/34] docs: filesystems: convert coda.txt to ReST
Message-ID: <20200415150849.6vvcka4dxenpwbe3@cs.cmu.edu>
References: <cover.1586960617.git.mchehab+huawei@kernel.org>
 <e3dd3b8835e132090cb82d0acda1947c8bacf156.1586960617.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3dd3b8835e132090cb82d0acda1947c8bacf156.1586960617.git.mchehab+huawei@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 10:39:25AM -0400, Mauro Carvalho Chehab wrote:
> This document has its own style. It seems to be print output
> for the old matrixial printers where backspace were used to
> do double prints.

Ha, yes the original was probably generated with something like
troff/nroff.

> For the conversion, I used several regex expressions to get
> rid of some weird stuff. The patch also does almost all possible
> conversions in order to get a nice output document, while keeping
> it readable/editable as is:
 
Looks good to me.

Jan

