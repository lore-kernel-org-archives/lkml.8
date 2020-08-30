Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A48C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 08:01:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7EEC20714
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 08:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e17tUimt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbgH3IBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 04:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbgH3IBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 04:01:42 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C8DAC061573
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 01:01:42 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id i26so4130139ejb.12
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 01:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y/8mkZkNr8MCMt5D6YbG+h46YXVdjKr6kILMxJe8eeQ=;
        b=e17tUimtOqdDOpNkjROCuuIderSWFMKZO8bmgr6bl9Zy7xZjs2vVWoCjw3I7un4Bp0
         vJVh+kX5Hm7sJ+xLxqDAGZcta+FXZEHy2kN2Jkdxw5CYcQsYIt8YpHaWyIAvC3txbFZd
         2QGBYw9bAr/bFQAlP/ECkTafc1hQtvvZ3aZRTmDCb08HAByLFah2J2FlQiUl8f0NK2aS
         catDqxqlUK88PbTeQtgZOLUjllGv/XJSEjT2lq/xLRCzLNxk5MxLKDMf+mu4eTJzWGSo
         IgL3XCQzoFAVO2bqVcXe7bmeE401N4Q/tB4/aJJ79Gx3E9Ace0BfuxsgQNS+t+g6Mac6
         zvFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y/8mkZkNr8MCMt5D6YbG+h46YXVdjKr6kILMxJe8eeQ=;
        b=Kmat9i6KQq7PmUfRL9W1TYWtwQVqKX0eEBnL3KVVdHMaExybEOXIuMxPFV0tuNdRRm
         D7hTNQfZalUMab8jw+nzZkQQcOIx9Z3pABRpmLOKBUZ4kzm1iVd7ycvquFiJ2Ha9Mls4
         As/1dHFJHXmNMPY0UocEQ+8nh9hbrEqk1ahSm3Uyl7OHKZAbeDwb2vPtY55CwGWqUfmM
         gkR03PBSsw5mpXUzqKBA8MqL4TOKM/JbbHNsZ8jM6fHCzBc/6OuHCjeLUvhWgGpywt0e
         cOBTM4MPWpwZdV1eXFSgKD31As3ztRMsnlnwZ+WuIZ5OINxWS51FZ8lq7GKkehY2iexv
         aOkA==
X-Gm-Message-State: AOAM533zN5YP3XlVfzhjHROKQ9t37IOTssSV6/luPcMlExgtupxNUE2D
        HZCqBq93Hz4wmpXfHrESTY4Yzm1AweHtB2uiSt8=
X-Google-Smtp-Source: ABdhPJyHI1vhRcIh7T+QdG1gOkjboGssT04ZTA/RaYK/qvgRQZM+xTcwmU9xfnSyeFg9BxT8qV6/GQyEkB9L3EBcd9w=
X-Received: by 2002:a17:907:7094:: with SMTP id yj20mr6554020ejb.471.1598774500814;
 Sun, 30 Aug 2020 01:01:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1598598459.git.zong.li@sifive.com> <ee6a18d118b65cca0602e32bbb8be092f63ae8b6.1598598459.git.zong.li@sifive.com>
In-Reply-To: <ee6a18d118b65cca0602e32bbb8be092f63ae8b6.1598598459.git.zong.li@sifive.com>
From:   Pekka Enberg <penberg@gmail.com>
Date:   Sun, 30 Aug 2020 11:01:22 +0300
Message-ID: <CAOJsxLHuX-nXFS6Dp+X=_hOrbT=-FUvWF_oM+6q508r=MNnFrQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] riscv: Add cache information in AUX vector
To:     Zong Li <zong.li@sifive.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        david.abdurachmanov@sifive.com,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 10:09 AM Zong Li <zong.li@sifive.com> wrote:
> +uintptr_t get_cache_geometry(u32 level, enum cache_type type)
> +{
> +       struct cacheinfo *this_leaf = get_cacheinfo(level, type);
> +       uintptr_t ret = (this_leaf->ways_of_associativity << 16 |
> +                        this_leaf->coherency_line_size);

You are dereferencing "this_leaf" without checking if it's NULL here.

> +
> +       return this_leaf ? ret : 0;
> +}

- Pekka
