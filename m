Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9145C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9EA02074B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591036773;
	bh=RyIsxe6m5o4uNe85AJQRvv7FiQv43lUiUS0HaYJTLWk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=LGykuSoz4pNaa4uliZLGhoHnxCWc3AObImi7gFq99V8WxCBXZHpG4J83qlh5RDTa6
	 qV19+6dzWXrTkqtOaUtW3tGsbaP6sA40keYCVeV6ThWLybhptFyj+gfqmYLo8Cu1wt
	 M5cwpscH6spw5iNfI2SmgZ1ffcpLJtTAOEdI+0KU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730055AbgFASjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731722AbgFASjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:39:25 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18BDFC008630
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 11:39:25 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id u10so8187826ljj.9
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 11:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OQI83XnTUpCYBOZaAbAv+Cb5Uoct40fY5tumECPOkoE=;
        b=G4XxvEfJ3uyBljRWLUv6ciQWBngwkPYJSSnhCt/HrGYHq8cB1vfKRYnv5BXMA/f8x7
         V9tX6tl4Nspup5rVZvhh1MWLoYUj0/kFkWHvUZWbPzedpCF6S1GUQRBOYo5GS7ag3l7h
         tSSv3TGgEIr8C3cowP2U/R/z2d9p+uPonS3LM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OQI83XnTUpCYBOZaAbAv+Cb5Uoct40fY5tumECPOkoE=;
        b=VlV/xZ4nH7HO1D0J2ahgli+IU58Rc4zzQJ/fFqTmUuexd2eSnkE9hYTRyEzL1dWf+0
         Y+YasNW8EzP3q7Kt2AaeaN4xtJdSAjV10agBRcvZJ0frr9FZZ0jCVUQcUK494rRjOeJ/
         3eNBctTxn2cnEZAcLjC0GB5NEETWXmFZJ5YMJ0oi/JNufdAntpn/kbhmJQH7evuvsNle
         IqIIX2iNnjeNor97XexZPeU5GF80wufmFzzVqgr0evAi9sPuJj4MvSmVO2y7cj+dSMHS
         bN2CgXBGQywF00P/Bmc/jI0jy3Ew5PXruatpWrUbX/HjUoTZFG/tZDBL8zOSWpGxmmmT
         C7/g==
X-Gm-Message-State: AOAM532jV0DIvCFCdTY3/nCIV7L77wQvmoiTTAJS34rOk9CY415YXzIm
        BlaX40sUT2CzEsZqSJy64dV9ZuXSgjE=
X-Google-Smtp-Source: ABdhPJzzE25hV+agfcbrASXkEaBP+rD7qdmiOj50K/txLIMEmx8SJYvq+qqWx9eAY8KElP9xQ1K3xA==
X-Received: by 2002:a2e:80d1:: with SMTP id r17mr11153717ljg.439.1591036763041;
        Mon, 01 Jun 2020 11:39:23 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id i22sm69062ljb.21.2020.06.01.11.39.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2020 11:39:22 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id h188so4531100lfd.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 11:39:21 -0700 (PDT)
X-Received: by 2002:a05:6512:62:: with SMTP id i2mr11740327lfo.152.1591036761565;
 Mon, 01 Jun 2020 11:39:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200601095423.00ffb5e1@collabora.com>
In-Reply-To: <20200601095423.00ffb5e1@collabora.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 1 Jun 2020 11:39:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=whW82ewxKJjaFq=96eEpCMN0=DtaZxX9ZGBH7BTgTkEfQ@mail.gmail.com>
Message-ID: <CAHk-=whW82ewxKJjaFq=96eEpCMN0=DtaZxX9ZGBH7BTgTkEfQ@mail.gmail.com>
Subject: Re: [GIT PULL] i3c: Changes for 5.8
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     linux-i3c <linux-i3c@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 1, 2020 at 12:54 AM Boris Brezillon
<boris.brezillon@collabora.com> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/i3c/linux.git i3c/for-5.8

Hmm. No such ref..

I see the "i3c/next" branch that has that top commit, but I don't see
the signed tag.

Forgot to push? "git request-pull" _should_ have warned about the
remote side missing..

              Linus
