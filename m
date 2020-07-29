Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4DD4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 03:44:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 810EC20786
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 03:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595994277;
	bh=PKYvCFT78LV/2YXEzkvGlUcCAL6ErGV+cm3sHxN8HLQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OT4/P73DpgJdSL78YMvHT1NheNsUXoOhBeBAR5ADNDlFxpyApmYZbvzZ/Bl4oF/CL
	 1KT5OBxusGwngQdywtUKoyBIxsJw0C6SkkGqT6QXEdTMgpZ2+C7g53tTC3hFwgCu3/
	 4J9NhOpRafRcBUBxgfe5wL7Ue90LxVyo2krF70P0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgG2Dog (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 23:44:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:57988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbgG2Dof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 23:44:35 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6172E207F5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 03:44:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595994275;
        bh=PKYvCFT78LV/2YXEzkvGlUcCAL6ErGV+cm3sHxN8HLQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iqJN1cg8NCB58hUnCfsBVkAky8B3owf813Vdl3hBZ/QxjpXfvsC2FgPjo/ynz7H2K
         +8/XdAwqJBAds2vrk6LdZ1MXN/HEHi49Xu70CsxphhPQLGnXVWikShaWEoPdxxtoo/
         AVeHtnzdsAO88lEZ3go4h3VJPsLR1iL/NHrDp/kA=
Received: by mail-wr1-f50.google.com with SMTP id z18so16633719wrm.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 20:44:35 -0700 (PDT)
X-Gm-Message-State: AOAM533DVkVXI1EYSLSerGJ16qc0VwSVfwfXtblCbefYBcgLfJc3/Exy
        Hof1sT/kVPm6x/YHzbLd+X5eW+C/JeoYLar5K13/lg==
X-Google-Smtp-Source: ABdhPJydMOfugQXiBm9mi1BWB5378gG11cdehsvov9PsS29MgAxX3CVl8oELDjiaFm3AEaX9IznBXW+fBCk2dRnMVsc=
X-Received: by 2002:a5d:65d2:: with SMTP id e18mr27014993wrw.70.1595994273955;
 Tue, 28 Jul 2020 20:44:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200728202229.1195682-1-krisman@collabora.com> <20200728202229.1195682-5-krisman@collabora.com>
In-Reply-To: <20200728202229.1195682-5-krisman@collabora.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 28 Jul 2020 20:44:22 -0700
X-Gmail-Original-Message-ID: <CALCETrV=UKzsXqjctjMQL=a=FJtgrWC1MbCH_EizcNgowerWpg@mail.gmail.com>
Message-ID: <CALCETrV=UKzsXqjctjMQL=a=FJtgrWC1MbCH_EizcNgowerWpg@mail.gmail.com>
Subject: Re: [PATCH 4/6] arch: x86: Expose psABI on thread_info
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 1:22 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> Expose psABI in thread_info, in preparation for the TIF_IA32 and
> TIF_X32 flags removal.

NAK.  Linux threads don't have a user ABI like this.  See my other comments :)

--Andy
