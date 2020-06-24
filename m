Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FDFAC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64D392076E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 15:25:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404488AbgFXPZt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:25:49 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:35495 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404017AbgFXPZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 11:25:48 -0400
Received: from sogo6.sd4.0x35.net (sogo6.sd4.0x35.net [10.200.201.56])
        (Authenticated sender: kerneldev@karsmulder.nl)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPA id 5FE581C000A;
        Wed, 24 Jun 2020 15:25:45 +0000 (UTC)
From:   "Kars Mulder" <kerneldev@karsmulder.nl>
In-Reply-To: <20200624131016.GA1807770@kroah.com>
Content-Type: text/plain; charset="utf-8"
X-Forward: 127.0.0.1
Date:   Wed, 24 Jun 2020 17:25:45 +0200
Cc:     "Pavel Machek" <pavel@ucw.cz>, linux-kernel@vger.kernel.org,
        "Kai-Heng Feng" <kai.heng.feng@canonical.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
MIME-Version: 1.0
Message-ID: <1da2-5ef37080-31-6d4cde00@228034409>
Subject: =?utf-8?q?Re=3A?= Writing to a const =?utf-8?q?pointer=3A?= is this 
 supposed to =?utf-8?q?happen=3F?=
User-Agent: SOGoMail 4.3.0
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, June 24, 2020 15:10 CEST, Greg Kroah-Hartman wrote: 
> Have you hit any runtime issues with this code doing this?  These
> strings should be held in writable memory, right?  Or do you see a
> codepath where that is not the case?

I haven't ran into any issues with it; I was just looking at the code
as reference for a patch I'm working on.

I initially assumed that casting a const pointer to non-const and
writing to it would be undefined behaviour, but after reading through
the C99 standard I can't find an unambiguous statement whether it is
undefined behaviour even if the const pointer points to an object that
was originally non-const (like char* -> const char* -> char* casts); it
only says it is undefined behaviour if the object was defined with the
const qualifier.

I should probably stop bothering you with my newbie questions.

