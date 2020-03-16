Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEFB9C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 20:30:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 855FF20674
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 20:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FXLiYLt6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732570AbgCPUaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 16:30:35 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39482 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732527AbgCPUaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 16:30:35 -0400
Received: by mail-pl1-f195.google.com with SMTP id m1so325086pll.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 13:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yu64KSO2j/IShyNkzlE1/rhNk4ckOFCAT1HOnClY8mw=;
        b=FXLiYLt6cHEbL1uT9QrMgvWyLBlMnb2tg9L8BeiuFntcKb7AKNDkGn1kFgPkKdscaA
         Xs9WVDvhTJtPw7JK3exyVFTQFORHIoC6mchYTjD+FBgsXWlC0xCQBigte/OjQKHuSMau
         BASNEcz7DY+9N+wiXzX6gaFCMjkYkaCcGnila9vM/9kVFG1x5ai844TnCIC9MBHU4b8F
         LDkWVaPGsRqHIgSzVTpeQqCm5H23TxFPvd4AeflGYFyqhnug0FgLxOs7/har+TbIWlu9
         GuOVSZlRHIXWmSPABHfyoYVqoyLfFE7Lwky9VMQPRzNLSYLjF9OqMOvRtoFXUUeMsoiQ
         rOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yu64KSO2j/IShyNkzlE1/rhNk4ckOFCAT1HOnClY8mw=;
        b=ZWt/P9UjkCdhdyx0ndiINyrVGOUdryfz3WhIrOskTF/h5u0bpvJezutrLKs00xLQNQ
         ugARDf5nJchXrdxsfQ4iszMJVtx1dcHYz7Zz6dn5nZrFeOQqqXrv1AzksWSxDLaJN/5a
         HahkSmvvFBiOSMpTaKkDh+qNFEv2U4/psLIaBsSvUKy9k+Mul+EqxL4EDw6it1XuwXy1
         Vzhzf8DFo+8b30kK/aPcyTeFjFbCLuDCWJw3UoC50naooOnXDdIj3B8NQufeZEVyQYxQ
         uS94w2bAKU/tZ5pcm423NukU8ii2yAjF3Cvg+BMtpx4bln1c00MeJW7E4rFXEuq/VPpc
         1dVg==
X-Gm-Message-State: ANhLgQ2wqqJQ7MZvxWaZi/wMxqCW/3vJIA6RPJwaBz5fgJgQRL8rYWXR
        mIukJ8DOYCyFiGc8Vlx8B5Sqq8o3z/bWyXOmhNPrxphot3I=
X-Google-Smtp-Source: ADFU+vsYzCffmQb/XCUQsISGT10ec0VfDjJAnTWXelfrf3RRvEi77GLXlwNTpMwq7rbWg2B5+1nh8eA/KcYjp7OW9V0=
X-Received: by 2002:a17:90a:a616:: with SMTP id c22mr1393948pjq.47.1584390632130;
 Mon, 16 Mar 2020 13:30:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200316202125.15852-1-heidifahim@google.com>
In-Reply-To: <20200316202125.15852-1-heidifahim@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Mon, 16 Mar 2020 13:30:21 -0700
Message-ID: <CAFd5g46CRzqp6r0DtMCzjjf3PYkkyJvt=tWznrW=ZNxT0FMP3A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] kunit: kunit_parser: make parser more robust
To:     Heidi Fahim <heidifahim@google.com>
Cc:     shuah <shuah@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 1:21 PM Heidi Fahim <heidifahim@google.com> wrote:
>
> Previously, kunit_parser did not properly handle kunit TAP output that
> - had any prefixes (generated from different configs e.g.
> CONFIG_PRINTK_TIME)
> - had unrelated kernel output mixed in the middle of
> it, which has shown up when testing with allyesconfig
> To remove prefixes, the parser looks for the first line that includes
> TAP output, "TAP version 14".  It then determines the length of the
> string before this sequence, and strips that number of characters off
> the beginning of the following lines until the last KUnit output line is
> reached.
> These fixes have been tested with additional tests in the
> KUnitParseTest and their associated logs have also been added.
>
> Signed-off-by: Heidi Fahim <heidifahim@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
