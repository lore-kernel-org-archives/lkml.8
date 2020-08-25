Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F13C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 00:05:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02F7E206BE
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 00:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QApUvtXG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbgHYAFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 20:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbgHYAFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 20:05:36 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A291C061795
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 17:05:35 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id o18so14160880eje.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 17:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qSJ3hn6SwlvnIDydC8UlMXM4TqY2oPyCDRxRi3ibWKE=;
        b=QApUvtXGB19mVLe2YJN+0fc/ADwHcSDUAddvOk2oAlHGx94SRMwAiMJTJvczmY5/LJ
         5H8+z7s7ZKd4wBvGD40WowzmVgvVsHC7ykBwWbntxs+LCdWQ0VlGq5aJy0tz0qdKFdin
         uqbcvQg3gw5dEsFtO/tv+zUPbf76fN0Xd+WIdO2tZWQV+cPBuKHwpaS0iqoIazyjb0WC
         0VZo8VziYEC6cUStvp9KOD1OLo0QqjVFLoqT/QcWYj/HyXpaO7wUMO/DhvkzYkOkf+Q8
         50J2vA7dD1LC81Uhbyha05eeIKaAFh7rlFdSCBn2tV5rFA3cEm13F4JrxvRfM0oeesYi
         BmQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qSJ3hn6SwlvnIDydC8UlMXM4TqY2oPyCDRxRi3ibWKE=;
        b=ORAJKTnETHrUuw3d3ra7iS1FKS9LPliZoidWr3y6UhE0IAfKj96kv9SM4XO+pooW3N
         mD8jA8fumAY0EhgpMFPKeqGGcasi6W4NBmyhHnHCTnomon/CFTts/nr1629WQ3Ys1VYH
         epJMNwrJbiJ9k7nDUioJkzmug6Zf8tWLWAnzyeJMOzo7GQRv2FEtiTnPff/lQbnApw5U
         eRLkz30JvJLOhvH1lUBsBWfRiRXrVqj9BlK4NUBUnpZ7Wp+CMuFi1pqOAYaGvtvTabk7
         s2JaqN50U2i+UNORYD6KcCqbLykvFZykXm70U39WBzDnpX7+N1HnFS8nChRgQwUOIXeI
         +bMQ==
X-Gm-Message-State: AOAM531vHXLrTZ+OAJHIYloD7nxhzNrF1riC7Npe8RxV7YnTZrSsjOct
        pFc25t396vqQhK5TyNu4nAmRMOXGsLQ72nI5vYvDMg==
X-Google-Smtp-Source: ABdhPJwq7yY0fgxViANrAk7HQzEo+kQDYpeeuJOcuEDl5RbeTE9wZIRWTSGvgD/2fC4+y7BPhunkS6W3JpETlvNIrSg=
X-Received: by 2002:a17:906:a085:: with SMTP id q5mr7825181ejy.136.1598313933985;
 Mon, 24 Aug 2020 17:05:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200819224030.1615203-1-haoluo@google.com> <20200819224030.1615203-2-haoluo@google.com>
 <35519fec-754c-0a17-4f01-9d6e39a8a7e8@fb.com>
In-Reply-To: <35519fec-754c-0a17-4f01-9d6e39a8a7e8@fb.com>
From:   Hao Luo <haoluo@google.com>
Date:   Mon, 24 Aug 2020 17:05:22 -0700
Message-ID: <CA+khW7iGs=tN2FT=rEiPZMQ_Z9=sqhRe4dY7dKbVoViwX666BQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/8] bpf: Introduce pseudo_btf_id
To:     Yonghong Song <yhs@fb.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Quentin Monnet <quentin@isovalent.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, Andrey Ignatov <rdna@fb.com>,
        Jakub Sitnicki <jakub@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yonghong,

An update on this thread. I successfully reproduced this issue on a
8.2.0 gcc compiler, It looks like gcc 4.9 did not have this issue. I
was also using clang which did not show this bug.

It seems having a DW_AT_specification that refers to another
DW_TAG_variable isn't handled in pahole. I have a (maybe hacky) pahole
patch as fix and let me clean it up and post for review soon.

Hao
