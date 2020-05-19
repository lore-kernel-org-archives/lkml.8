Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B02C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 22:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCB6C20657
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 22:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbgESWEg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 18:04:36 -0400
Received: from smtp.al2klimov.de ([78.46.175.9]:51852 "EHLO smtp.al2klimov.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgESWEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 18:04:36 -0400
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 8B55F454AE;
        Tue, 19 May 2020 22:04:33 +0000 (UTC)
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: documentation
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200516122740.30665-1-grandmaster@al2klimov.de>
 <CAHp75VevnkT5BohzWxtvdsP__sD0PmsaymXKB8c1cm9JHjw50w@mail.gmail.com>
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
Message-ID: <0b2f391c-9796-0620-a7d6-7844d4ba3449@al2klimov.de>
Date:   Wed, 20 May 2020 00:04:32 +0200
MIME-Version: 1.0
In-Reply-To: <CAHp75VevnkT5BohzWxtvdsP__sD0PmsaymXKB8c1cm9JHjw50w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 19.05.20 um 22:49 schrieb Andy Shevchenko:
> On Sat, May 16, 2020 at 3:31 PM Alexander A. Klimov
> <grandmaster@al2klimov.de> wrote:
>>
>> ... for security reasons.
>>
>> No breaking changes as either the HTTP vhost redirects to HTTPS
>> or both vhosts redirect to the same location
>> or both serve the same content.
> 
> I wonder how you tested that all changed URLs continue working after this.
> I met some sites where https://, alas, doesn't work as expected.
> 
1) As I've written in the commit message, I checked vhosts, *not* whole 
URLs. 2) Jonathan already complained about that. (And *now* – patch 
coming soon – I'm actually checking whole URLs, automated.)
