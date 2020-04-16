Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E735C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 17:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55E022078E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 17:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587056538;
	bh=P+Ucer1M9l6KKQUwDRkklq0Zc/HtIzbc269fL8kXSM8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=emq44k99WFM0NgwJeUQ9+/q+yXWGpy8z+PiVGraB362JFSa5pHYzgLEO4EteJMjnl
	 XJr5k7VtuLwBFnc05G2hJ/NSRTvWY1b7MV83Ric/OmP4Dl7dO6xVqvqxBYB2d4jH9i
	 abYpYnNYKZ5jsXhP/O6+U0qSrKDC82Tsq80cAPMI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404775AbgDPRCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 13:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404251AbgDPRCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 13:02:13 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7492C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 10:02:12 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id h6so6189819lfc.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 10:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dDes2+uYwqdDpp6u8TFEa/zLM2coaSYzbk9Klu5JF50=;
        b=d4bGcI6r9EXx896lm5psS0z1tGPVAD1Aq/Ppvu5hGlzAbh+Zf/1v3KrwUBex7wJOqX
         fdBbg7Y0d06giLFwxcJ/M+yzoOCnSc92Ma3Vx8FQSeIFEJ9t0tWAkPjyb2FW9WP2SOBk
         +rtsc0ysltydTupDTjzTBovmcsnwzBPYrog24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dDes2+uYwqdDpp6u8TFEa/zLM2coaSYzbk9Klu5JF50=;
        b=qUYvRZ7FBtLQuivkFsS9fB9toATOCJ4yfBV9cK1zBXu2t4dMHNA91C97YwJDgZVDV6
         DL5Dcj/uKlOc/Wg7lNV65M1/wA066er564TUkpW40qi9/ecbRjYwNPf87bOwxaaxA8v0
         IVe1+hpRLNnTbQtwibWvB5cSPtEiGMMT70rK/HxUBVvXRygw+L79TtWEJcdt2s5mKoZa
         PtzAI8H3tgDE9TzkC0dfgQD6Ij+n1QiuqcA4E65KqlYmemtvIG1j6pC+41LZ2rvGiS30
         V6KQJkI3Yb4yuTobwHp62utYziW5jc6GZAiIAAr1+NFsZO3xIYu6ddf7dJHug4tZck6z
         l1nQ==
X-Gm-Message-State: AGi0PuabWyhZfaS859DjFkeBEZs+2CQlaUh/7bCyCcHEuJQ61uThLf2o
        Pdan9TAcNB5dZncF+VPnscmcunB1uZE=
X-Google-Smtp-Source: APiQypJJVv/OzRC4NTJ7O6cBPU6snnKX9qGZ9MihREbz8lCCMggHKG/0luLtbkyFOVZcPdIv2/eJjQ==
X-Received: by 2002:a05:6512:242:: with SMTP id b2mr6736277lfo.92.1587056530078;
        Thu, 16 Apr 2020 10:02:10 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id q6sm15247184ljp.21.2020.04.16.10.02.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2020 10:02:09 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id r7so8558923ljg.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 10:02:08 -0700 (PDT)
X-Received: by 2002:a2e:7c1a:: with SMTP id x26mr6539997ljc.209.1587056528034;
 Thu, 16 Apr 2020 10:02:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200414123606-mutt-send-email-mst@kernel.org>
 <CAHk-=wgVQcD=JJVmowEorHHQSVmSw+vG+Ddc4FATZoTp9mfUmw@mail.gmail.com> <20200416081330-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200416081330-mutt-send-email-mst@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 16 Apr 2020 10:01:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjduPCAE-sr_XLUdExupiL0bOU5GBfpMd32cqMC-VVxeg@mail.gmail.com>
Message-ID: <CAHk-=wjduPCAE-sr_XLUdExupiL0bOU5GBfpMd32cqMC-VVxeg@mail.gmail.com>
Subject: Re: [GIT PULL] vhost: cleanups and fixes
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     KVM list <kvm@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, ashutosh.dixit@intel.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Markus Elfring <elfring@users.sourceforge.net>,
        eli@mellanox.com, eperezma@redhat.com,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>, hulkci@huawei.com,
        "Cc: stable@vger.kernel.org, david@redhat.com, dverkamp@chromium.org,
        hch@lst.de, jasowang@redhat.com, liang.z.li@intel.com, mst@redhat.com,
        tiny.windzz@gmail.com," <jasowang@redhat.com>,
        matej.genci@nutanix.com, Stephen Rothwell <sfr@canb.auug.org.au>,
        yanaijie@huawei.com, YueHaibing <yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 16, 2020 at 5:20 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> Well it's all just fallout from

What? No. Half of it seems to be the moving of "struct vring" around
to other headers and stuff.

And then that is done very confusingly too, using two different
structures both called "struct vring".

No way can I pull that kind of craziness as a "fix".

                Linus
