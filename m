Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C632C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 09:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 650D521D20
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 09:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X51AbloW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbgIHJ1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 05:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728925AbgIHJ1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 05:27:37 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1AFC061755
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 02:27:37 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id m5so9625703pgj.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 02:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=i0GFzGW74PyYALEBgGjzHXdAT2j83gL/RVUSxd4kwZw=;
        b=X51AbloW9ypAQ1OQa7gR/4XkFqgIJPigv3XJzZaBAJbkqCUSTNeQCSKny+zZ+ol6uf
         W+qVyKrrLUwg44iL3zmZyKemnBmtyQwtrFnVZXNIhTIbOuitZuJ33VACIOePrBgf7x6D
         qN/xQUbDXasH+P5jcjf9R2V9XKxgJJr2vKR4X1zUGwKPYKxjBdhPhWzjsi/fAH8W3WqN
         QTir5aY9ONJG1qhasl7hlHoQDhKQwScuiKmpISpleXUpYIQFQwWQWghu8e21SqQnivIY
         /vXSZMMQ5j/ge95hqp+E3uFmPVTNxU9DlxGUZ9JPOClKzjkoZX410WApFaqe9AEBSzjA
         JFlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=i0GFzGW74PyYALEBgGjzHXdAT2j83gL/RVUSxd4kwZw=;
        b=coYqlDKZMnwpHOusPN1L6768kG9gOjD1+JW8whXigYifKfCK2i7O1ReRfihlW3Bet0
         tGVLmSftMDBbfi6th8+q/PkPK0VzlBv45QMjWd4hyu29tIBajYmcHjVMP/X2SC2kDGXq
         V/SdRwtXgnXhIl/7WRVQKSzy049LODO+QG7lBYYr5YhRkIW2XxC6p6kvd68WJJc0slHj
         7PBwblK+03QAq0JfTOl3MDmRb+69n2Yr8RWBp4P0byoDkkZVA2M5/m/mI65deVeYW+9O
         XEVX7gXGcTyyduQ1AlTIchYrswwBdL88kRi7hqzkmLLJhs254uuH+YnR1eDbqy1sJOY3
         twcQ==
X-Gm-Message-State: AOAM5329t9qAdulrFU+F1lqy/awjB8EegvGRW9cMCMFcQ2Ff8zVp63pf
        813+itTOnNFawe+MRXoKjkno/Q==
X-Google-Smtp-Source: ABdhPJxQ5sM0tMG1zH359TymoXLzPfbTreQlsgxFUwS+5qLrfqoW66Pg8LhWCsxBeR9jVPXLnUfUVQ==
X-Received: by 2002:a63:fd0b:: with SMTP id d11mr19743398pgh.21.1599557256781;
        Tue, 08 Sep 2020 02:27:36 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id n26sm17352986pff.30.2020.09.08.02.27.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Sep 2020 02:27:36 -0700 (PDT)
Date:   Tue, 8 Sep 2020 14:57:29 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] dt-bindings: mailbox: add doorbell support to ARM MHU
Message-ID: <20200908092729.sv2pzkvqzpbloe2o@vireshk-i7>
References: <CABb+yY27Ngb0C-onkU2qyt=uKgG4iVrcv8hGkC+anypQbTRA1w@mail.gmail.com>
 <20200605045645.GD12397@bogus>
 <CABb+yY2YZ99NjHYNi0=KLGFDsVUeJmqiJD3E25Chwk-THJV4iw@mail.gmail.com>
 <20200605085830.GA32372@bogus>
 <CABb+yY2TR7tuMx6u8yah6mO2GwZ5SWYOO80EQRL-i=ybgn=Wog@mail.gmail.com>
 <20200610093334.yznxl2esv5ht27ns@vireshk-i7>
 <20200611100027.GB18781@bogus>
 <CABb+yY1OwVB+uk+0w+D-4Xy46iYn8tPZYBZ0qjrzQFLA6SaTvw@mail.gmail.com>
 <20200612052853.nds4iycie6ldjnnr@vireshk-i7>
 <CAK8P3a0nVOR7YYSZaKmzm3WsUZLgOqL7yZq+f0Dfnn2=16AkLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0nVOR7YYSZaKmzm3WsUZLgOqL7yZq+f0Dfnn2=16AkLA@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-09-20, 11:14, Arnd Bergmann wrote:
> Picking up the old thread again after and getting pinged by multiple
> colleagues about it (thanks!) reading through the history.

Thanks for your inputs Arnd.

> Earlier, Jassi also commented "Linux does not provide real-time
> guarantees", which to me is what actually causes the issue here:
> 
> Linux having timeouts when communicating to the firmware means
> that it relies on the hardware and firmware having real-time behavior
> even when not providing real-time guarantees to its processes.
> 
> When comparing the two usage models, it's clear that the minimum
> latency for a message delivery is always at least the time time
> to process an interrupt, plus at least one expensive MMIO read
> and one less expensive posted MMIO write for an Ack. If we
> have a doorbell plus out-of-band message, we need an extra
> DMA barrier and a read from coherent memory, both of which can
> be noticeable. As soon as messages are queued in the current
> model, the maximum latency increases by a potentially unbounded
> number of round-trips, while in the doorbell model that problem
> does not exist, so I agree that we need to handle both modes
> in the kernel deal with all existing hardware as well as firmware
> that requires low-latency communication.

Right.

> It also sounds like that debate is already settled because there
> are platforms using both modes, and in the kernel we usually
> end up supporting the platforms that our users have, whether
> we think it's a good idea or not.
> 
> The only questions that I see in need of being answered are:
> 
> 1. Should the binding use just different "#mbox-cells" values or
>    also different "compatible" strings to tell that difference?
> 2. Should one driver try to handle both modes or should there
>    be two drivers?
> 
> It sounds like Jassi strongly prefers separate drivers, which
> would make separate compatible strings the more practical
> approach. While the argument can be made that a single
> piece of hardware should only have one DT description,
> the counter-argument would be that the behavior described
> by the DT here is made up by both the hardware and the
> firmware behind it, and they are in fact different.

I would be fine with both the ideas and that isn't a blocker for me.
Though I still feel this is exactly why we have #mbox-cells here and
that should be enough in this case, even if we opt for multiple
drivers.

But whatever everyone agrees to will be fine.

-- 
viresh
