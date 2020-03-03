Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA154C3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 16:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81D392073D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 16:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0oFKzzS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730175AbgCCQMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 11:12:06 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:33705 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728714AbgCCQMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 11:12:06 -0500
Received: by mail-yw1-f67.google.com with SMTP id j186so3879092ywe.0;
        Tue, 03 Mar 2020 08:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9eh6lszkeCBFBrzn1n/zGlKp8TJzbq4QmrWCYSghREo=;
        b=Y0oFKzzSc1nc8EEpUc959fsNttLh4PDgkd4P07j3pazdOzGf5/UPGVKv4OPzL33gZ/
         4j5Kc9ngKfMH7K/Ty+0La0bsZimQxy0Y8NBQF8HdtgM2NVonUSpeY3oKt7xj9q0fMaWC
         JCAvfKDQJaZHIZSTGkhJaTN+vGQ+7P+oI8wzqvXCacyM0IPgK3KJiRhSbCdiR5125Eue
         6gbxXpw/6wz2wE61lq5LkO/sLKwBwB7kKK5eYToXEgxfJ+SzsQnYueLZKqslsypZnTx6
         7Geu8tPbLI/SvXDatHNMziqgrVm9IhMWV8d9BThzuVw/y+YRDBn7sGGVSZN88cspMLT6
         q+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9eh6lszkeCBFBrzn1n/zGlKp8TJzbq4QmrWCYSghREo=;
        b=eBPKwed2W25cIK4x4pk1QFYQkAUd3/6BG/rk/IYWHs6DTCPUIFfeh71r7Xu6BfYCy2
         r4OnuApfG8t62OLMzEF2tMybvOs0xlwV+INFIHqa8A95Do9xyYTvYARwUL8W5etmvJxJ
         Bs/PrlrlrRRhFk5XZEeE6DFPPuog4tK1jfNjhpTtaFtgv7Axh26dvoh+kiyXXX69Lo3S
         uQhdzUqJTpg6OD1Frgp1U4khQzWyHF1dt9ETf3zCslUYxdRB1kMz/DhdRS0DZhcGqK8Q
         NGDqZyUjnmBI6GSzJirw2An5Jrwb56K3pB81N4n+7Wh750/go26bm/du9QPCzChz7wA5
         IUZg==
X-Gm-Message-State: ANhLgQ3v1mYg/4q6W+72pBAs5w+BH6MMdnzz9xgtkHm2Gn/Uq8cIfOpZ
        vM8APqhCdrfB+k1EHlb7e48=
X-Google-Smtp-Source: ADFU+vsrItRuClqVuhTf2p+WIfR263od0YmdikXPzIh6Ux5um/AZOGZw1D297aIg/nuvC94YjKpMZQ==
X-Received: by 2002:a81:67c2:: with SMTP id b185mr5409082ywc.250.1583251925142;
        Tue, 03 Mar 2020 08:12:05 -0800 (PST)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id v133sm9374025ywb.86.2020.03.03.08.12.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Mar 2020 08:12:04 -0800 (PST)
Subject: Re: [PATCH v1 1/1] scripts: dtc: mask flags bit when check i2c addr
To:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>
References: <20200228084842.18691-1-rayagonda.kokatanur@broadcom.com>
 <CAL_JsqLXvVnVq0Mc1d0WMLNjURbHe9T3bKNb+5D6Nz3iyTK8GA@mail.gmail.com>
 <CAHO=5PFuercRYBzupd-Zb3q8v3sQWGT2ySXodG9S5NVj7Ta+1Q@mail.gmail.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <ca5e269e-9b30-4206-45a4-9a2d9f0f4fef@gmail.com>
