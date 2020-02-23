Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34588C35675
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 00:43:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17A0F2071C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 00:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbgBXAnJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Feb 2020 19:43:09 -0500
Received: from esgaroth.petrovitsch.at ([78.47.184.11]:5712 "EHLO
        esgaroth.tuxoid.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727151AbgBXAnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Feb 2020 19:43:08 -0500
X-Greylist: delayed 3401 seconds by postgrey-1.27 at vger.kernel.org; Sun, 23 Feb 2020 19:43:08 EST
Received: from thorin.petrovitsch.priv.at (80-110-97-114.cgn.dynamic.surfer.at [80.110.97.114])
        (authenticated bits=0)
        by esgaroth.tuxoid.at (8.15.2/8.15.2) with ESMTPSA id 01NNk3Mg005792
        (version=TLSv1 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Mon, 24 Feb 2020 00:46:09 +0100
Subject: Re: General Discussion about GPLness
To:     Stephan von Krawczynski <skraw.ml@ithnet.com>
Cc:     linux-kernel@vger.kernel.org, bruce@perens.com
References: <8b0e828da35ab77c1ad4603768c6eab6@waifu.club>
 <20200223133301.03eab91d@ithnet.com>
 <2241a3e0c8dcba5b69b4f670e181d7cd@waifu.club>
 <20200223153909.1ba91bae@ithnet.com>
 <dadb648cd23ee79dacf5992ff5ca6094@waifu.club>
 <20200223214757.5adf49e4@ithnet.com>
From:   Bernd Petrovitsch <bernd@tuxoid.at>
Message-ID: <7896b0b9-c12e-5327-f531-95097cf04eca@tuxoid.at>
Date:   Mon, 24 Feb 2020 00:46:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200223214757.5adf49e4@ithnet.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-DCC--Metrics: esgaroth.tuxoid.at 1481; Body=3 Fuz1=3 Fuz2=3
X-Virus-Scanned: clamav-milter 0.97 at esgaroth.tuxoid.at
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

On 23/02/2020 21:47, Stephan von Krawczynski wrote:
[...]
> I do understand why you cannot enter a discussion with your real name, as most

I ignore folks who don't use their real name - this is since Usenet
times an indication for a troll ...

> of your input is of zero quality - and below.
[...]
>                                                              But our story is
> about kernel modules, something everybody is free to write and publish, with a

... publish implicitly with a GPLv2 or compatible license ...

> defined and open interface for interaction. No kernel code is modified in that

And that's a point which is completely wrong: the only *defined*
interface of the kernel is sys-calls, /proc and similar. And all of this
is from user-space to kernel-space and back.

There is no (and never was) a "defined interface" within the kernel
(inter-operating in kernel space) in any direction simply because the
kernel-internal (infra)structure changes more or less constantly - some
may call that evolution;-)

And I don't get what an "open interface" here couls seriously mean. You
surely don't want to call the list of the GPL_EXPORTed C functions
(which may change from one kernel version to the next) an "open
interface" (whatever that should suggest).

At most the list of GPL_EXPORTed C functions is a de-facto interface and
that may change from one git-commit to the next.

> sense. But you fail to understand that.
> Hopefully others here do. I do not expect them to stand up and jump into a
> discussion where you are a part of. But I hope people start to think about it

And you are barking up the wrong tree. The discussion has to happen in
the ZFS-world so that they fix their license if they want to interface
with any GPL software (without sys-calls etc. in between - WTF it works
via FUSE) like they seen to do now.

And no, I'm not a lawyer so I won't comment more on the law-aspects -
the above is my short summary of discussions hereover about license
clashes etc. over the last decades ...

[ Full quote deleted - pls do not top-post]

MfG,
	Bernd
-- 
Bernd Petrovitsch                  Email : bernd@petrovitsch.priv.at
                     LUGA : http://www.luga.at
