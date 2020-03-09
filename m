Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9DC9C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 08:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CE792084E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 08:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583742666;
	bh=sLXvjGCJnnzW+uQLTDT14+oKIKR/17ArcoVG6GZsO+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aWLatPku9ByxmxUYnqjCPjs+OnrLEjUrW//UtionMqz54o6YtIZllYSwbincP6Ft/
	 1wdRz2Q98QVX7IEoGRCkUqA+GRkOolk+F4RD270fnZDsuhqB8UnViu3RPq/kd615De
	 eLbiRZpZ6oL6BO1qdZTbda+OXuI7RLwYsE49F/Xk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgCIIbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 04:31:05 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41831 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgCIIbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 04:31:05 -0400
Received: by mail-lj1-f195.google.com with SMTP id o10so2225152ljc.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 01:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NJLkCkuMzzpPuugQcQ0p8avakDTUhh8cOIKlBZwAH50=;
        b=SHI+D42vIKCfVfhubgrE7mQySwz2KY4n7wex8dsyr3e8XOz+JBMlyTe/gOyfXIx53U
         EBUU8o6CNYM0PoOzFre/BYvTVgDBDd3FoB9PV/j414GLVkHS7KpUmh6b1ZTxmUDFjuAI
         qtRLI5R3lDhj4p+xyz9WgQ1T3QdUYLk3X6ElaCx0URctgwnrItlmdL6a5WzCfgu56+Y2
         brz/B0SX6CYBIi2C/NgP/SF5v3GOExYSB+CBxsDpzUcV8vJ8jpseKUah1NFHMmfLIhqu
         +M02MiacGiwHp9JspNqmM5YRQqN1E8DJIq2G/+GtjobR9ocWxyWMhzK+Z24gkAECCIrl
         eRZQ==
X-Gm-Message-State: ANhLgQ3rIcRmTgduqusxAC95xR4Cb0NvIrT9/H3CBpHaWrueZyV3m8Jv
        SC6S3blIw/NfWjgqsX+6V4ukMCP0
X-Google-Smtp-Source: ADFU+vstW8cNSfPuh7HcES1v35XdnhqmfHlxAQ2GEL9hma2Cnbdj+5C4Kn5Ha+yDjLUgikjjxUWlBg==
X-Received: by 2002:a2e:978d:: with SMTP id y13mr8365758lji.287.1583742663353;
        Mon, 09 Mar 2020 01:31:03 -0700 (PDT)
Received: from xi.terra (c-12aae455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.170.18])
        by smtp.gmail.com with ESMTPSA id u15sm11477985ljl.34.2020.03.09.01.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 01:31:02 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1jBDoH-0004nB-23; Mon, 09 Mar 2020 09:30:49 +0100
Date:   Mon, 9 Mar 2020 09:30:49 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org
Subject: Re: [PATCH] staging: greybus: Fix the irq API abuse
Message-ID: <20200309083049.GA14211@localhost>
References: <87o8t9boqq.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o8t9boqq.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 02:24:13PM +0100, Thomas Gleixner wrote:
> Nothing outside of low level architecture code is supposed to look up
> interrupt descriptors and fiddle with them.
> 
> Replace the open coded abuse by calling generic_handle_irq().
> 
> This still does not explain why and in which context this connection
> magic is injecting interrupts in the first place and why this is correct
> and safe, but at least the API abuse is gone.

Yeah, there's more to that story. The interrupt-handling was known to
have issues, but I can't seem to find the details right now.

> Fixes: 036aad9d0224 ("greybus: gpio: add interrupt handling support")
> Fixes: 2611ebef8322 ("greybus: gpio: don't call irq-flow handler directly")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: Johan Hovold <johan@kernel.org>

Johan
