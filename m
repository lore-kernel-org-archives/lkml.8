Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A66C33CAC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 10:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4F1220661
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 10:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DrFFLbT6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbgBCKrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 05:47:16 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44056 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbgBCKrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 05:47:16 -0500
Received: by mail-wr1-f68.google.com with SMTP id m16so17319193wrx.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 02:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T7d7soSR0gPW5ttjKX5i29rp97gN4GjRtPqKhyOovuE=;
        b=DrFFLbT66Xa1xftRQkInvNrDUN+LmAymz5A8++pAxFDvF7wcmnH1nkoyR9ajAIwLhF
         r3/nUqCY+KAjKoDO3zRUqVUP6zmz1yXq+4kvDCxd0B3+ikIHZkvOZD8gxwrnR3MWlDjk
         4wApNq+7Z2HwMAlchY7GeG1ciu9d+Fmi4o/lBwt9O+CQPAEPB8nb8z0Jsz9p9ufLBsHB
         xeKqX/vHYueEU+BMZE227DeHTod+OKeif4ODpE1RjJrMEnOrVUdJg5eUUkrZE/gVHY9W
         yIrObBDPnQRGy0ITydr9j/Gtggtqp5FJU9+tijRT/4PXOwTAoFC0t0aq4mGxT8kY5fqE
         vgpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T7d7soSR0gPW5ttjKX5i29rp97gN4GjRtPqKhyOovuE=;
        b=l4VjUPjDCv7CUx5mSJO2/rUquob5PSsh08ihE+TZqGbnlt3Tw6+MEhgDifsWw7KWFD
         Ox0lh7OTpmfyVyDsA222lqDmv702+VfUwdtXq4iCkH1uXF9LUcbnFK79YfESeuH6ICrW
         Qa6XwUtQh6OlH8WvsWfEzwogwaohT+vYdFj9P5uDLeVr09e5bPKyM0xI11nyTDfST36D
         vsd1RCEXHKCJc1ozPjNN92OJFp/MITFxOY2mObLr7T8z+6KHLJ4S+Lx2gAa2+SJUNw/N
         eImxHc1tnWgJghbQcUFRjR2CFqCkhYWfevrUu8s0tMqsYCnW8iazmzfoEwj/rBi0EO7H
         MaJQ==
X-Gm-Message-State: APjAAAW7txPGSR4e8ZuXJSOR9TLnbB0O33Fs0sQFYUkj0on1I03ZdeXu
        P6Acws5ki2M9O5IuIYFt2i2VAnHSJt7nBY1e8BnCMOOg29U=
X-Google-Smtp-Source: APXvYqyw1koBeNuL/pBldr4cfKzqQca/OVBn2QudVj7bzXwhfLjN/2s333uYjnsLZBawsZoyr9pey+N6h9dcD27qaJU=
X-Received: by 2002:a5d:6852:: with SMTP id o18mr15136167wrw.426.1580726835087;
 Mon, 03 Feb 2020 02:47:15 -0800 (PST)
MIME-Version: 1.0
References: <20200203012702.GA8731@bombadil.infradead.org>
In-Reply-To: <20200203012702.GA8731@bombadil.infradead.org>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Mon, 3 Feb 2020 18:47:03 +0800
Message-ID: <CACVXFVPyW9+oSPAv7-+=hExzktLkmPG=gYUY5acR5UGeJzTh0Q@mail.gmail.com>
Subject: Re: Current Linus tree protection fault in __kmalloc
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 3, 2020 at 9:29 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> Anyone else seeing this?  My poor laptop has little compile grunt.

It can be triggered in my VM every time, and has started git-bisect already.

Thanks,
Ming
