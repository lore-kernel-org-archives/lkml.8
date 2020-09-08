Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37B7C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 06:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C88AC218AC
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 06:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729228AbgIHG5m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 02:57:42 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58426 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729005AbgIHG5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 02:57:41 -0400
Received: from mail-lj1-f198.google.com ([209.85.208.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1kFXZQ-0002qQ-Ru
        for linux-kernel@vger.kernel.org; Tue, 08 Sep 2020 06:57:36 +0000
Received: by mail-lj1-f198.google.com with SMTP id i9so4840082ljc.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 23:57:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vzp7zmy16qSTY1Tj4XpNRu/ljIgkqSbcbe8XDlpXvi4=;
        b=DUlD7XmWl2+97gK0pgwzhtKrtRjNb+Qq/59oelwkFq+Lr0eqOfNCNF1f1o9W/cmpbo
         dEFuvG2vqQvIWoGh/mW/V3HJnkv7Qv32saHzrVlVaDWllWM5hqWXBgwFC06YeJXgBcKi
         cNY8NG2L9cL/I7YzbZB/D7QABWCTZuk2YaimoLmFh9VGv4DeaZHNxMH2ogYBZGV0Xlww
         aD/lTi+pWGB2pJ36C28B+S/sq0tkqc8o7g1rjnNz95xWOG7g6tuBQjbGjiE5EzmBtRIS
         AJj0kNGDoGlX3yb5s5b6LsFNa90sVZklORSq9QMs12P6EdtQ+mPrzDlquI3LkQdrsesL
         txTw==
X-Gm-Message-State: AOAM5336RHcJE5SJLxnt9DY7WqmubPNlh8vwh7icxge70wjZkOYvoJeJ
        0xRuvjTkyvy+mPAtu6/NM1e5YBnQbMt06TfYMX2iEbUwlLdpyONG7M/CUrYqrXXaJxhrz5LO6x9
        Vg0gm3DMiHKiBM9OCZtYNFKqXeSEr/JmGovytiWzKKyrotlT8LD2ONZoT
X-Received: by 2002:a19:a411:: with SMTP id q17mr11860167lfc.203.1599548256276;
        Mon, 07 Sep 2020 23:57:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygp/Cy9i5kwwqPW29UqRHI61VnfUXcFf9tILlkpm11JRKPQHotL77csl2OK1RXodhDbYgfkWa4aatVJw3RBRA=
X-Received: by 2002:a19:a411:: with SMTP id q17mr11860150lfc.203.1599548255889;
 Mon, 07 Sep 2020 23:57:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200907035010.9154-1-po-hsu.lin@canonical.com> <20200907131217.61643ada@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200907131217.61643ada@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
Date:   Tue, 8 Sep 2020 14:57:24 +0800
Message-ID: <CAMy_GT-kaqkcdR+0q5eKoW3CJn7dZSCfr+UxRf6e5iRzZMiKTA@mail.gmail.com>
Subject: Re: [PATCHv3] selftests: rtnetlink: load fou module for
 kci_test_encap_fou() test
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     David Miller <davem@davemloft.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 8, 2020 at 4:12 AM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Mon,  7 Sep 2020 11:50:10 +0800 Po-Hsu Lin wrote:
> > The kci_test_encap_fou() test from kci_test_encap() in rtnetlink.sh
> > needs the fou module to work. Otherwise it will fail with:
> >
> >   $ ip netns exec "$testns" ip fou add port 7777 ipproto 47
> >   RTNETLINK answers: No such file or directory
> >   Error talking to the kernel
> >
> > Add the CONFIG_NET_FOU into the config file as well. Which needs at
> > least to be set as a loadable module.
> >
> > Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
>
> > diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
> > index 7c38a90..a711b3e 100755
> > --- a/tools/testing/selftests/net/rtnetlink.sh
> > +++ b/tools/testing/selftests/net/rtnetlink.sh
> > @@ -520,6 +520,11 @@ kci_test_encap_fou()
> >               return $ksft_skip
> >       fi
> >
> > +     if ! /sbin/modprobe -q -n fou; then
> > +             echo "SKIP: module fou is not found"
> > +             return $ksft_skip
> > +     fi
> > +     /sbin/modprobe -q fou
> >       ip -netns "$testns" fou add port 7777 ipproto 47 2>/dev/null
> >       if [ $? -ne 0 ];then
> >               echo "FAIL: can't add fou port 7777, skipping test"
> > @@ -540,6 +545,7 @@ kci_test_encap_fou()
> >               return 1
> >       fi
> >
> > +     /sbin/modprobe -q -r fou
>
> I think the common practice is to not remove the module at the end of
> the test. It may be used by something else than the test itself.
>
Hello Jakub,
Thanks for your feedback.

For this case I think it's safe to remove the module here, as it was
never loaded before and thus causing this test to fail.
If other tests in this rtnetlink.sh need this fou module, we should be
able to spot those failures too, however this is the only failure as I
can see.
(pmtu.sh will need fou module to run as well, but it will be loaded there.)

Shouldn't we insert the required module whenever the test needs it? So
that we can run the test itself directly, without depending on other
tests.
Also, I can see modules for tests were being unloaded in other tests as well.

Thanks

> >       echo "PASS: fou"
> >  }
> >
>
