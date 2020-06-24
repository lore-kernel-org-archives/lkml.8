Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F6DBC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D79620CC7
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403940AbgFXMfL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 08:35:11 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:57843 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403894AbgFXMes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 08:34:48 -0400
Received: from sogo3.sd4.0x35.net (sogo3.sd4.0x35.net [10.200.201.53])
        (Authenticated sender: kerneldev@karsmulder.nl)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPA id 0FA45C0009;
        Wed, 24 Jun 2020 12:34:45 +0000 (UTC)
From:   "Kars Mulder" <kerneldev@karsmulder.nl>
In-Reply-To: <20200623195520.GA24965@duo.ucw.cz>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
Date:   Wed, 24 Jun 2020 14:34:45 +0200
Cc:     linux-kernel@vger.kernel.org,
        "Kai-Heng Feng" <kai.heng.feng@canonical.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
To:     "Pavel Machek" <pavel@ucw.cz>
MIME-Version: 1.0
Message-ID: <db0-5ef34880-ab-10c623c0@12577330>
Subject: =?utf-8?q?Re=3A?= Writing to a const =?utf-8?q?pointer=3A?= is this 
 supposed to =?utf-8?q?happen=3F?=
User-Agent: SOGoMail 4.3.0
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, June 23, 2020 21:55 CEST, Pavel Machek wrote: 
> Odd, indeed... but not likely to cause immediate problems.
> 
> You may want to cc relevant maintainers, or even run git
> blame and contact author.

Thank you for your response.

The code was written by Kai-Heng Feng, whom I shall CC. The code is
part of the usbcore module, which does not have a maintainer listed in
MAINTAINERS, but the patch and most other recent patches to usbcore
were signed off exclusively by Greg Kroah-Hartman, so I guess that
makes him the de facto maintainer? I'll CC him as well.

I'm not sure whether it is easy to read the previous messages of this
thread if you got CC'ed just now, so I'll repeat/paraphrase the
important part of my initial mail for your convenience:

> In the file drivers/usb/core/quirks.c, I noticed that the function
> quirks_param_set writes to a const pointer, and would like to check
> whether this is ok with the kernel programming practices. Here are
> the relevant lines from the function (several lines omitted):
> 
> 	static int quirks_param_set(const char *val, const struct kernel_param *kp) {
> 		char *p, *field;
> 		for (i = 0, p = (char *)val; p && *p;) {
> 			field = strsep(&p, ":");
>
> In here a const pointer *val is cast into a non-const pointer and
> then written to by the function strsep, which replaces the first
> occurrence of the ':' token with a null-byte. Is this allowed?

CC: Kai-Heng Feng <kai.heng.feng@canonical.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

