Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D06BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 21:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E6A920659
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 21:31:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aRWb+5j2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbgEMVbD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 17:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728718AbgEMVbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 17:31:02 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22803C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 14:31:02 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id b6so1256713ljj.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 14:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a9uxH9jWM4mVXVshrpkeyF8BGnOgX348uy7Ps74S7eg=;
        b=aRWb+5j2c0aj7XE/Ves+oxeniLbg9iIlAhIISgisDu4/eSB4ZqiQChimWhZ3HGmpXc
         WURsi4vQsfpLvwdxw48T+IKK3N3RHlcICKOh0WF+PdpzfdqqwZRnpP58vzupTR6G/YQE
         +W2WNCd8Q2g8DzMsJfTHYCusqlCnF6z7F6xI08HQcPxEArZKRpsln8LhTN4/Y+arbix4
         FG1Zzq6Pt/0WAkmITpHuJNS0uzYebUiOObQU2AvZmOlMDGv7wLn9fdA/myV38leDpvRh
         RgCBVn6nTg4EncSiLHEB3dt1Zw2fDc+C2feriU/z5QgP8e0hzNCLZvfX0iCSt+a8bKWP
         7fwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a9uxH9jWM4mVXVshrpkeyF8BGnOgX348uy7Ps74S7eg=;
        b=bjEPZBO6NufxKFE7V+t/FZdeF3e4jznN989qTJF+Mv8ZXuuUq0ZFsLri9Jrt1r+TrG
         HyGlEBrpnAvEh8792SZjZux3SKmabebJpp4l8ClKjzv77PI7zFqlQvGvIoHZj2Ty3HZk
         awLOSF6OQiJNFQBJCvT0TCqQgTwSV+Sxl5yTLPE1EDcNmvnlfnz9te6uKhIV6pXA+bNw
         2d2U2jOVaKdJ2ByVgSzkTSjzraw6w+fTeQ2/i/jgNroQ5oI76MVfEjlenKPBzzOqfzjN
         IkSmg8j5KhIFdCfdPQDumwzB3qUbRBzpQsIWmkoR1Ft4Xo7iTOjNPs86bDHG9tm0uKDH
         rrcw==
X-Gm-Message-State: AOAM531YZPITCfa4KkBM2ndEZ1REcdv0xv80DAbWBhl7KMIpGArU8+9O
        k3swMj/7A0lczHzL5xP2sn9W1zo0i7ruvyjwUA2O9A==
X-Google-Smtp-Source: ABdhPJw4IyIFesqGpLpxuKkqi5G3Abd0+9YLqr/XEd7oHtLUyW3ygmOr1Oo0CkhpszrDBkrmRzqTZ4cXhjM85UjglsA=
X-Received: by 2002:a2e:9b45:: with SMTP id o5mr646235ljj.33.1589405460384;
 Wed, 13 May 2020 14:31:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200513151840.36400-1-heikki.krogerus@linux.intel.com>
In-Reply-To: <20200513151840.36400-1-heikki.krogerus@linux.intel.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 13 May 2020 14:30:49 -0700
Message-ID: <CAFd5g44d+VCSimjboPkf-NF1eCdbq6Uy+pabNftB8p5Lj2yc1A@mail.gmail.com>
Subject: Re: [PATCH] kobject: Make sure the parent does not get released
 before its children
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        kernel test robot <rong.a.chen@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 8:18 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> In the function kobject_cleanup(), kobject_del(kobj) is
> called before the kobj->release(). That makes it possible to
> release the parent of the kobject before the kobject itself.
>
> To fix that, adding function __kboject_del() that does
> everything that kobject_del() does except release the parent
> reference. kobject_cleanup() then calls __kobject_del()
> instead of kobject_del(), and separately decrements the
> reference count of the parent kobject after kobj->release()
> has been called.
>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> Fixes: 7589238a8cf3 ("Revert "software node: Simplify software_node_release() function"")
> Cc: Brendan Higgins <brendanhiggins@google.com>
> Cc: Randy Dunlap <rdunlap@infradead.org>
> Suggested-by: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Tested-by: Brendan Higgins <brendanhiggins@google.com>
