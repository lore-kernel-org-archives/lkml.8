Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E793EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 14:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B67F020738
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 14:14:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxACmpbv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgFCOOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 10:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbgFCOOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 10:14:38 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1AFC08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 07:14:38 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id y5so2367782iob.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 07:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=svZoKn4xGPR4SS45fq6+SKw2sCAIAoHnLGq22FBq738=;
        b=LxACmpbv08TgK6F7H4VnmPbRZrBcz4vbFuw7uwxc9OG8DYfaBqoi2IUmPOgqWcFiLe
         aiJLTOexhnYuIlhoMx+PKNalgGLyzk/PCGKZ/zTTJZM68Cuwk6CcQ+eioANYUFfo+h8n
         by/JI6i7qAscM+mBHQgyfKFgFvZM7eTzpczVMC25DRkF68zbvMXItA4dxfjLhu7W5exv
         ji0LIY+T8Cy5yDGCyCw46LQ4w25+LS1HKcAJXWU0QIcJX3VS6UQAnY3VK3s4jtMlDxZN
         lS50T8FTMdTGqV+0IPrrW+TafuTxpxLfjppiy5UsU2JqGYtOeuA29uzXau+WszxVPJZX
         TFvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=svZoKn4xGPR4SS45fq6+SKw2sCAIAoHnLGq22FBq738=;
        b=OKwdoB/TA6Og9r8XqJv0dfIny7HxSEh5P8pd3iodC1a+N8ePmA0YKgoDL15YPLR7ny
         eyHFgzO/lsYnd5dyjb4roQZ+22Nc+SHL87Rd7zNT73XDBi/TQNpljFz8c+hIkBdexIKj
         gzgICYYYXlxyxm1HHdMWyXo6/gWPvOiywwIsaeGfBUBG1tkFyoTEoFHwZ2qVYAsUJvBJ
         zWrMyyKCkN0G6oYFLa+Db+HCzEyEYHQ5ORDN1DkIC9HuXCiBEEgB/D5ToLty0Cf15677
         /svcYh1c8yIRQW3Dl9C+0BS/zbyZZDqUuJ3Y+8Il5zPVa4f1WsmSuEfEIovcyZq0SVWe
         Bjcg==
X-Gm-Message-State: AOAM533d6SEnKt/mFhJ/rJUsXIGud7O7Cr3/yHDgQM6JE47+GbWDPCDL
        Js2yXMZrrQUwuupzeFZnt5MoNVqwEdNKi+i2FAA=
X-Google-Smtp-Source: ABdhPJxa2oyjWRoZohXrmz15wupkaQOWdagTFY89oc2GOMryFOKHoPx4iiWhVt4MgZ6nOjJ7yVjNWeTONSrd5QN7dJI=
X-Received: by 2002:a02:5184:: with SMTP id s126mr107435jaa.30.1591193677903;
 Wed, 03 Jun 2020 07:14:37 -0700 (PDT)
MIME-Version: 1.0
References: <4627b565-0a5c-080e-726a-01b773c985e8@landley.net>
In-Reply-To: <4627b565-0a5c-080e-726a-01b773c985e8@landley.net>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Wed, 3 Jun 2020 16:14:26 +0200
Message-ID: <CAFLxGvwdkj4J_O_82nnhUcc_AnLwmT1eCp8qkjJBn8Ce6GHVeA@mail.gmail.com>
Subject: Re: headers_install builds break on a lot of targets?
To:     Rob Landley <rob@landley.net>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Rich Felker <dalias@libc.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 3, 2020 at 3:51 PM Rob Landley <rob@landley.net> wrote:
> um
> gcc: error: missing argument to =E2=80=98-Wframe-larger-than=3D=E2=80=99
> Makefile:1230: *** Headers not exportable for the um architecture.  Stop.
> make: *** [__build_one_by_one] Error 2

Exporting headers of UML makes not much sense.

--=20
Thanks,
//richard
