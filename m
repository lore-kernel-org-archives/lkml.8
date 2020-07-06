Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495FEC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27720206E6
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQBaBonQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729236AbgGFNE4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 09:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729173AbgGFNEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 09:04:55 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C33C061794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 06:04:55 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id a21so8285957otq.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 06:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hmLqrXXhVU4dEhpiExA430FqmWSncr+dRol/WcQpdPA=;
        b=DQBaBonQAQTGt198EmZPaGn/UjYlH+cYKBN38YTb53yvhwvC7lKya7ILMRVUbNk+Pv
         uQSNbW4ToO5M3ISD2ehUAPxzJcKs1s3CKF0E0E5DN5AMKNsOwuuokBwlDf/5BnmSOCcu
         hLAMXL3vqozL387spk4aw5oN2aycAc2GISl0OD7IXk/Z91zNt9sQOYahganwqDd4T4UI
         R1p9tsXY9HoUYrNVyHK1ZuMb154HAZBpOY4M4Yv/TcW7TFR1ySbR+MMYilU+xvDNDDiI
         gH1fxOu2aewmQ09ziNON7PdQPUXV4CUbUvpUeOZJd2FlJPZ8YeJdaNZqTssxU4LCTYJy
         9hQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hmLqrXXhVU4dEhpiExA430FqmWSncr+dRol/WcQpdPA=;
        b=qfzTO46cn6FeRCdTGXbeUTb950Gwwi45J1LffaVDfgFv2Zgfrq/F7mgSWU1NW4m+QA
         /VLdTHfjIVAGBkVyaGj8S66iQafZM1tDPrnFI7ct9XlnivKgB8kAMSabNjQbecTi6077
         yFqPvVipVPNfA4N+egHfge2OOirrsDsfc+UGU74HYLAly4QVT6X+Kh08U+Akh18dMwx2
         jtCF7yFhGomzjITz7Dz7DjRF00SM21D0fjo1Q/xqqXS3yLIrphFsSISFPGDyNgaXsj+n
         c1/zb5HnM4CKA/kBD0g0z6K1ByPo6kVXmveDK1I4DW4g1kGmh9vRf9O43fLn+lAklcZq
         qHRQ==
X-Gm-Message-State: AOAM532VDxQEN37VafNcHqoVcuuFB0xNsDCqz44OACOdwmyfZsDEJk07
        qjiTxCpdRQcMfrFyO9KnNKkJnerB+HcADhDsqHzNOBUl
X-Google-Smtp-Source: ABdhPJxdi1Sr0McbvvV8tl9DN5sHqNT7r8eLLtsgY9qZMSgz7xaiT6KSI9r8aTgR1lq6vLkRR7bdJQpbqHXUxgsBHn8=
X-Received: by 2002:a05:6830:18f6:: with SMTP id d22mr24596505otf.243.1594040694747;
 Mon, 06 Jul 2020 06:04:54 -0700 (PDT)
MIME-Version: 1.0
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAFhKne_ZVWVhZX5hNEbeGBfU6BMRN9JKQeTsVYOcMmEH1cd3xg@mail.gmail.com>
 <87h7ul15le.fsf@notabene.neil.brown.name> <20200706072221.GA1947246@kroah.com>
 <CAMuHMdWj2d5GF1ZkuhzQxg9teA51zjF0oQQPWcphzK=kJ6-x9Q@mail.gmail.com>
 <CAFhKne9vswg3Q4mTOz4WP6QWJ8tDH+SNx1Pu7LotLagoNURKgw@mail.gmail.com> <d6f56f5f5e0790ee9c7579eb05c7d92e071ee15a.camel@perches.com>
In-Reply-To: <d6f56f5f5e0790ee9c7579eb05c7d92e071ee15a.camel@perches.com>
From:   Matthew Wilcox <willy6545@gmail.com>
Date:   Mon, 6 Jul 2020 09:04:43 -0400
Message-ID: <CAFhKne_p_rKN4adhsuyUyBfrS0YwCtoNFNn-x4aFajPmnkR6iQ@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [PATCH] CodingStyle: Inclusive Terminology
To:     Joe Perches <joe@perches.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chris Mason <clm@fb.clm>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        tech-board-discuss@lists.linuxfoundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 6, 2020 at 8:59 AM Joe Perches <joe@perches.com> wrote:
> On Mon, 2020-07-06 at 08:51 -0400, Matthew Wilcox wrote:
> > In terms of number of lines of code using the word, it's only seventh
> > in drivers/:
> >
> > $ for i in drivers/*; do c=$(find $i -type f |xargs grep slave |wc
> > -l); echo "$c $i"; done |sort -rn |head
> > 5218 drivers/net
> > 1341 drivers/dma
> > 988 drivers/i2c
> > 695 drivers/gpu
> > 666 drivers/soundwire
> > 665 drivers/spi
> > 559 drivers/w1
> > 461 drivers/infiniband
> > 389 drivers/media
> > 301 drivers/scsi
>
> I get rather different and much lower numbers
>
> $ git grep -i -w slave drivers | \
>   cut -f1,2 -d/ | uniq -c | sort -rn | head -20 | cat -n

That's because you're using grep -w which excludes, for example,
slave_configure in drivers/scsi.
