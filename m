Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 987C1C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 10:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A74C24686
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 10:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="YRoQng0U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgA1KKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 05:10:09 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35200 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbgA1KKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 05:10:09 -0500
Received: by mail-qk1-f194.google.com with SMTP id q15so6315771qki.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 02:10:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=wwPnc/z0vFoENe41dHkv8XLHnCHQXdvCpY8VfuCLBtA=;
        b=YRoQng0UgKXHYur22BX4pE7ckr9a8UqOeKda27MTcYcCLRNOm7FEdh4rkMGippkEFu
         QfikVd+H+JBJ9mHXILQViSgCrj7J3odhXqmOonF3IQL6M02ezpab4t8cElz5R02tV6kW
         J204JQHN/+XL0fsP+t8JzjGPrvnPXd1plH1YZufFA4XlSvjW+raJewbElU97D3KygW/1
         3KDJRcYYUd0nce4q2+Tb3I/Zxk0CbX00QAoV0atiGt5nsJ4Goa9LWg7TQrxsP2aVr43H
         chCioDXxf7zEa0FvEOcJ0A6Qusx5Q3B5TCBsqfllUP+1036KE9HFRqoLMF73AnoaO4mn
         a4qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=wwPnc/z0vFoENe41dHkv8XLHnCHQXdvCpY8VfuCLBtA=;
        b=iF8JTwUoOv9KTzqIl/0ZqBl6ZQ/5JG7n56okTeryuZstZ50QDPZRZDnGG4y4A6IARQ
         /tDVlupdpc+xzbDf0XxcYlKDzfMmaXw6s2MGx+0+18DNMXw0E+ogGPYOVUKm5fl1jHTo
         QOUpuILL+Ms+oSgiugS56d0eEZqop++CBn1iK6D4qVog3Fq0nYbBpqy2NOfUFVMiunYc
         OoSP/hEcFLRkB0wuMIUM8xxOrTopdnyBaBrORZDDPiCwW1BKe2Doum6DVHQy0+Gxnrhc
         NoWh2b1We+iD+nBIEpkY00qB1f150PuFlbYKJ9HWp0eroQxYSoQs1Ddz0G3k1HRnwP1j
         5Ybg==
X-Gm-Message-State: APjAAAUroHPfSRNvK05n5/0YAh5TfiTLuOaDfWxWyw4krMhjB/hpDD4Z
        BBDD2XaOBqfmq6YrBnCd9Nk1jvDuutvi1g==
X-Google-Smtp-Source: APXvYqz+aIb6RWCxNUE3UTnWuhjgN+0ZbX2OBJk/o0aHvDd0xFFbAWnjRuLU5/ucLCnXZFah8dPOJQ==
X-Received: by 2002:a37:aacc:: with SMTP id t195mr13812676qke.462.1580206207866;
        Tue, 28 Jan 2020 02:10:07 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id v80sm8756447qka.15.2020.01.28.02.10.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2020 02:10:07 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] locking/osq_lock: fix a data race in osq_wait_next
Date:   Tue, 28 Jan 2020 05:10:06 -0500
Message-Id: <E65D0BFC-719A-4CF9-A934-55ACFF663F98@lca.pw>
References: <CANpmjNMzvcrQWpGWVgNRxvZroecAEZYYa2yYAtm5+ekcK=H3OQ@mail.gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "paul E. McKenney" <paulmck@kernel.org>
In-Reply-To: <CANpmjNMzvcrQWpGWVgNRxvZroecAEZYYa2yYAtm5+ekcK=H3OQ@mail.gmail.com>
To:     Marco Elver <elver@google.com>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 28, 2020, at 3:18 AM, Marco Elver <elver@google.com> wrote:
>=20
> This should be an instance of same-value-store, since the node->cpu is
> per-CPU and smp_processor_id() should always be the same, at least
> once it's published. I believe the data race I observed here before
> KCSAN had KCSAN_REPORT_VALUE_CHANGE_ONLY on syzbot, and hasn't been
> observed since. For the most part, that should deal with this case.

Are you sure? I had KCSAN_REPORT_VALUE_CHANGE_ONLY=3Dy here and saw somethin=
g similar a splat. I=E2=80=99ll also double check on my side and provide the=
 decoding.=
