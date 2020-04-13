Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22A2C2BBFD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 14:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEE922073E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 14:24:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JO5dvR2s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730757AbgDMOYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 10:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730687AbgDMOXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 10:23:51 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA640C0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 07:23:51 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id d7so2432967oif.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 07:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zgppeRMxVpIfTJVA3qGRUdRIsFdXnQrzqcTneOFy0VQ=;
        b=JO5dvR2szf5ab4R86+km40ex7EHd2y5Ot0J5exoIs5vUF3QEwyEgZc71+KfcKuw7kn
         QArJRgB8V8fxIucSWTw7lKEpaJ4ybHQ260rlWZE9wUeRDTeW6LG2lq3tWfN9rWMsHhpf
         laFzd58X1lA179xxhELHYe98pYbTb3fILdtVDoAEdG9a3qkjyTKlYX4dDaA3xrzrlQ4J
         nV6n6Y5mHjzKPFcuFi5aQEZyO6ysDGf6ezA4dDkqgPYwd1QNqS5Lba1F8IocYBFazcLT
         TraEzJuR5DtX07lNFNmwHkZTupJnR7xLAY1t+1RwQ1SrYiaAKYq5/ZxWC3n6BYbjRH0N
         +3IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=zgppeRMxVpIfTJVA3qGRUdRIsFdXnQrzqcTneOFy0VQ=;
        b=GNBwswW7YrNfeN+xtch0PadNyeKPHx6KQdbc2urgGKioJagJflbnNaMleZUI1ytJ7J
         JSSXZvZljcOkbuS3vW53z4BE5/ruu022VnQdh1nBz67CZfSC3ogEnMrk7LrhbPrJLD9t
         Mim5O75avU/7oxjSoD48Khqyh93GcQkb/0ICbxTJAR+xCk+9n6zchNnolWflTZD4J89S
         ZkHwPSKe6m7fhlSooTARHmeheybyFKQAo4ACk/OMmd4WMxHAs5lxeWQ55RIm7CESDDg4
         qILhBdHngViuLu8zvgZa2OdxX/O/vIsbc3w4QE/V1SCvV4TcNXkARbVjxq0RdFk3cpaM
         qSoQ==
X-Gm-Message-State: AGi0PuYGU7u7e5IZtUkTpCeKuwK55trG1PzrsDlUoSr3+bG6BUZA88yV
        wNY5gSw7/wlRBVnPgFxI3w==
X-Google-Smtp-Source: APiQypJXWJZ4G3NyASimxCreOzU+hPt7KjyQITSZwlrNmWLk6GM6HoAZfdkGKl0DwhOVywzy4ibVXQ==
X-Received: by 2002:aca:cf0d:: with SMTP id f13mr11506745oig.162.1586787830992;
        Mon, 13 Apr 2020 07:23:50 -0700 (PDT)
Received: from serve.minyard.net ([47.184.149.130])
        by smtp.gmail.com with ESMTPSA id f45sm4780968otf.30.2020.04.13.07.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 07:23:50 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:8b39:c3f3:f502:5c4e])
        by serve.minyard.net (Postfix) with ESMTPSA id 64CD4181888;
        Mon, 13 Apr 2020 14:23:49 +0000 (UTC)
Date:   Mon, 13 Apr 2020 09:23:48 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3]ipmi:bt-bmc:Avoid unnecessary judgement
Message-ID: <20200413142348.GD3587@minyard.net>
Reply-To: minyard@acm.org
References: <20200408115958.2848-1-tangbin@cmss.chinamobile.com>
 <20200413113225.GB3587@minyard.net>
 <47c06465-9ae5-42c2-ca00-5c666521bbde@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <47c06465-9ae5-42c2-ca00-5c666521bbde@cmss.chinamobile.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 13, 2020 at 07:56:44PM +0800, Tang Bin wrote:
> Hi, Corey:
> 
> On 2020/4/13 19:32, Corey Minyard wrote:
> > On Wed, Apr 08, 2020 at 07:59:58PM +0800, Tang Bin wrote:
> > > bt_bmc_probe() is only called with an openfirmware platform device.
> > > Therefore there is no need to check that the passed in device is NULL or
> > > that it has an openfirmware node.
> > I waited until after the merge window closed, this is queued for 5.8.
> Can I consider that the patch will be applied in 5.8？

It's in my queue, so that's the plan.

> >   I
> > changed the title to be "Avoid unnecessary check".
> You have modified it, which means I don't need to submit a new patch？

Correct.

> >   "Judgement",
> > although technically correct, has a legal or moral connotation.
> 
> I'm sorry, I won't use that word again.

It's not a problem.  English is a language with a lot of things like
this.

-corey

> 
> 
> Thanks for your instruction.
> 
> Tang Bin
> 
> > 
> 
> 
