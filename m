Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3383CC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 07:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1863C2184D
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 07:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbgGEHTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 03:19:24 -0400
Received: from mx3.molgen.mpg.de ([141.14.17.11]:36155 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726025AbgGEHTY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 03:19:24 -0400
Received: from [192.168.0.6] (ip5f5af298.dynamic.kabel-deutschland.de [95.90.242.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 32148206442E0;
        Sun,  5 Jul 2020 09:19:21 +0200 (CEST)
Subject: Re: [PATCH v2] .gitignore: Do not track `defconfig` from `make
 savedefconfig`
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200702111200.39997-1-pmenzel@molgen.mpg.de>
 <CAK7LNAR7=NCsJ5irVUCStkfCLt0d=R5AX6cEwc9z=b_-V=-0Ng@mail.gmail.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <59a4efc5-f6cb-f00a-fa83-bc7658ca1463@molgen.mpg.de>
Date:   Sun, 5 Jul 2020 09:19:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAK7LNAR7=NCsJ5irVUCStkfCLt0d=R5AX6cEwc9z=b_-V=-0Ng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Masahiro,


Am 05.07.20 um 09:14 schrieb Masahiro Yamada:
> On Thu, Jul 2, 2020 at 8:12 PM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>>
>> Running `make savedefconfig` creates by default `defconfig`, which is,
>> currently, on git’s radar, for example, `git status` lists this file as
>> untracked.
>>
>> So, add the file to `.gitignore`, so it’s ignored by git.
>>
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>
>> ---
>>   .gitignore | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/.gitignore b/.gitignore
>> index 87b9dd8a163b..f07500889fba 100644
>> --- a/.gitignore
>> +++ b/.gitignore
>> @@ -143,6 +143,9 @@ x509.genkey
>>   /allrandom.config
>>   /allyes.config
>>
>> +# Kconfig presets, default savedefconfg output
> 
> 
> I just noticed this comment is wrong
> since 'defconfig' is not a preset.
> 
> I will change it to 'Kconfig savedefconfig output'.

Thank you for finding my error and correcting it.

I couldn’t find out more about *presets*.

     $ git grep -i preset scripts/kconfig/
     $

Where can I look, so I won’t repeat the same mistake next time?

>> +/defconfig
>> +
>>   # Kdevelop4
>>   *.kdev4
>>
>> --
>> 2.27.0

Kind regards,

Paul
