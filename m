Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379DCC433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 20:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12F3E207DF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 20:28:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e+YdMIZb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbgGTU2Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 16:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728324AbgGTU2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 16:28:15 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52E6AC0619D4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 13:28:14 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id e18so14471350ilr.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 13:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jnROxpLTebfdg0VQxLM+qOeJIWXx+3VtqAPYTCwBg5A=;
        b=e+YdMIZbfHuIN71zlAV9pte6XTKkIrMTuKqwzmQZxOkC954LaZlH12s9VMPeezYI/f
         Jzv9Vzo+NY9vuVMW7D959S2Cdvs9ichUR+pxGCUw8tgcn9EqQtUg+gaQcJ0/MHWorqZG
         /UDNGpn0SIDSdKMAMJQOHR7Re670rfu9J3bP/upy5wVU8JbcSWFw7jSVkEhpbdUvmmwy
         2XkrGG80hp9CMfvxOaOhxtD9ErS7CIYgMtAd9PUGPwpxpdRbgachvMNiitkCzU4SDh6e
         WfI7egJn+xCqdGw1WJUiGfrYepxPaHbyfX45EeOp+TCrHvYYLqEQ82fwEjcD0Fx5Lj35
         diTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jnROxpLTebfdg0VQxLM+qOeJIWXx+3VtqAPYTCwBg5A=;
        b=g02xyPXae6Xcu5TnFnUdcsZ9Emt7Fnt9YGTR9cSr4h1/kJhnDBO8QUz1DHImldwaXi
         TYHgVqjWpkcMun5dkKAfQAO7oXgXDZPGCWhfdl0YxpknI8p07AgLqBt/Pw6cjOTi44cA
         w53HDg1UXJWxPOSlNZ5u8xL1Zji5j8xGvrKKYiyb0y6kOejmoeFPtdqjGEPJKM1vkh6D
         0tJgBPBnhf2+qW8M9KcKR7iWX6x3nJcM9zjvl9u+dVxvcNlX1LS2uy4v5YBEJnCaY+P9
         RnvJO8BEh6m+XGFLR+2lP887E9vct1hQtLRMuRfu8WQZUZ6CFK8why/G0NgUdVLRBqeU
         iByA==
X-Gm-Message-State: AOAM531udxG+VEd0sBdTbCJOXwtsiXDhRgSdfvTBsLMsP8U7apYV/4bk
        tDNMcvjYRlOcHQ2UQm5P6JEA01PVGnpyfO5ZSuKa4A==
X-Google-Smtp-Source: ABdhPJziZBrq7Pg+3/2EhDfmIw4gaLRIAxqYeGhCSSFHEMO8VPg5I18oqjIhNgbraAGINUvLf5g9njXh6av9exRpt4U=
X-Received: by 2002:a92:bb57:: with SMTP id w84mr25017823ili.104.1595276893343;
 Mon, 20 Jul 2020 13:28:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200715214312.2266839-1-haoluo@google.com> <20200715214312.2266839-3-haoluo@google.com>
 <CAEf4BzYxWk9OmN0QhDrvE943YsYd2Opdkbt7NQTO9-YM6c4aGw@mail.gmail.com>
In-Reply-To: <CAEf4BzYxWk9OmN0QhDrvE943YsYd2Opdkbt7NQTO9-YM6c4aGw@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Mon, 20 Jul 2020 13:28:02 -0700
Message-ID: <CA+khW7i9wq0+2P_M46pEv-onGXL_=sW7xE=10CYeP_yjPh-Rpw@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next 2/2] selftests/bpf: Test __ksym externs with BTF
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin@isovalent.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> This should ideally look like a real global variable extern:
>
> extern const struct rq runqueues __ksym;
>
>
> But that's the case for non-per-cpu variables. You didn't seem to
> address per-CPU variables in this patch set. How did you intend to
> handle that? We should look at a possible BPF helper to access such
> variables as well and how the verifier will prevent direct memory
> accesses for such variables.
>
> We should have some BPF helper that accepts per-CPU PTR_TO_BTF_ID, and
> returns PTR_TO_BTF_ID, but adjusted to desired CPU. And verifier
> ideally would allow direct memory access on that resulting
> PTR_TO_BTF_ID, but not on per-CPU one. Not sure yet how this should
> look like, but the verifier probably needs to know that variable
> itself is per-cpu, no?
>

Yes, that's what I was unclear about, so I don't have that part in
this patchset. But your explanation helped me organize my thoughts. :)

Actually, the verifier can tell whether a var is percpu from the
DATASEC, since we have encoded "percpu" DATASEC in btf. I think the
following should work:

We may introduce a new PTR_TO_BTF_VAR_ID. In ld_imm, libbpf replaces
ksyms with btf_id. The btf id points to a KIND_VAR. If the pointed VAR
is found in the "percpu" DATASEC, dst_reg is set to PTR_TO_BTF_VAR_ID;
otherwise, it will be a PTR_TO_BTF_ID. For PTR_TO_BTF_VAR_ID,
reg->btf_id is the id of the VAR. For PTR_TO_BTF_ID, reg->btf_id is
the id of the actual kernel type. The verifier would reject direct
memory access on PTR_TO_BTF_VAR_ID, but the new BPF helper can convert
a PTR_TO_BTF_VAR_ID to PTR_TO_BTF_ID.

Hao
