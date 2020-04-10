Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B2E1C2BB86
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 14:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEEC620A8B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 14:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="cU+DmLkC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgDJO7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 10:59:11 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:38848 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726049AbgDJO7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 10:59:11 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 7DC1F41417;
        Fri, 10 Apr 2020 14:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        in-reply-to:content-disposition:content-type:content-type
        :mime-version:references:message-id:subject:subject:from:from
        :date:date:received:received:received; s=mta-01; t=1586530748;
         x=1588345149; bh=QW/aUtaswxl+za3c1gmqfuAg6QD/Af1ecf/UE38sKEU=; b=
        cU+DmLkCexDSeQEYeq6DIvlUuef7JmObciJ0QTUk4FeEnTRbT1GR+E1tHtDCTcOX
        s2c/oLiB/Z8W+P3SGLcA9GLYEgrWEs5Zv2sTuW7sMJqxrVZ0hogLB2lzReRuRSCn
        8mtCSPC47LERrb3eBE8OvvR0NNRTxbUOnkItnfe6cvU=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6KlDxzkNWdWi; Fri, 10 Apr 2020 17:59:08 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 8487F404CF;
        Fri, 10 Apr 2020 17:59:05 +0300 (MSK)
Received: from localhost (172.17.14.122) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 10
 Apr 2020 17:59:05 +0300
Date:   Fri, 10 Apr 2020 17:59:04 +0300
From:   "Alexander A. Filippov" <a.filippov@yadro.com>
To:     Andrew Jeffery <andrew@aj.id.au>
CC:     <linux-aspeed@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] ARM: DTS: Aspeed: Add YADRO Nicole BMC
Message-ID: <20200410145904.GA15615@bbwork.lan>
References: <20200406101553.28958-1-a.filippov@yadro.com>
 <ad46ff33-8ce2-4ffa-b12e-204053e4f705@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <ad46ff33-8ce2-4ffa-b12e-204053e4f705@www.fastmail.com>
X-Originating-IP: [172.17.14.122]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 10, 2020 at 02:29:47PM +0930, Andrew Jeffery wrote:
> 
> 
> > +&i2c11 {
> > +	status = "okay";
> > +};
> > +
> > +&i2c12 {
> > +	status = "okay";
> > +};
> 
> Are you accessing devices on the busses from userspace? It would
> be helpful to comment here why you're enabling all of these busses
> but not describing any devices on them, if it's necessary to enable
> them at all.
> 

Yes, some of them are unused and may be removed.
For others I'll add comments in the next version.

> > +
> > +&adc {
> > +	status = "okay";
> 
> You should specify the pinmux configuration for the channels you're using
> to ensure exclusive access to those pins (otherwise they could be exported
> e.g. as GPIOs).

It was just copied from Romulus and looks like I missed iio-hwmon-battery.
Is it what you meant?

All other pins are wired to the ground.`


Alexander
