Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E51C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 10:36:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6DB52077B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 10:36:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="myg5QbUS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgAPKgk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 05:36:40 -0500
Received: from mail-wm1-f49.google.com ([209.85.128.49]:53202 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgAPKgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 05:36:39 -0500
Received: by mail-wm1-f49.google.com with SMTP id p9so3183049wmc.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 02:36:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6eYsHx9cl8AC3I2Z/xAMb/OglACMn1Ya3+4GA6djOtI=;
        b=myg5QbUSpE5QsqFDd2VUlNCPaI675Nu1tdg9evnFfjRCZXOws/kpq8C+ffpe0blRZB
         aGn35u+BY870pkgqtlN0tMefmrkP/r0qZtjbwmpr7egqmb6/QDshEC1CJZYnoe8LwAHc
         Rq6rHmfOyOpV3nyjGFu++zhoGkPwiREnMeAMGYAUIQI0tznA9xnUFjcQJVL8+Dv1sl7a
         QKp2cMr0PE4pW0rTlnRO1oY8LhP2bya/QHpbaqKSPpsM4IrWoqHP4UKxlNJW9ojRiokR
         LujG+0gMgI/UZldKghvkDmWQ8G4LeTuaiuwXnaPsgCr0xvm1YPTWIBdnM1gWjhe/xhjH
         z5xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6eYsHx9cl8AC3I2Z/xAMb/OglACMn1Ya3+4GA6djOtI=;
        b=OLdJMYBYZMSStgNUJNUcDjflxSHNzniRgR4Eoy19/7lbzkd9bFDTeF3KQWslAsvMCk
         twgQ6wOvdP9SogWUO1cmINYfBV0FSyW3cqj2ErzyRYTOiA6bOP7ZBgTy+Jlong023lM2
         onjocz/RSpZkwVHKce/NeQ4Jv8TpFSsmjRRmUwtsTbJhaEBwfVKPbi0ZyZMeHbgNdIzu
         zudbrBs24gWiCVCYc9RCZLLAdpQCJpcxHGwlfmpIv3lC8AeSQeR8lL+MYAP5Ca+Z/Yrz
         lM3jcN7wRPHYKPyIj953jh6IGPhaPaXbwCFJlacsT8IJzJGqIKwB+RTMA/xBoxKL5eZg
         8k7A==
X-Gm-Message-State: APjAAAXSA6RugpG1EdHsoQ0Okf37Wixcs01T2u0Kzh9UbaT5RXmnWb5O
        qGFaYXD6FOpchxptfWP6CieizQagy69zDOp4/N9bMA==
X-Google-Smtp-Source: APXvYqwmIPcbVrxcjPawixE5rrv79zwFht2K134eNAG/UZpHZIU2SRZu6MFJr0cwTb1KkUEN5d7AbKTJvfIQpP9oNrw=
X-Received: by 2002:a1c:4144:: with SMTP id o65mr5496764wma.81.1579170997525;
 Thu, 16 Jan 2020 02:36:37 -0800 (PST)
MIME-Version: 1.0
References: <20200115162512.70807-1-elver@google.com>
In-Reply-To: <20200115162512.70807-1-elver@google.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Thu, 16 Jan 2020 11:36:26 +0100
Message-ID: <CAG_fn=WgQtqhmJ4Nr8N9VKLWaJpZCdyPy5NPUdRpUBJLZSstaQ@mail.gmail.com>
Subject: Re: [PATCH -rcu v2] kcsan: Make KCSAN compatible with lockdep
To:     Marco Elver <elver@google.com>
Cc:     paulmck@kernel.org, Andrey Konovalov <andreyknvl@google.com>,
        Dmitriy Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, will@kernel.org,
        Qian Cai <cai@lca.pw>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Reported-by: Qian Cai <cai@lca.pw>
> Signed-off-by: Marco Elver <elver@google.com>
Acked-by: Alexander Potapenko <glider@google.com>
