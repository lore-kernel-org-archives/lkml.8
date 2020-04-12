Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64904C2BA2B
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 18:15:17 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3858A206C3
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 18:15:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ij4GQLJZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3858A206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbgDLSPJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 14:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:41432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbgDLSPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 14:15:07 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE25C0A88B5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 11:09:17 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id w145so4990156lff.3
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 11:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9h/VHDAipBx0jF2b7D17h8FJCGnqVlCluR/r3Xtn0BU=;
        b=Ij4GQLJZsh3MKHveLeyeI08E/AvICQr2ocvTVNPEs3GMobICHj68ZgWwiR/Nkj/FSL
         JLkRsQVjisUCeSfigv8WYvBziaRdGlfZILOLwyyyNOUi8jUtSV2JK35eIuNup2FDbBq1
         bT1hZiZa9TvXc7Ucc1YurFyg0WJ+HEZSHlSPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9h/VHDAipBx0jF2b7D17h8FJCGnqVlCluR/r3Xtn0BU=;
        b=tUskAc/MsWT8oE8hEWJzB6berpPkoAcGmdp+cdD4Q31/pquNTfD7DrgU0LaICpvT03
         cJ/SlFYes5hIQ6bAW3XpAgnj1gAYNLpg5AngA8FlS9pQgrs8KsPhq2Rh1ci8sjsy/x7w
         QN3eQWmUrv2ClenKiTL3nQRarAnvBv+KAdex6ltiAAIamrE8v5LRWsd7YvsI0lrTnYzD
         /9wppv2uko40Jn2ummmJuvN2X0paDg5aOiJZ6gC+FrKkzqbwJnOKD7XNW2xlCdrUV7Pd
         V2Qkb34f0vW5Ce1L80fmkIg1RB+qlhptBX9wZGNQ+bGUaJCBzFrzG+xorFzNWaOpgYuc
         wCiw==
X-Gm-Message-State: AGi0PuZD6k3xjj4laveqopPRRUyEH1Ia1K0CSDWIIIlf2B3EynF/u5/C
        L4tAdbmD2atgU/g/4H0CgJb28SpWsqw=
X-Google-Smtp-Source: APiQypIDTJjn214KFp9sADAh+hzvag95t28A+gKCOKE9gueT8gNdaqC+CrSk9ifNychkR4VfBdqlJQ==
X-Received: by 2002:ac2:47f0:: with SMTP id b16mr8505379lfp.81.1586714954866;
        Sun, 12 Apr 2020 11:09:14 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id d15sm6368092lfl.77.2020.04.12.11.09.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Apr 2020 11:09:13 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id h25so6703041lja.10
        for <linux-kernel@vger.kernel.org>; Sun, 12 Apr 2020 11:09:13 -0700 (PDT)
X-Received: by 2002:a2e:b619:: with SMTP id r25mr8646337ljn.150.1586714952848;
 Sun, 12 Apr 2020 11:09:12 -0700 (PDT)
MIME-Version: 1.0
References: <f53fdf2283e1c847a4c44ea7bea4cb6600c06991.camel@perches.com> <af4673918a3f6bfba51118d68d554d4a1ff3dad4.camel@perches.com>
In-Reply-To: <af4673918a3f6bfba51118d68d554d4a1ff3dad4.camel@perches.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 12 Apr 2020 11:08:56 -0700
X-Gmail-Original-Message-ID: <CAHk-=whs8jNmbrXVyOekWD2zugN=jweHrspPqYVx59+0c5BWhQ@mail.gmail.com>
Message-ID: <CAHk-=whs8jNmbrXVyOekWD2zugN=jweHrspPqYVx59+0c5BWhQ@mail.gmail.com>
Subject: Re: Request to sort MAINTAINERS again just before an -rc1 release
To:     Joe Perches <joe@perches.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 11, 2020 at 9:45 AM Joe Perches <joe@perches.com> wrote:
>
> Please consider running and committing:
>
> $ ./scripts/parse-maintainers.pl --input=MAINTAINERS --output=MAINTAINERS --order

Ok, done. Let's see how painful this ends up being..

               Linus
