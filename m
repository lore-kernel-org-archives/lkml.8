Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF3DC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11FE722CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 16:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598546680;
	bh=Q5aYYSu8IY0KtYyVdillqXz7kNeaqxHQnPYNT03oQfk=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=PwLsdeo5Vjg/AahuaKuoVDluspbhNUTqSk4ex/0n4cyw3xPjGaBiiglXbU884FZSC
	 iA2gY3acWZK/wQjt9CGNTLlw5QbK8sJSZSGW6RhvIqdaFT0bjtUR3QJIsPwUX+uNnc
	 KveWzZfRminvN6yrcJfffAvEBT2cvhCB6kJvFAis=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgH0Qoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 12:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgH0Qoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 12:44:37 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690C4C061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 09:44:37 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id i10so6533713iow.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 09:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=yD0oCQhhV/YgON9Q9qRgw4PKAGTMOkPcQdtUeu+eeGo=;
        b=H05tKdjRA7CpsxEhAgD2n+R4Zle8k6MFcogR4vh+WxqFQFBrWtVUdJz3+SUM49oHD9
         zfD94Dxq/goNnWe5STC8ZOGq3O1pQQzCsLTtD8+q8FTmclfPnQU473ymDA4x/Nd0v02C
         lEFjhLE0CSByi+9XTNWb9TYCy0ZrRoSh1D7gE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yD0oCQhhV/YgON9Q9qRgw4PKAGTMOkPcQdtUeu+eeGo=;
        b=nxKzdHdnRaYExBYQOsjpCgtpy7heJ7ygBA5ezxDoQhEEPW6CyRzENBWKd11OW4reiF
         iwg7zPBu/5aqlI95MvcFfSJR72hUHqFMRuxgf+NzAHj34SRDQkCbXqwBAMLID1BLl3/a
         g7uPhyfTJyDsy6pkCvFEM1OwAnaHoiH/7WxCkPiXCT0Akk37r9uladsm+3bGZs8flQEZ
         ZVI3dKSODes2yzp6ZK2Lu96+t2zJLHqC2ql5WoG8vR5jie+Ii4MUrm/puC8lI/3+OZIR
         FaQ/j+x2MVVFDZTx4F0rQGTR35eqXWqzhErZxRgIcW+tAmAQ9GHoiDrAmObjyIM7nt6p
         NFwA==
X-Gm-Message-State: AOAM530Jc1aKdDfyS25sJJN2/W0UC37NvHRpbK1Gj4gVifbuthl0Cg/u
        RcWDs8orrl2BgptAC7XgU+GFpw==
X-Google-Smtp-Source: ABdhPJy0QNZLAye/+ntACjbnw1CEGNqxV2Hk5ydPtsRxq1oIDicWP2J9Mdu1tNXeMBU5axSrEjfP7A==
X-Received: by 2002:a02:843:: with SMTP id 64mr14945203jac.59.1598546676673;
        Thu, 27 Aug 2020 09:44:36 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id v11sm632346ili.66.2020.08.27.09.44.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 09:44:36 -0700 (PDT)
Subject: Re: [PATCH] staging: ion: remove from the tree
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        laura@labbott.name, sumit.semwal@linaro.org, john.stultz@linaro.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        =?UTF-8?Q?Arve_Hj=c3=b8nnev=c3=a5g?= <arve@android.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Christian Brauner <christian@brauner.io>,
        Christoph Hellwig <hch@infradead.org>,
        Hridya Valsaraju <hridya@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Martijn Coenen <maco@android.com>,
        Shuah Khan <shuah@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Todd Kjos <tkjos@android.com>, devel@driverdev.osuosl.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20200827123627.538189-1-gregkh@linuxfoundation.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <6be71d12-1335-e53a-72ed-bd4392f20394@linuxfoundation.org>
