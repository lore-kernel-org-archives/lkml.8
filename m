Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23940C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 08:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2E5620768
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 08:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jwhzWOYT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731730AbgF3Is1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 04:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728132AbgF3IsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 04:48:25 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38A4C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 01:48:24 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id e4so21528110ljn.4
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 01:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6fsC+acqOWGmffLGOO9jUUTQnpmWJlfaJA/k6/maTXQ=;
        b=jwhzWOYTDIWkGYCjUjnh/hwQSfIQFakAv6CQUjqEt4lGOfycy+SXqpkauASE8Uv9mR
         HQv/CFC25aFyJGL1zaWOskY9nxqomD8anB5SgT41JK2+NAhLoVv/V7kapQtj1LprizUz
         9NWgdrg5DV/8QYEDqTeEoQBll6ZNiEtOUu9LIYIqDwuaV90Hauso9TljSKrWlRjz1xmS
         5k/P3sBGk/fhl23Y3JhxJup+qF6wPjQBiJmZFPfu+b47V4hlKIbXN9MJiKdk/p4O6ugh
         FfkzZelWVMWID7VeVmDc58BAsTKDDi1fjv0yA5t2BtW/F2wHXOgM/ab7n3m4BpJJL7ol
         t/LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6fsC+acqOWGmffLGOO9jUUTQnpmWJlfaJA/k6/maTXQ=;
        b=QkNIk1RVO19b3y15Zt6YbsnR9oUtaICfVTQg12iV/by24jaJuxDnikY6lcXVb7e5M3
         yXzLRm1yv+Ndjq9xozRBjsX+/SmlRGEPqXwfz61190xH+dkdlun0vqkcEJxx3IcDL1Jc
         N6XEC57+CMGInFRt/397MCSyqs8FPyADdQjMfLLdxBKTVUZnkV2vr5ud1ZgXYt8nAuAF
         LbAt97IqmKFLcsjxPEi1YehSKPKdFzno9BVJTpss7313/52s46yShbnbFirn8NOCqqTi
         jSHfCFEWMoAlR0fHHUuYuM/CvWrSQKhFo0X5XU16pBE7N6NRjtBUVMi0QDcSB94svwLX
         jOXw==
X-Gm-Message-State: AOAM531W7OLuO5aOrXOzGDQJMY671gzuQ2Bs3pztD7djF6zyPO1IussR
        l+yO+H8RQ/DiUs3fVoTwxe9yv9vszulAF1O4biI/hw==
X-Google-Smtp-Source: ABdhPJwX4BRg7XNjPqa+bGRmf7a5TT5LE3ptad/uzUQ2PEfbNV+nz2O7wy3pdPl3lEJ0PbZmgV66tY8SYz/nHrGnDlw=
X-Received: by 2002:a2e:9ed0:: with SMTP id h16mr10660397ljk.366.1593506903171;
 Tue, 30 Jun 2020 01:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvHFs5Yx8TnT6VavtfjMN8QLPuXg6us-dXVJqUUt68adA@mail.gmail.com>
 <20200622224920.GA4332@42.do-not-panic.com> <CA+G9fYsXDZUspc5OyfqrGZn=k=2uRiGzWY_aPePK2C_kZ+dYGQ@mail.gmail.com>
 <20200623064056.GA8121@gondor.apana.org.au> <20200623170217.GB150582@gmail.com>
 <20200626062948.GA25285@gondor.apana.org.au>
In-Reply-To: <20200626062948.GA25285@gondor.apana.org.au>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 30 Jun 2020 14:18:11 +0530
Message-ID: <CA+G9fYutuU55iL_6Qrk3oG3iq-37PaxvtA4KnEQHuLH9YpH-QA@mail.gmail.com>
Subject: Re: [PATCH] crypto: af_alg - Fix regression on empty requests
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        LTP List <ltp@lists.linux.it>,
        open list <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        lkft-triage@lists.linaro.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Jan Stancek <jstancek@redhat.com>, chrubis <chrubis@suse.cz>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        David Howells <dhowells@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sachin Sant <sachinp@linux.vnet.ibm.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux- stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jun 2020 at 12:00, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Tue, Jun 23, 2020 at 10:02:17AM -0700, Eric Biggers wrote:
> >
> > The source code for the two failing AF_ALG tests is here:
> >
> > https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/crypto/af_alg02.c
> > https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/crypto/af_alg05.c
> >
> > They use read() and write(), not send() and recv().
> >
> > af_alg02 uses read() to read from a "salsa20" request socket without writing
> > anything to it.  It is expected that this returns 0, i.e. that behaves like
> > encrypting an empty message.

Since we are on this subject,
LTP af_alg02  test case fails on stable 4.9 and stable 4.4
This is not a regression because the test case has been failing from
the beginning.

Is this test case expected to fail on stable 4.9 and 4.4 ?
or any chance to fix this on these older branches ?

Test output:
af_alg02.c:52: BROK: Timed out while reading from request socket.

ref:
https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/build/v4.9.228-191-g082e807235d7/testrun/2884917/suite/ltp-crypto-tests/test/af_alg02/history/
https://qa-reports.linaro.org/lkft/linux-stable-rc-4.9-oe/build/v4.9.228-191-g082e807235d7/testrun/2884606/suite/ltp-crypto-tests/test/af_alg02/log

- Naresh
