Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5624BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 10:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D9E52065E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 10:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595845244;
	bh=hQhd05LXAPUzwQ3UfG5KK9j6yLXXJMe0iDQuBeqoHns=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=a/R+9PXTS83vqKJd4cjQvjHJJkooQJYWucMXiO8Sj2yjoS59OWngCyl7l7XZdYSYo
	 m60nxXFw6XjnyWidCre91DChF1wxFqOp5nUXjSWzYlI0C0dROqAAgjdkoIIrTKJi+q
	 BYPHxz8xrhq3zvdfs3KOtpOUDu5HhFOvApDPkLt8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgG0KUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 06:20:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:49272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgG0KUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 06:20:42 -0400
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 367DA2075A;
        Mon, 27 Jul 2020 10:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595845242;
        bh=hQhd05LXAPUzwQ3UfG5KK9j6yLXXJMe0iDQuBeqoHns=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bIzVZyZhA97PhUA4EYvzfXEQwyyNNoyQOJIOL/oTL539fSOOf3CVe/kR0BO4UHBM+
         MF5SpNMerItNE8HpFVeCdmutj/YlrDnT1fzfEYGaEDCOX7AF0MfsE9+FMMxjff64pv
         Q+1UxWAgyOSymrNjrZZMBWYGa0SNXMQjs6DrvwOM=
Received: by mail-lj1-f174.google.com with SMTP id q7so16616530ljm.1;
        Mon, 27 Jul 2020 03:20:42 -0700 (PDT)
X-Gm-Message-State: AOAM5310NO8aBX4qNh9rcgH93y/I+xBgUC7kw0az+1P5HdEqYWeeykmy
        1bPazVCpMYL9P2ZTPDs543A4ZprivtyhPFz39Cg=
X-Google-Smtp-Source: ABdhPJxtpea9rcbxDoSjPDe363q5v13DQCeX0XUIQbde3R4Ukf2I/W1lLNDlLkuIctJ6zpqjHgdEMeQ4EQeCPQrm3+k=
X-Received: by 2002:a2e:91da:: with SMTP id u26mr10158388ljg.311.1595845240511;
 Mon, 27 Jul 2020 03:20:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200727201600.7d3b31c8@canb.auug.org.au>
In-Reply-To: <20200727201600.7d3b31c8@canb.auug.org.au>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Mon, 27 Jul 2020 12:20:29 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcna2YyemERXhumasikQZMKVciQoDbpDfAYAvg3+GCXMQ@mail.gmail.com>
Message-ID: <CAJKOXPcna2YyemERXhumasikQZMKVciQoDbpDfAYAvg3+GCXMQ@mail.gmail.com>
Subject: Re: linux-next: manual merge of the devfreq tree with the arm-soc tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jul 2020 at 12:16, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the devfreq tree got a conflict in:
>
>   MAINTAINERS
>
> between commit:
>
>   8a9ff8758159 ("MAINTAINERS: Add Krzysztof Kozlowski as maintainer of memory controllers")
>
> from the arm-soc tree and commit:
>
>   34886407581b ("PM / devfreq: tegra: Add Dmitry as a maintainer")

Thanks, looks correct to me,

Dear Arnd, Olof,

I forgot to check for this conflic. I don't expect any other conflicts
in the first drivers/memory pull.

Best regards,
Krzysztof