Date:   Thu, 27 Aug 2020 10:44:34 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200827123627.538189-1-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/27/20 6:36 AM, Greg Kroah-Hartman wrote:
> The ION android code has long been marked to be removed, now that we
> dma-buf support merged into the real part of the kernel.
> 
> It was thought that we could wait to remove the ion kernel at a later
> time, but as the out-of-tree Android fork of the ion code has diverged
> quite a bit, and any Android device using the ion interface uses that
> forked version and not this in-tree version, the in-tree copy of the
> code is abandonded and not used by anyone.
> 
> Combine this abandoned codebase with the need to make changes to it in
> order to keep the kernel building properly, which then causes merge
> issues when merging those changes into the out-of-tree Android code, and
> you end up with two different groups of people (the in-kernel-tree
> developers, and the Android kernel developers) who are both annoyed at
> the current situation.  Because of this problem, just drop the in-kernel
> copy of the ion code now, as it's not used, and is only causing problems
> for everyone involved.
> 
> Cc: "Arve Hjønnevåg" <arve@android.com>
> Cc: "Christian König" <christian.koenig@amd.com>
> Cc: Christian Brauner <christian@brauner.io>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Hridya Valsaraju <hridya@google.com>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: John Stultz <john.stultz@linaro.org>
> Cc: Laura Abbott <laura@labbott.name>
> Cc: Martijn Coenen <maco@android.com>
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Sumit Semwal <sumit.semwal@linaro.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Todd Kjos <tkjos@android.com>
> Cc: devel@driverdev.osuosl.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linaro-mm-sig@lists.linaro.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>   MAINTAINERS                                   |  10 -
>   drivers/staging/android/Kconfig               |   2 -
>   drivers/staging/android/Makefile              |   2 -
>   drivers/staging/android/TODO                  |   5 -
>   drivers/staging/android/ion/Kconfig           |  27 -
>   drivers/staging/android/ion/Makefile          |   4 -
>   drivers/staging/android/ion/ion.c             | 649 ------------------
>   drivers/staging/android/ion/ion.h             | 302 --------
>   drivers/staging/android/ion/ion_cma_heap.c    | 138 ----
>   drivers/staging/android/ion/ion_heap.c        | 286 --------
>   drivers/staging/android/ion/ion_page_pool.c   | 155 -----
>   drivers/staging/android/ion/ion_system_heap.c | 377 ----------
>   drivers/staging/android/uapi/ion.h            | 127 ----
>   tools/testing/selftests/Makefile              |   3 +-
>   tools/testing/selftests/android/Makefile      |  39 --
>   tools/testing/selftests/android/config        |   5 -
>   .../testing/selftests/android/ion/.gitignore  |   4 -
>   tools/testing/selftests/android/ion/Makefile  |  20 -
>   tools/testing/selftests/android/ion/README    | 101 ---
>   tools/testing/selftests/android/ion/ion.h     | 134 ----
>   .../testing/selftests/android/ion/ion_test.sh |  58 --
>   .../selftests/android/ion/ionapp_export.c     | 127 ----
>   .../selftests/android/ion/ionapp_import.c     |  79 ---
>   .../selftests/android/ion/ionmap_test.c       | 136 ----
>   .../testing/selftests/android/ion/ionutils.c  | 253 -------
>   .../testing/selftests/android/ion/ionutils.h  |  55 --
>   .../testing/selftests/android/ion/ipcsocket.c | 227 ------
>   .../testing/selftests/android/ion/ipcsocket.h |  35 -
>   tools/testing/selftests/android/run.sh        |   3 -
>   29 files changed, 1 insertion(+), 3362 deletions(-)
>   delete mode 100644 drivers/staging/android/ion/Kconfig
>   delete mode 100644 drivers/staging/android/ion/Makefile
>   delete mode 100644 drivers/staging/android/ion/ion.c
>   delete mode 100644 drivers/staging/android/ion/ion.h
>   delete mode 100644 drivers/staging/android/ion/ion_cma_heap.c
>   delete mode 100644 drivers/staging/android/ion/ion_heap.c
>   delete mode 100644 drivers/staging/android/ion/ion_page_pool.c
>   delete mode 100644 drivers/staging/android/ion/ion_system_heap.c
>   delete mode 100644 drivers/staging/android/uapi/ion.h
>   delete mode 100644 tools/testing/selftests/android/Makefile
>   delete mode 100644 tools/testing/selftests/android/config
>   delete mode 100644 tools/testing/selftests/android/ion/.gitignore
>   delete mode 100644 tools/testing/selftests/android/ion/Makefile
>   delete mode 100644 tools/testing/selftests/android/ion/README
>   delete mode 100644 tools/testing/selftests/android/ion/ion.h
>   delete mode 100755 tools/testing/selftests/android/ion/ion_test.sh
>   delete mode 100644 tools/testing/selftests/android/ion/ionapp_export.c
>   delete mode 100644 tools/testing/selftests/android/ion/ionapp_import.c
>   delete mode 100644 tools/testing/selftests/android/ion/ionmap_test.c
>   delete mode 100644 tools/testing/selftests/android/ion/ionutils.c
>   delete mode 100644 tools/testing/selftests/android/ion/ionutils.h
>   delete mode 100644 tools/testing/selftests/android/ion/ipcsocket.c
>   delete mode 100644 tools/testing/selftests/android/ion/ipcsocket.h
>   delete mode 100755 tools/testing/selftests/android/run.sh
> 
>

For selftest changes in this patch:

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah


