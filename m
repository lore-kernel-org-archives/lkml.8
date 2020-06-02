Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D336CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 21:51:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA0152074B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 21:51:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="LQzwc1HZ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="LQzwc1HZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbgFBVvO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 17:51:14 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:50292 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726112AbgFBVvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 17:51:14 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id D14438EE269;
        Tue,  2 Jun 2020 14:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1591134672;
        bh=zzBXsNBuXIwx4FJrfyfpP3vuGw4PqkY/lK7qzNfsglo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=LQzwc1HZNUbTfmYftCpq2xCukFV8tsieIvpDth5OA7lIsnd6EAP1Zigp2nc8HkSp6
         BpI0NhuAkN+5tm7X7iZ+cyXeCVY+C7yTJjsfRRD1oD+lA4W7IiS3Yp96uXQKO4OCg/
         egW6kXZhKBA9W8gQRKqZQaRX60Y5WVmCojW7yeSE=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SocALtf7texX; Tue,  2 Jun 2020 14:51:12 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.76.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 646708EE0F8;
        Tue,  2 Jun 2020 14:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1591134672;
        bh=zzBXsNBuXIwx4FJrfyfpP3vuGw4PqkY/lK7qzNfsglo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=LQzwc1HZNUbTfmYftCpq2xCukFV8tsieIvpDth5OA7lIsnd6EAP1Zigp2nc8HkSp6
         BpI0NhuAkN+5tm7X7iZ+cyXeCVY+C7yTJjsfRRD1oD+lA4W7IiS3Yp96uXQKO4OCg/
         egW6kXZhKBA9W8gQRKqZQaRX60Y5WVmCojW7yeSE=
Message-ID: <1591134670.16819.18.camel@HansenPartnership.com>
Subject: Re: kobject_init_and_add is easy to misuse
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Wang Hai <wanghai38@huawei.com>, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, khlebnikov@yandex-team.ru,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Tue, 02 Jun 2020 14:51:10 -0700
In-Reply-To: <20200602200756.GA3933938@kroah.com>
References: <20200602115033.1054-1-wanghai38@huawei.com>
         <20200602121035.GL19604@bombadil.infradead.org>
         <1591111514.4253.32.camel@HansenPartnership.com>
         <20200602173603.GB3579519@kroah.com>
         <1591127656.16819.7.camel@HansenPartnership.com>
         <20200602200756.GA3933938@kroah.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-06-02 at 22:07 +0200, Greg Kroah-Hartman wrote:
> On Tue, Jun 02, 2020 at 12:54:16PM -0700, James Bottomley wrote:
[...]
> > I think the only way we can make the failure semantics consistent
> > is to have the kobject_init() ones (so kfree on failure).  That
> > means for the add part, the function would have to unwind
> > everything it did from init on so kfree() is still an option.  If
> > people agree, then I can produce the patch ... it's just the
> > current drive to transform everyone who's doing kfree() into
> > kobject_put() would become wrong ...
> 
> Everyone should be putting their kfree into the kobject release
> anyway, right?

No, that's the problem ... for a static kobject you can't free it; and
the release path may make assumption which aren't valid depending on
the kobject state.

> Anyway, let's see your patch before I start to object further :)

My first thought was "what?  I got suckered into creating a patch",
thanks ;-)  But now I look, all the error paths do unwind back to the
initial state, so kfree() on error looks to be completely correct.  I
got confused by a bogus patch set like this:

https://lore.kernel.org/linux-scsi/20200528201353.14849-1-wu000273@umn.edu/

But it turns out the person sending the patch didn't understand the
network failure they quote:

b8eb718348b8 net-sysfs: Fix reference count leak in rx|netdev_queue_add_kobject

Has the problem precisely because the kobject is static.  The release
path clears it and that allows it to be readded.  I'll just reply to
the sender of the bogus patches.

James


