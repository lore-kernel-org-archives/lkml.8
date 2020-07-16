Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7346EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 16:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EFBB20739
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 16:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=massaru-org.20150623.gappssmtp.com header.i=@massaru-org.20150623.gappssmtp.com header.b="coWa0ly+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729253AbgGPQcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 12:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729048AbgGPQcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 12:32:06 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2B5C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 09:32:05 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id el4so2955018qvb.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 09:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=IqaV5FL0PECxrzqMcMpsU9VUXbw3Oykiac0eOEM8xRk=;
        b=coWa0ly+THdkxmgAczU5j9YW2aZldQ+LrSFhlaBEd4BmZx6OP9QCpUiKKmkMvikvTv
         IwNqFmD13zSYGJ3Zh7enFVghVnftWaN+vSKRmGVHLgBNDWC/5gRlvJEcLujqB7jjJPez
         J8r97Xsji3+8GEr8De5QUMMLxi6z8XIa1O5rbljptJtjo4bSVC8BThwDxIZqVJ+CwCNz
         LxKJBFDtUsvXAahhlyCvHcl29Jj6xMg2otzTkGUaRf2+a8KBB1kjm/cfokdzDoRlgHOh
         QnZ/Y4+Q7jYPfBVVRjfJshnYWt+DVDWaHsZSbgfktyYMoAE0KKfvyXxXj81fg+t5dTeZ
         X3Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=IqaV5FL0PECxrzqMcMpsU9VUXbw3Oykiac0eOEM8xRk=;
        b=ZpS9DlZqFNe2XpCfTrTY7nwmBg4AbQmT3eW0cUKFgTtDwWIkdTW3b+xGa7ZYJuajtF
         zJtdeKalm2mB5DC8A0uFRIUuOna9SpgStTtA7CAplIBlHCuWaYdFqPxn5C33bUKLYS5N
         hb5ZpaYR8kkA/3yl1jRwYQg8kXn6FmC631/mC8T2vAU5ScAaQov+wDOxKQR3APnK+NVw
         Mk3AG5wZisFO1wYkpRI1fdlvN8ehpQSlsJioboyouuJF1yI18bGu6IAla/zUDiow4kYX
         2WI5vSTlI3pSYlv6iSmb02VemF+84H3kmKn9F+Q5iJ8o+iuuUo3bOqYm2fLei1/W7cFt
         k72A==
X-Gm-Message-State: AOAM532hq1vdV2RadqspiRTVaBha2CnI6d4Hk4hqa0kJPm0onka5//HA
        JUz742KfMpXPo5L16dX4Y5l+vGC0TeZvAsmS
X-Google-Smtp-Source: ABdhPJy97JfulwTIX38u7Qbd97AVcE4dFHFkx2zvVbbPhDUKKWpZv/FUnRVMqlX0T+/IfOSfVGDcuQ==
X-Received: by 2002:a05:6214:8f4:: with SMTP id dr20mr4872867qvb.228.1594917124969;
        Thu, 16 Jul 2020 09:32:04 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id f15sm7083485qka.120.2020.07.16.09.32.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 09:32:04 -0700 (PDT)
Message-ID: <196eed159aa0e4c94f7481b148a458a465050dc7.camel@massaru.org>
Subject: Re: [RFC 0/3] kunit: add support to use modules
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     Kees Cook <keescook@chromium.org>, David Gow <davidgow@google.com>
Cc:     KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org
Date:   Thu, 16 Jul 2020 13:32:01 -0300
In-Reply-To: <202007151939.62EFE6F@keescook>
References: <20200715031120.1002016-1-vitor@massaru.org>
         <CABVgOSkBAiMSMzCx62_CRo_0e2SGdvRWZ0dSC4t628YJBw-3Aw@mail.gmail.com>
         <202007151939.62EFE6F@keescook>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3 (3.36.3-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-07-15 at 19:41 -0700, Kees Cook wrote:
> On Wed, Jul 15, 2020 at 11:47:11AM +0800, David Gow wrote:
> > - The inheriting of the mm stuff still means that
> > copy_{from,to}_user() will only work if loaded as a module. This
> > really needs to be documented. (Ideally, we'd find a way of having
> > this work even for built-in tests, but I don't have any real ideas
> > as
> > to how that could be done).
> 
> I'd like to better understand this ... are there conditions where
> vm_mmap() doesn't work? I thought this would either use current()
> (e.g.
> how LKDTM uses it when getting triggered from debugfs), or use
> init_mm.
> 
> I'd really like to see the mm patch more well described/justified.
> 

Sure, I'll describe the patch better.

Thanks for the review.

