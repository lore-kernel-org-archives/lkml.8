Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24808C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 23:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E143B217D8
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 23:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n9LgZ0jV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgDPXML (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 19:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbgDPXMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 19:12:10 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC73C061A0F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 16:12:10 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id o1so229633pjs.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 16:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qHnZMVe5Y7EDy73UocFbOqkOic/ITzFdjJim0WbrCVg=;
        b=n9LgZ0jVDeOIG0dfjM08EFewOl7JGzK1/ZndCN6VfuY6rsSsFEtpwkN3C6cLgd1uzQ
         aEZqc4K0sm8GJmecM+3Pc/OF6Ym6gj18zcOl5Qo7H1p/2YUXyuT6WzJAuvdd4mpm3S1b
         ccnvtOaThM3rMC456ydHEv88YQQa+vz/Cmocsa5AQb9pABrf/zoniuCCNIcFgzr78p1A
         Nq+ALGXBXXZB4F/OGrqGfbQ6Y79gvKlk3qY31sBqKnHGDKdtqNtax3gK5jk9YB/6bX1s
         TRo54mCyR5uuJ38KnuIY9bC2dCmr2/cWYJet3e9gzl7rinBbfuAzIYLDz/rp2NnTGOf9
         BI6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qHnZMVe5Y7EDy73UocFbOqkOic/ITzFdjJim0WbrCVg=;
        b=DPQlY7rZtISKJ0bJu/M+iTDrqinP7LI8RbW7IfAJnJMI5MWKAn8+03RHPqrJLcBbRL
         ddEtrpAQBcQCK/0EA7nxPA5a5Y8qpWLbtXjG4KJd/OydcGGHIV+0oBZ8hpRUV5s/z5Wu
         JKHiCXcucEKjMq1GhcTPQHPqJFHfto7WHWsA5UBezbxELScrWePUXr2sfg8SIfUeI6PJ
         RDfWwmq3KUtiZaZje2hLlVHl+x2MLESC9+6QXrtMn+USDbIZDqTgXOmKnvjYznCGU4xR
         b1KTj5Jq5+czFt4Nx8oboJJgR2FcLRBzoc5N6qcPBM8qEy65L0RBazUf0z3UX4e0tBfK
         4VHA==
X-Gm-Message-State: AGi0PuZFBLDVfmsnMoVGkl9TimplQAMyGkQ2fj9J3L0+/eUjN9p2osEm
        ADasqDeJ32L3e2IRg3sFKUYluggq6+lZW/riXnGK0Q==
X-Google-Smtp-Source: APiQypJzSIA7M8WieLTPiRB0Atlxe05VI645b6MAkDHdrAbIL8/iKZz4Cfptd+4ZR7WHMXeYTkLG5HT32gZYTfR/mK8=
X-Received: by 2002:a17:90a:3568:: with SMTP id q95mr852976pjb.47.1587078730154;
 Thu, 16 Apr 2020 16:12:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200414230950.83665-1-vitor@massaru.org>
In-Reply-To: <20200414230950.83665-1-vitor@massaru.org>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 16 Apr 2020 16:11:58 -0700
Message-ID: <CAFd5g47CaeEBiJsiSUtihHQF+OGpfCg76dS2ys2mwy2qn_L5-w@mail.gmail.com>
Subject: Re: [RESEND] kunit: use --build_dir=.kunit as default
To:     Vitor Massaru Iha <vitor@massaru.org>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 4:09 PM Vitor Massaru Iha <vitor@massaru.org> wrote:
>
> To make KUnit easier to use, and to avoid overwriting object and
> .config files, the default KUnit build directory is set to .kunit
>
>  * Related bug: https://bugzilla.kernel.org/show_bug.cgi?id=205221
>
> Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
