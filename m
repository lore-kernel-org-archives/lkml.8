Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B56C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 18:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31FBF20657
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 18:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726634AbgHRSPd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 14:15:33 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:11798 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726435AbgHRSPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 14:15:31 -0400
Subject: Re: Scheduler benchmarks
To:     Muni Sekhar <munisekharrms@gmail.com>, Greg KH <greg@kroah.com>
CC:     kernelnewbies <kernelnewbies@kernelnewbies.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
References: <CAHhAz+inPwKYx_4qaujQ=bGG9twashiuqLhQQ-+vgHWF7FLhRA@mail.gmail.com>
 <20200818143633.GA628293@kroah.com>
 <CAHhAz+hG5kS5rhph4SaSLOEc5PgcSOTPWpiANLNpwotY9Zy6qQ@mail.gmail.com>
 <20200818171457.GA736234@kroah.com>
 <CAHhAz+ggd4DPFfWPB+h6Obkjebf5mv5cV6307oKEkEYMhAB3wQ@mail.gmail.com>
 <20200818173656.GA748290@kroah.com>
 <CAHhAz+hi9rh5w8hNyas0RkO4WwZXsSNh5g0nS710NSr6-ntioQ@mail.gmail.com>
From:   peter enderborg <peter.enderborg@sony.com>
Message-ID: <84362b8b-971f-fb89-115d-41d2457c24fd@sony.com>
Date:   Tue, 18 Aug 2020 20:15:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAHhAz+hi9rh5w8hNyas0RkO4WwZXsSNh5g0nS710NSr6-ntioQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Language: en-GB
X-SEG-SpamProfiler-Analysis: v=2.3 cv=frmim2wf c=1 sm=1 tr=0 a=kIrCkORFHx6JeP9rmF/Kww==:117 a=IkcTkHD0fZMA:10 a=y4yBn9ojGxQA:10 a=2C6YHBdLAAAA:8 a=-lEIe7sNZIQA5pNoOQYA:9 a=QEXdDO2ut3YA:10 a=yxGMNg53M24zlVSZdvMH:22
X-SEG-SpamProfiler-Score: 0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/20 7:53 PM, Muni Sekhar wrote:
> On Tue, Aug 18, 2020 at 11:06 PM Greg KH <greg@kroah.com> wrote:
>> On Tue, Aug 18, 2020 at 11:01:35PM +0530, Muni Sekhar wrote:
>>> On Tue, Aug 18, 2020 at 10:44 PM Greg KH <greg@kroah.com> wrote:
>>>> On Tue, Aug 18, 2020 at 10:24:13PM +0530, Muni Sekhar wrote:
>>>>> On Tue, Aug 18, 2020 at 8:06 PM Greg KH <greg@kroah.com> wrote:
>>>>>> On Tue, Aug 18, 2020 at 08:00:11PM +0530, Muni Sekhar wrote:
>>>>>>> Hi all,
>>>>>>>
>>>>>>> I’ve two identical Linux systems with only kernel differences.
>>>>>> What are the differences in the kernels?
>>>> You didn't answer this question, is this the same kernel source being
>>>> compared here?  Same version?  Same compiler?  Everything identical?
>>> Both systems are having exactly the same hardware configuration.
>>> Compiler and kernel versions are different. One system has Ubuntu
>>> 16.04.4 LTS(4.4.0-66-generic kernel with gcc version 5.4.0) kernel and
>>> the other one has Ubuntu 18.04.4 LTS(4.15.0-91-generic kernel with gcc
>>> version 7.5.0).
>> Those are _very_ different kernel versions, with many years and tens of
>> thousands of different changes between them.
>>
>> Hopefully the newer kernel is faster, so just stick with that :)
> But unfortunately the newer kernel is very slow, that is the reason
> for starting this investigation :)
> Any type of help,  and guidelines to dive deeper will be highly appreciated.

On the 4.4 kernel you dont have

+CONFIG_RETPOLINE=y
+CONFIG_INTEL_RDT=y

And your base is very different two.

Try to use mainline on both system and see.

You can also use the same base kernel version from ubuntu and

run your test.


>> greg k-h
>
>

