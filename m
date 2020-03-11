Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C196C0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 21:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 618FC2074C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 21:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MQGWctOa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729483AbgCKVZl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 17:25:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33637 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729102AbgCKVZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 17:25:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583961939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IjfIPBthPl8u65C2XDaDaETsD9HwFlq+W0NT+KQRiNc=;
        b=MQGWctOaWUM3/ovyb/NRqtLUyEEzNtaUbn98dVdssvwQkztldQLKb3MArPXkIjQ9/qNw+p
        CkdQvSK8d9Ssc6TJUcY/OBY+LBPytKg8cDBp6hCRz/FcmkKaxk4zoWvjKsKwjh4G2GU1Fw
        iQ2dMR5AFM7YOIsDG1YDSvAfv2AOn5Q=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-186-9covld2_PmyP2ZQoNDKetw-1; Wed, 11 Mar 2020 17:25:35 -0400
X-MC-Unique: 9covld2_PmyP2ZQoNDKetw-1
Received: by mail-wm1-f69.google.com with SMTP id s20so536577wmj.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 14:25:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IjfIPBthPl8u65C2XDaDaETsD9HwFlq+W0NT+KQRiNc=;
        b=DleFUjdPn3ZAEjZ0P/Bv/g3Gs9lrqonv9J4ZwvH9A7gqLq9v3IHvw0w59GFvTRqYmr
         uYEXSlKVQSNuBCQoV+cunHeS4PQA4NQPyx6RIepTti8ylWou4ney7YaXouC7XvUHzvYF
         1OlkjPiQVpEgO+/RHHX7twnzJm3daMxLP2DHnqcnDCTUENrNPl3aVsDWBhhtKXkxsNhB
         DrfY1Gg8KHwCwpo72ZAGjSm2m7bd0V1CohCueHfColmxqb3bQpp98SS/p3/Jh9q5lGVS
         AlQwo6M940awy1XxGjuP9AUBGaYHCFIoJGFs1YKF7G1qOm8SkVj2inek+gsZ40kMndvv
         vIOg==
X-Gm-Message-State: ANhLgQ3RDtGPaNbzL9Uc5nhHg2J8X/ZXtg7twaIlwWkUkccNO1QmxsMH
        4MmFbOoXB8WTK8+eROc22U21ITt1DppDGtmbBdSUeW6EYvs7+lkUMEzI/AyZ0NiD+SjCi+Bf1/y
        4RY5WmA5YD5E+jAA0NScDF/Jz
X-Received: by 2002:a5d:420c:: with SMTP id n12mr6433059wrq.173.1583961933542;
        Wed, 11 Mar 2020 14:25:33 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuhcZpxl+Rv9fxaoaW66vMAwPmm6H7sPYDLITq3Y6Dnqf9sIeOWwVEoWbfjnEziA6KhGk9QCA==
X-Received: by 2002:a5d:420c:: with SMTP id n12mr6433040wrq.173.1583961933335;
        Wed, 11 Mar 2020 14:25:33 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
        by smtp.gmail.com with ESMTPSA id f207sm10601024wme.9.2020.03.11.14.25.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 14:25:32 -0700 (PDT)
Subject: Re: [PATCH resend] x86/purgatory: Make sure we fail the build if
 purgatory.ro has missing symbols
To:     Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@alien8.de>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20200221165941.508653-1-hdegoede@redhat.com>
 <202003010150.eyjF3gp0%lkp@intel.com>
 <b9a34773-ab38-a3c7-3e35-7da95dc625f4@redhat.com>
 <20200311204813.GM3470@zn.tnic> <20200311212000.GA4022430@rani.riverdale.lan>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <33a87683-8944-72f7-2c86-aa9b3c0ed64b@redhat.com>
Date:   Wed, 11 Mar 2020 22:25:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200311212000.GA4022430@rani.riverdale.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI,

On 3/11/20 10:20 PM, Arvind Sankar wrote:
> On Wed, Mar 11, 2020 at 09:49:54PM +0100, Borislav Petkov wrote:
>> On Sat, Feb 29, 2020 at 07:12:57PM +0100, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 2/29/20 6:16 PM, kbuild test robot wrote:
>>>> Hi Hans,
>>>>
>>>> I love your patch! Yet something to improve:
>>>>
>>>> [auto build test ERROR on tip/x86/core]
>>>> [also build test ERROR on v5.6-rc3 next-20200228]
>>>> [cannot apply to tip/auto-latest]
>>>> [if your patch is applied to the wrong git tree, please drop us a note to help
>>>> improve the system. BTW, we also suggest to use '--base' option to specify the
>>>> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>>>>
>>>> url:    https://github.com/0day-ci/linux/commits/Hans-de-Goede/x86-purgatory-Make-sure-we-fail-the-build-if-purgatory-ro-has-missing-symbols/20200223-040035
>>>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 248ed51048c40d36728e70914e38bffd7821da57
>>>> config: x86_64-randconfig-s1-20200229 (attached as .config)
>>>> compiler: gcc-4.9 (Debian 4.9.2-10+deb8u1) 4.9.2
>>>> reproduce:
>>>>           # save the attached .config to linux build tree
>>>>           make ARCH=x86_64
>>>>
>>>> If you fix the issue, kindly add following tag
>>>> Reported-by: kbuild test robot <lkp@intel.com>
>>>>
>>>> All errors (new ones prefixed by >>):
>>>>
>>>>      ld: arch/x86/purgatory/purgatory.ro: in function `kstrtoull':
>>>>>> (.text+0x2b0e): undefined reference to `ftrace_likely_update'
>>>
>>> AFAICT this is the patch working as intended and pointing out an actual issue
>>> with the purgatory code. Which shows that we really should get this
>>> patch merged...
>>
>> ... and break the build? I don't think so.
>>
>> I know, it would fail silently now but I don't recall anyone complaining
>> about it. So it was a don't care so far.
>>
>> IOW, first this ftrace_likely_update thing needs to be sorted out and
>> then this merged.
>>
>> Thx.
>>
>> -- 
>> Regards/Gruss,
>>      Boris.
>>
>> https://people.kernel.org/tglx/notes-about-netiquette
> 
> Hans, I think adding -DDISABLE_BRANCH_PROFILING to PURGATORY_CFLAGS
> might fix this.

Yes I was just looking into doing that myself, I agree that that
should fix this. I will mail out a new patch-series with that as
preparation patch soon.

Regards,

Hans

