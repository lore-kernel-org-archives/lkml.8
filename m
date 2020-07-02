Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CB5C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:49:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 447AC20899
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:49:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoyObNL9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730313AbgGBOtG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730294AbgGBOtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:49:00 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A9B9C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 07:49:00 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id q74so5582026iod.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 07:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v4VXI9uP014tYHa4Tj77JYdAu3duCFmr1FkN+vT8NsI=;
        b=FoyObNL92iyVLE061Hvbm+xq+zoeDIpNkTcIUjGaXkrsBOkS1ywIpFNY/kdIw7OPms
         EWzPxJOpa7MJzcQI1tMfv/vtfU3yNUt4ZETFGw4iwn/fsT9oFyCTnaKIEPlG/LQW7v/F
         cuJdCxfF3FjsQCpeWWNc/QExbhhNa5rnBjX3vciDAAGLevquONjrb00s+NcBsQlgv81f
         e2GGhZ5MMK992CtMz1m3IsNTvXT5qf752JhUqT9DMnFntgzsoYNJScekoqqQ9tlo3OqY
         saoknjuOJ2JQx0GcMqJd6BehD+PelFtZ31gCN2UQkckHDMAyNoGZFxYKfdmuvXR7NZJY
         oPAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v4VXI9uP014tYHa4Tj77JYdAu3duCFmr1FkN+vT8NsI=;
        b=bpSeTLdPmAPPK/tHAXlGEsMXt+CbQNjTz4+A/Nz19lJTGGDfBbq5S4tQ+8toeEjUKU
         GP6qJ74AVxrqf0YocJxC/jVi601ifjmMbl/v0C9L/5E9zuXvwq/2lcMR/kqpKaMXMWYo
         JkDhFxBpHW99dwPEleN9jg95+AQ+JSL5t49Jo8hPn0ciUI4P384VeM//j1Di3fyYMe/p
         TPnQ6XBeovAovfDuSx9loY/PSkaEBiBVGF62xSBpSlQpLlFecABHsJfTWJCCOEF90BaK
         s2+z1a1YUriLGZb30e/ihHQ0gO6VReGMOjrZMgcLPZykDevEUiC0bIp5iiABWnE6ZPZ/
         QE8A==
X-Gm-Message-State: AOAM532oRulckcF5xTGcYO1aZuyYB16+IQA1bongHIj2TFwbqxLhSKcc
        epmA+etF8GWMP+aKoj3/0XfF/KQKUByhznHBcA==
X-Google-Smtp-Source: ABdhPJyVQXzx0lAtmUN3BtC8Tkcr13el8baae8+TSIqX/1DCH6FcNUO6wM89BF5N7w1XA1rAyO0/vpSkh2gr5Elwbuo=
X-Received: by 2002:a5d:849a:: with SMTP id t26mr7826768iom.22.1593701339267;
 Thu, 02 Jul 2020 07:48:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200701110650.16172-1-jgross@suse.com>
In-Reply-To: <20200701110650.16172-1-jgross@suse.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Thu, 2 Jul 2020 10:48:48 -0400
Message-ID: <CAMzpN2hvK2T7Qje51MPjMyTggxT7_=EFnt7gAmJEa1Zq+t3LtA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Remove 32-bit Xen PV guest support
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel <xen-devel@lists.xenproject.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Virtualization <virtualization@lists.linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Deep Shah <sdeep@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 1, 2020 at 7:07 AM Juergen Gross <jgross@suse.com> wrote:
>
> The long term plan has been to replace Xen PV guests by PVH. The first
> victim of that plan are now 32-bit PV guests, as those are used only
> rather seldom these days. Xen on x86 requires 64-bit support and with
> Grub2 now supporting PVH officially since version 2.04 there is no
> need to keep 32-bit PV guest support alive in the Linux kernel.
> Additionally Meltdown mitigation is not available in the kernel running
> as 32-bit PV guest, so dropping this mode makes sense from security
> point of view, too.

One thing that you missed is removing VDSO_NOTE_NONEGSEG_BIT from
vdso32/note.S.  With that removed there is no difference from the
64-bit version.

Otherwise this series looks good to me.
--
Brian Gerst
