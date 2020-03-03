Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73C8C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 04:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F813208C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 04:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EHIAT/zU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727385AbgCCEqt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 23:46:49 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46644 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbgCCEqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 23:46:49 -0500
Received: by mail-pf1-f196.google.com with SMTP id o24so801108pfp.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 20:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UFYxSZrni6CvNffGhjXolw+msCaYdHC1D/0ujqewWaU=;
        b=EHIAT/zU9e9bsS5E6eozCM31t5B2bkWmjLdU6kV8nbjDVj9mzBeGrUU9NPASBuDm4T
         G6Darqnz0AcNltKumEoIANitAHpB3Jh3/pV6iuzjIT9BeS/4LcvF1GdDnqupXSHncm4G
         8ByPerSV7B0QEeileoYqy+e8w11f06FmL2KU8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UFYxSZrni6CvNffGhjXolw+msCaYdHC1D/0ujqewWaU=;
        b=E8GquRrjIwMz7tS3QJCnbxaXylNjZlJn3ya5a5T/XFxO8YuuWYAIUz0bhxHiJljT55
         AuT7o2DlmD4UKbQKbm4QdpNIUwIu1iofvwxWvDuSIiGHHGdbE1HTMTjbzg1Gwc6FFWB2
         n6Nwjl/c6qPYQr8l0/th8dNAuDi2i67Ix2dxeOKLFoBuY8sOPJSYGXZxyeYeIyohrS4g
         fd+oV8uD/i4ADW5NZWJ/KIVYkyZajLGk0VdZQAc/XSY2HOjeDXoOXQOBMQDPpni4ifw0
         w7fy6FmHFVipgEDusIBSmvoAj5uZuYoB47KhFNkOvCmJ7avDtmjmdZd0TKMSuBG6s3sI
         k97Q==
X-Gm-Message-State: ANhLgQ1dAieyVkuvS9zwyFM6UeYrqT3FEyI3UGLEI6NMoUi9TE9lCcJI
        y1BQvwA3lh0+98KvS+xAQlVMFg==
X-Google-Smtp-Source: ADFU+vu/TNvNc0FLRpHo+HDfp6KHd1XVEFDDJc21QkTufe7swPXY9rij6UOEsPoMuIJqL2GUKMScZg==
X-Received: by 2002:a63:114a:: with SMTP id 10mr2265128pgr.185.1583210808160;
        Mon, 02 Mar 2020 20:46:48 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r1sm879527pgh.84.2020.03.02.20.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2020 20:46:47 -0800 (PST)
Date:   Mon, 2 Mar 2020 20:46:46 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        David Abdurachmanov <david.abdurachmanov@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Oleg Nesterov <oleg@redhat.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Keith Packard <keith.packard@sifive.com>,
        Tycho Andersen <tycho@tycho.ws>
Subject: Re: [PATCH] riscv: fix seccomp reject syscall code path
Message-ID: <202003022042.2A99B9B0@keescook>
References: <20200208151817.12383-1-tycho@tycho.ws>
 <20200223171757.GB22040@cisco>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200223171757.GB22040@cisco>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2020 at 10:17:57AM -0700, Tycho Andersen wrote:
> On Sat, Feb 08, 2020 at 08:18:17AM -0700, Tycho Andersen wrote:
> > ...
> 
> Ping, any risc-v people have thoughts on this?
> 
> Tycho

Re-ping. :) Can someone please pick this up? Original patch here:
https://lore.kernel.org/lkml/20200208151817.12383-1-tycho@tycho.ws/

-- 
Kees Cook
