Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7D3C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 426C6206D5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 17:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="zRtJA3wm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732682AbgCCRzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 12:55:18 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:55687 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732666AbgCCRzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 12:55:12 -0500
Received: by mail-pj1-f68.google.com with SMTP id a18so1671184pjs.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 09:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=ZYyTe7dD0f8CvlodvaFSBY4T+0LuLzAx2lyOiyIeWAw=;
        b=zRtJA3wm3MQ5pRqwalHG6UtXT02ioF+mHErjs1nXkOOTCon8efC0VtPdPekDH394g3
         IbEJf1wprR8XvNcei9K8haA1y9XeSij7hI8HHG60QqBGr28noC7dKjg4tZFJLJ+jJ7lY
         jjHYVUkj/Yzs5AL2pLcjTQLfCQOycNWS2JaDGgSblDhqKaGmwfPMX+WC6x4lErGMSj2e
         uPgbgk74XxEsB0Uj+adZG8AvG6MeBPvHRmgZMQwvgCGgi8SghaSm5KrhZyQhh9EBIutE
         76XDWLhiC5MJ2syoI5A8RM35CnmyXnh0ioD8WrhoCGDFQZE4TEgVgnPOGrTDBRyyV/ne
         omSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=ZYyTe7dD0f8CvlodvaFSBY4T+0LuLzAx2lyOiyIeWAw=;
        b=tEa40zziYuQjPFYeQwIHtYMvS6K1dhg5i2ngL42Qzqs/vOo91VHgAPfR/RN+MVIV+z
         IhMpzYtC6ZpUlAueK8dadcvT14yV0Qq4yYFQBlbszQVm0KgB9diEORlLZoLJXFQI6czg
         9QtPBMww+ljVh7MYd5SVCWt7TNUTl+IWEQ+KYc0AWBxN3yHt+/DZTpVRuyb+EsB99MWP
         xF2tuj7YwObvGt7UuVKdkagZq0RFo+4Qg8wEgdTr4cZe0q/TudWC5EKC39wAifFdyiip
         EwYOPB28hatqDoNRpFKhoIktEM20/sYCDUEVBj2rD7pjZteYJix3NBRKNBdqn2mCXFFq
         biZg==
X-Gm-Message-State: ANhLgQ3LeeGiqVS/C9gHCuQxvImKUbm/MFGHketaouvO7StRpndfdzC5
        y/0cuDU4gs4nBQJzydwP++kIuQ==
X-Google-Smtp-Source: ADFU+vuKc3jVLGpaNwoGxZ4r38rovpZ+mHwCyyZycowdPXRgzjM6iaIQymbENr48CbA9H+HKPHnJ4A==
X-Received: by 2002:a17:90a:3701:: with SMTP id u1mr5049507pjb.25.1583258111018;
        Tue, 03 Mar 2020 09:55:11 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:23a5:d584:6a92:3e3c])
        by smtp.gmail.com with ESMTPSA id u6sm24584506pgj.7.2020.03.03.09.55.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 09:55:10 -0800 (PST)
Date:   Tue, 03 Mar 2020 09:55:10 -0800 (PST)
X-Google-Original-Date: Tue, 03 Mar 2020 09:55:07 PST (-0800)
Subject:     Re: [PATCH] riscv: fix seccomp reject syscall code path
In-Reply-To: <202003022042.2A99B9B0@keescook>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        david.abdurachmanov@gmail.com, luto@amacapital.net,
        oleg@redhat.com, aou@eecs.berkeley.edu, keith.packard@sifive.com,
        tycho@tycho.ws
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     keescook@chromium.org
Message-ID: <mhng-f926452f-8491-4deb-9721-a52487de676d@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 02 Mar 2020 20:46:46 PST (-0800), keescook@chromium.org wrote:
> On Sun, Feb 23, 2020 at 10:17:57AM -0700, Tycho Andersen wrote:
>> On Sat, Feb 08, 2020 at 08:18:17AM -0700, Tycho Andersen wrote:
>> > ...
>>
>> Ping, any risc-v people have thoughts on this?
>>
>> Tycho
>
> Re-ping. :) Can someone please pick this up? Original patch here:
> https://lore.kernel.org/lkml/20200208151817.12383-1-tycho@tycho.ws/

Sorry, the other messages didn't end up in my inbox.  I'll take a look, as this
seems like a good candidate for rc5.
