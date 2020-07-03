Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532DFC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 03:46:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2941720674
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 03:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="joEV550q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgGCDqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 23:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgGCDqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 23:46:24 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0863C08C5C1;
        Thu,  2 Jul 2020 20:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=tl1FdWvpFQnPexFdlrgm6yvYDCYbeKdU9qtH/0JodSA=; b=joEV550q2IT7SFooW/7hNlij3c
        gQLfbxh3lzKhQAl9VZB2eMkzINzD587BpyAA8Ns/6cElFEjiIv5HRdl4pzxQIoZfZ1Izy4IKhqPUn
        UaDycqO6njqDaS8mK0JqtqnXR40aAqs6gqoRjjZTGmD5qSGRJIDQEExIJLXkcSSh/gxMv1S5ppcXw
        tu2mMrvQS7Y64m83ni4AB3VINOJpY5Qhou20Rnb3+18VV1O0XP4lKk6f5qwcs84Xfhj729UbmJ0mG
        qyKsw0ya5GLIKauycKTkb2Ay2T19yT3MIdQVT7FRlearjFkhfL398cjAogqQjzGL9LGWYl78P/JaZ
        aScU8aOw==;
Received: from [2601:1c0:6280:3f0::19c2]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrCeZ-0005Fy-AJ; Fri, 03 Jul 2020 03:46:19 +0000
Subject: Re: [RFC] many-files Documentation patch
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <ca6d7248-df70-4a39-3cbe-b49f286d5e50@infradead.org>
 <20200702161207.082d42e5@lwn.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <6ed53b44-0dd7-7191-74fc-382712a67de9@infradead.org>
Date:   Thu, 2 Jul 2020 20:46:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200702161207.082d42e5@lwn.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/2/20 3:12 PM, Jonathan Corbet wrote:
> On Thu, 2 Jul 2020 15:05:01 -0700
> Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>> This patch series eliminates/corrects many doubled words, such as
>> "the the", "of of", "with with", and "and and".
>> It mostly drops the doubled word, but sometimes it modifies one or two
>> words so that they make sense.
>>
>>
>> Can (will) Jon merge this patch series or do I send many separate patches
>> to relevant subsystem maintainers?
>> or trivial?
> 
> I'd have to see the actual patches, of course, but assuming it makes sense
> and doesn't create a mess of conflicts it should be something I could
> apply.


Thanks, Jon. However, I have become hesitant to send a patch series of around 100
patches at one time, given that submitting-patches.rst warns against doing that.
(even though these are all small patches)
(I guess that stable review is excused from that limit.)

I think that I should break them up into smaller (logical?) groups
to send them.

We'll see...
-- 
~Randy

