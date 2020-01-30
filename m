Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB87AC33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 05:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72A652082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 05:11:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pGorZGIo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgA3FLd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 00:11:33 -0500
Received: from mail-oi1-f169.google.com ([209.85.167.169]:44926 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbgA3FLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 00:11:33 -0500
Received: by mail-oi1-f169.google.com with SMTP id d62so2258502oia.11;
        Wed, 29 Jan 2020 21:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=TGtlEkzd4Z5nVApY3fWDup+A9ksYgkqdElgcGPpoUCM=;
        b=pGorZGIolsXDFhpRoC9kQLqOOwnPQif4kJmoTE9oFOwR7uCRzmVAK1LUlkZZ4D4K+0
         5tT009uvImFyfWI2hAp4pRmRJPJkah30FF+m+gNEZMwWuvWbQO7N+eKjSPLJ+Vr6820H
         ZEzu5NUyfUoVLo39EHTIPYfkm10jSqDCoo91Ty667P8l4YJh7ezUnS74QGGirkNdxSHX
         oJrROLJ8iwm85kobnXK8oY4YSsEFRvJSlaYwC+tibn34XpR5hB/HBWY3Sos34GrwO8Jo
         y/1bh0s3cglM5/nsAuXO7M5FoHmCHV1gLNiDKnD7w3dZS0UhS5d3evhSuWdwx1PkSNhI
         hDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=TGtlEkzd4Z5nVApY3fWDup+A9ksYgkqdElgcGPpoUCM=;
        b=hkL3bAt47EWVFaciYA3cA5kvDo6BpbK6pNs4x4vDR6kqSavFPcGd68bRkXmGsBGObF
         QpLtmQtC9lmOjXEN6a3gCOeQBR5scli03Cdbwt2vLg0wLFBpgUCZoJp7bTj0dMvQ5mlX
         mlikb4qvxMZdag9mehd5CpSBCK9qOOrEcwqXXX1F2FSgHL0cdEDrL8jwH2I2YpVq11Nc
         JoxzpBWOetsxc4EvhE9p2F331P5Y1NJtL6Uuri5oh2JBes8v68lfIz5rt5UBg+9gRSJK
         4shJQ/l+uOgkCwde8vNYHQ24JSSyyBbZsKrN6uc9iyqxuqdXRqHKy0bwNu0fb1mISZ9b
         pyxg==
X-Gm-Message-State: APjAAAXCwTeXNLF6b9PnddTHnhpEt0dtadGG4rvp1e4B1I7g1AJVEDaK
        ek+pWCKPL5t0x4AtaDqkBcG2L6zhnLGk4gbnJnhrfg==
X-Google-Smtp-Source: APXvYqx+7f1zPGOo0BhO4NoVs+K+ftrM/DpMKPQzlig4RrGa8EeuiEOn7HEWJ4YsmIFauwvRFTqGHEjbk16f2n1rOTc=
X-Received: by 2002:a05:6808:a9c:: with SMTP id q28mr1780563oij.176.1580361090895;
 Wed, 29 Jan 2020 21:11:30 -0800 (PST)
MIME-Version: 1.0
From:   hacker kernel <thekernelhacker007@gmail.com>
Date:   Thu, 30 Jan 2020 10:41:19 +0530
Message-ID: <CA+Jm+AGWbHG4U7T7R=6JhzXJywRD4tinDecEKEdfvfzyOkm0dg@mail.gmail.com>
Subject: Interested to join in any sub-system as a newbie
To:     linux-kernel@vger.kernel.org, newbies@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is Dileep, im a newbie, i would like to contribute in any
sub-system so that it would help me in learning. please help me in
taking into your project.

Thanks in advance.
