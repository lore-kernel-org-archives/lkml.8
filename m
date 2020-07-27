Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D370BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 22:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A715E206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 22:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595889608;
	bh=bFPrgU1Jk9K/I7DQUNxsJ01gcPYC3G9ZPht5BYF0kM8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ppwHQM1JhLV0VTPBC4PW6oIypfbcHGcPBgy5eSlqNO7mrGJUTtOi5JCwj65Q8Rhit
	 OiHGszdngGFanGYTV3nRG1C+n0M/Bf2EA/SG4ax7yfdgbT+O2waArHNx7/qQJzJ+ph
	 karcsY6zLEFPDAyIBur4N5HNJu0VRki39IlQvb2g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727837AbgG0WkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 18:40:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:45638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727800AbgG0WkH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 18:40:07 -0400
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A3B020FC3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 22:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595889606;
        bh=bFPrgU1Jk9K/I7DQUNxsJ01gcPYC3G9ZPht5BYF0kM8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=w+gqaDIcclPtKT4N8I4PlPGw/3ZfZO3xy2fUtCvLzNd6QdKXNte+8p1VvOSUp6buE
         Gm/DP30ZkkY9pe2wrNkDPsX3L/ToWQPV3w9TjvaoTKbRFZf2FAp1NaYrPWC1MC3q61
         X5fmnnQlYmK26oUlgUmG9ZNfu1BpFuoKgX3zA5RQ=
Received: by mail-wr1-f47.google.com with SMTP id a5so6413696wrm.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 15:40:06 -0700 (PDT)
X-Gm-Message-State: AOAM531P/zbevi1ZVvQ1Mtm/phRer0yfXZI+0NC/VMHd4atABqyGyYw4
        IcWgtUD5eWm/IBAGSG6lVRWAAg/vmvbWHUyHIKzR8w==
X-Google-Smtp-Source: ABdhPJzd/wIx7hz77kMspi3Ap4wzBDMwXrL3/v/GsIahaf+7is+QENmLWwBqaUwNt2/x6huhKSjrbFAM2Lz0dTnsVDo=
X-Received: by 2002:adf:fa85:: with SMTP id h5mr22738351wrr.18.1595889605046;
 Mon, 27 Jul 2020 15:40:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200721105706.030914876@linutronix.de> <20200721110808.889765456@linutronix.de>
In-Reply-To: <20200721110808.889765456@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 27 Jul 2020 15:39:53 -0700
X-Gmail-Original-Message-ID: <CALCETrW0OmZ04rWO=JN1M+Bcum18Vna+St+QM9pHEeV0yVc=rQ@mail.gmail.com>
Message-ID: <CALCETrW0OmZ04rWO=JN1M+Bcum18Vna+St+QM9pHEeV0yVc=rQ@mail.gmail.com>
Subject: Re: [patch V4 06/15] x86/entry: Consolidate check_user_regs()
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 4:08 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> The user register sanity check is sprinkled all over the place. Move it
> into enter_from_user_mode().
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Reviewed-by: Kees Cook <keescook@chromium.org>

Acked-by: Andy Lutomirski <luto@kernel.org>
