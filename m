Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44155C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14F122078D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M5lUnHIQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgHZOrp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbgHZOrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 10:47:43 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1822EC061574;
        Wed, 26 Aug 2020 07:47:43 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id y65so1560114qtd.2;
        Wed, 26 Aug 2020 07:47:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Xc2Hb9o/7Ud3w/FXjCQl5Yr4FI/SfE6ovQyC4Jq0IVE=;
        b=M5lUnHIQ/AgrRdVc1DXk/Fxye2VdpNklMkr+fsPbADxxVl54//+QmKmArjsaO7IrB/
         HMGrDSSGc3BvHkRXktG1Ojo+AYwqkIMoI2SoPtLx2GuCT0KV5pnsWA4Doe8Ibic6xb4q
         x117qeHQsGHMqLOT8uyto49hfN9quRZPOq1E9rJe7rRCsfou8pctxrXL7Ma6kOk5hjJS
         nF3Dcp2bEbWmv141bj1O7K2HghTbqAgauFbctEBVpRr6JhRD/g69T9/0kSQp5ipIW+Z9
         JICDu0HU859q7Kk7zNEt2bTTPdC9r7qsgfqIf7XWCsv+FEwHqhDb2tpOl14nEiviuAWF
         O0KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xc2Hb9o/7Ud3w/FXjCQl5Yr4FI/SfE6ovQyC4Jq0IVE=;
        b=WpP1eTDtDxRLGq0fVT9F3V7GuPOhYDCrtOGVuCAmEzp3KyFn0j8/noevovUlxUV9Fb
         HUWj12kRZmo6TDeWCYt2iLtd4VxVQ4omM9ZMsU0aikXZSPb6Ctic/sFhjoNbhzuQgU/B
         C3bJENqrHF2t49MkpD6TaapTpko/CgEzAfLu9+tHDoB3T4fFFl8KbeG9j6D9q7FHW6w+
         WUB0hIjyiztI3CEpZy/fPLAZZTpe6KQKsxkxgHQzBqs3oWLT2nlp46TrDCto5laW67b8
         TfQJUHmfjO6vRZ2fjpM4UCsZTDBlVwlAqlo+peH5uglmKEpAAfS48FHrXUvCtdi/H8LZ
         4pNQ==
X-Gm-Message-State: AOAM5336kPPlHdI0Fi6wkqys3V2/kh/DsMLYZdOUyJll7nphSDzQlNNW
        PRWSpJOps83LU8tVPIm4RTPCh0zALTyspA==
X-Google-Smtp-Source: ABdhPJyT5a9WePwjGlwmbnuS5NX7RQ8zzM7hSEpnNk6/4mOkh8NTEaP5HnVV5RKaGcDjhOpsyAO3ag==
X-Received: by 2002:ac8:4f4b:: with SMTP id i11mr13930514qtw.379.1598453262096;
        Wed, 26 Aug 2020 07:47:42 -0700 (PDT)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id o187sm1807312qkf.14.2020.08.26.07.47.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2020 07:47:41 -0700 (PDT)
Subject: Re: (EXT) Re: [PATCH] of: skip disabled CPU nodes
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200826120254.8902-1-matthias.schiffer@ew.tq-group.com>
 <4dd06b79-1402-d7cf-9676-1f9a9526da12@gmail.com>
 <9eb72c6561333661599411e49072928385629999.camel@ew.tq-group.com>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <ac64852a-7f2a-6005-f914-268670cd4f95@gmail.com>
Date:   Wed, 26 Aug 2020 09:47:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <9eb72c6561333661599411e49072928385629999.camel@ew.tq-group.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 2020-08-26 08:54, Matthias Schiffer wrote:
> On Wed, 2020-08-26 at 08:01 -0500, Frank Rowand wrote:
>> On 2020-08-26 07:02, Matthias Schiffer wrote:
>>> Allow disabling CPU nodes using status = "disabled".
>>>
>>> This allows a bootloader to change the number of available CPUs
>>> (for
>>> example when a common DTS is used for SoC variants with different
>>> numbers
>>> of cores) without deleting the nodes altogether (which may require
>>> additional fixups where the CPU nodes are referenced, e.g. a
>>> cooling
>>> map).
>>>
>>> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com
>>>>
>>> ---
>>>  drivers/of/base.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/of/base.c b/drivers/of/base.c
>>> index ea44fea99813..d547e9deced1 100644
>>> --- a/drivers/of/base.c
>>> +++ b/drivers/of/base.c
>>> @@ -796,6 +796,8 @@ struct device_node *of_get_next_cpu_node(struct
>>> device_node *prev)
>>>  		of_node_put(node);
>>>  	}
>>>  	for (; next; next = next->sibling) {
>>> +		if (!__of_device_is_available(next))
>>> +			continue;
>>>  		if (!(of_node_name_eq(next, "cpu") ||
>>>  		      __of_node_is_type(next, "cpu")))
>>>  			continue;
>>>
>>
>> The original implementation of of_get_next_cpu_node() had
>> that check, but status disabled for cpu nodes has different
>> semantics than other nodes, and the check broke some systems.
>> The check was removed by c961cb3be906 "of: Fix cpu node
>> iterator to not ignore disabled cpu nodes".
>>
>> It would be useful to document that difference in the
>> header comment of of_get_next_cpu_node().
>>
>> -Frank
> 
> Hmm, I see. This difference in behaviour is quite unfortunate, as I'm
> currently looking for a way to *really* disable a CPU core.
> 
> In arch/arm64/boot/dts/freescale/imx8mn.dtsi (and other variants of the
> i.MX8M), there are 4 CPU nodes for the full-featured quad-core version.
> The reduced single- and dual-core versions are currently handled in
> NXP's U-Boot fork by deleting the additional nodes.
> 
> Not doing so causes the kernel to hang for a while when trying to
> online the non-existent cores during boot (at least in linux-imx 5.4 -
> I have not checked a more recent mainline kernel yet), but the deletion
> is non-trivial to do without leaving dangling phandle references.

Any thoughts on implementing another universal property that means
something like "the hardware described by this node does not exist
or is so broken that you better not use it".

Matthias, if Rob thinks that is a good idea, then you should start
with a new proposal that is also sent to
devicetree-spec@vger.kernel.org <devicetree-spec@vger.kernel.org>

-Frank

> 
> Kind regards,
> Matthias
> 

