Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7FD3C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 06:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B4B520772
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 06:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNOc7OZ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgGEGk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 02:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgGEGk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 02:40:58 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA226C061794
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 23:40:58 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id m22so6577253pgv.9
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 23:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OMeXN5/b7K5fCIhCyqLI0LAfiQ3ZT4Xn9DFmhUax7hA=;
        b=eNOc7OZ5WQuVvw9x8zJ9169rpmQEyowaV3xV9hS4Mn/7b4fEALpTa1ag82sk0ud3Qx
         w6ZOU+s5CQkc1aoJ/uKiDl2OzS3oeqjMH41KezFL69/QsUc4RA4mlTbeqdYe/CA/oCXM
         pVWKkzlNlfZK7Da5eO78z7ngEsxnAzXjsOXB0m+2fy7CgDsBuyZViv+uxy3EMfQqgxW6
         63+f89JlOSQc57Xc0oyU10idVv0nJ0jknWHNJLz/1XL/KP+oNyR0+DyGAGnfDZ8Yii3F
         RK9en0m6hBMrGgedi/U6nNfxGDRGS3m4tpfk3ak5AJOHDnA3R42WW6pWebSmKI7yukkS
         6hRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OMeXN5/b7K5fCIhCyqLI0LAfiQ3ZT4Xn9DFmhUax7hA=;
        b=lDPMDtFRdMJEtBjFPhHpnaq7VrjvqYgmAPCewbufu2PqKmbIzIv6svWqQkhYP3yILh
         /o9mkZK94egy84De+GGJGJMZ3/I1d+eQw81JUH2KTLkbr4n4eNmXe5pBjaSCB9260dIY
         Ca3RapQJgH9LeofiFFCvqt46LhLiIzR57rgCb6tSdqmmKWg7Mc74blToM9Loe+gRVjPH
         d2DshqIhC7KonyDN5uXsg7ycxtAu+RIktaVimfGaMmCYbzigO3LcbJ8s2BHmUrc5rNkK
         xrPa5Z9+edzB6yTRqTWFDgIeiBC7ZPI5l4QophOR3e8Ma85Lnr6gMkCK/kkBOG/P/tGj
         Uo2A==
X-Gm-Message-State: AOAM530OaPeYAQhxzVEn+L8R/JiTH6mDHc8mV9QoOVCTxBSXPGnXJWEr
        gAc9uL9wD7Y3ikMxK6NGDs4=
X-Google-Smtp-Source: ABdhPJwFJVuPIlYS9uzm3lCCCEeYYAlNF6O3cqT7mA+2dthYpcVek8XypOHlgUU0nyaP/Tg6rl51OA==
X-Received: by 2002:a63:1641:: with SMTP id 1mr35512763pgw.370.1593931257956;
        Sat, 04 Jul 2020 23:40:57 -0700 (PDT)
Received: from gmail.com ([2601:600:9b7f:872e:a655:30fb:7373:c762])
        by smtp.gmail.com with ESMTPSA id w29sm16082400pfq.128.2020.07.04.23.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2020 23:40:57 -0700 (PDT)
Date:   Sat, 4 Jul 2020 23:40:55 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH v5 0/6] arm64: add the time namespace support
Message-ID: <20200705064055.GA28894@gmail.com>
References: <20200624083321.144975-1-avagin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20200624083321.144975-1-avagin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 01:33:15AM -0700, Andrei Vagin wrote:
> Allocate the time namespace page among VVAR pages and add the logic
> to handle faults on VVAR properly.
> 
> If a task belongs to a time namespace then the VVAR page which contains
> the system wide VDSO data is replaced with a namespace specific page
> which has the same layout as the VVAR page. That page has vdso_data->seq
> set to 1 to enforce the slow path and vdso_data->clock_mode set to
> VCLOCK_TIMENS to enforce the time namespace handling path.
> 
> The extra check in the case that vdso_data->seq is odd, e.g. a concurrent
> update of the VDSO data is in progress, is not really affecting regular
> tasks which are not part of a time namespace as the task is spin waiting
> for the update to finish and vdso_data->seq to become even again.
> 
> If a time namespace task hits that code path, it invokes the corresponding
> time getter function which retrieves the real VVAR page, reads host time
> and then adds the offset for the requested clock which is stored in the
> special VVAR page.
> 

> v2: Code cleanups suggested by Vincenzo.
> v3: add a comment in __arch_get_timens_vdso_data.
> v4: - fix an issue reported by the lkp robot.
>     - vvar has the same size with/without CONFIG_TIME_NAMESPACE, but the
>       timens page isn't allocated on !CONFIG_TIME_NAMESPACE. This
>       simplifies criu/vdso migration between different kernel configs.
> v5: - Code cleanups suggested by Mark Rutland.
>     - In vdso_join_timens, mmap_write_lock is downgraded to
>       mmap_read_lock. The VMA list isn't changed there, zap_page_range
>       doesn't require mmap_write_lock.
> 
> Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Reviewed-by: Dmitry Safonov <dima@arista.com>

Hello Will and Catalin,

Have you had a chance to look at this patch set? I think it is ready to be
merged. Let me know if you have any questions.

Thanks,
Andrei

