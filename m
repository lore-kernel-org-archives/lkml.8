Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3D22C47255
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:19:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F1F2208DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 16:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbgD3QTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 12:19:21 -0400
Received: from li1843-175.members.linode.com ([172.104.24.175]:34642 "EHLO
        mail.stoffel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbgD3QTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 12:19:12 -0400
X-Greylist: delayed 562 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Apr 2020 12:19:12 EDT
Received: from quad.stoffel.org (066-189-075-104.res.spectrum.com [66.189.75.104])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.stoffel.org (Postfix) with ESMTPSA id 560F21F03E;
        Thu, 30 Apr 2020 12:09:50 -0400 (EDT)
Received: by quad.stoffel.org (Postfix, from userid 1000)
        id 99CE8A6257; Thu, 30 Apr 2020 12:09:49 -0400 (EDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <24234.63565.561786.818825@quad.stoffel.home>
Date:   Thu, 30 Apr 2020 12:09:49 -0400
From:   "John Stoffel" <john@stoffel.org>
To:     Song Liu <songliubraving@fb.com>
Cc:     Jason Baron <jbaron@akamai.com>, Coly Li <colyli@suse.de>,
        "agk\@redhat.com" <agk@redhat.com>,
        "snitzer\@redhat.com" <snitzer@redhat.com>,
        "linux-raid\@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        NeilBrown <neilb@suse.de>
Subject: Re: [PATCH] md/raid0: add config parameters to specify zone layout
In-Reply-To: <E3616A45-C6D0-4B3B-8112-688B03126F00@fb.com>
References: <1585236500-12015-1-git-send-email-jbaron@akamai.com>
        <0b7aad8b-f0b7-24c6-ad19-99c6202a3036@suse.de>
        <8feb2018-7f99-6e02-c704-9d7fed40bba2@akamai.com>
        <E3616A45-C6D0-4B3B-8112-688B03126F00@fb.com>
X-Mailer: VM 8.2.0b under 25.1.1 (x86_64-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Song" == Song Liu <songliubraving@fb.com> writes:

Song> Hi Jason,
>> On Apr 27, 2020, at 2:10 PM, Jason Baron <jbaron@akamai.com> wrote:
>> 
>> 
>> 
>> On 4/25/20 12:31 AM, Coly Li wrote:
>>> On 2020/3/26 23:28, Jason Baron wrote:
>>>> Let's add some CONFIG_* options to directly configure the raid0 layout
>>>> if you know in advance how your raid0 array was created. This can be
>>>> simpler than having to manage module or kernel command-line parameters.
>>>> 
>>> 
>>> Hi Jason,
>>> 
>>> If the people who compiling the kernel is not the end users, the
>>> communication gap has potential risk to make users to use a different
>>> layout for existing raid0 array after a kernel upgrade.
>>> 
>>> If this patch goes into upstream, it is very probably such risky
>>> situation may happen.
>>> 
>>> The purpose of adding default_layout is to let *end user* to be aware of
>>> they layout when they use difference sizes component disks to assemble
>>> the raid0 array, and make decision which layout algorithm should be
>>> used. Such situation cannot be decided in kernel compiling time.
>> 
>> I agree that in general it may not be known at compile time. Thus,
>> I've left the default as RAID0_LAYOUT_NONE. However, there are
>> use-cases where it is known at compile-time which layout is needed.
>> In our use-case, we knew that we didn't have any pre-3.14 raid0
>> arrays. Thus, we can safely set RAID0_ALT_MULTIZONE_LAYOUT. So
>> this is a simpler configuration for us than setting module or command
>> line parameters.

Song> I would echo Coly's concern that CONFIG_ option could make it risky. 
Song> If the overhead of maintaining extra command line parameter, I would
Song> recommend you carry a private patch for this change. For upstream, it
Song> is better NOT to carry the default in CONFIG_.

I agree as well.  Just because you have a known base, doesn't mean
that others wouldn't be hit with this problem.

John

