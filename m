Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD9EC352A1
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 07:57:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2833217BA
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 07:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbgBHH5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 02:57:06 -0500
Received: from ivanoab7.miniserver.com ([37.128.132.42]:35820 "EHLO
        www.kot-begemot.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbgBHH5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 02:57:06 -0500
Received: from tun252.jain.kot-begemot.co.uk ([192.168.18.6] helo=jain.kot-begemot.co.uk)
        by www.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1j0Kz6-0006fj-Jw; Sat, 08 Feb 2020 07:57:02 +0000
Received: from sleer.kot-begemot.co.uk ([192.168.3.72])
        by jain.kot-begemot.co.uk with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <anton.ivanov@cambridgegreys.com>)
        id 1j0Kz4-0007GD-8F; Sat, 08 Feb 2020 07:57:00 +0000
Subject: Re: [PATCH v3] uml: make CONFIG_STATIC_LINK actually static
To:     Brendan Higgins <brendanhiggins@google.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        James McMechan <james_mcmechan@hotmail.com>
Cc:     linux-um <linux-um@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Gow <davidgow@google.com>
References: <20200124221401.210449-1-brendanhiggins@google.com>
 <CAFd5g44eznV-9cPf4JVpsJo93+R8YCqUwBqRf+PbjaRMizy1aQ@mail.gmail.com>
From:   Anton Ivanov <anton.ivanov@cambridgegreys.com>
Organization: Cambridge Greys
Message-ID: <7f8b86f1-3759-c9ff-6216-a7104edb8030@cambridgegreys.com>
Date:   Sat, 8 Feb 2020 07:56:58 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAFd5g44eznV-9cPf4JVpsJo93+R8YCqUwBqRf+PbjaRMizy1aQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Clacks-Overhead: GNU Terry Pratchett
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2020 01:07, Brendan Higgins wrote:
> On Fri, Jan 24, 2020 at 2:14 PM Brendan Higgins
> <brendanhiggins@google.com> wrote:
>>
>> Currently, CONFIG_STATIC_LINK can be enabled with options which cannot
>> be statically linked, namely UML_NET_VECTOR, UML_NET_VDE, and
>> UML_NET_PCAP; this is because glibc tries to load NSS which does not
>> support being statically linked. So make CONFIG_STATIC_LINK depend on
>> !UML_NET_VECTOR && !UML_NET_VDE && !UML_NET_PCAP.
>>
>> Link: https://lore.kernel.org/lkml/f658f317-be54-ed75-8296-c373c2dcc697@cambridgegreys.com/#t
>> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
>> ---
> 
> Ping.

ICMP echo reply,

I thought I acked it :)

If not - apologies.

A.

> 
>>   arch/um/Kconfig         | 8 +++++++-
>>   arch/um/drivers/Kconfig | 3 +++
>>   2 files changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/um/Kconfig b/arch/um/Kconfig
>> index 0917f8443c285..28d62151fb2ed 100644
>> --- a/arch/um/Kconfig
>> +++ b/arch/um/Kconfig
>> @@ -62,9 +62,12 @@ config NR_CPUS
>>
>>   source "arch/$(HEADER_ARCH)/um/Kconfig"
>>
>> +config FORBID_STATIC_LINK
>> +       bool
>> +
>>   config STATIC_LINK
>>          bool "Force a static link"
>> -       default n
>> +       depends on !FORBID_STATIC_LINK
>>          help
>>            This option gives you the ability to force a static link of UML.
>>            Normally, UML is linked as a shared binary.  This is inconvenient for
>> @@ -73,6 +76,9 @@ config STATIC_LINK
>>            Additionally, this option enables using higher memory spaces (up to
>>            2.75G) for UML.
>>
>> +         NOTE: This option is incompatible with some networking features which
>> +         depend on features that require being dynamically loaded (like NSS).
>> +
>>   config LD_SCRIPT_STATIC
>>          bool
>>          default y
>> diff --git a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
>> index 72d4170557820..9160ead56e33c 100644
>> --- a/arch/um/drivers/Kconfig
>> +++ b/arch/um/drivers/Kconfig
>> @@ -234,6 +234,7 @@ config UML_NET_DAEMON
>>   config UML_NET_VECTOR
>>          bool "Vector I/O high performance network devices"
>>          depends on UML_NET
>> +       select FORBID_STATIC_LINK
>>          help
>>          This User-Mode Linux network driver uses multi-message send
>>          and receive functions. The host running the UML guest must have
>> @@ -245,6 +246,7 @@ config UML_NET_VECTOR
>>   config UML_NET_VDE
>>          bool "VDE transport (obsolete)"
>>          depends on UML_NET
>> +       select FORBID_STATIC_LINK
>>          help
>>          This User-Mode Linux network transport allows one or more running
>>          UMLs on a single host to communicate with each other and also
>> @@ -292,6 +294,7 @@ config UML_NET_MCAST
>>   config UML_NET_PCAP
>>          bool "pcap transport (obsolete)"
>>          depends on UML_NET
>> +       select FORBID_STATIC_LINK
>>          help
>>          The pcap transport makes a pcap packet stream on the host look
>>          like an ethernet device inside UML.  This is useful for making
>> --
>> 2.25.0.341.g760bfbb309-goog
>>
> 
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
> 


-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
