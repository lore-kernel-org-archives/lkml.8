Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF34C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 06:09:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0004204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 06:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590041345;
	bh=rw8NuWYZLi77ecJ1DgyaQ2mq0QiBdMOyeKV1HeV4SAQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DC4fkD5OSVrJOOiSY59BZgpWoMRD7gW9TCovfQSU/AI2r3IcBmsumgOHLvh7VL5Ai
	 Wdq44drl/bjWj/GNbZkutC8l+AOdet9jbI4PVOld74vh0MV9ZvtiYoKIhvDszeZ1vx
	 h/SgrKPWh9Atx4s76qAzyQmkBf4BUreq4u0jenBo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgEUGJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 02:09:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:53954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726984AbgEUGJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 02:09:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B21BD207D8;
        Thu, 21 May 2020 06:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590041344;
        bh=rw8NuWYZLi77ecJ1DgyaQ2mq0QiBdMOyeKV1HeV4SAQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VTA3OCDGpcvS0FGCSfPz+MzoTxdfXeLYwM8IciNVS1doVk0Ygn7aKItiIOhUFGZ8Q
         EcDPrulCP2iukWdV6/0bmf03Xtap3fX2cm3BoNNWPaf6/oHnCV2rcHtNKmvE7TFtX7
         /aM9ZVgIZzPmd3fn+h6RdBqCDvzdFbc4diNXtjh8=
Date:   Thu, 21 May 2020 08:09:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alan Cooper <alcooperx@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        ": Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        DTML <devicetree@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v10 1/5] usb: xhci: Change the XHCI link order in the
 Makefile
Message-ID: <20200521060902.GA2352222@kroah.com>
References: <20200512150019.25903-2-alcooperx@gmail.com>
 <20200513122613.GA1023594@kroah.com>
 <7acc2a4c-caab-11e7-7b3f-4176f19c58cf@gmail.com>
 <20200513162723.GF1362525@kroah.com>
 <38ff034d-a84c-2309-a8d5-f344930d9a31@gmail.com>
 <20200513170505.GB1369204@kroah.com>
 <20200513173920.GA2862@rowland.harvard.edu>
 <c0642cf4-1436-aec4-96fd-355a897f6418@gmail.com>
 <CAOGqxeU=LjAmAYR9wGeKZo_eLj+ehkrANTM+04E7xWNAp82EJA@mail.gmail.com>
 <CAOGqxeV_9LpFudC3VuFPAOmYVYBQGJ+s01HCK2nP6XxpprK2Qw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOGqxeV_9LpFudC3VuFPAOmYVYBQGJ+s01HCK2nP6XxpprK2Qw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Wed, May 20, 2020 at 01:29:45PM -0400, Alan Cooper wrote:
> Greg, Alan,
> 
> The other 4 related patches were accepted into usb-next and I just
> realized that this one didn't make it. This patch will not fix the
> "insmod out of order" issue, but will help our controllers work with
> some poorly behaved USB devices when the drivers are builtin.

As it doesn't solve the real issue, I did not accept this so that you
all can continue to work on creating a real solution that works for both
situations (built in and as modules.)

I thought I said that already...

thanks,

greg k-h
