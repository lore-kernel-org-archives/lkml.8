Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37329C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 18:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF8D20679
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 18:39:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3Gb++k8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732411AbgCPSjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 14:39:51 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:35234 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732373AbgCPSju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 14:39:50 -0400
Received: by mail-oi1-f175.google.com with SMTP id k8so17505455oik.2;
        Mon, 16 Mar 2020 11:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V5MeuyFn7e4mHxz4tUSn4H5NtYvN6rAxu8E1UQB7qo4=;
        b=S3Gb++k8PoCDq6ifZEeU4qJ/0KlyGBByMVRGxXfM72hsqEcyydhCrEoXiAJv7o6h/u
         L9SCDx8RMPG3rA1msIWyy3z3D2mbE145EJhO/OVxAtzXvsvPCkScDbk5DSXmITfbgTN0
         FgX6w31IKLLlImlOzMruRnVc/paNk6RbMmbO3BG0NJ3bHtW7IIhDfgg3Lo41dCCBmdt/
         Jfxd17e8u7GmITyg8zrXvQhlI1hzyeS4L3y+dE8V1N9wlcuwL/ceoh68IYkw9txWRcut
         3adipUOJFUbhzboD32vln4B3fJ3e9wtlZKw5rd53P2LK7SkK0ZVcOnqIIq8Bz6LXPsmw
         zsEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V5MeuyFn7e4mHxz4tUSn4H5NtYvN6rAxu8E1UQB7qo4=;
        b=gMhS/S2ewEsbrCzs8WcDZ+8iRHJqh8n74cTuQCIbWv7CZGT7DpwhKf3+VVFzdqC5Ki
         BtTKgnqixKFkXnApvskwlgENC+qjmtYcGNR8aeJuXWePcekZYkZlRBc+m+EXvDuxBKWB
         vjkAMFxU/5MSpSQa+fAsmFeaW2mq8s8TrgkesPTBWLJBgfuIsSQO1HPaasC91qflOYqV
         InxwEFvxjSwCVKv1XnIlmDjcA+BaCotmosnVNsCUojiLjmwmktVfTcFPIyxm6SXK1gnX
         rupuElGNGZ8BYR2uHXAYVaufWpHZQDmt6FI4nPfLj/77wDoTteUyEcmA52Jj7X1oe+9p
         AY5w==
X-Gm-Message-State: ANhLgQ3QR0yfI/VArPuFKRo4N474dYtSaRHrnviYEjJEEyh5m0C7CYF+
        fkU7lBfN8XqUWGGB3fKkcyNsUSgcQS2LFgjezXpI+WNcuyY=
X-Google-Smtp-Source: ADFU+vtxax4sSazwm4CJkAHb7CssKVL/gjbJsY7S66yrglZsJKGmaXZTcIJY0Y+V1UxYvLU3ecg6g/3bSLJPEvaetyc=
X-Received: by 2002:aca:d489:: with SMTP id l131mr681627oig.5.1584383989691;
 Mon, 16 Mar 2020 11:39:49 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000696eaf05a0877436@google.com>
In-Reply-To: <000000000000696eaf05a0877436@google.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Mon, 16 Mar 2020 11:39:38 -0700
Message-ID: <CAM_iQpV9eLSBrrFwEkznwSjVeShLQAfA+aOjwJf==kEm8B+Utg@mail.gmail.com>
Subject: Re: WARNING: refcount bug in __tcf_action_put
To:     syzbot <syzbot+91aff155f11242aeafbe@syzkaller.appspotmail.com>
Cc:     David Miller <davem@davemloft.net>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Jiri Pirko <jiri@resnulli.us>,
        Jakub Kicinski <kuba@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz fix: net_sched: keep alloc_hash updated after hash allocation
