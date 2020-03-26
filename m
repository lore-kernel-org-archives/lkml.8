Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4065C2D0E5
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 11:30:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EAFA2070A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 11:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbgCZLaI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 07:30:08 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36112 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728021AbgCZLaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 07:30:08 -0400
Received: from mail-pg1-f199.google.com ([209.85.215.199])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jHQi5-0000jE-HK
        for linux-kernel@vger.kernel.org; Thu, 26 Mar 2020 11:30:05 +0000
Received: by mail-pg1-f199.google.com with SMTP id z29so4458656pgc.23
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 04:30:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=HALfYwFfeY5UrbJ7xe/bm/b+wfD4jWuw8RPBvgJnNt8=;
        b=KyisNW0ZYy8LHlgHBCkk6vZSANLiIwbNWJ3cJwqEYmsRkfPzyXLqs0zU60M5RDlYVF
         u8thtcCvrBs5KeFHRKj6wk0DCGZuso2YqLCEMjGLhrRB4VsRmvt+wHBrMAS3xKG2YcLY
         VUf6Vwr3RslGRxV+yNmLcneiG9Xu9bSgKnsNXcBo/kokaAiLCHBr+bxJYda8uOSnpL5J
         lz6kyXm+QUjX8w/gTzJ72cRGLJlpTmLiJCUWpXl2U5KoLCtahqSzfuZKC+w6AtTojD9h
         e+2MzOER9E5nGI7PBm6TDyVq6pUbaPKJaDJ94JZEgbNNNUpvi6DsMhlmJuLJLMTaFe84
         gIhg==
X-Gm-Message-State: ANhLgQ1zaPSQyajlby4aRTCKTcDhrE91xFMBOwA/QEQuwlFWdzNM1QKr
        3DwqDV/rWS/VKf9MKKGdiMySlyJ6KKAFNnZzX2GIippVwpl19kjoveoWYQsubWDcqSrPu99aqNJ
        xDOcrkS/PFhKi9rjX/xsG6ZoQHe6Gtv4h9Pd9EE3kyQ==
X-Received: by 2002:a17:90a:d081:: with SMTP id k1mr2764267pju.57.1585222203902;
        Thu, 26 Mar 2020 04:30:03 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuS+bLH90tlYwet5AJzyUoCGHkWCs9CDSvMU1YuamVJeArEPTfM7EKmXOeR4nlxgDj09iQpzg==
X-Received: by 2002:a17:90a:d081:: with SMTP id k1mr2764220pju.57.1585222203472;
        Thu, 26 Mar 2020 04:30:03 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id y131sm1454645pfb.78.2020.03.26.04.30.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Mar 2020 04:30:03 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Re: [Intel-wired-lan] [PATCH] e1000e: bump up timeout to wait when ME
 un-configure ULP mode
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <f9dc1980-fa8b-7df9-6460-b0944c7ebc43@molgen.mpg.de>
Date:   Thu, 26 Mar 2020 19:29:59 +0800
Cc:     Sasha Neftin <sasha.neftin@intel.com>,
        Aaron Ma <aaron.ma@canonical.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        David Miller <davem@davemloft.net>,
        Rex Tsai <rex.tsai@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <60A8493D-811B-4AD5-A8D3-82054B562A8C@canonical.com>
References: <20200323191639.48826-1-aaron.ma@canonical.com>
 <EC4F7F0B-90F8-4325-B170-84C65D8BBBB8@canonical.com>
 <2c765c59-556e-266b-4d0d-a4602db94476@intel.com>
 <899895bc-fb88-a97d-a629-b514ceda296d@canonical.com>
 <750ad0ad-816a-5896-de2f-7e034d2a2508@intel.com>
 <f9dc1980-fa8b-7df9-6460-b0944c7ebc43@molgen.mpg.de>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

