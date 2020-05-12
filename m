Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9CAC2D0F7
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 19:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83EB6206DD
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 19:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtpTD4OH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731062AbgELT6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 15:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726324AbgELT6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 15:58:20 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E92C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 12:58:20 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id v5so7539524lfp.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 12:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=UkKrmoO+1GROby9Kk2d90YvChtXCnxfkfMutiA10uAQ=;
        b=dtpTD4OHuYCGHXxEDr3+iJTL9o/TakZfaKn0H8edSyCLNh/U3lRZXqEhQRgB4uAFbY
         zFoHhCPUjdPo2Ld7n+vm8kowiEXxGmrGigp21tA+yf+HActvdSOV4pHL/e0lSDjUdIum
         DC0Y3vKE7Cz741X9uDS6VTBsv5cU4JUYh79dTMdvQkyIRVbcHhLV9edgin4synNEThep
         JmdCvyJl+asxrKPv/9CGoh8Zk0QuyG5mh3pF+cb3PYucuP2nHyLaZUQX44YnGyMR26yQ
         rBG9s55fLghSp1bVbKhM4KDlp+iwwUc2Y+DIfhiCFnZrDEeur5Xh2EwhmSm0vcgYFTBl
         VPyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=UkKrmoO+1GROby9Kk2d90YvChtXCnxfkfMutiA10uAQ=;
        b=EeqhhJKXSV9N7ovSvxlu/FSlhrGM9lvyu053pD9YAVM+gh4Wxeo2qIgbIfUAWiQ+/G
         NI0KofP/MMa/UO+VZ64O4B1qzl0sgrImEmahZ7OR8QU2RxIdNJEzRncpBegh0vkB1id2
         LxI96a9SOP9YB/DBodbTd1aiCK3cDL5l1z4rrTJnM1fqQ7x1f333Jbej3Xc3bbq0OKEO
         k25xrjZ8jdcTuAlkH54R6njM9zIJvueQtXqjPHlukWXfG02cEreYSarvB0y9cxKBJSMp
         XSFXabryV4VJt+KEPLECVhCb08f9aK7E2is9rjmqtbKsP+rZarwtoUTaCQe14lqqHk/T
         zSQA==
X-Gm-Message-State: AOAM532dYCl5Gx7b+PF/G1i6Iojpz3Cpoju/KfSl9V/9IPkyQmIHehOH
        PCePqTOILaH5+rSWeee7pvOw7LAD
X-Google-Smtp-Source: ABdhPJwvxI23o8a6CrSw048P6cYlp01qjq3PvGygN4P6tDIItDPVK2ZXIrwkosaRN7FZJ1KuqcCANg==
X-Received: by 2002:a19:e041:: with SMTP id g1mr15109301lfj.70.1589313498236;
        Tue, 12 May 2020 12:58:18 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id l9sm13204627lje.57.2020.05.12.12.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 12:58:17 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Eugene Syromiatnikov <esyr@redhat.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] uapi, posix-timers: provide clockid-related macros
 and functions to UAPI
References: <20190923130531.GA27774@asgard.redhat.com>
Date:   Tue, 12 May 2020 22:58:16 +0300
In-Reply-To: <20190923130531.GA27774@asgard.redhat.com> (Eugene
        Syromiatnikov's message of "Mon, 23 Sep 2019 15:05:31 +0200")
Message-ID: <87y2pxvsbr.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eugene Syromiatnikov <esyr@redhat.com> writes:

> As of now, there is no interface exposed for converting pid/fd into
> clockid and vice versa; linuxptp, for example, has been carrying these
> definitions in missing.h header for quite some time[1].
>
> [1] https://sourceforge.net/p/linuxptp/code/ci/af380e86/tree/missing.h
>
> Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
> ---
> Changes since v1[1]:
>  * Actually tried to build with the patch and fixed the build error
>    reported by kbuild test robot[2].
>
> [1] https://lkml.org/lkml/2019/9/20/698
> [2] https://lkml.org/lkml/2019/9/22/13
> ---
>  include/linux/posix-timers.h | 47 +------------------------------------------
>  include/uapi/linux/time.h    | 48 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 49 insertions(+), 46 deletions(-)

Was this patch applied, rejected, lost?

I can't find it in the current master.

Thanks,
-- Sergey Organov

