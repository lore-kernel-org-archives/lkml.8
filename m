Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB178C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 18:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98FBC246B0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 18:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582914943;
	bh=GBCP5rJCRf158WDaaiSNEzMTdjhXomHfFag57VLC4Sk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=H8jX4L2nku+nAQxBdbxgpRcdOLiDLU3xdKkpDc6TPWaUo6OTCKBV/gA87XIP33rAW
	 wZsUjeo3VrufFca3KQf4/wZngOgMKGxlDJZfUSrGD7jZq68v68ppaYB0tWERItJZbx
	 5UqVYW9QG8X7T2Xc4xfN+0L80jTo2W8qESA7HxlE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgB1Sfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 13:35:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:38546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgB1Sfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 13:35:42 -0500
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FBCE246B0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 18:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582914941;
        bh=GBCP5rJCRf158WDaaiSNEzMTdjhXomHfFag57VLC4Sk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yXkHIoJ6l+tcPmEyJD1vdet4yKY4enrnMEj8W7knk1+lERKDxAqLfkzK4sQSdRSsr
         NPjFrQ3lV5sCm3JpydrjVHsVHH1tzyzMtZgR4rC7CR9l6SxMWFBZZo2lQmhjAL6cVZ
         FqKLGYmhhcu1QQoSDmWRNB80ftzLlg4EZKKgFPs4=
Received: by mail-wm1-f46.google.com with SMTP id a141so4314827wme.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 10:35:41 -0800 (PST)
X-Gm-Message-State: APjAAAVqxTXzHnzzhj1YyFdy8a42/bewdQKtQQEgEcp4vBJXeDRWCKWQ
        fimXhYELXDpS86a5moKWB1GN95SedTgrOXQThIQq8Q==
X-Google-Smtp-Source: APXvYqzMxRsodS1e8wI0uEA798kCmZpyLKN/Cs3QROgRJhi89nceURi6tyiTi6BKPol8rU9tWRQrPcc7VtSxky4Bkj4=
X-Received: by 2002:a1c:b0c3:: with SMTP id z186mr5805385wme.36.1582914939828;
 Fri, 28 Feb 2020 10:35:39 -0800 (PST)
MIME-Version: 1.0
References: <20200227132826.195669-1-brgerst@gmail.com> <20200227132826.195669-3-brgerst@gmail.com>
In-Reply-To: <20200227132826.195669-3-brgerst@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 28 Feb 2020 10:35:28 -0800
X-Gmail-Original-Message-ID: <CALCETrXYxKk+30Py0hUHuMiXCXLzYW6Oh8tDo-bBp9G2OWxqyw@mail.gmail.com>
Message-ID: <CALCETrXYxKk+30Py0hUHuMiXCXLzYW6Oh8tDo-bBp9G2OWxqyw@mail.gmail.com>
Subject: Re: [PATCH v3 2/8] x86, syscalls: Refactor SYSCALL_DEFINE0 macros
To:     Brian Gerst <brgerst@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 5:28 AM Brian Gerst <brgerst@gmail.com> wrote:
>
> Pull the common code out from the SYSCALL_DEFINE0 macros into a new
> __SYS_STUB0 macro.  Also conditionalize the X64 version in preparation for
> enabling syscall wrappers on 32-bit native kernels.

Reviewed-by: Andy Lutomirski <luto@kernel.org>

It would be really nice if there was a clean way to get rid of the
0-arg special case, but I don't immediately see one.

--Andy
