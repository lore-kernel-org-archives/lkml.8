Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35B90C2BA1A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 20:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FA822072A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 20:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="E6gDB1rO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgDFUdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 16:33:31 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45009 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgDFUdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 16:33:31 -0400
Received: by mail-qk1-f193.google.com with SMTP id j4so17672047qkc.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 13:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VZndNblKg2Lp/IRXBvxJ8CPTAZH6z/6SP71Yf2KIiBw=;
        b=E6gDB1rOHel6zgkjkGrAgyYksgi2vU0Iyf5cWeGBQ5mpnvcEocj3k9XXkH54nC8Ibp
         0g9F6WPHwG2IISDsoB1WtEYV9tEguyQ8zqJLa4z9JsYXsSVkd+MLPieNYuOSVAwO7Fb5
         yhO9sxAVzKcqZWeaxGxDhTDbPZmcIHpGt0zL2j1NzjkfF1l10SZ+vVmaz4vnqFZECsaR
         vY+/SF78OLFWcC0gybjzbB16+CGPDu+SoklKy0q9yXMLz6kn6TyhOrid5qz/NnEnMG9m
         LUrW9ySGpp+uflh7KFcvJQ8V87tzuG5MaMHYWbJgGt5op6l59AinZlt15YR+9VZ4BoyK
         g9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VZndNblKg2Lp/IRXBvxJ8CPTAZH6z/6SP71Yf2KIiBw=;
        b=RevDRcyjEMTj1QnZ/Vd8QAUaiinrpTZ5D+fCw/bkjetRdktFr7pPlyR4QCCqYxodkn
         kLz+jRdNU6SJIdGnx+gBi6voY7hOBxgfarsHCWfY6WDDvJzzz+tLyTL7iqbnQxxVvD+r
         ShFcfrwP2Z+A6a00YOYiauNmXQ6muPFk80lGhA07HG2yCCCtR7NZUJVG3kq867TL15NZ
         kL1dqKoq4kLGnmdLHyes6f9ooc+OYCLQokHffRHNtWk+R4okCA2qMN99aHD8YePhpuNv
         XN4obntkT3H7z9RL2+xUVkLjMJsqfXHkRZFotRhprRI2AiC6Tdt3OqP1s6iaLxRWIZeR
         Kkcg==
X-Gm-Message-State: AGi0PuYIBSjf1QruEqNc6cFNJOArCI8P6uF8myTTUSaFpWj9oiCOzFd3
        SrhhStn55lZKsUjC2WbVb5+5Gg==
X-Google-Smtp-Source: APiQypIAquLRlacI0lYPWyaShGao0tAhiBwsgo7aHqLY5Isth42bIUHVgxbssWWkrH9Y5KFk1saoqg==
X-Received: by 2002:a37:98c7:: with SMTP id a190mr5636331qke.91.1586205208887;
        Mon, 06 Apr 2020 13:33:28 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id e10sm2728801qtj.76.2020.04.06.13.33.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2020 13:33:28 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v3] kcsan: Add option for verbose reporting
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200406195146.GI19865@paulmck-ThinkPad-P72>
Date:   Mon, 6 Apr 2020 16:33:27 -0400
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Marco Elver <elver@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3B06DA7F-DCAF-4566-B72A-F088A8F0B8A9@lca.pw>
References: <20200406133543.GB19865@paulmck-ThinkPad-P72>
 <67156109-7D79-45B7-8C09-E98D25069928@lca.pw>
 <20200406195146.GI19865@paulmck-ThinkPad-P72>
To:     paulmck@kernel.org
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 6, 2020, at 3:51 PM, Paul E. McKenney <paulmck@kernel.org> =
wrote:
>=20
> On Mon, Apr 06, 2020 at 09:45:44AM -0400, Qian Cai wrote:
>>=20
>>=20
>>> On Apr 6, 2020, at 9:35 AM, Paul E. McKenney <paulmck@kernel.org> =
wrote:
>>>=20
>>> It goes back in in seven days, after -rc1 is released.  The fact =
that
>>> it was there last week was a mistake on my part, and I did =
eventually
>>> get my hand slapped for it.  ;-)
>>>=20
>>> In the meantime, if it would help, I could group the KCSAN commits
>>> on top of those in -tip to allow you to get them with one "git pull"
>>> command.
>>=20
>> Testing Linux-next for a week without that commit with KCSAN is a =
torture, so please do that if that is not much work. Otherwise, I could =
manually cherry-pick the commit myself after fixing all the offsets.
>=20
> Just to confirm, you are interested in this -rcu commit, correct?
>=20
> 2402d0eae589 ("kcsan: Add option for verbose reporting")
>=20
> This one and the following are directly on top of the KCSAN stack
> that is in -tip and thus -next:
>=20
> 48b1fc1 kcsan: Add option to allow watcher interruptions
> 2402d0e kcsan: Add option for verbose reporting
> 44656d3 kcsan: Add current->state to implicitly atomic accesses
> e7b3410 kcsan: Fix a typo in a comment
> e7325b7 kcsan: Update Documentation/dev-tools/kcsan.rst
> 1443b8c kcsan: Update API documentation in kcsan-checks.h
>=20
> These are on top of this -tip commit:
>=20
> f5d2313bd3c5 ("kcsan, trace: Make KCSAN compatible with tracing")
>=20
> You can pull them in via the kcsan-dev.2020.03.25a branch if you wish.

Great! That should be enough food for me to survive for this week.

