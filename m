Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BB7C433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 15:04:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D7DF20709
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 15:04:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkEVU9ZU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729698AbgGUPEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 11:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728064AbgGUPEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 11:04:46 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573BFC061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 08:04:46 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id k18so16329435qtm.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 08:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xcBXfL/2ghXmfWUhIUFmjDIyiJHk+JdIwC3C6WYMhpA=;
        b=nkEVU9ZU87N0ifRBVfB1q8YCi1RxVxmEu5RdvsDBXhFiPEL0+m0yusDrGS/FPQ3rV4
         xIvv4ogoqcsmhBb2zKHlT8evZyfcSrjlNRIDagEWf2bZJ+APn9ZNgdOWqtt3jSVKMQjc
         8jA9M3khDvpJ/TEVAbWFQNwBkiJyvtzM7IUzy0BA1NgrC9LRk93FKRVqtD9AEsVn6viX
         kgsPnKKqECnJc6sBS4aeiSeBZeS7SKdsRVwoyZ5zVYFPPkcY7RARcI5IxXIJT+kqyJKJ
         /9YzVuyStefKMLITBThkojKd8PUiTeZAmOJfUyw230YDsecfXsxPQHpsqj579b/xhvBO
         TQXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xcBXfL/2ghXmfWUhIUFmjDIyiJHk+JdIwC3C6WYMhpA=;
        b=UZXmj14PmyyOAP6XIi5AHJ4QS8OO45+W4QY95AGTsV12cPeiv8nxO4+2hY/tM9yr3O
         QNXe2f6dccmJPRvjNsYm8B0vsTc1xsCKnAGbc9ZkySwmLrABvNFrRI03a9wq8g+IO0dk
         AGq+PzAbxS0uWTfjzS7Jw8DM8Ursw64LzqCb47fO1C3JXjNGdWF/oRQdYbxoBgxndFpj
         kq9tr4ynCI/ztVKlORLeBdqm8ghlyabUpZnySoN/9KEA1tlOxNx/yhaRGfkQ3nB2pIg9
         LXa6AEgM4UktQlghCPGDWlO+6Jght5ANgPPi2B1D/D4qsssK8PJ3ObTlqUE+F9DBXRoj
         mgnQ==
X-Gm-Message-State: AOAM533dGa3hBoppsmbI5KnBFqi10ASdEHn0UmLpNWR641xJkc2OnnR0
        ReG7zTGfZxRs6++q57dTFPuC9co2
X-Google-Smtp-Source: ABdhPJwcRO7tXnnPSf8B+4lEuH1QUJZdUVQ0cn4kYYXhtisfbmAXqhFc7yHxIC+6L/VpKdV5We+r+g==
X-Received: by 2002:ac8:957:: with SMTP id z23mr29480958qth.68.1595343884455;
        Tue, 21 Jul 2020 08:04:44 -0700 (PDT)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com. [209.85.222.174])
        by smtp.gmail.com with ESMTPSA id p4sm2543441qkj.135.2020.07.21.08.04.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 08:04:43 -0700 (PDT)
Received: by mail-qk1-f174.google.com with SMTP id h7so3701184qkk.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 08:04:43 -0700 (PDT)
X-Received: by 2002:a25:4886:: with SMTP id v128mr40285167yba.53.1595343882471;
 Tue, 21 Jul 2020 08:04:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200721145249.72153-1-paolo.pisati@canonical.com>
In-Reply-To: <20200721145249.72153-1-paolo.pisati@canonical.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Tue, 21 Jul 2020 11:04:06 -0400
X-Gmail-Original-Message-ID: <CA+FuTSeN8SONXySGys8b2EtTqJmHDKw1XVoDte0vzUPg=yuH5g@mail.gmail.com>
Message-ID: <CA+FuTSeN8SONXySGys8b2EtTqJmHDKw1XVoDte0vzUPg=yuH5g@mail.gmail.com>
Subject: Re: [PATCH] selftests: txtimestamp: tear down setup() 'tc' and 'ip'
 env on EXIT
To:     Paolo Pisati <paolo.pisati@canonical.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Shuah Khan <shuah@kernel.org>, Jian Yang <jianyang@google.com>,
        Network Development <netdev@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 10:52 AM Paolo Pisati
<paolo.pisati@canonical.com> wrote:
>
> Add a cleanup() path upon exit, making it possible to run the test twice in a
> row:
>
> $ sudo bash -x ./txtimestamp.sh
> + set -e
> ++ ip netns identify
> + [[ '' == \r\o\o\t ]]
> + main
> + [[ 0 -eq 0 ]]
> + run_test_all
> + setup
> + tc qdisc add dev lo root netem delay 1ms
> Error: Exclusivity flag on, cannot modify.
>
> Signed-off-by: Paolo Pisati <paolo.pisati@canonical.com>

The test should already clean up after itself, by being run inside a
network namespace. That is a more robust method to ensure that all
state is reset.

The issue here is that the else branch is taken in

  if [[ "$(ip netns identify)" == "root" ]]; then
          ./in_netns.sh $0 $@
  else
          main $@
  fi

because the ip netns identify usually returns an empty string, not
"root". If we fix that, no need to add additional cleanup.
