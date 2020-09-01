Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98C0C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 13:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D80A206EB
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 13:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728129AbgIANjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 09:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbgIANij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 09:38:39 -0400
Received: from smtp2-3.goneo.de (smtp2.goneo.de [IPv6:2001:1640:5::8:33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E5EC061245
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 06:38:19 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp2.goneo.de (Postfix) with ESMTP id EFA7223F56F;
        Tue,  1 Sep 2020 15:38:12 +0200 (CEST)
X-Virus-Scanned: by goneo
Received: from smtp2.goneo.de ([127.0.0.1])
        by localhost (smtp2.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id J9dzge83HrKw; Tue,  1 Sep 2020 15:38:11 +0200 (CEST)
Received: from [192.168.1.127] (dyndsl-091-096-137-061.ewe-ip-backbone.de [91.96.137.61])
        by smtp2.goneo.de (Postfix) with ESMTPSA id 5854823F03B;
        Tue,  1 Sep 2020 15:38:11 +0200 (CEST)
Subject: Re: linux-next: build failure after upgrading sphinx
To:     Jonathan Corbet <corbet@lwn.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200827145017.47c16c73@canb.auug.org.au>
 <20200831130312.0a2cbd0c@lwn.net>
From:   Markus Heiser <markus.heiser@darmarit.de>
Message-ID: <089b8100-0ee6-36b2-c524-0d9370d6bb52@darmarit.de>
Date:   Tue, 1 Sep 2020 15:38:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200831130312.0a2cbd0c@lwn.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 31.08.20 um 21:03 schrieb Jonathan Corbet:
> On Thu, 27 Aug 2020 14:50:17 +1000
> Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> 
>> Today I upgraded ot sphinx v3.2.1 and got the following error from
>> "make htmldocs":
>>
>> Running Sphinx v3.2.1
>> enabling CJK for LaTeX builder
>>
>> Extension error:
>> Could not import extension cdomain (exception: cannot import name 'c_funcptr_sig_re' from 'sphinx.domains.c' (/usr/lib/python3/dist-packages/sphinx/domains/c.py))
>>
>> I have downgraded to version 2.4.3 and await suggestions/patches :-)
> 
> [Adding Markus]
> 
> Markus, this looks like an issue with the "handle function-like macros"
> code that has your name on it.  The Sphinx folks think that functionality
> can just be removed:
> 
> 	https://github.com/sphinx-doc/sphinx/issues/7421
> 
> Do you agree?  We need to look at what they're saying about the :name:
> directive as well; somehow I missed that when it first went in.
> 
> Thanks,
> 
> jon

Hi Jon, thanks for taking me into CC.

I guess you refer this post:

   https://github.com/sphinx-doc/sphinx/issues/7421#issuecomment-609830660

What I know is: The Sphinx >= v3.0 includes a "C, initial
rewrite" which is not downward compatible.

  https://github.com/sphinx-doc/sphinx/commit/0f49e30c#diff-59e33b0

---

To give an short answer to opener's question:

Our Sphinx-build is not Sphinx >= v3.0 ready.  We recommend
to follow our installation instructions [1] and install
requirements by::

   (virtualenv) $ pip install -r Documentation/sphinx/requirements.txt

In the requirements.txt we stick Sphinx at 'Sphinx==2.4.4'.
In my personal opinion there are more problems than just the
C-domain when using other Sphinx Versions (e.g. PDF is most
often problematic).

[1] https://www.kernel.org/doc/html/latest/doc-guide/sphinx.html#sphinx-install

---

I can't say if this *rewrite* has a better "handle
function-like macros" or not.

Since the changes are not downward compatible,
Documentation/sphinx/cdomain.py needs a rewrite
(Unfortunately, I hadn't had the time to do this).

TL;DR;

In my linuxdoc [2] project I use the same cdomain.py
implementation and split cdomain into v2 and v3 [3].  ATM
linuxdoc/cdomainv3.py is just a skeleton which is used in
Sphinx >= v3.0 installations.  My experience is, that it
spits out more noise, but I haven't had time to look closer
right now.

[2] https://return42.github.io/linuxdoc
[3] https://github.com/return42/linuxdoc/commit/70673dc


   -- Markus --
