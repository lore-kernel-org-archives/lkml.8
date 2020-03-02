Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7320CC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 17:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4305B2146E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 17:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583170454;
	bh=wjMTRnUNd5cJ8OEoiePT84V0U+qJX4Fb84bHAssH9NA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=afijW4Np5n7NCl7pQsqaJ6FinjJb3qNEYRCPP/VH+143d1+kCndipsoKMkTlHd7Kx
	 HLHNoYbc8xa209S6FDkcphDHrUUi200EJlrGsrmrvRndiKK/QPGk5sCOpwXnwm9S1V
	 8QR043uBexctCIVZigfnC+wn2/Z/8U5Am5RdanFk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbgCBReN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 12:34:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:60340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727101AbgCBReM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 12:34:12 -0500
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F068024673;
        Mon,  2 Mar 2020 17:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583170452;
        bh=wjMTRnUNd5cJ8OEoiePT84V0U+qJX4Fb84bHAssH9NA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gDUE5EstDFLUx2qaO9VtZKSx5YA7OnyHA3ToCrC7+hGQmgXCRKgUCMuFcKfZ7UFVM
         T9cgRoCN9U2ndcvhFdDEh0XKdQRF9DQ/YnjZmTrokHPRnwq9GRJh9+CmOOvZwM0E4W
         FYnhSt7dWIQ6cZ3l1uvXW9kwfYiG3BLQikpVduMU=
Received: by mail-qk1-f182.google.com with SMTP id h22so472311qke.5;
        Mon, 02 Mar 2020 09:34:11 -0800 (PST)
X-Gm-Message-State: ANhLgQ2YbrXda2jjGC+EJG06ikcjbqlS9Ly9uom6VEkVG96FaCRnHGMd
        Pw88Zdw2WfaROW93ChbVFNlIWrGSEA8WpyAU/Q==
X-Google-Smtp-Source: ADFU+vv2zWP8LALxPle+rVBTCPBLOKpVAdTyCE+9q1Ly5nHm6dinZB6UfLzBu790RZYPm3z9Smvto7izyi0pefOej3A=
X-Received: by 2002:ae9:f205:: with SMTP id m5mr386773qkg.152.1583170451093;
 Mon, 02 Mar 2020 09:34:11 -0800 (PST)
MIME-Version: 1.0
References: <1582863389-3118-1-git-send-email-frowand.list@gmail.com> <db823e84-5d59-374f-c616-e67819d62406@gmail.com>
In-Reply-To: <db823e84-5d59-374f-c616-e67819d62406@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 2 Mar 2020 11:33:59 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKxGdyU0G2soehcGLeGxJFw1Zrm8b8Zem3Jb6aLgJUhyA@mail.gmail.com>
Message-ID: <CAL_JsqKxGdyU0G2soehcGLeGxJFw1Zrm8b8Zem3Jb6aLgJUhyA@mail.gmail.com>
Subject: Re: [PATCH] of: unittest: make gpio overlay test dependent on CONFIG_OF_GPIO
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alan Tull <atull@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 8:10 AM Frank Rowand <frowand.list@gmail.com> wrote:
>
> Hi Rob,
>
> On 2/27/20 10:16 PM, frowand.list@gmail.com wrote:
> > From: Frank Rowand <frank.rowand@sony.com>
> >
> > Randconfig testing found compile errors in drivers/of/unittest.c if
> > CONFIG_GPIOLIB is not set because CONFIG_OF_GPIO depends on
> > CONFIG_GPIOLIB.  Make the gpio overlay test depend on CONFIG_OF_GPIO.
> >
> > No code is modified, it is only moved to a different location and
> > protected with #ifdef CONFIG_OF_GPIO.  An empty
> > of_unittest_overlay_gpio() is added in the #else.
>
> Should I have used your 'next' or 'for-next' branch for the commit id:
>
> Fixes: f4056e705b2e ("of: unittest: add overlay gpio test to catch gpio hog problem")

Yes, I added it.

Rob
