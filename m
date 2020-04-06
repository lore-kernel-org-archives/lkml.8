Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E4CCC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 13:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D49EF22571
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 13:45:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="cI+2uYi1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbgDFNps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 09:45:48 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:38271 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728228AbgDFNps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 09:45:48 -0400
Received: by mail-qv1-f65.google.com with SMTP id p60so7501858qva.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 06:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=4wY1rqBiu6VyguDiXD3Q35BlZEB49/SImy/GPIj/YvI=;
        b=cI+2uYi1r5epEPSGWiBI12N1/cVAkj+90TuoutJk4pLVsFsI8JhbOdIndM+ADYECgv
         FzViRUIiY+1GHs5MfU7XuZGioRB0HXE9FE+M5/gAAbl9cnyzg9PjPT7Gu+HNqri3cueY
         X3fvFUOBVjI4CfIqCkqMX1MUJubpRMgxqMFdgeivJUA24FKK+GTbTwd6xZfWGpfJsTRj
         etbRVtx+k+gTINIiWX1UXL09eChdwW7j+t4SczvZshi9d28XTV6YB7Il0b5Tt43rPlJ8
         0AsgauxM9+RH6dunk8xTgie5B2BJs0tvmhVr/L0oPyKnRlj2w+tas0/cfYn5x+YcugU+
         YAWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=4wY1rqBiu6VyguDiXD3Q35BlZEB49/SImy/GPIj/YvI=;
        b=eNY5bi8GnEH2BvvHvOqsqtL9GD8KQltNBEMhxNTWiGc8eGe/ZU7+4Yjox6wAWEMrEM
         raNxVfAp4/6NZPCX6c2hNqflBIqmZz5KTZuFkYDpK/yjuAKIiZQVu1L3JbfcPGQYcddz
         4X74uPjtjwnypNh2mX/af7vlIdw7/915afuRc403oQyh3cHrkP78cjHadGwwo+7qt9Tr
         8yMo7aCtEsZrZIIMQncXYGIsYAf3VdUDyxsCcO9B3p6ZMdQu5+Z1Gn7rinwwRNDQgeiQ
         0tiuFs7D3yIQFRRmZ1UVBDYUlM9l+X09TJ+NUlrZXA3pNJCluZzi7YCHZ//lKflBGI/U
         FhXg==
X-Gm-Message-State: AGi0PuZNhZLqv0p6MFeqjVCCSFHmn9fuygFNvE+SDVZmfZhR6bwqbKAm
        qGCHSxEy/puxfzaFeU1ou0TupQ==
X-Google-Smtp-Source: APiQypJOCvhTUoQ6G2kyoqTzOz8thaZ4ORKE6nkZuuGslBLkJHFWs5OVe/5OCGAZIODOCV5aNISICg==
X-Received: by 2002:a0c:f7d0:: with SMTP id f16mr20916964qvo.206.1586180745725;
        Mon, 06 Apr 2020 06:45:45 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id n92sm1676549qtd.68.2020.04.06.06.45.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2020 06:45:45 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3] kcsan: Add option for verbose reporting
Date:   Mon, 6 Apr 2020 09:45:44 -0400
Message-Id: <67156109-7D79-45B7-8C09-E98D25069928@lca.pw>
References: <20200406133543.GB19865@paulmck-ThinkPad-P72>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Marco Elver <elver@google.com>
In-Reply-To: <20200406133543.GB19865@paulmck-ThinkPad-P72>
To:     paulmck@kernel.org
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 6, 2020, at 9:35 AM, Paul E. McKenney <paulmck@kernel.org> wrote:
>=20
> It goes back in in seven days, after -rc1 is released.  The fact that
> it was there last week was a mistake on my part, and I did eventually
> get my hand slapped for it.  ;-)
>=20
> In the meantime, if it would help, I could group the KCSAN commits
> on top of those in -tip to allow you to get them with one "git pull"
> command.

Testing Linux-next for a week without that commit with KCSAN is a torture, s=
o please do that if that is not much work. Otherwise, I could manually cherr=
y-pick the commit myself after fixing all the offsets.=
