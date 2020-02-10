Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDBE8C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 09:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CB1F20714
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 09:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbgBJJVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 04:21:14 -0500
Received: from mga04.intel.com ([192.55.52.120]:34805 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbgBJJVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 04:21:14 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Feb 2020 01:21:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,424,1574150400"; 
   d="scan'208";a="227130673"
Received: from liujing-mobl1.ccr.corp.intel.com (HELO [10.249.174.64]) ([10.249.174.64])
  by fmsmga008.fm.intel.com with ESMTP; 10 Feb 2020 01:21:12 -0800
Subject: Re: [virtio-dev][PATCH v1 1/2] virtio-mmio: Add MSI and different
 notification address support
To:     Stefan Hajnoczi <stefanha@redhat.com>
Cc:     virtio-dev@lists.oasis-open.org, slp@redhat.com,
        linux-kernel@vger.kernel.org,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Zha Bin <zhabin@linux.alibaba.com>,
        Liu Jiang <gerry@linux.alibaba.com>
References: <1576855504-34947-1-git-send-email-jing2.liu@linux.intel.com>
 <20200106161836.GB350142@stefanha-x1.localdomain>
 <f691fb60-8f59-e827-6a5f-569db29e0a39@linux.intel.com>
 <20200110095217.GB573283@stefanha-x1.localdomain>
 <801cf09a-759f-b6bf-e71b-02dbf0f1d513@linux.intel.com>
 <20200122165637.GD677983@stefanha-x1.localdomain>
From:   "Liu, Jing2" <jing2.liu@linux.intel.com>
Message-ID: <46df15c3-5643-f3f1-b0c2-36c451d10875@linux.intel.com>
Date:   Mon, 10 Feb 2020 17:21:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200122165637.GD677983@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/23/2020 12:56 AM, Stefan Hajnoczi wrote:
> On Mon, Jan 13, 2020 at 07:54:06PM +0800, Liu, Jing2 wrote:
>>>>>>         \end{note}
>>>>>>       }
>>>>>>       \hline
>>>>>> @@ -1671,25 +1671,23 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
>>>>>>         accesses apply to the queue selected by writing to \field{QueueSel}.
>>>>>>       }
>>>>>>       \hline
>>>>>> -  \mmioreg{QueueNotify}{Queue notifier}{0x050}{W}{%
>>>>>> -    Writing a value to this register notifies the device that
>>>>>> -    there are new buffers to process in a queue.
>>>>>> +  \mmioreg{QueueNotify}{Queue notifier}{0x050}{RW}{%
>>>>>> +    Reading from the register returns the virtqueue notification configuration.
>>>>>> -    When VIRTIO_F_NOTIFICATION_DATA has not been negotiated,
>>>>>> -    the value written is the queue index.
>>>>>> +    See \ref{sec:Virtio Transport Options / Virtio Over MMIO / MMIO-specific Initialization And Device Operation / Notification Address}
>>>>>> +    for the configuration format.
>>>>>> -    When VIRTIO_F_NOTIFICATION_DATA has been negotiated,
>>>>>> -    the \field{Notification data} value has the following format:
>>>>>> +    Writing when the notification address calculated by the notification configuration
>>>>>> +    is just located at this register.
>>>>> I don't understand this sentence.  What happens when the driver writes
>>>>> to this register?
>>>> We're trying to define the notification mechanism that, driver MUST read
>>>> 0x50 to get the notification configuration
>>>>
>>>> and calculate the notify address. The writing case here is that, the notify
>>>> address is just located here e.g. notify_base=0x50, notify_mul=0.
>>> I still don't understand what this means.  It's just an English issue
>>> and it will become clear if you can rephrase what you're saying.
>> Sure, let me try to explain it. :)
>>
>> The different notification locations are calculated via the structure
>> returned by reading this register.
>>
>> le32 {
>>      notify_base : 16;
>>      notify_multiplier : 16;
>> };
>>
>> location=notify_base + queue_index * notify_multiplier
>>
>> The location might be the same when mul=0, and furthermore, it might be
>> equal to 0x50 (notify_base=0x50, notify_mul=0) so we make this register W
>> too.
>>
>> So we said, the register is RW and W is only for such scenario.
>>
>> Feel free to tell me if it's still confusing.
> I understand now:
>
>    Devices that only require a single notify address may set
>    notify_base=0x50 and notify_multiplier=0 to use the Queue Notifier
>    register itself for notifications.  In this case the driver writes to
>    Queue Notifier to notify the device that there are new buffers in a
>    virtqueue.
>
> Perhaps you could include this in the text.

Thanks for the guide. Since v2 was sent out, we'll add such text in 
later version.

Jing

>>>>>> -    \lstinputlisting{notifications-le.c}
>>>>>> -
>>>>>> -    See \ref{sec:Virtqueues / Driver notifications}~\nameref{sec:Virtqueues / Driver notifications}
>>>>>> -    for the definition of the components.
>>>>>> +    See \ref{sec:Virtio Transport Options / Virtio Over MMIO / MMIO-specific Initialization And Device Operation / Available Buffer Notifications}
>>>>>> +    to see the notification data format.
>>>>>>       }
>>>>>>       \hline
>>>>>>       \mmioreg{InterruptStatus}{Interrupt status}{0x60}{R}{%
>>>>>>         Reading from this register returns a bit mask of events that
>>>>>> -    caused the device interrupt to be asserted.
>>>>>> +    caused the device interrupt to be asserted. This is only used
>>>>>> +    when MSI is not enabled.
>>>>>>         The following events are possible:
>>>>>>         \begin{description}
>>>>>>           \item[Used Buffer Notification] - bit 0 - the interrupt was asserted
>>>>>> @@ -1703,7 +1701,7 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
>>>>>>       \mmioreg{InterruptACK}{Interrupt acknowledge}{0x064}{W}{%
>>>>>>         Writing a value with bits set as defined in \field{InterruptStatus}
>>>>>>         to this register notifies the device that events causing
>>>>>> -    the interrupt have been handled.
>>>>>> +    the interrupt have been handled. This is only used when MSI is not enabled.
>>>>>>       }
>>>>>>       \hline
>>>>>>       \mmioreg{Status}{Device status}{0x070}{RW}{%
>>>>>> @@ -1762,6 +1760,31 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
>>>>>>         \field{SHMSel} is unused) results in a base address of
>>>>>>         0xffffffffffffffff.
>>>>>>       }
>>>>>> +  \hline
>>>>>> +  \mmioreg{MsiStatus}{MSI status}{0x0c0}{R}{%
>>>>>> +    Reading from this register returns the global MSI enable/disable status and maximum
>>>>>> +    number of virtqueues that device supports.
>>>>>> +    \lstinputlisting{msi-status.c}
>>>>>> +  }
>>>>> Why is it necessary to combine the number of virtqueues and global
>>>>> MSI enable/disable into a single 16-bit field?
>>>> Originally, we want this 16-bit Read-Only, so we put some RO things together
>>>> and separate
>>>>
>>>> enable setting command to next register.
>>>>
>>>>> virtio-mmio uses 32-bit registers.  It doesn't try hard to save register
>>>>> space so it's strange to do it here (11-bit number of virtqueue field
>>>>> but 32-bit QueueSel field).
>>>> In order to improve performance/save register space,  we combine some data
>>>> together.
>>>>
>>>> For example, combine MSI cmd operator (e.g. enable/disable, vector setup)
>>>> with argument (e.g. 1/0,  queue index).
>>>>
>>>> But it seems we miss the consistency with QueueSel.  So do you think if the
>>>> max queue number should be 32-bit,
>>>>
>>>> which means it must be the same with QueueSel? If so, I guess we need some
>>>> re-organization. :)
>>> I suggest following the 32-bit register size convention unless there is
>>> a specific reason why using other register sizes is absolutely necessary.
>> Yes, let's keep consistency with QueueSel and re-organize other registers.
>>
>> I feel concern why Available Buﬀer Notifcations (section describing
>> VIRTIO_F_NOTIFICATION_DATA) makes vq index as 16bit?
> As you mentioned, the valid range of virtqueue numbers is only 16 bits
> due to non-MMIO parts of the specification using 16 bits.
>
> However, I think it makes sense to stick to the MMIO transport 32-bit
> register size convention for consistency.  Devices just won't support
> values above 0xffff.
>
> Stefan
