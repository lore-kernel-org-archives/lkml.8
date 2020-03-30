Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09CD9C2D0EB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 18:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0DC720714
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 18:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585593816;
	bh=Z0VUw2YakUTgB50DeHAQaZKDihqXNcZ0JYTwOd0KF9o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ctHID1N6DmY3yZVcOiljAsAxkYHgiP000Wxp6wlL9pjAO6xGk3oFDXmehjNUKK4DQ
	 pgdwkeJAY2DtwgZed1OSm5+MCrZ8nVXkJV2y08SNLm09L1VvM6Z3e0wPUVqYvDeEfi
	 Azvs97W6YLQJngcqQPK7XSEdGaCMCq/Thsxbs3wM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbgC3Snf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 14:43:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:42070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726385AbgC3Snf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 14:43:35 -0400
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14EEA20714;
        Mon, 30 Mar 2020 18:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585593815;
        bh=Z0VUw2YakUTgB50DeHAQaZKDihqXNcZ0JYTwOd0KF9o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fxoGOExezV4j/TqUOQtHDBhDeULDM+/Rp2luy9VMApyZE/qr3ssz9PAwcjugaxTU7
         IjSYldrHryVFfyIqS+T2naPkhqSoBfD9mmW+JTGzs8QDYoNiK13ZQb6y3ICRB9GVtx
         CVeZ0VCJxpIot37ah1DRzIFOac7PVlLtKp8L5s1I=
Received: by mail-qt1-f169.google.com with SMTP id t17so16018013qtn.12;
        Mon, 30 Mar 2020 11:43:35 -0700 (PDT)
X-Gm-Message-State: ANhLgQ37d66s3PHV8uwG0osLgYrhF9qGIp2ADDVVRkK02dfQe0MZ/Nwt
        ZTxnz4kmFDxN8X9nwkIzFRSS10+T+/2iMnuLEw==
X-Google-Smtp-Source: ADFU+vvQ0VB8PAiOLE1oS4Rl8T3375Rl3/Pz63Irc4+08WeMr8hOvQ1rBd58/OgA3kCy/W68GrYFFzK4tmdP1dLoAZY=
X-Received: by 2002:ac8:18ab:: with SMTP id s40mr1475183qtj.224.1585593814245;
 Mon, 30 Mar 2020 11:43:34 -0700 (PDT)
MIME-Version: 1.0
References: <1564306219-17439-1-git-send-email-bmeng.cn@gmail.com>
 <20190816215425.GA2726@bogus> <CAEUhbmU-SdjjsmPmc7JHQLVjfs7CcXxSf9mZ01h7w=nv7HiP4w@mail.gmail.com>
In-Reply-To: <CAEUhbmU-SdjjsmPmc7JHQLVjfs7CcXxSf9mZ01h7w=nv7HiP4w@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 30 Mar 2020 12:43:22 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJX5wFOb89ZAqNkiXrEFt6BjApAwN7Pc_cg-5eVm-qZMw@mail.gmail.com>
Message-ID: <CAL_JsqJX5wFOb89ZAqNkiXrEFt6BjApAwN7Pc_cg-5eVm-qZMw@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: interrupt-controller: msi: Correct
 msi-controller@c's reg
To:     Bin Meng <bmeng.cn@gmail.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 8:06 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Hi Rob,
>
> On Sat, Aug 17, 2019 at 5:54 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Sun, 28 Jul 2019 02:30:18 -0700, Bin Meng wrote:
> > > The base address of msi-controller@c should be set to c.
> > >
> > > Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> > > ---
> > >
> > >  Documentation/devicetree/bindings/interrupt-controller/msi.txt | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> >
> > Applied, thanks.
>
> This seems not be applied anywhere. Could you please check? Thanks!

Sorry, not sure what happened there. Now queued for 5.7.

Rob
