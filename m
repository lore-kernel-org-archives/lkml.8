Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A9FAC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 17:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8ACFE205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 17:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHuOQ7kU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389865AbgEMRNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 13:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389431AbgEMRNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 13:13:23 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E81FC061A0C;
        Wed, 13 May 2020 10:13:23 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id k7so6394121pjs.5;
        Wed, 13 May 2020 10:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CESDIXK5iziXykt0Y/ez2vWrIKygUcVw6M6S2Ji/JxM=;
        b=lHuOQ7kUnqQ2J0pAG3sD5Jmpiv/ZRrptG88vVBX3a6kKvOnEj9jay5x80zP7d27cU0
         hsnrdGm01EqSgogJIz7up6/iww5HRrxBkHIrnvZVX980yyqqQVn5hsIq3aNQdOkMkWZq
         sshgStyWmPTxxWtzMEIG5deLjiaPpOuoZcaE6NZFHEJS9D/zEvmjLaB6z/kL6pz1AbCi
         w7s06b1aApuoQjttFuvOQQVG6undKKO+yPHP2N8lHCAgxRX0hmmLOYSQrRCq8Zs0yu1D
         L2O9cp3DoSh0+CO5hrgxoXAc6Y8DKaAN93O88wgIQc2QyQ7DQty+5Xd3+nxK9AoYj2YC
         kxTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CESDIXK5iziXykt0Y/ez2vWrIKygUcVw6M6S2Ji/JxM=;
        b=VE5kdUUFQv3Dp+a9XYbyIeSSEjdYCAvxC1ZAcTe9SAIXRcI4n5tEax7jLzuV4INc3s
         6X877dgG/p0olmP4KU/xAVowjRybtY+vRKDHXy15EnSR3OTNFg8uRnGpGZMrQSslWkX6
         0gQ27pbSv7TDrayGq5FhN/joLvmXUv4uqg9jZtycfPipBtjjytHAWr0EqIAF9/AHcQtb
         C/XsGiTeqNxfoRx7K7XQgCqUCNTcyFsJvxNCQFYUzKFRrqV27INACOJvWmkfuATJL4Mi
         GIEp7AH/90HbA7TP5KLo1drRg+TzdYFXXoqlr6F6Ix/CGmWP55PVqkSR3RbGV2KS/jgC
         tcHw==
X-Gm-Message-State: AGi0PuZO/pmbJ8gL3/fTlNd2IfpsCB4LqZVDltZ3cIUius0/XH069rW5
        wQfZM5K4CEg7t/7NYoy0W1bp2SsDagDlhYtjWG00CcK9J40=
X-Google-Smtp-Source: APiQypJb2ISh0rO+fH9GikkKZila88U9u2hScbncsFLhBKJ17A2wWU2g4j/yfe5q/bd2kIKf2YRxCXnmezeOzQ619E0=
X-Received: by 2002:a17:90b:3717:: with SMTP id mg23mr36843294pjb.129.1589390002549;
 Wed, 13 May 2020 10:13:22 -0700 (PDT)
MIME-Version: 1.0
References: <1589388975-15499-1-git-send-email-alencar.fmce@imbel.gov.br>
In-Reply-To: <1589388975-15499-1-git-send-email-alencar.fmce@imbel.gov.br>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 13 May 2020 20:13:16 +0300
Message-ID: <CAHp75VeycGutrfTCrVP-9V61ag-KbNHfykQXHWU-8hwEFOerMQ@mail.gmail.com>
Subject: Re: [PATCH v2] video: fbdev: ssd1307fb: Added support to Column offset
To:     Rodrigo Rolim Mendes de Alencar <455.rodrigo.alencar@gmail.com>
Cc:     linux-fbdev@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        devicetree <devicetree@vger.kernel.org>,
        Rodrigo Rolim Mendes de Alencar <alencar.fmce@imbel.gov.br>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 7:56 PM Rodrigo Rolim Mendes de Alencar
<455.rodrigo.alencar@gmail.com> wrote:
>
> This patch provides support for displays like VGM128064B0W10,
> which requires a column offset of 2, i.e., its segments starts
> in SEG2 and ends in SEG129.

Also, include Rob as well into Cc.

...

> +       if (device_property_read_u32(node, "solomon,col-offset", &par->col_offset))
> +               par->col_offset = 0;
> +
>         if (device_property_read_u32(dev, "solomon,com-offset", &par->com_offset))
>                 par->com_offset = 0;

Have you ever compile it?

-- 
With Best Regards,
Andy Shevchenko