Date:   Tue, 3 Mar 2020 10:12:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAHO=5PFuercRYBzupd-Zb3q8v3sQWGT2ySXodG9S5NVj7Ta+1Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/20 10:56 PM, Rayagonda Kokatanur wrote:
> On Fri, Feb 28, 2020 at 7:20 PM Rob Herring <robh+dt@kernel.org> wrote:
>>
>> On Fri, Feb 28, 2020 at 2:48 AM Rayagonda Kokatanur
>> <rayagonda.kokatanur@broadcom.com> wrote:
>>>
>>> Generally i2c addr should not be greater than 10-bit. The highest 2 bits
>>> are used for I2C_TEN_BIT_ADDRESS and I2C_OWN_SLAVE_ADDRESS. Need to mask
>>> these flags if check slave addr valid.
>>>
>>> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
>>> ---
>>>  scripts/dtc/Makefile | 2 +-
>>>  scripts/dtc/checks.c | 5 +++++
>>>  2 files changed, 6 insertions(+), 1 deletion(-)
>>
>> dtc changes must be submitted against upstream dtc.
> 
> Please let me know link to clone the upstream dtc branch.

Info about the dtc upstream project:

   https://elinux.org/Device_Tree_Reference#dtc_.28upstream_project.29

And the mail list to submit the patch to:

   https://elinux.org/Device_Tree_Reference#Device-tree_Compiler_and_Tools_Mailing_List

-Frank

>>
>>
>>> diff --git a/scripts/dtc/Makefile b/scripts/dtc/Makefile
>>> index 3acbb410904c..c5e8d6a9e73c 100644
>>> --- a/scripts/dtc/Makefile
>>> +++ b/scripts/dtc/Makefile
>>> @@ -9,7 +9,7 @@ dtc-objs        := dtc.o flattree.o fstree.o data.o livetree.o treesource.o \
>>>  dtc-objs       += dtc-lexer.lex.o dtc-parser.tab.o
>>>
>>>  # Source files need to get at the userspace version of libfdt_env.h to compile
>>> -HOST_EXTRACFLAGS := -I $(srctree)/$(src)/libfdt
>>> +HOST_EXTRACFLAGS := -I $(srctree)/$(src)/libfdt -I$(srctree)/tools/include
>>>
>>>  ifeq ($(shell pkg-config --exists yaml-0.1 2>/dev/null && echo yes),)
>>>  ifneq ($(CHECK_DTBS),)
>>> diff --git a/scripts/dtc/checks.c b/scripts/dtc/checks.c
>>> index 756f0fa9203f..17c9ed4137b5 100644
>>> --- a/scripts/dtc/checks.c
>>> +++ b/scripts/dtc/checks.c
>>> @@ -3,6 +3,7 @@
>>>   * (C) Copyright David Gibson <dwg@au1.ibm.com>, IBM Corporation.  2007.
>>>   */
>>>
>>> +#include <linux/bits.h>
>>
>> Not a UAPI header not that that would be much better as dtc also builds on Mac.
>>
>>>  #include "dtc.h"
>>>  #include "srcpos.h"
>>>
>>> @@ -17,6 +18,9 @@
>>>  #define TRACE(c, fmt, ...)     do { } while (0)
>>>  #endif
>>>
>>> +#define I2C_TEN_BIT_ADDRESS    BIT(31)
>>> +#define I2C_OWN_SLAVE_ADDRESS  BIT(30)
>>> +
>>>  enum checkstatus {
>>>         UNCHECKED = 0,
>>>         PREREQ,
>>> @@ -1048,6 +1052,7 @@ static void check_i2c_bus_reg(struct check *c, struct dt_info *dti, struct node
>>>
>>>         for (len = prop->val.len; len > 0; len -= 4) {
>>>                 reg = fdt32_to_cpu(*(cells++));
>>> +               reg &= ~(I2C_OWN_SLAVE_ADDRESS | I2C_TEN_BIT_ADDRESS);
>>
>> I'd just mask the top byte so we don't have to update on the next flag we add.
> Do you mean something like this, shown below ?
> reg &= 0xFFFF_FC000;
> 
>>
>> Rob
> 

