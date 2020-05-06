Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F87C47256
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 17:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61066208DB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 17:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ECGhwMJF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbgEFRiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 13:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbgEFRiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 13:38:11 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA161C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 10:38:10 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id m24so1551105vsq.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 10:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8a5zVBKejAgld7VXzNaF8qHJFaoZBo2UQTEJWN0/Pas=;
        b=ECGhwMJFfElWGMQN6/BzuvU4toFz9t7sCKONntpXpgyTmUVrganDLiAX/JlOezV9MQ
         v0ZNSoJ+RYvhi10KmB3EhaeHUbcH3Cdf9MmAvDRRODJ6v0moR/ADr9ynPi6ZiHninbhx
         axqnRj1QFSWECx6NxDenAzW44t5GBcDUwJa8o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8a5zVBKejAgld7VXzNaF8qHJFaoZBo2UQTEJWN0/Pas=;
        b=HgfZF3cveAJQK+XthMFWpAKoIE28Nvk9CL10N609Gg0RFHWf5YnYqysn9SlUTxvGj5
         a5O+m7YuAkiWzq0wkLsBb1pV0JrmX/4CsL0OYp4Si+xUfkF9BIhI3r/4L5F+nn9hBK4M
         owz1j+RpGjBQ3jDAnlmUMSNSV5Aa9kYVjVHgnJAJ+n2sxX+xQq7GF3yeXSR5PyB9HFji
         SPEFDmQy/MQ6f94t23q6LbK5ojDWiupsapSjzNCW5R1rHVeaQUgA5NgVL6DhLoh9s7sc
         DfVWRIv5tbsbwB9DgbEHiGNw/8LSBG7pp9sNCiRiuy0fKTK2jw+J3PE0lnQB9vMnFZRm
         67TA==
X-Gm-Message-State: AGi0Pubf+OKpNrwxIWjG2o3fUHyFXuPe4J8UOeH7VLWLiJV/gpQvrZ1L
        zm8A4B8Wh6B9UWxDSNfvr4osB5ki6Qs=
X-Google-Smtp-Source: APiQypIgzcPwoIlr/pl/vdElTZ0yP1aBOoxtVPcBuy2Ad5cSHpYHO+P95Cps1hNjp8UkHH6SRCgTnQ==
X-Received: by 2002:a67:6487:: with SMTP id y129mr8905842vsb.48.1588786689536;
        Wed, 06 May 2020 10:38:09 -0700 (PDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id t23sm1019637vsm.31.2020.05.06.10.38.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2020 10:38:08 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id u12so1682035vsq.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 10:38:08 -0700 (PDT)
X-Received: by 2002:a67:c40c:: with SMTP id c12mr8798801vsk.106.1588786687950;
 Wed, 06 May 2020 10:38:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200506164223.2875760-1-daniel.thompson@linaro.org>
In-Reply-To: <20200506164223.2875760-1-daniel.thompson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 6 May 2020 10:37:56 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X7RjSV+dVt-AUn04bW9ZxcmQs8=OpYuXrPFx3US8yMsw@mail.gmail.com>
Message-ID: <CAD=FV=X7RjSV+dVt-AUn04bW9ZxcmQs8=OpYuXrPFx3US8yMsw@mail.gmail.com>
Subject: Re: [PATCH] kgdb: Fix spurious true from in_dbg_master()
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        Patch Tracking <patches@linaro.org>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, May 6, 2020 at 9:42 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> Currently there is a small window where a badly timed migration could
> cause in_dbg_master() to spuriously return true. Specifically if we
> migrate to a new core after reading the processor id and the previous
> core takes a breakpoint then we will evaluate true if we read
> kgdb_active before we get the IPI to bring us to halt.
>
> Fix this by checking irqs_disabled() first. Interrupts are always
> disabled when we are executing the kgdb trap so this is an acceptable
> prerequisite. This also allows us to replace raw_smp_processor_id()
> with smp_processor_id() since the short circuit logic will prevent
> warnings from PREEMPT_DEBUG.
>
> Fixes: dcc7871128e9 ("kgdb: core changes to support kdb")
> Suggested-by: Will Deacon <will@kernel.org>
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  include/linux/kgdb.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/kgdb.h b/include/linux/kgdb.h
> index b072aeb1fd78..4d6fe87fd38f 100644
> --- a/include/linux/kgdb.h
> +++ b/include/linux/kgdb.h
> @@ -323,7 +323,7 @@ extern void gdbstub_exit(int status);
>  extern int                     kgdb_single_step;
>  extern atomic_t                        kgdb_active;
>  #define in_dbg_master() \
> -       (raw_smp_processor_id() == atomic_read(&kgdb_active))
> +       (irqs_disabled() && (smp_processor_id() == atomic_read(&kgdb_active)))
>  extern bool dbg_is_early;
>  extern void __init dbg_late_init(void);
>  extern void kgdb_panic(const char *msg);

Reviewed-by: Douglas Anderson <dianders@chromium.org>
