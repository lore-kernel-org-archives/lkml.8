Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F77BC38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 10:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7E5D2083B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 10:00:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gPi+BOYY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbgEGKAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 06:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726744AbgEGKAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 06:00:16 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0F7C061A10;
        Thu,  7 May 2020 03:00:16 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id 7so3669717pjo.0;
        Thu, 07 May 2020 03:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=r9BrKcJnvJmQnTdOvCUMZHeGW+d+Z7GzgcJoLMueHRI=;
        b=gPi+BOYYO7BXDrePnM7PlUZwlz4m22UGrS+9znZ0xgz4zX18sdWTjhgBTJK0MW6LXC
         GT8U8Ud8SvFM5MkzPmfaFAewKtOvt8fGBol/xbrs7h+k2A5bIyMQu9wyf6O1L4hNrxaf
         EcjoyENpgAbT/OjIhY5AFD47MsD8q+17fShhKbrPVehida8mQ8AcGJzjvWEZ4WWqL77y
         AFwKDv9Xpr+/dK4AxptK9iDLtj38sD70MiSbRiMgRIKhuCXnIqpju5lLEllQghVRs2W6
         IWW5ny8SZC2oXq7rI1ocXAvCi9s/hu+/xZ4ekmkz3kepqdJX9XnQ72t3wWV5NZ3hHI8Q
         nMLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=r9BrKcJnvJmQnTdOvCUMZHeGW+d+Z7GzgcJoLMueHRI=;
        b=glncX1Ie7V4HLSzbGBy3y4v9EcNK7G2Ht2dKW2E5QbqWo1M2f7EHBrczZCd9Qlyxpr
         vGw8zibzu4+PUknqamHnYt8uclpdXkzy9Q1xCeoftqcbaDj7YUQIHUTPvzaW0blo+L7M
         oAohGDCamhDFIr+TqWKGNr+6QRKt0ODSposdJMnuyVs2s1PdfJuLtGbacQJ6jALwyKBQ
         ywd0oSdCyrNnpd0R1Jcpjz0a0YcikRXPxE9mcOCFfgco1sO95dX7unMC5dlCC9EfpcmV
         guU9kF404Z0ZoXhW2ynFMG3fBMjY6aIlrORvprvGBYJNXDvAyoNU4JEOwmXGcG3AZ8pU
         jAUQ==
X-Gm-Message-State: AGi0Pubs4DrMekCtH1Ba7Cfv2E6Ckw+3wPMl3P079qtofUtuQhWX/WbC
        p7ESc3nPXWoRCQgTTKNLSZklIAmEzfg=
X-Google-Smtp-Source: APiQypJ/p27A3ApFLRTZbrZlwZ4OXNzXy/CNfPKjawprFoghQynBgR10A+xaiCvgerQ3+rqW5sdUiA==
X-Received: by 2002:a17:902:c203:: with SMTP id 3mr13153122pll.242.1588845615538;
        Thu, 07 May 2020 03:00:15 -0700 (PDT)
Received: from [192.168.1.7] ([120.244.109.48])
        by smtp.gmail.com with ESMTPSA id p190sm4450528pfp.207.2020.05.07.03.00.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 May 2020 03:00:14 -0700 (PDT)
Subject: Re: [PATCH] media: usb: ttusb-dec: avoid buffer overflow in
 ttusb_dec_handle_irq() when DMA failures/attacks occur
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     mchehab@kernel.org, kstewart@linuxfoundation.org,
        tomasbortoli@gmail.com, sean@mess.org, allison@lohutok.net,
        tglx@linutronix.de, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200505142110.7620-1-baijiaju1990@gmail.com>
 <20200505181042.GD1199718@kroah.com>
 <0e4a86ee-8c4e-4ac3-8499-4e9a6ed7bd1e@gmail.com>
 <20200506110722.GA2975410@kroah.com>
 <b3af10e3-8709-3da0-6841-e5ddd6b4a609@gmail.com>
 <20200506155257.GB3537174@kroah.com>
 <46615f6e-11ec-6546-42a9-3490414f9550@gmail.com>
 <20200506174345.GA3711921@kroah.com>
 <4bc70ec6-e518-5f42-b336-c86e1f92619f@gmail.com>
 <20200507075237.GA1024567@kroah.com>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <e7233d0f-d21f-5b4c-cc77-e71eff1e8a47@gmail.com>
Date:   Thu, 7 May 2020 17:59:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200507075237.GA1024567@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/5/7 15:52, Greg KH wrote:
> On Thu, May 07, 2020 at 01:15:22PM +0800, Jia-Ju Bai wrote:
>> At present, I only detect the cases that a DMA value *directly* taints array
>> index, loop condition and important kernel-interface calls (such as
>> request_irq()).
>> In this one driver, I only find two problems that mentioned in this patch.
>> With the kernel configuration "allyesconfig" in my x86_64 machine, I find
>> nearly 200 such problems (intra-procedurally and inter-procedurally) in all
>> the compiled device drivers.
>>
>> I also find that several drivers check the data from DMA memory, but some of
>> these checks can be bypassed.
>> Here is an example in drivers/scsi/esas2r/esas2r_vda.c:
>>
>> The function esas2r_read_vda() uses a DMA value "vi":
>>    struct atto_ioctl_vda *vi =
>>              (struct atto_ioctl_vda *)a->vda_buffer;
>>
>> Then esas2r_read_vda() calls esas2r_process_vda_ioctl() with vi:
>>    esas2r_process_vda_ioctl(a, vi, rq, &sgc);
>>
>> In esas2r_process_vda_ioctl(), the DMA value "vi->function" is
>> used at many places, such as:
>>    if (vi->function >= vercnt)
>>    ...
>>    if (vi->version > esas2r_vdaioctl_versions[vi->function])
>>    ...
>>
>> However, when DMA failures or attacks occur, the value of vi->function can
>> be changed at any time. In this case, vi->function can be first smaller than
>> vercnt, and then it can be larger than vercnt when it is used as the array
>> index of esas2r_vdaioctl_versions, causing a buffer-overflow vulnerability.
>>
>> I also submitted this patch, but no one has replied yet:
>> https://lore.kernel.org/lkml/20200504172412.25985-1-baijiaju1990@gmail.com/
> It's only been a few days, give them time.
>
> But, as with this patch, you might want to change your approach.  Having
> the changelog say "this is a security problem!" really isn't that "real"
> as the threat model is very obscure at this point in time.
>
> Just say something like I referenced here, "read the value from memory
> and test it and use that value instead of constantly reading from memory
> each time in case it changes" is nicer and more realistic.  It's a
> poential optimization as well, if the complier didn't already do it for
> us automatically (which you really should look into...)

Okay, I used objdump to generate the assembly code of ttusb_dec.o 
(ttusb_dec.c is compiled with -O2).
I found the following possible operations for "buffer[4] - 1" in the 
assembly code:
    ......
    movsbl   0x4(%rbp), %r15d
    lea          -0x1(%r15), %r13d
    cmp        $0x19, %r13d
    .....
    movsbl   0x4(%rbp), %r13d
    sub         $0x1, %r13d
    .....
    movsbl   0x4(%rbp), %ebp
    sub         $0x1, %ebp
    .....

Thus, I guess that the compiler does not optimize these three accesses 
to "buffer[4] - 1".
As you suggested, I will change my log and send a new patch, thanks :)


>
> If you make up a large series of these, I'd be glad to take them through
> one of my trees to try to fix them all up at once, that's usually a
> simpler way to do cross-tree changes like this.
>

Okay, I will organize my found issues, and send them to you.
Thanks :)


Best wishes,
Jia-Ju Bai
