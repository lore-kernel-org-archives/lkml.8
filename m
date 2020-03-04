Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372E9C3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 06:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AA4A20665
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 06:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgCDGUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 01:20:54 -0500
Received: from smtp2.goneo.de ([85.220.129.33]:51520 "EHLO smtp2.goneo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725271AbgCDGUx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 01:20:53 -0500
Received: from localhost (localhost [127.0.0.1])
        by smtp2.goneo.de (Postfix) with ESMTP id 4672B23F498;
        Wed,  4 Mar 2020 07:20:50 +0100 (CET)
X-Virus-Scanned: by goneo
Received: from smtp2.goneo.de ([127.0.0.1])
        by localhost (smtp2.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zEuSR6mKl8G7; Wed,  4 Mar 2020 07:20:49 +0100 (CET)
Received: from [192.168.1.127] (dyndsl-091-096-162-220.ewe-ip-backbone.de [91.96.162.220])
        by smtp2.goneo.de (Postfix) with ESMTPSA id 0F9C623F488;
        Wed,  4 Mar 2020 07:20:49 +0100 (CET)
Subject: Re: [PATCH] scripts/sphinx-pre-install: add '-p python3' to
 virtualenv
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Bird, Tim" <Tim.Bird@sony.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "tbird20d@gmail.com" <tbird20d@gmail.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1582594481-23221-1-git-send-email-tim.bird@sony.com>
 <20200302130911.05a7e465@lwn.net>
 <MWHPR13MB0895EFDA9EBF7740875E661CFDE40@MWHPR13MB0895.namprd13.prod.outlook.com>
 <20200304064214.64341a49@onda.lan>
From:   Markus Heiser <markus.heiser@darmarit.de>
Message-ID: <31a69fe7-c08d-9381-a111-5f522a4c9ffd@darmarit.de>
Date:   Wed, 4 Mar 2020 07:20:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200304064214.64341a49@onda.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 04.03.20 um 06:42 schrieb Mauro Carvalho Chehab:
> Em Tue, 3 Mar 2020 17:07:48 +0000
> "Bird, Tim" <Tim.Bird@sony.com> escreveu:
> 
>>> -----Original Message-----
>>> From: Jonathan Corbet <corbet@lwn.net>
>>>
>>> On Mon, 24 Feb 2020 18:34:41 -0700
>>> tbird20d@gmail.com wrote:
>>>    
>>>> With Ubuntu 16.04 (and presumably Debian distros of the same age),
>>>> the instructions for setting up a python virtual environment should
>>>> do so with the python 3 interpreter.  On these older distros, the
>>>> default python (and virtualenv command) might be python2 based.
>>>>
>>>> Some of the packages that sphinx relies on are now only available
>>>> for python3.  If you don't specify the python3 interpreter for
>>>> the virtualenv, you get errors when doing the pip installs for
>>>> various packages
>>>>
>>>> Fix this by adding '-p python3' to the virtualenv recommendation
>>>> line.
>>>>
>>>> Signed-off-by: Tim Bird <tim.bird@sony.com>
>>>
>>> I've applied this, even though it feels a bit fragile to me.  But Python
>>> stuff can be a bit that way, sometimes, I guess.
>>
>> I agree it seems a bit wonky.
> 
> Well, we could, instead, add some code that would be checking python and pip
> versions, but still distros could be doing some backports with could
> cause side-effects. So, checking for distro versions as done in this patch
> seems a lot safer.
> 
>> The less fragile approach would have been to just
>> always add the '-p python3' option to the virtualenv setup hint,
>> but Mauro seemed to want something more fine-tuned.
> 
> Yeah, I asked for a more fine-tuned version.
> 
> Depending on python/pip version, adding a -p python3 seems to cause
> troubles (at least I found some bug reports about that). I may be
> wrong (it was a long time ago), but, before adding the logic that checks
> for "python3" I guess I tried first add -p python3, but, back then,
> I found some troubles (probably with some old Fedora version).
> 
> So, better to use this syntax only on distros we know it will
> work as expected.
> 
>> As far as the string parsing goes, I think that the format of strings
>> returned by lsb-release (and the predecesors that sphinx_pre_install
>> checks) is unlikely to change.
> 
> Since when we added this script, we didn't have any troubles yet with
> the part of the code with checks the distribution version. So, I guess
> that the lsb-release related checks are pretty much reliable.
> 

With py3 the recommended way to install virtual environments is::

   python3 -m venv sphinx-env

This (python3) is what worked for me on RHEL/CentOS (dnf),
archlinux and debian/ubuntu (tested from 16.04 up to 20.04).

I am not familiar with the sphinx-pre-install script but may be
one of you is able to apply such a patch?


  -- Markus --
