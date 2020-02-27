Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C55DC35DF9
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 19:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35C9F2468E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 19:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vg4eJJf5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730364AbgB0Tas (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 14:30:48 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:41781 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729727AbgB0Tas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 14:30:48 -0500
Received: by mail-yw1-f66.google.com with SMTP id h6so693046ywc.8;
        Thu, 27 Feb 2020 11:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ms7ngyPWar2qTVrk3JwekzFVpUj9g8rYLZFTYitG1L4=;
        b=Vg4eJJf52nV/QEaLGfoy/7pOMlXMCzJV6BDXgLP+8pOfYvE3LNy/3H/PfrcDKy7q36
         u7cwhlZEJJX+7kbyJg2/1DSKsNeuLzw246fD6Knxztsjj8Bf4o0tSEHvVZA6qF0WMeoW
         93hpdvMTbKjXeHyc4PVdVHNQWl9pQDquQD0SxKCGIiP2Y0KnPjhfAhYX03LPLQDSGVdP
         PV9PuPJwl3RHxy0nE5YjVq7St/atqZZzLBkALhdtZBDlQAtzkeLcwNpPxfkHjZ5xveoG
         P3W4DSI9RBGAa8CjbZd6p1QcwAM1IOzLzgSZdbQqjnYT/ZScv2ym+Q/vvAf/QPfuwcQS
         N4hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ms7ngyPWar2qTVrk3JwekzFVpUj9g8rYLZFTYitG1L4=;
        b=V1IgvmsINcmul4rgKzg2kXMdX5l8NUALZodiwW155MaEshBLVlLyOvhmZWOnds/eBJ
         4ingF4B1V4bpSZDYH6JbZPTOXONNQ2SaOMksYrWMRfrpDCZmzn8cDvOmpceYraKrUSzY
         7EhUmbnk0mCDsLGwCOUnysfnNCL2jeiRje3YV0dgxJMti51GtbjWVHby17F98QOlftjb
         DoEj51CEutmDC7OHvIXRNHcmyaauYqV4XS2Gcg4nU3bXLqdIVsJXZ+I8DoqfOwEg9g35
         wCI1iXtFDoBn43WGuI+cBv4QSWkNAGeZJaWtxPwsmvidDUAhKLguGmhOHNo7h/CzlyPm
         qmug==
X-Gm-Message-State: APjAAAUyE5kWK0cby7x+TiiwScV59SU6Cfw1Bm3ERuMRHscrfFG8CO30
        5tbx/+lP+1ls3DG8DhQiQ5c=
X-Google-Smtp-Source: APXvYqy+WY0jHqtqjj8JxepUNnPEWKjf5VaeZerNTq74HfE9WncKQwQXPKW8OPgcFRvjWBnQOfVcOA==
X-Received: by 2002:a81:5305:: with SMTP id h5mr953870ywb.31.1582831846997;
        Thu, 27 Feb 2020 11:30:46 -0800 (PST)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id q16sm2846732ywa.110.2020.02.27.11.30.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Feb 2020 11:30:46 -0800 (PST)
Subject: Re: [PATCH v2] of: overlay: log the error cause on resolver failure
To:     Luca Ceresoli <luca@lucaceresoli.net>, devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Pantelis Antoniou <pantelis.antoniou@konsulko.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
References: <20200225164540.4520-1-luca@lucaceresoli.net>
 <f9565679-5892-bcf0-f751-bfcac87670a8@gmail.com>
 <40fdf0f2-85a4-9f84-6994-a59b7b56cec4@lucaceresoli.net>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <efcb22be-7fb4-908d-d54f-6a22f1c62ec5@gmail.com>
Date:   Thu, 27 Feb 2020 13:30:46 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <40fdf0f2-85a4-9f84-6994-a59b7b56cec4@lucaceresoli.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/20 2:11 AM, Luca Ceresoli wrote:
> Hi Frank,
> 
> On 26/02/20 04:53, Frank Rowand wrote:
>> On 2/25/20 10:45 AM, Luca Ceresoli wrote:
>>> For some of its error paths, of_resolve_phandles() only logs a very generic
>>> error which does not help much in finding the origin of the problem:
>>>
>>>   OF: resolver: overlay phandle fixup failed: -22
>>>
>>> Add error messages for all the error paths that don't have one. Now a
>>> specific message is always emitted, thus also remove the generic catch-all
>>> message emitted before returning.
>>>
>>> For example, in case a DT overlay has a fixup node that is not present in
>>> the base DT __symbols__, this error is now logged:
>>>
>>>   OF: resolver: node gpio9 not found in base DT, fixup failed
>>>
>>> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
>>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>>> ---
>>>
>>> I don't know in detail the meaning of the adjust_local_phandle_references()
>>> and update_usages_of_a_phandle_reference() error paths, thus I have put
>>> pretty generic messages. Any suggestion on better wording would be welcome.
>>
>> If you have not read the code to understand what the meaning of
>> the errors are, you should not be suggesting changes to the error
>> messages.
>>
>> Only one of the issues detected as errors can possibly be something
>> other than an error either in the resolver.c code or the dtc
>> compiler -- a missing symbol in the live devicetree.  This may
>> be because of failing to compile the base devicetree without
>> symbols, depending on a symbol from another overlay where the
>> other overlay has not been applied, or depending on a symbol
>> from another overlay where the other overlay is applied but
>> the overlay was not compiled with symbols.  (Not meant to be
>> an exhaustive list, but it might be.)  Thus the missing
>> symbol problem might be fixable without a fix to kernel
>> code.  The error message philosophy for overlay related
>> errors is to minimize error messages that help diagnose
>> the precise cause of a kernel code bug, with the intent
>> of keeping the code more compact and readable.  When a
>> bug occurs, debugging messages can be added for the
>> debug session.
> 
> Got it, sorry about that.
> 
>> Following this philosophy, only the message in the second
>> patch chunk is ok.
> 
> Then I think you can apply the v1 patch which only contains the message
> about the problem I experienced, and which was caused by an incorrect DTO:
> 
> https://patchwork.ozlabs.org/patch/1243987/
> 
> Just ignore the note saying the patch is not for mainline, it's wrong.
> 

Mostly yes, v1 contains the one place a message should be added.

Let me bike shed a little bit though.

I suggested a different wording for the message in v2, but I
do not think my attempt at wording was precise enough.  I
would instead suggest:

  "node label '%s' not found in live devicetree symbols table\n"

Some subtle differences.
  - It is a node label, not a node name.
  - If multiple overlays are applied, then the intention may have
    been to supply the node label via a previously applied overlay
    instead of from the base devicetree.  So specifying the live
    devicetree is more accurate.

Please submit v3 for mainline.

Thanks,

Frank
