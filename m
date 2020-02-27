Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91807C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DD372067C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 18:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tvcOJ69L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729820AbgB0SzK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:55:10 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32790 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729269AbgB0SzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 13:55:10 -0500
Received: by mail-wr1-f67.google.com with SMTP id x7so132526wrr.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 10:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/V85YaAe8XR5oTJ96oXQ+ABPr+snDJtWcbgtmR0Qea4=;
        b=tvcOJ69LptQiNyIzqDTnQbb+0cH7+bJsKcKVrNn1ocnZu1vLfyskMvmxRkGO+mGr6u
         f2Ykbd9OTXcEGdrbFghUU1KgIrUIZeOT43FiPQgbZRlL5KpRxgL7wWg0AAtfFXJ0iWYR
         rpZj5k8cq/Fp+cVgo7T3U3PhCnOqckMoOQvYGsdHsn6A2+2q/7ejTDo3ypiwxgF5OwVe
         F2QO4IFnWh9b1iHODVBOjreYygP/18KqrjJpFhKp5RCQZWJ7p8R3/puyepM9lHxSvtFr
         QoX+v1NzdKAwqdlfF/td6PRIx8bVx/j3EGSJjuLCOzduvVqHMmIQ6DkYAG7ppOvqtkdR
         wIzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/V85YaAe8XR5oTJ96oXQ+ABPr+snDJtWcbgtmR0Qea4=;
        b=CZcE7D8OBsFHFiFPIs8w+eInCOOHqycS2u64TIEMzPUNMtoAhHP8ZYaekIKxzhjNF2
         qyzQ2cHv/xZIcG7MbVy394NGeJfQadryCZGdlFW2JTs6/wf4eIqLpNqQuXrJNBOa32Zw
         Jha4p9F0FkJQCvnNOZL43LMFJyNcIH1d+6g10BD458VQV4NJp4lT9edtAwTKnrPKelBk
         F74WcF32fYJNfTwC5B504feVtHvkoHJbu60K+wAWzrj1DbJfrmv4kzzxKlO5IdZ6fuom
         GvPB+hUnCNwlDCIO9GbUVgrXnM8FRI4/QkjpUTgxScFE+8DBDNItY0uZjfLhoC7XnRCw
         if9g==
X-Gm-Message-State: APjAAAUpZMc7LPXUvMk5XPn2O8wiiRg2101aHWT1t2klKw6ul5GUNDO8
        iN4pLrp6TT1KrUFyn6dZe/bYqXgTBVH8mjPOLBf0ig==
X-Google-Smtp-Source: APXvYqxqsioMAn9f18ckX2JCivtKIQRNEzVlRJ7K9EUTjk60nx17Q4stuJaYzodA9hVo7BuMRtl7HCJdy9LJNH66dxI=
X-Received: by 2002:adf:ef4c:: with SMTP id c12mr248687wrp.203.1582829708486;
 Thu, 27 Feb 2020 10:55:08 -0800 (PST)
MIME-Version: 1.0
References: <20200227063134.261636-1-gthelen@google.com>
In-Reply-To: <20200227063134.261636-1-gthelen@google.com>
From:   David Gow <davidgow@google.com>
Date:   Thu, 27 Feb 2020 10:54:56 -0800
Message-ID: <CABVgOSkdphVaWhL1bBpC-vBgJ5pS144wD_g588o2_xxHXd=Ngg@mail.gmail.com>
Subject: Re: [PATCH] kunit: add --make_options
To:     Greg Thelen <gthelen@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 10:31 PM 'Greg Thelen' via KUnit Development
<kunit-dev@googlegroups.com> wrote:
>
> The kunit.py utility builds an ARCH=um kernel and then runs it.  Add
> optional --make_options flag to kunit.py allowing for the operator to
> specify extra build options.
>
> This allows use of the clang compiler for kunit:
>   tools/testing/kunit/kunit.py run --defconfig \
>     --make_options CC=clang --make_options HOSTCC=clang
>
> Signed-off-by: Greg Thelen <gthelen@google.com>

Tested-by: David Gow <davidgow@google.com>

Nice! This worked for me with all of the options I tried (and it's
great to see KUnit working on clang builds!)

-- David
