Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0186C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 10:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 895AF2076D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 10:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="Bb+YFGXE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbgH2Knu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 06:43:50 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:1453 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727022AbgH2Kno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 06:43:44 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4BdtNt4GLxz18;
        Sat, 29 Aug 2020 12:43:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1598697822; bh=fGConhRjkD/M4qym9EGNNIyAY17CNESN0/THcr9p2aU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bb+YFGXEs9oiPnrzOBfO949QntwH5VfoT7O5zmecy1SzOTtsdVf1P4r1jO6KW0MBi
         8EAjY46G7w9g2IDC43othJPebfc3jj9sqN0usmVhJIoNSdoAgViF5CR3YOtKt6IxQh
         Ey6Sfoof4CjdQWK0aDraTFdLpYGBl3x7wA5nt0T87fnFOxQwG9w+jVuP53gucZAqly
         myxSNBestBtMDLLuGDKnpdsbcglpVG5AEklhrVTedYlxw8RSVrhtUiNTzsWwq3QM+z
         gTt+i0cdvSjVwdeqctrr2VDS3s620uD/3n33C9oCqqc+XBopEheGQEr/1ThMJzadQF
         r7a3FDxEjM62g==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.4 at mail
Date:   Sat, 29 Aug 2020 12:43:38 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Tom Rix <trix@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver code: print symbolic error code
Message-ID: <20200829104337.GA11179@qmqm.qmqm.pl>
References: <ea3f973e4708919573026fdce52c264db147626d.1598630856.git.mirq-linux@rere.qmqm.pl>
 <434ca0ab-1c9b-5c4f-c844-5e792725f9ab@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <434ca0ab-1c9b-5c4f-c844-5e792725f9ab@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 11:22:25AM -0700, Tom Rix wrote:
> 
> On 8/28/20 9:14 AM, Micha³ Miros³aw wrote:
> > dev_err_probe() prepends the message with an error code. Let's make it
> > more readable by translating the code to a more recognisable symbol.
> recognizable
> >
> > Fixes: a787e5400a1c ("driver core: add device probe log helper")
> is this change really to fix a bug?
[...]

Yes, but this depends on how you define a bug. :-)

Best Regards,
Micha³ Miros³aw
