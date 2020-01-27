Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCC9DC32771
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 11:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EBF8214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 11:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TeflSVeC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730379AbgA0LQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 06:16:52 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:35157 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729235AbgA0LQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 06:16:52 -0500
Received: by mail-io1-f67.google.com with SMTP id h8so9512724iob.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 03:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B2jn7Up2+cD+eD0D5ROwEvtEdti9pDs97jpRUZiU808=;
        b=TeflSVeClgOmybuUdraDwRDq9IBddwlPu0A697aG3aE5gp2/aIDp2vvWgEWA/XhPU5
         DKrgrbvlYYAdAEyYGSHlCA3Lyu+tHHlgxKD4D17+p9Ty0j+YOIKzJpDWzCaU11xjS2ga
         tAECbeUjD+qPWCI4YH854OjSrAxIK+z8wE4kY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B2jn7Up2+cD+eD0D5ROwEvtEdti9pDs97jpRUZiU808=;
        b=IykOX0byjB07Stl/ndz90pBkblcpN6z52Ym6MhrQfobJDX/Dwn0vWbBB9JxOCTF0BS
         4KOH/Yud2jPkzaLhm6tJ2tQykyPU7/STi37hN9k5rqNjuaBYyBJLLH03tA+VtzO1CbMM
         bP4ULv59bkECk90G9/rqkM7bGMxHAR6PWdMqIZDCKan+4nFz4Np59vbs4sSxHelZwiaR
         MMEAjm7e8E40MiVksoFRVQYq7ShnMcWebN1VjCQbUduKitJI5DZqyHr2tQ0whMda+Vbf
         sxElG9voNZDFJVVkqDQ/fIPvGcrjqrf84UZp9RQjbnEoWILO2axgjvMOuHBLzn+PQOfL
         C+2g==
X-Gm-Message-State: APjAAAWr3AxjwjpLQN2VEJdO/Gu1S8tY8+ZI4X51t0xsHK9KQLjjmNJX
        GuAaq3fzZy6S9Oezc8I5ZkwjSTDAhYTSjQbsMg76G22j6aM=
X-Google-Smtp-Source: APXvYqxi9Al6EhVp6Fzs3kt7WGSSwQJ9MM7X9p2Zw11dLwUwgYfH+Qk893fJYujMv7QyZvGWxu7R2xASBb1OJ8GmRss=
X-Received: by 2002:a92:bb08:: with SMTP id w8mr13902051ili.27.1580123446775;
 Mon, 27 Jan 2020 03:10:46 -0800 (PST)
MIME-Version: 1.0
References: <20200123130816.24815-1-kalimuthu.velappan@broadcom.com> <a7d6f51f-8c5c-9242-97a1-8fdea9fdbb7b@iogearbox.net>
In-Reply-To: <a7d6f51f-8c5c-9242-97a1-8fdea9fdbb7b@iogearbox.net>
From:   Kalimuthu Velappan <kalimuthu.velappan@broadcom.com>
Date:   Mon, 27 Jan 2020 16:40:09 +0530
Message-ID: <CAKA8wj0nLH7UV=Pnk6kbHbyx2sxbL+fOd7JC=o2KryZKRgPFYQ@mail.gmail.com>
Subject: Re: [PATCH] Support for nlattr and nested_nlattr attribute search in
 EBPF filter
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        "David S. Miller" <davem@davemloft.net>,
        Stanislav Fomichev <sdf@google.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        Andrey Ignatov <rdna@fb.com>,
        "open list:BPF (Safe dynamic programs and tools)" 
        <netdev@vger.kernel.org>,
        "open list:BPF (Safe dynamic programs and tools)" 
        <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

There are few network applications relying on Netlink subsystem to get
notifications for net-device attribute changes like MTU, Speed,
Oper-Status, Name, slave, slave info, etc. The Netlink subsystem
notifies the application on every attribute change regardless of what
is being needed for the application. The attribute search support in
EBPF filter helps to filter the Netlink packets based on the specific
set of attributes that are needed for the application.

The classical BPF supports attribute search but that doesn't support
MAPS. The extended BPF supports MAPS, but the attribute search is not
enabled. Hence this patch enables the support for attribute search in
EBPF.

Thanks
Kals


On Thu, Jan 23, 2020 at 9:27 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 1/23/20 2:08 PM, Kalimuthu Velappan wrote:
> > Added attribute search and nested attribute support in EBPF filter
> > functionality.
>
> Your commit describes what the code does, but not the rationale why it's needed
> resp. the use-case you're trying to solve with this.
>
> Also, why it cannot be resolved in native BPF?
>
> > Signed-off-by: Kalimuthu Velappan <kalimuthu.velappan@broadcom.com>
> > ---
> >   include/uapi/linux/bpf.h       |  5 ++++-
> >   net/core/filter.c              | 22 ++++++++++++++++++++++
> >   tools/include/uapi/linux/bpf.h |  4 +++-
> >   3 files changed, 29 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index dbbcf0b..ac9794c 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -2938,7 +2938,10 @@ union bpf_attr {
> >       FN(probe_read_user),            \
> >       FN(probe_read_kernel),          \
> >       FN(probe_read_user_str),        \
> > -     FN(probe_read_kernel_str),
> > +     FN(probe_read_kernel_str),  \
> > +     FN(skb_get_nlattr),     \
> > +     FN(skb_get_nlattr_nest),
> > +
>
> This is not on latest bpf-next tree.
>
> >   /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> >    * function eBPF program intends to call
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 538f6a7..56a87e1 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -2699,6 +2699,24 @@ static const struct bpf_func_proto bpf_set_hash_invalid_proto = {
> >       .arg1_type      = ARG_PTR_TO_CTX,
> >   };
> >
> > +static const struct bpf_func_proto bpf_skb_get_nlattr_proto = {
> > +     .func           = bpf_skb_get_nlattr,
> > +     .gpl_only       = false,
> > +     .ret_type       = RET_INTEGER,
> > +     .arg1_type      = ARG_PTR_TO_CTX,
> > +     .arg2_type  = ARG_ANYTHING,
> > +     .arg3_type  = ARG_ANYTHING,
> > +};
> > +
> > +static const struct bpf_func_proto skb_get_nlattr_nest_proto = {
> > +     .func           = bpf_skb_get_nlattr_nest,
> > +     .gpl_only       = false,
> > +     .ret_type       = RET_INTEGER,
> > +     .arg1_type      = ARG_PTR_TO_CTX,
> > +     .arg2_type  = ARG_ANYTHING,
> > +     .arg3_type  = ARG_ANYTHING,
> > +};
> > +
> >   BPF_CALL_2(bpf_set_hash, struct sk_buff *, skb, u32, hash)



-- 
Thanks
- Kals
