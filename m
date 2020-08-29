Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980ACC433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 13:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E99D208A9
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 13:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598708895;
	bh=AZb1b4y5096A89A37Faog2iRzuECW60W3P99jw4H6Uc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HP8JsgnNJEjzsIdbVatclxujwH5+oA5Rg+XDzvGjgdsmUsphhWhuv0e79hWhElUY3
	 +mpzUNDOfOV9uZsGOhrpqxwN6+mhkvh5EB47V3eAa7VYdqb8iqYOmrQyS10iRd4RwV
	 gRo1s4CSFTQgmFXX/eSQzs/6WdGNu5oVOLRtbys8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgH2NsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 09:48:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:38762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728012AbgH2NsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 09:48:07 -0400
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C68092076D
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 13:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598708886;
        bh=AZb1b4y5096A89A37Faog2iRzuECW60W3P99jw4H6Uc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TN/1DY5skbtcHE12YuX/ITCvcC1ga18Idg8VR2xIlXkEmDo8HcWyE4c9BMfWBWBc6
         TOWs2g90bDP9kSNWhwqOztedUHSesDNFz9niFgC3tbULNlaQ+6VBsiy6oN38LrzN/O
         MLIg7+6dis++5YZw26hG+/RkUBAZ4fBGcXzds1Q8=
Received: by mail-ed1-f52.google.com with SMTP id q4so1586649eds.3
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 06:48:05 -0700 (PDT)
X-Gm-Message-State: AOAM533QCt9Pqy6g0xI/qB+8AKyPfYqFtCpxm9c+S1j9sTO2W8ZdbYwc
        aVPnjVqnm8NrO7BVhpnMOHPJocRr9EkOmqKnbOk=
X-Google-Smtp-Source: ABdhPJx24WZzw5hA4K8oKdK9B1yztcg3T9ktVveQ+EyprDcKrTlr+3EKq9cPx24vlo3LaomFfu9QF3FEROshf+zb/7o=
X-Received: by 2002:aa7:cb52:: with SMTP id w18mr3592453edt.132.1598708884439;
 Sat, 29 Aug 2020 06:48:04 -0700 (PDT)
MIME-Version: 1.0
References: <1458211793-9823-1-git-send-email-r.baldyga@hackerion.com>
In-Reply-To: <1458211793-9823-1-git-send-email-r.baldyga@hackerion.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Sat, 29 Aug 2020 15:47:53 +0200
X-Gmail-Original-Message-ID: <CAJKOXPf2eMmF7DQKk3FRC4ba2fgDocRRVdxqak-1S5vY53o=2w@mail.gmail.com>
Message-ID: <CAJKOXPf2eMmF7DQKk3FRC4ba2fgDocRRVdxqak-1S5vY53o=2w@mail.gmail.com>
Subject: Re: [PATCH] drivers: nfc: update Robert Baldyga's email address
To:     Robert Baldyga <r.baldyga@hackerion.com>
Cc:     sameo@linux.intel.com, aloisio.almeida@openbossa.org,
        lauro.venancio@openbossa.org, k.opasiak@samsung.com,
        linux-nfc@lists.01.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Mar 2016 at 12:35, Robert Baldyga <r.baldyga@hackerion.com> wrote:
>
> The r.baldyga@samsung.com email address is no longer valid, so
> this commit replaces it with r.baldyga@hackerion.com which is
> employer-agnostic and thus should be valid for foreseeable future.
>
> Signed-off-by: Robert Baldyga <r.baldyga@hackerion.com>
> ---
>  MAINTAINERS                    | 2 +-
>  drivers/nfc/s3fwrn5/core.c     | 4 ++--
>  drivers/nfc/s3fwrn5/firmware.c | 2 +-
>  drivers/nfc/s3fwrn5/firmware.h | 2 +-
>  drivers/nfc/s3fwrn5/i2c.c      | 4 ++--
>  drivers/nfc/s3fwrn5/nci.c      | 2 +-
>  drivers/nfc/s3fwrn5/nci.h      | 2 +-
>  drivers/nfc/s3fwrn5/s3fwrn5.h  | 2 +-
>  8 files changed, 10 insertions(+), 10 deletions(-)

Hi all,

That's a pretty old patch but it was never applied. Robert, can you
rebase and send a recent version?

Best regards,
Krzysztof
