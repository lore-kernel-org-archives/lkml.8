Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02E0C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 09:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A963020748
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 09:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbgIDJLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 05:11:07 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:33237 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729949AbgIDJKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 05:10:55 -0400
Received: from mail-lf1-f72.google.com ([209.85.167.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <po-hsu.lin@canonical.com>)
        id 1kE7kB-0004jq-L7
        for linux-kernel@vger.kernel.org; Fri, 04 Sep 2020 09:10:51 +0000
Received: by mail-lf1-f72.google.com with SMTP id j19so943676lfg.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 02:10:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MpOzB7dmCTuCyJm4q5JJcfMsN2ZZvsAlJt0YiaUL728=;
        b=WI3I3vk+wmkyNpytkK/JwwjJppbfFxz6M58mdz8dMpUxkK0/OXUqWLm33eqdEB9p9F
         SZp5CGCAegb0ciq/le5DPNTatr9hERVoRIwSdaSiqhqUZn1VH72gGQsy+E7QYFEl0JuC
         oyhh9Vw+BcEtmZjy2ORo8/74fc6KtutnQ2SVjECMbmOL5d82mh/mFQUl9DzAB3VAL3M/
         ItOa3GvxXYGMR+pgfjzs8umjSzj2FR6kb7MvyEvmwK2Slur3i+deNviWh7hHwWme/sT7
         +/eZTttF6RjQCvbXBh6GcNGt8dINVTDrdD1g8t11UZWueJVRnw8/pPJA3vq8ZhVURh4F
         OXng==
X-Gm-Message-State: AOAM533YwMR4LlJLsaF5JQ+zaWaSUUGJSxRgX7db1QhCfiQrn//LC+do
        +KnsHany8MR4QafMK3qtIdIKcSizGVAKLehbUHHyuyEPFUIgXU86MpDnZ08lNmgi3Ka6sxCjint
        OnzNFw4UyA+099DG/O4oTZU/99GhIgnF5HGZfjMHvp6ZBPuxAM3klQsof
X-Received: by 2002:a2e:a16f:: with SMTP id u15mr3550080ljl.5.1599210651094;
        Fri, 04 Sep 2020 02:10:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRBBq/qjRBD6kgJssSry/FlrnrAD8qz7ovDVT+hqOyTrNsEtHy4P1ksymgoBxNoaZOC5pVhIT6RcxFjIk7xas=
X-Received: by 2002:a2e:a16f:: with SMTP id u15mr3550055ljl.5.1599210650811;
 Fri, 04 Sep 2020 02:10:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200813044422.46713-1-po-hsu.lin@canonical.com>
In-Reply-To: <20200813044422.46713-1-po-hsu.lin@canonical.com>
From:   Po-Hsu Lin <po-hsu.lin@canonical.com>
Date:   Fri, 4 Sep 2020 17:10:39 +0800
Message-ID: <CAMy_GT8jOOPw+esd53X2LQ4aY9eqpE0rv9vDgr_eBD6fy5Wmqg@mail.gmail.com>
Subject: Re: [PATCHv2] selftests: rtnetlink: load fou module for kci_test_encap_fou()
To:     David Miller <davem@davemloft.net>, kuba@kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David,

do you need more information for this V2 patch?

Thank you
PHLin

On Mon, Aug 17, 2020 at 10:53 AM Po-Hsu Lin <po-hsu.lin@canonical.com> wrote:
>
> The kci_test_encap_fou() test from kci_test_encap() in rtnetlink.sh
> needs the fou module to work. Otherwise it will fail with:
>
>   $ ip netns exec "$testns" ip fou add port 7777 ipproto 47
>   RTNETLINK answers: No such file or directory
>   Error talking to the kernel
>
> Add the CONFIG_NET_FOU into the config file as well. Which needs at
> least to be set as a loadable module.
>
> Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
> ---
>  tools/testing/selftests/net/config       | 1 +
>  tools/testing/selftests/net/rtnetlink.sh | 6 ++++++
>  2 files changed, 7 insertions(+)
>
> diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
> index 3b42c06b..96d2763 100644
> --- a/tools/testing/selftests/net/config
> +++ b/tools/testing/selftests/net/config
> @@ -31,3 +31,4 @@ CONFIG_NET_SCH_ETF=m
>  CONFIG_NET_SCH_NETEM=y
>  CONFIG_TEST_BLACKHOLE_DEV=m
>  CONFIG_KALLSYMS=y
> +CONFIG_NET_FOU=m
> diff --git a/tools/testing/selftests/net/rtnetlink.sh b/tools/testing/selftests/net/rtnetlink.sh
> index bdbf4b3..7931b65 100755
> --- a/tools/testing/selftests/net/rtnetlink.sh
> +++ b/tools/testing/selftests/net/rtnetlink.sh
> @@ -521,6 +521,11 @@ kci_test_encap_fou()
>                 return $ksft_skip
>         fi
>
> +       if ! /sbin/modprobe -q -n fou; then
> +               echo "SKIP: module fou is not found"
> +               return $ksft_skip
> +       fi
> +       /sbin/modprobe -q fou
>         ip -netns "$testns" fou add port 7777 ipproto 47 2>/dev/null
>         if [ $? -ne 0 ];then
>                 echo "FAIL: can't add fou port 7777, skipping test"
> @@ -541,6 +546,7 @@ kci_test_encap_fou()
>                 return 1
>         fi
>
> +       /sbin/modprobe -q -r fou
>         echo "PASS: fou"
>  }
>
> --
> 2.7.4
>
