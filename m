Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 527CDC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 18:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18A22208E4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 18:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgHJSku convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 14:40:50 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:57076 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbgHJSku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 14:40:50 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id CD01161D8ABB;
        Mon, 10 Aug 2020 20:40:47 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id hU8bXeKPAT8V; Mon, 10 Aug 2020 20:40:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 6AAEC61D8ABC;
        Mon, 10 Aug 2020 20:40:47 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id aOzKDsZ6vDg5; Mon, 10 Aug 2020 20:40:47 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 425DD61D8ABB;
        Mon, 10 Aug 2020 20:40:47 +0200 (CEST)
Date:   Mon, 10 Aug 2020 20:40:47 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Pavel Machek <pavel@denx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        stable <stable@kernel.org>
Message-ID: <1475688016.229129.1597084847149.JavaMail.zimbra@nod.at>
In-Reply-To: <20200810163851.GB24408@amd>
References: <20200810151804.199494191@linuxfoundation.org> <20200810151804.911709325@linuxfoundation.org> <20200810163851.GB24408@amd>
Subject: Re: [PATCH 4.19 14/48] mtd: properly check all write ioctls for
 permissions
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Topic: properly check all write ioctls for permissions
Thread-Index: SPuvyTwnFDc3qnA8Gvg/tEw1EZFuYQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Pavel Machek" <pavel@denx.de>
>> When doing a "write" ioctl call, properly check that we have permissions
>> to do so before copying anything from userspace or anything else so we
>> can "fail fast".  This includes also covering the MEMWRITE ioctl which
>> previously missed checking for this.
> 
>> +	/* "safe" commands */
>> +	case MEMGETREGIONCOUNT:
> 
> I wonder if MEMSETBADBLOCK, MEMLOCK/MEMUNLOCK, BLKPG, OTPLOCK and
> MTDFILEMODE should be in the list of "safe" commands? Sounds like they
> can do at least as much damage as average MEMWRITE...

Most of the ioctls you listed are not write-exclusive because existing
user space applications (such as mtd-utils) issue them on a read-only fd.
So, we didn't want to break them.
Before we move such an ioctl to the "non-safe" list, common user space needs to
be inspected. This includes, android, openwrt, mtd-utils, etc...

On the other hand, this is a raw mtd, it is hard to draw the line.
For NAND even reading allows an attacker doing harm, she can trigger read-distrurb
super efficiently using the read ioctl...

So passing an mtdchar fd (no matter whether read or write mode) to untrusted
entities is a bad idea.

Thanks,
//richard
