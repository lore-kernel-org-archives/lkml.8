Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA914C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 12:56:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86A0320678
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 12:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbgAVM4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 07:56:08 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:46751 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbgAVM4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 07:56:08 -0500
Received: from webmail.gandi.net (webmail23.sd4.0x35.net [10.200.201.23])
        (Authenticated sender: cengiz@kernel.wtf)
        by relay12.mail.gandi.net (Postfix) with ESMTPA id 24DEA200008;
        Wed, 22 Jan 2020 12:56:05 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 22 Jan 2020 15:56:05 +0300
From:   Cengiz Can <cengiz@kernel.wtf>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: fuse: check return value of fuse_simple_request
In-Reply-To: <CAJfpegtOOCVrNkSmpmMY0dVH-359jc3RqXJ7K6dzvUqxtCxBtg@mail.gmail.com>
References: <20200120121310.17601-1-cengiz@kernel.wtf>
 <CAJfpegtOOCVrNkSmpmMY0dVH-359jc3RqXJ7K6dzvUqxtCxBtg@mail.gmail.com>
Message-ID: <8024c282d1b007c45b9655ddadd20e35@kernel.wtf>
X-Sender: cengiz@kernel.wtf
User-Agent: Roundcube Webmail/1.3.8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-01-20 16:39, Miklos Szeredi wrote:
> On Mon, Jan 20, 2020 at 1:13 PM Cengiz Can <cengiz@kernel.wtf> wrote:
>> 
>> In `fs/fuse/file.c` `fuse_simple_request` is used in multiple places,
>> with its return value properly checked for possible errors.
>> 
>> However the usage on `fuse_file_put` ignores its return value. And the
>> following `fuse_release_end` call used hard-coded error value of `0`.
>> 
>> This triggers a warning in static analyzers and such.
>> 
>> I've added a variable to capture `fuse_simple_request` result and 
>> passed
>> that to `fuse_release_end` instead.
> 
> Which then goes on to ignore the error, so we are exactly where we
> were with some added obscurity, which will be noticed by the next
> generation of static analyzer, when you'd come up with an even more
> obscure way to ignore the error, etc...  This leads to nowhere.

I got your point. Thanks for explaining.

> If this matters (not sure) then we'll need a notation to ignore the
> return value.  Does casting to (void) work?

It should probably work for the sake of silencing the analyzer but I 
think
it would be easier to just ignore the warning and mark is as 
unimportant.

IMHO code should be as readable as possible. So not point in casting it.

If `fuse_simple_request` errors are very rare, we can ignore this patch.

Thank you

> 
> Thanks,
> Miklos

-- 
Cengiz Can
@cengiz_io
