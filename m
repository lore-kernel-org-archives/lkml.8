Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546F8C3F2DA
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 09:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33E2820705
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 09:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729140AbgCDJUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 04:20:40 -0500
Received: from smtp3-1.goneo.de ([85.220.129.38]:57975 "EHLO smtp3-1.goneo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgCDJUj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 04:20:39 -0500
Received: from localhost (localhost [127.0.0.1])
        by smtp3.goneo.de (Postfix) with ESMTP id 2CC2423F604;
        Wed,  4 Mar 2020 10:20:37 +0100 (CET)
X-Virus-Scanned: by goneo
Received: from smtp3.goneo.de ([127.0.0.1])
        by localhost (smtp3.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id EgvGAP8NJ19H; Wed,  4 Mar 2020 10:20:35 +0100 (CET)
Received: from [192.168.1.127] (dyndsl-091-096-162-220.ewe-ip-backbone.de [91.96.162.220])
        by smtp3.goneo.de (Postfix) with ESMTPSA id 24A4523F935;
        Wed,  4 Mar 2020 10:20:35 +0100 (CET)
Subject: Re: [PATCH] scripts/sphinx-pre-install: add '-p python3' to
 virtualenv
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     "Bird, Tim" <Tim.Bird@sony.com>, Jonathan Corbet <corbet@lwn.net>,
        "tbird20d@gmail.com" <tbird20d@gmail.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1582594481-23221-1-git-send-email-tim.bird@sony.com>
 <20200302130911.05a7e465@lwn.net>
 <MWHPR13MB0895EFDA9EBF7740875E661CFDE40@MWHPR13MB0895.namprd13.prod.outlook.com>
 <20200304064214.64341a49@onda.lan>
 <31a69fe7-c08d-9381-a111-5f522a4c9ffd@darmarit.de>
 <20200304093138.6aced5a0@coco.lan>
From:   Markus Heiser <markus.heiser@darmarit.de>
Message-ID: <c491adf3-ae49-fefc-ea6d-32b75f4f9ca9@darmarit.de>
Date:   Wed, 4 Mar 2020 10:20:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200304093138.6aced5a0@coco.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 04.03.20 um 09:31 schrieb Mauro Carvalho Chehab:
> Em Wed, 4 Mar 2020 07:20:48 +0100
> Markus Heiser <markus.heiser@darmarit.de> escreveu:
>> With py3 the recommended way to install virtual environments is::
>>
>>     python3 -m venv sphinx-env
>>
>> This (python3) is what worked for me on RHEL/CentOS (dnf),
>> archlinux and debian/ubuntu (tested from 16.04 up to 20.04).
> 
> Hmm... from:
> 
> 	https://packaging.python.org/guides/installing-using-pip-and-virtual-environments/
> 
> This works since Python version 3.3. It sounds doable to use it.
> 
> Yet, if we'll be switching to this method, the script should check if
> the version is 3.3 or newer. The logic inside get_sphinx_fname() would
> also require some changes, as it won't need to install anymore the
> virtualenv program for Python >= 3.3.

I guess you can ignore 3.2 and downwards

   https://en.wikipedia.org/wiki/History_of_Python#Table_of_versions

Support for py2.7 and >=py3.3 should match nearly all use cases / distributions 
we support.

BTW: starting scripts with:

-m <module-name>
     Searches sys.path for the named module and runs the
     corresponding .py file as a script.

is mostly more robust.  The option exists also in py2.  From py3.3 on
a subset of virtualenv is built-in, so you can run '-m venv' ot of the
box.

   -- Markus --
