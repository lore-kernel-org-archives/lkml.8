Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56512C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 10:07:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EB0320679
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 10:07:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="vCFFrRZr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbgBQKHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 05:07:24 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44396 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729073AbgBQKHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 05:07:23 -0500
Received: by mail-qt1-f193.google.com with SMTP id k7so11600335qth.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 02:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QKmvUuTt70pSAatHZ0jteOvjXuuDVvr+bCMj5+FFq08=;
        b=vCFFrRZrjoPXbs1+l6naVB0eUJ3yxVHXvgsyCrb5LjhS2ONKBUaYUtYVw8ooD3MpVN
         rXDdKtQu97wRmL+FqAuQ7abYMjL9ccTqfVst4GoDIVCLzyEgIowJpIQIpOm8kGoeWN19
         0sqaDpLR2KWxdmYkc+d0qvaarFa+9Y2mjq2kaOi/a2ysWjbnV/G0/acHVaeS3PrkED8Y
         p+6l4U2D2xkPj0Zv/wY+ZaJfYPvDNR/+Z/mt8cz+c+K+ueUQY9WA1KfqUPdBBQ+TCEaV
         CQ6Au2FpqwJYghlMkX11cuJgyBb8zSchrJE+gzsroZtPXEGUB7i8rW7QW1Ekz4/5whZ/
         5bOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QKmvUuTt70pSAatHZ0jteOvjXuuDVvr+bCMj5+FFq08=;
        b=Gr8OWmFmQMHJB+nTaiEU7sxmZBogZ4oRaS4APUp05tnBfryaoI+2agO6RsU+r7IMbE
         HjEfBsnLuP8JLFq7scXnUx/2HpTgBSBaxFljGOZ5+CR9Mh/Tokr1KRWAg+op5n9T+w9Z
         fJ3U4pg7CB4c7evbcnsBRC1k6XHQ/XUaN/HVCCRqFzFDFZ4kRh2XHAmcAYZ4gtsEOSLO
         GtLQszRl9vK63WsnqU822Hbqk4n63XleW9Q/UB9SdfenAHdTmAO9RtLXgrt7DxDV2oHS
         wFC8buXoydNd2UGz5ydrBBHsQ2MVwHYciUYWSzW087e2poKgzBRLuzeNFJ04l9hX5wsa
         kmxA==
X-Gm-Message-State: APjAAAWITAZ6w3CzApKDhg61vgCtIPdCvBKHRVmgXG4IbIjY6b5b49vF
        f/0RNa/zf8LArr1lFyG29zA9xVZX/nFtLe85e6VEiJN/
X-Google-Smtp-Source: APXvYqwVP2B36bbYFlQML/AXp94nphTIrkBxle/EKeNaBgmECufJ48t3oBIbJyL9Vm9rR/3FxaY+WDfBPXcQXWiWeHg=
X-Received: by 2002:ac8:44d1:: with SMTP id b17mr5644819qto.208.1581934043023;
 Mon, 17 Feb 2020 02:07:23 -0800 (PST)
MIME-Version: 1.0
References: <1581664537-14386-1-git-send-email-srinivas.neeli@xilinx.com> <1581664537-14386-5-git-send-email-srinivas.neeli@xilinx.com>
In-Reply-To: <1581664537-14386-5-git-send-email-srinivas.neeli@xilinx.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 17 Feb 2020 11:07:12 +0100
Message-ID: <CAMpxmJVLh6uq=0PKdHZ1CrmfCTuJen3UyVeNMqmCHv8bFAYARw@mail.gmail.com>
Subject: Re: [PATCH V2 4/7] gpio: zynq: Add Versal support
To:     Srinivas Neeli <srinivas.neeli@xilinx.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        shubhrajyoti.datta@xilinx.com,
        linux-gpio <linux-gpio@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, git@xilinx.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 14 lut 2020 o 08:16 Srinivas Neeli <srinivas.neeli@xilinx.com> napisa=
=C5=82(a):
>
> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
>
> Add Versal support in gpio.
> Only bank 0 and 3 are connected to the Multiplexed Input output pins.
> Bank 0 to mio and bank3 to fabric Multiplexed input output pins.
>
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
> Versal devices are the industry's first adaptive compute acceleration pla=
tforms.
> https://www.xilinx.com/support/documentation/data_sheets/ds950-versal-ove=
rview.pdf
>

Ok so you added the description, but why isn't it part of the commit
message? We want to make this information part of the git history -
otherwise it'll get lost on the mailing list.

Bart
