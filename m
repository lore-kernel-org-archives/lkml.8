Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8E2C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 02:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C321206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 02:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bSVfWQej"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgFKChg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 22:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726306AbgFKChf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 22:37:35 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76162C08C5C1;
        Wed, 10 Jun 2020 19:37:35 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 202so2642782lfe.5;
        Wed, 10 Jun 2020 19:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H+PEFHyUXjNCEtnDDerXaMNGUi3G6eX8i5SlzQw9UMI=;
        b=bSVfWQejXCjrLOj8aD59mpI6QkWd3hIqBjXK49cAsH8WRyy92kxtm0atwhhm+5W6kr
         xGTReb9eBIElpXamEsVqLi2KDehDVKX2Rb8nuTm3sEemMn44vBuUbFIemxzorJIqDUOs
         V2d0FBjlDVnLKMzP89OEqIicF6R7Oh/fZnavHYshnTs/IQWbbpCdwr55byyCb4cBk+o9
         Vni3sI4Sm3Jbz8w+2rawif+8ZD8bqM5XgCX/d0g8f5hOyuedx5jpSx00zG8VgCRda37j
         30fIHmcDNBjYxtRITEDLWSbw3/QPHuNlnMJFpkns5dPPQZjH7CA9ysuV7BCRCh78uxXy
         E+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H+PEFHyUXjNCEtnDDerXaMNGUi3G6eX8i5SlzQw9UMI=;
        b=W4yFp0+milZF6H4n5Q26GM/6am69SiJGy86/Bt+nMD3iUlxZuycZFXgWDdGIkjSasr
         YXcI49Fx4gDQVly8sqwD+fPjWURjchSiKbcfAEaqKjsOACHL0prU6yV70bc6VEu+CHfp
         HycGvxVkmTuxakZeI1QPqZQeHtLgvXT1qmb1tCFy/UPiy3iNzPKegcv1IaOEk36aGiMQ
         0XvOnR+LGLgKmlymBq9pHtlOUCFFgXN2u9YPGbNrAoYGYQv3uy2r/g+epfJv0c9l5xOM
         NBD5lxxV/SEBKcYA4SVsGKPYOHdnzH1u0zspzziMU+pArGkUbgrwc5v+wDF2UCwbMj7L
         H5zQ==
X-Gm-Message-State: AOAM5306neTsJ2HHFvkfHFgXG9jM14Y54o9Wk/htNdq8bgm7q0WHrn7e
        fg92MRNHrd2yp2xuHThx6giFE8avGJhRAU9ER00=
X-Google-Smtp-Source: ABdhPJxWdTRGBWzD5BGjFzlGFy2xizTaM088b6o597jGy9OQ0toSHngXQPy6TPuvxL9N1Bpb6s2zEczlkz+VL65NfU0=
X-Received: by 2002:a19:8453:: with SMTP id g80mr3137317lfd.167.1591843053787;
 Wed, 10 Jun 2020 19:37:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200610065846.3626-1-zhenzhong.duan@gmail.com>
 <20200610065846.3626-2-zhenzhong.duan@gmail.com> <20200610171912.GB1474@agluck-desk2.amr.corp.intel.com>
In-Reply-To: <20200610171912.GB1474@agluck-desk2.amr.corp.intel.com>
From:   Zhenzhong Duan <zhenzhong.duan@gmail.com>
Date:   Thu, 11 Jun 2020 10:37:22 +0800
Message-ID: <CAFH1YnP_nreyKmHOa24d1XkrFECQg3yFjAJ04FJqWub__SjVxg@mail.gmail.com>
Subject: Re: [PATCH] EDAC/mc: call edac_inc_ue_error() before panic
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-edac@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        mchehab@kernel.org, james.morse@arm.com, rrichter@marvell.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 1:19 AM Luck, Tony <tony.luck@intel.com> wrote:
>
> On Wed, Jun 10, 2020 at 02:58:46PM +0800, Zhenzhong Duan wrote:
> > By calling edac_inc_ue_error() before panic, we get a correct UE error
> > count for core dump analysis.
>
> Looks accurate, and I'll add the patch to be applied. But I wonder
> how big a problem it is. Isn't most of the information deriveable
> from the panic message?

Thanks for review.
Yes, it's totally not a problem.  I'm a little too strict here.

Zhenzhong
