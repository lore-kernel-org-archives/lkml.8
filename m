Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A1BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 12:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56D60207CB
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 12:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="jWI5D5V7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731762AbgEZMOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 08:14:19 -0400
Received: from ozlabs.org ([203.11.71.1]:39667 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728682AbgEZMOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 08:14:19 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49WXvD1JR3z9sRW;
        Tue, 26 May 2020 22:14:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1590495257;
        bh=edkHVtYOKN1TVgGDRKISh6yBxBVEyLNdkDMbZWBQadE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=jWI5D5V7v1nS5Zu/kPhmvs3xLMxGeKkJ6iQjr/fNYMOTg+mcUqB5qTPqlT8+dPUso
         W21vKySR0RcRX+BzZRpQwJVNzfGWB1PyKCy7jqsQQaIDKWPXQsD8qdwSOdHrbxrI7z
         YkLKmvvLfbyd1/tBF9ELEPc87BF6KLYzAPQWtpOxKRwNaZdr38ZyOy2EryhBtYUC/j
         LBwq3hVjVebNuRw6eVDs6ynqeL3hcPcj8GDQbEc1ygosaYGPm4FIJZrQqKwoqtKTdM
         zYFV1CbzFadMKF7jhg9nvAOhk5c/oRbdXzM1+TLQoNFqzkRBOdl1l1mXKGgKGib8Xb
         8pUdR5p3WJ5Pw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Vaibhav Jain <vaibhav@linux.ibm.com>,
        Ira Weiny <ira.weiny@intel.com>
Cc:     "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>, linux-nvdimm@lists.01.org
Subject: Re: [RESEND PATCH v7 4/5] ndctl/papr_scm, uapi: Add support for PAPR nvdimm specific methods
In-Reply-To: <87a71ww7f9.fsf@linux.ibm.com>
References: <20200519190058.257981-1-vaibhav@linux.ibm.com> <20200519190058.257981-5-vaibhav@linux.ibm.com> <20200520153209.GC3660833@iweiny-DESK2.sc.intel.com> <87367t941j.fsf@mpe.ellerman.id.au> <87ftbswhb6.fsf@linux.ibm.com> <87a71ww7f9.fsf@linux.ibm.com>
Date:   Tue, 26 May 2020 22:14:39 +1000
Message-ID: <875zcigafk.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vaibhav Jain <vaibhav@linux.ibm.com> writes:
> Hi Ira, Mpe and Aneesh,
>
> Vaibhav Jain <vaibhav@linux.ibm.com> writes:
>
>> Michael Ellerman <mpe@ellerman.id.au> writes:
>>
>>> Ira Weiny <ira.weiny@intel.com> writes:
>>>> On Wed, May 20, 2020 at 12:30:57AM +0530, Vaibhav Jain wrote:
>>>>> Introduce support for Papr nvDimm Specific Methods (PDSM) in papr_scm
>>>>> modules and add the command family to the white list of NVDIMM command
>>>>> sets. Also advertise support for ND_CMD_CALL for the dimm
>>>>> command mask and implement necessary scaffolding in the module to
>>>>> handle ND_CMD_CALL ioctl and PDSM requests that we receive.
>>> ...
>>>>> + *
>>>>> + * Payload Version:
>>>>> + *
>>>>> + * A 'payload_version' field is present in PDSM header that indicates a specific
>>>>> + * version of the structure present in PDSM Payload for a given PDSM command.
>>>>> + * This provides backward compatibility in case the PDSM Payload structure
>>>>> + * evolves and different structures are supported by 'papr_scm' and 'libndctl'.
>>>>> + *
>>>>> + * When sending a PDSM Payload to 'papr_scm', 'libndctl' should send the version
>>>>> + * of the payload struct it supports via 'payload_version' field. The 'papr_scm'
>>>>> + * module when servicing the PDSM envelope checks the 'payload_version' and then
>>>>> + * uses 'payload struct version' == MIN('payload_version field',
>>>>> + * 'max payload-struct-version supported by papr_scm') to service the PDSM.
>>>>> + * After servicing the PDSM, 'papr_scm' put the negotiated version of payload
>>>>> + * struct in returned 'payload_version' field.
>>>>
>>>> FWIW many people believe using a size rather than version is more sustainable.
>>>> It is expected that new payload structures are larger (more features) than the
>>>> previous payload structure.
>>>>
>>>> I can't find references at the moment through.
>>>
>>> I think clone_args is a good modern example:
>>>
>>>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/sched.h#n88
>>
>> Thank Ira and Mpe for pointing this out. I looked into how clone3 sycall
>> handles clone_args and few differences came out:
>>
>> * Unlike clone_args that are always transferred in one direction from
>>   user-space to kernel, payload contents of pdsms are transferred in both
>>   directions. Having a single version number makes it easier for
>>   user-space and kernel to determine what data will be exchanged.
>>
>> * For PDSMs, the version number is negotiated between libndctl and
>>   kernel. For example in case kernel only supports an older version of
>>   a structure, its free to send a lower version number back to
>>   libndctl. Such negotiations doesnt happen with clone3 syscall.
>
> If you are ok with the explaination above please let me know. I will
> quickly spin off a v8 addressing your review comments.

I don't have strong opinions about the user API, it's really up to the
nvdimm folks.

cheers
