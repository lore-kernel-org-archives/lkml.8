Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10193C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 22:27:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25A6720722
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 22:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596493674;
	bh=biJ2kOlDYdY6/OLDAJ8JB5eojvMm10XWknHfh7Rdrbw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Qi/IvS3bfMSaMac3dIu5lE18NvKgLFB19+UXsVd8pU8qlS64s6hZmdd+zJEhAebv/
	 5pVQreoDzQTxz2cImhZOT77Wk/FzQ4sv6tncs4WOQvmFwMWZJ8PZkk6Qwd7OxMQ6EO
	 hh8Tori8WohDC6lAvKDYvLNq7IGIFejIbdZPISIs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgHCW1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 18:27:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:60958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbgHCW1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 18:27:52 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34B3720722;
        Mon,  3 Aug 2020 22:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596493672;
        bh=biJ2kOlDYdY6/OLDAJ8JB5eojvMm10XWknHfh7Rdrbw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eoVHkOQVag6krs4G4hOfe5G/U9F8Eh7Ys8RHj4U8EuM2Ej3M7RMrHZoou78u8Odmz
         fq5WXKDlqqOhjIQWrwEBJYmdckvI9S8NHeaQTq72eoaNVrS6Z6wGXZn68WZoFdDaTY
         rHZSK33xF+whVobDtUwR8E11gllrlMSOKorN0ldU=
Received: by mail-oi1-f181.google.com with SMTP id 25so11102848oir.0;
        Mon, 03 Aug 2020 15:27:52 -0700 (PDT)
X-Gm-Message-State: AOAM533OJ9s6+lHv4I1+PRbyjc+5KW5p8WoWmvoWR3L3FzSVY9o3tTs3
        0B6h8hG2SC+N1uhzQyXPlq8zmydK3y21ykv3XQ==
X-Google-Smtp-Source: ABdhPJzfbyIHX+2tZSmvIz2Nt9s/AOwqnX2gnwQT6MnE5sNL8J6Y4AMY5vGmmxRSX4u4/WbOE7kyaV+1/ltEPpe0pHc=
X-Received: by 2002:aca:c3d8:: with SMTP id t207mr533646oif.152.1596493671416;
 Mon, 03 Aug 2020 15:27:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200731100248.26982-1-nsaenzjulienne@suse.de>
 <CAL_JsqKu4CB7-b_hRvu63c9jQ_S91epWMr=P__9Fu-h_WFR-_Q@mail.gmail.com> <9200970a917a9cabdc5b17483b5a8725111eb9d0.camel@suse.de>
In-Reply-To: <9200970a917a9cabdc5b17483b5a8725111eb9d0.camel@suse.de>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 3 Aug 2020 16:27:39 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+oQyQhAaB-jP8MxKp9jTEbr4c0oxPY5FiwmQRcnqJOdg@mail.gmail.com>
Message-ID: <CAL_Jsq+oQyQhAaB-jP8MxKp9jTEbr4c0oxPY5FiwmQRcnqJOdg@mail.gmail.com>
Subject: Re: [PATCH] of: unittest: Use bigger address cells to catch parser regressions
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 3, 2020 at 8:25 AM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> Getting address and size cells for dma-ranges/ranges parsing is tricky
> and shouldn't rely on the node's count_cells() method. The function
> starts looking for cells on the parent node, as its supposed to work
> with device nodes, which doesn't work when input with bus nodes, as
> generally done when parsing ranges.
>
> Add test to catch regressions on that specific quirk as developers will
> be tempted to edit it out in favor of the default method.
>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  drivers/of/unittest-data/tests-address.dtsi | 10 +++++-----
>  drivers/of/unittest.c                       |  2 +-
>  2 files changed, 6 insertions(+), 6 deletions(-)

Applied, thanks.

Rob