> On Mar 25, 2020, at 23:49, Paul Menzel <pmenzel@molgen.mpg.de> wrote:
> 
> Dear Linux folks,
> 
> 
> Am 25.03.20 um 14:58 schrieb Neftin, Sasha:
>> On 3/25/2020 08:43, Aaron Ma wrote:
> 
>>> On 3/25/20 2:36 PM, Neftin, Sasha wrote:
>>>> On 3/25/2020 06:17, Kai-Heng Feng wrote:
> 
>>>>>> On Mar 24, 2020, at 03:16, Aaron Ma <aaron.ma@canonical.com> wrote:
>>>>>> 
>>>>>> ME takes 2+ seconds to un-configure ULP mode done after resume
>>>>>> from s2idle on some ThinkPad laptops.
>>>>>> Without enough wait, reset and re-init will fail with error.
>>>>> 
>>>>> Thanks, this patch solves the issue. We can drop the DMI quirk in
>>>>> favor of this patch.
>>>>> 
>>>>>> Fixes: f15bb6dde738cc8fa0 ("e1000e: Add support for S0ix")
>>>>>> BugLink: https://bugs.launchpad.net/bugs/1865570
>>>>>> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
>>>>>> ---
>>>>>> drivers/net/ethernet/intel/e1000e/ich8lan.c | 4 ++--
>>>>>> 1 file changed, 2 insertions(+), 2 deletions(-)
>>>>>> 
>>>>>> diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c
>>>>>> b/drivers/net/ethernet/intel/e1000e/ich8lan.c
>>>>>> index b4135c50e905..147b15a2f8b3 100644
>>>>>> --- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
>>>>>> +++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
>>>>>> @@ -1240,9 +1240,9 @@ static s32 e1000_disable_ulp_lpt_lp(struct
>>>>>> e1000_hw *hw, bool force)
>>>>>>              ew32(H2ME, mac_reg);
>>>>>>          }
>>>>>> 
>>>>>> -        /* Poll up to 300msec for ME to clear ULP_CFG_DONE. */
>>>>>> +        /* Poll up to 2.5sec for ME to clear ULP_CFG_DONE. */
>>>>>>          while (er32(FWSM) & E1000_FWSM_ULP_CFG_DONE) {
>>>>>> -            if (i++ == 30) {
>>>>>> +            if (i++ == 250) {
>>>>>>                  ret_val = -E1000_ERR_PHY;
>>>>>>                  goto out;
>>>>>>              }
>>>>> 
>>>>> The return value was not caught by the caller, so the error ends up
>>>>> unnoticed.
>>>>> Maybe let the caller check the return value of
>>>>> e1000_disable_ulp_lpt_lp()?
> 
>>>> I a bit confused. In our previous conversation you told ME not running.
>>>> let me shimming in. Increasing delay won't be solve the problem and just
>>>> mask it. We need to understand why ME take too much time. What is
>>>> problem with this specific system?
>>>> So, basically no ME system should works for you.
>>> 
>>> Some laptops ME work that's why only reproduce issue on some laptops.
>>> In this issue i219 is controlled by ME.
>> 
>> Who can explain - why ME required too much time on this system?
>> Probably need work with ME/BIOS vendor and understand it.
>> Delay will just mask the real problem - we need to find root cause.
>>> Quirk is only for 1 model type. But issue is reproduced by more models.
>>> So it won't work.
> 
> (Where is Aaron’s reply? It wasn’t delivered to me yet.)
> 
> As this is clearly a regression, please revert the commit for now, and then find a way to correctly implement S0ix support. Linux’ regression policy demands that as no fix has been found since v5.5-rc1. Changing Intel ME settings, even if it would work around the issue, is not an acceptable solution. Delaying the resume time is also not a solution.

The s0ix patch can reduce power consumption, finally makes S2idle an acceptable sleep method.
So I'd say it's a fix, albeit a regression was introduced.

> 
> Regarding Intel Management Engine, only Intel knows what it does and what the error is, as the ME firmware is proprietary and closed.
> 
> Lastly, there is no way to fully disable the Intel Management Engine. The HAP stuff claims to stop the Intel ME execution, but nobody knows, if it’s successful.
> 
> Aaron, Kai-Hang, can you send the revert?

I consider that as an important fix for s2idle, I don't think reverting is appropriate.

Kai-Heng

> 
> 
> Kind regards,
> 
> Paul
> 
> 

