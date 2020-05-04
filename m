Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0412C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 19:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD335206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 19:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Si7dlb0A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgEDTMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 15:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725956AbgEDTMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 15:12:14 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 426EAC061A0F
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 12:12:14 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id r14so6024900pfg.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 12:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DRRJVsf51l5t9Dm4TlhSU/EZbXOvcOE4YxM3FowxRF0=;
        b=Si7dlb0AnRhxMKmPOWWmPJJFBiUT4hTbUEZ13DYzEVOo2Il6yfzy/8I4eF85hIu4Kg
         JTsIF/Gth/JFANckJbrIiWa1vqiV+Kn8c9EHteuh/ReoJW0U5GlArClgOw2sVllSjRef
         3fe1eu6sfxWOOEXu+wxVB1GNh8zSo/xAskcUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DRRJVsf51l5t9Dm4TlhSU/EZbXOvcOE4YxM3FowxRF0=;
        b=nsVYsSuLbX64Pt3hnan38sVfSVPg4fVMjpbMEz+Vavz67emtpn4eKKEuIwrkB7LDpd
         fy259OEsDtfkenYZJfB5nvMQ2seyPGrGVoIRmEkUa7l9bLWGjenL/4tUPH16MNRlOfMS
         MyuXxx8TnbWqT4y6vEh8PpEPnnCuikEPjIjZQ5pCL3DM2eoIDHJq11Oe2340I3E2uFxX
         q+jtO+PMH00ZuwAnLv1gtVAcWWBrCq74RVcIdvcU+w0hKgfp32QI8nCcmpIJy519IC2M
         lgCQ3qJDi+6uJ0N3f0ZAU9OzMBoSqZMEIAQP0WH/SUC6qob8XzM1+iduWWK2mIT463vn
         Jsew==
X-Gm-Message-State: AGi0PuZJd+m+Q/COi06NRMi8IZuUuZ+m32Udtc4rEuk4Dx5qhDvAKrWg
        QX4yx70B7sdu70i3ET+c5lPsXhLssS8=
X-Google-Smtp-Source: APiQypK9UGDyEzyZDsYFS7KmpnuRRHd1CKSUuVF2CV0RkZbNly3BomdV876VP1jJ+iRSqqtxTefo9g==
X-Received: by 2002:a63:7e1b:: with SMTP id z27mr403821pgc.19.1588619533882;
        Mon, 04 May 2020 12:12:13 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s4sm1730400pgv.78.2020.05.04.12.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 12:12:13 -0700 (PDT)
Date:   Mon, 4 May 2020 12:12:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, anton@enomsg.org,
        ccross@android.com, Tony Luck <tony.luck@intel.com>,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 0/3] allow ramoops to collect all kmesg_dump events
Message-ID: <202005041211.040A1C65C8@keescook>
References: <20200502143555.543636-1-pasha.tatashin@soleen.com>
 <202005041112.F3C8117F67@keescook>
 <CA+CK2bBDzbXdH23aDxqGzMoxPppNcVmitrYJ00tJqympMBVJOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bBDzbXdH23aDxqGzMoxPppNcVmitrYJ00tJqympMBVJOg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 04, 2020 at 02:47:45PM -0400, Pavel Tatashin wrote:
> > > # reboot -f
> > >
> > > After VM is back:
> > >
> > > # mount -t pstore pstore /mnt
> > > # head /mnt/dmesg-ramoops-0
> > > Restart#1 Part1
> >
> > Is there a reason that using ramoops.console_size isn't sufficient for
> > this?
> 
> Unfortunately, the console option is not working for us (Microsoft),
> we have an embedded device with a serial console, and the baud rate
> reduces the reboot performance, so we must keep the console quiet. We
> also want to be able collect full shutdown logs from the field that
> are collected during kexec based updates.

I meant collecting console via pstore (i.e. /mnt/console-ramoops-0). Are
you saying that's still too large for your situation?

-- 
Kees Cook
