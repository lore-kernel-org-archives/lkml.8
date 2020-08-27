Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054CBC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 01:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C81692074A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 01:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dnw0CNEg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgH0BiU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 21:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgH0BiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 21:38:15 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D541AC0617BE
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 18:38:13 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id t74so2028428lff.6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 18:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tcZaZT5thwhJ11Sw+P5MksLekBOktbPk7Gm1gWNLeIg=;
        b=Dnw0CNEgWHRjRY6mVfKDmenVclOHmH5gb8vsyRKn1HlquwSK9oiMqP5+l+4bHIUmEN
         ImBA+i6GyDM1F0AHWS7CRMjJ7MbjGg3iMTfGDiQs2TxZFuTaeWydDDDSQzsB1j+J+HS2
         hF5BeBXmPWTkNM6rGsgz2JkcZoHkS34A8KeAOj/TRNVUC4cD4QDaQFLc1HCe10CG1PYe
         Q0U9h5FTzR8smu+Ap/LU1p61Im/PL+P7y/rCDRvwMmMg06sLJPyajSl/UF/RMG3Dnw47
         6BcaQUsr7h/UOccf+voQ08xND5Y4s1o9fVhqmMAio85FbwxE4hrSZAgkBPmBsn1k0C6I
         e/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tcZaZT5thwhJ11Sw+P5MksLekBOktbPk7Gm1gWNLeIg=;
        b=UNoBplobcy++e0WGoQ36spNqgXpzE5jsca+75iUAGltjgZPuF5Pm7NLTdlbRFupuah
         q+wUDbVrKDSxEh2XzwZU+57N9PRoQTJqA55rtn1QH7a14DW0bB6SC2ERokdgje4j7NjC
         fzQFOcCe987w6UTCAfFZFHyPgyvfv4nQ27MSThIK13sZ70bgx9ajJQ2WRd3beE7ORI3P
         dYf78fFS5MdVhrn23bx0fVhNTpQYc9qva7l7aggS04PutCPLrzvNnHJTMQKErBeHnU6q
         k0MoGL+7/8GhOz2yaV6zERQA4yoBqU7O+/vRcE5YYFM2ZeCbZZCNpey2hTp29RwsUEgL
         HgmA==
X-Gm-Message-State: AOAM532ukHLzmXuxBTzJCayMNCecW9+h7GhrehnujFA8PZv9Cc0BWmFn
        H471w7zATH+slhmun8O2c2Dg/sMyMCFMnTo88N1iMQ==
X-Google-Smtp-Source: ABdhPJxRcjc/Gqp/xT0urxhuNv5VqgxhHlf/nPvUR2crUR0WvM1oYHdUzyehd4aChT2XgBrBktIsBGkJHiIB0EJwAh4=
X-Received: by 2002:ac2:47ec:: with SMTP id b12mr3245912lfp.124.1598492292040;
 Wed, 26 Aug 2020 18:38:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200821150134.2581465-1-guro@fb.com> <20200821150134.2581465-8-guro@fb.com>
In-Reply-To: <20200821150134.2581465-8-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 26 Aug 2020 18:38:01 -0700
Message-ID: <CALvZod62e=y1-HJJrC7dQQiarRR9o5t+4y_NtZT4B7aGhF46WQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 07/30] bpf: refine memcg-based memory
 accounting for devmap maps
To:     Roman Gushchin <guro@fb.com>
Cc:     bpf@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linux MM <linux-mm@kvack.org>, Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 8:18 AM Roman Gushchin <guro@fb.com> wrote:
>
> Include map metadata and the node size (struct bpf_dtab_netdev) on
> element update into the accounting.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Acked-by: Song Liu <songliubraving@fb.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
