Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA21AC2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 11:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABB8420753
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 11:25:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="ROQfgV0c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbgDJLZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 07:25:03 -0400
Received: from mail-qv1-f48.google.com ([209.85.219.48]:40254 "EHLO
        mail-qv1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgDJLZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 07:25:02 -0400
Received: by mail-qv1-f48.google.com with SMTP id k9so762519qvw.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 04:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=EyRGokCM/wVUU/nXIGOSGIM3r9LXN2RB/WA9Dd31/fo=;
        b=ROQfgV0cUD7XVup63svo3RL/AkZxQJ+fzf0+St66kLDv734ApzcVHDh3HUmeuG8KXk
         cqlatVQcoyIjdBaIz8liOq6Ir26yPxe1mV9FN+t/Kk0ZwlJRYFRHiBq6O4Ot+99XKAAq
         B9i3YLywbDhnkff++HQgj9XsQZTd48kpcGHK+TIVp01fy4P1A9qhsZtgIMR9W0o3m+r6
         LlPBX/1yvrlvdvpwVcFmj5eDWlB+/1vEN0lFr5B82oh2JK/4+Ay3O/MfhMHO/+FHrZi0
         lp5izN+65oGZrTYrdxCe/yZPneFZoty3FxRgFgmCJRzeoHn+a6LAH8uNpLsGEyZINxrN
         3Low==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=EyRGokCM/wVUU/nXIGOSGIM3r9LXN2RB/WA9Dd31/fo=;
        b=kzXJoX5xavTwfEVwsQWutOIDY9zjM7zAZ31dbObOyxabmAt0BOBRovjTyAE5/sGwcv
         6W4qlQiPyt+petchEBgfgWW8PdHnoYbHprdvWU6l0xBZOuNMQBQm994fjFbF3BONdY0B
         ZgY+IAnL7mLYZBt8jgYUj4EkJXh9Fo8URqXwJrGH+Jg8yVTjKSVvYHzGOU3J5Xb3HAnX
         p9x1XxL+Jlu977ZqcMEVDkZezktawuJ2ihn7YfniaOBhO78i1SsM1EQGJV4IBet60YQL
         gY7v8ORHYh9Xwh1QaddKe1AQ5FCZwor5HHwZDhPibyuUKQc8bFJSOIEPCNtCZunC9Ftb
         8Bjg==
X-Gm-Message-State: AGi0Pubek2iQ3SOfqkqdqohyPMlyj+C0Fe+l7IuUo3kxT0/OOPWecPFw
        f945MaAlrboU7uW4pZWrveIP+j9FmFe3AA==
X-Google-Smtp-Source: APiQypL29YhpcmDiwkdJuLx+IPWrg86N797Ulso1EMGSj4X4L7yWUcYHhSm1qb8MPtacyC7NLU6jWA==
X-Received: by 2002:ad4:4665:: with SMTP id z5mr4803594qvv.32.1586517902125;
        Fri, 10 Apr 2020 04:25:02 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id p9sm1349995qkg.34.2020.04.10.04.25.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2020 04:25:01 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: KCSAN + KVM = host reset
Date:   Fri, 10 Apr 2020 07:25:00 -0400
Message-Id: <AC8A5393-B817-4868-AA85-B3019A1086F9@lca.pw>
References: <CANpmjNMR4BgfCxL9qXn0sQrJtQJbEPKxJ5_HEa2VXWi6UY4wig@mail.gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        "paul E. McKenney" <paulmck@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org
In-Reply-To: <CANpmjNMR4BgfCxL9qXn0sQrJtQJbEPKxJ5_HEa2VXWi6UY4wig@mail.gmail.com>
To:     Marco Elver <elver@google.com>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 10, 2020, at 5:47 AM, Marco Elver <elver@google.com> wrote:
>=20
> That would contradict what you said about it working if KCSAN is
> "off". What kernel are you attempting to use in the VM?

Well, I said set KCSAN debugfs to =E2=80=9Coff=E2=80=9D did not help, i.e., i=
t will reset the host running kvm.sh. It is the vanilla ubuntu 18.04 kernel i=
n VM.

github.com/cailca/linux-mm/blob/master/kvm.sh=
