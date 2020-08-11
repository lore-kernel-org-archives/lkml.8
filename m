Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E66EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 14:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE1B3206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 14:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BIjSpO0j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbgHKOm4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 10:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728783AbgHKOmu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 10:42:50 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FACEC061787;
        Tue, 11 Aug 2020 07:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=qDSQHCDBU4D3YRSldaGEKRiZu5f5C5HcKUrvXP1BRoo=; b=BIjSpO0jPg+gb45bDcxNRZ5Cvw
        6TGXh918jACirRi/3Eo6jf/a9OrSgID5WPc9DYawF3ydNVOyu4YgdTblKd8HcyILobnac/x96bxeJ
        tTAT+8GYuesYENvzgLd8tipOmbaw4V5NTuHn3EpMpFz+qSydXoGQ/PWDcPBLX8zmU5RR8kt3Q/ZhZ
        uiuVgAi1f+STKDoAzmA1Xq7s/+qwntQftwuVrZrzTNawhyUW/V5/Z3Xc8yWkCnNpgwTOR46Y7/NQ9
        tiR6XqCrcF6XWtN2yJG3iZAVG+moqBhIwTc1eEnSXVAonvU908HuZN/uxx/mvlVZMwPBMdeLQbcBH
        oMMzoFeQ==;
Received: from c-73-157-219-8.hsd1.or.comcast.net ([73.157.219.8] helo=[10.0.0.252])
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k5VUE-0000sS-UI; Tue, 11 Aug 2020 14:42:47 +0000
Subject: Re: [PATCH] fs: autofs: delete repeated words in comments
To:     Ian Kent <raven@themaw.net>, linux-kernel@vger.kernel.org
Cc:     autofs@vger.kernel.org
References: <20200811021817.24982-1-rdunlap@infradead.org>
 <75e04b06be0561c3cec936cd3bbc44fe82ca73f4.camel@themaw.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <811e011e-2f45-87c3-d92d-729680da5917@infradead.org>
Date:   Tue, 11 Aug 2020 07:42:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <75e04b06be0561c3cec936cd3bbc44fe82ca73f4.camel@themaw.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/20 1:36 AM, Ian Kent wrote:
> On Mon, 2020-08-10 at 19:18 -0700, Randy Dunlap wrote:
>> Drop duplicated words {the, at} in comments.
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Ian Kent <raven@themaw.net>
>> Cc: autofs@vger.kernel.org
> 
> Acked-by: Ian Kent <raven@themaw.net>

Hi Ian,

Since you are the listed maintainer of this file, does this mean
that you will be merging it?

thanks.

> 
>> ---
>>  fs/autofs/dev-ioctl.c |    4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> --- linux-next-20200807.orig/fs/autofs/dev-ioctl.c
>> +++ linux-next-20200807/fs/autofs/dev-ioctl.c
>> @@ -20,7 +20,7 @@
>>   * another mount. This situation arises when starting automount(8)
>>   * or other user space daemon which uses direct mounts or offset
>>   * mounts (used for autofs lazy mount/umount of nested mount trees),
>> - * which have been left busy at at service shutdown.
>> + * which have been left busy at service shutdown.
>>   */
>>  
>>  typedef int (*ioctl_fn)(struct file *, struct autofs_sb_info *,
>> @@ -496,7 +496,7 @@ static int autofs_dev_ioctl_askumount(st
>>   * located path is the root of a mount we return 1 along with
>>   * the super magic of the mount or 0 otherwise.
>>   *
>> - * In both cases the the device number (as returned by
>> + * In both cases the device number (as returned by
>>   * new_encode_dev()) is also returned.
>>   */
>>  static int autofs_dev_ioctl_ismountpoint(struct file *fp,
> 

-- 
~Randy

