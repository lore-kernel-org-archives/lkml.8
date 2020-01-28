Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CECD1C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 15:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5FF124683
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 15:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RwoHxlEi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgA1PiC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 10:38:02 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40483 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726141AbgA1PiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 10:38:02 -0500
Received: by mail-pl1-f196.google.com with SMTP id y1so1697971plp.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 07:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=p/deCH70MeRzW576JyUqvHOFrulpoT9ELP3wElLzEto=;
        b=RwoHxlEidVrtaVNrBr0sHELF0cy8c6FVzBJXx6cAvJrkquD1+CKsZJV/qXjli3jaNM
         XWfhnmy9vVl5o7cYuwmpa41NoXIxNCrXMAbs1T57v8ur4xmaxoQacltl9Yr9DcnNRteZ
         Ay/vGiN+8oFIJ4IlX9jQVMbOrRfAW5hsMA6pQblkf68Fe5wOiq3vF4wJeGWTU/JlD4TW
         yf5ChdcfN6f1GHP/SjbVIiQMwDmlkFgTw3t4Ul3dhRb56MFabj4LPxs8KKuqG0i5fO/t
         K9587nBMg+bN0IcRYOh+m2tUNxzbNw8U/MrvBApvpMbSU9bPMlQyDvwJRU0Ez/ovDgRk
         hAFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=p/deCH70MeRzW576JyUqvHOFrulpoT9ELP3wElLzEto=;
        b=iuE306YD+wPad/gWTGmveVcIzQAE8Jz813RvLNZAeOrdqz4waAZVA4VoWGuVGr3o2c
         KcrwIoznSc0LzzQtDh4IDM7pwtnFJgO3ticYJeR3iFTJJFDpN1Jf2qIJb7icTjJ8WLYx
         a89mi+1uNtOXYUt7D3qihY8Flijil1h5zKzr6zzcPgsTIpTyy36LVhzSe4AzKU/r6gpA
         Coorxnh8ociMD+kJtrsaFrF/LxJXI/SZhpUI5b/Vj/IDKxOiEMLhJVbnNgZ3+56H5+k2
         TYpjgt5acIKGhw28VdohLTEkkPz6etIHy0xXXmYv68xb3kuTOhzf4gsdSY4mzOYupM/6
         1s3g==
X-Gm-Message-State: APjAAAVW+Aqx+kZ9vaTUtvW8840FDysF0dWqm9WqZ4O5OMy+KRDJWtLg
        UiryfP5CPI48k5iq3qXHJyE=
X-Google-Smtp-Source: APXvYqwBn8D27wICUe37lf5NXst8djpr0iBEhkYpFsi2bs9ag/G61zrnPtOlL9fv1XtWOce3rhCfmQ==
X-Received: by 2002:a17:90a:8043:: with SMTP id e3mr5270015pjw.24.1580225881520;
        Tue, 28 Jan 2020 07:38:01 -0800 (PST)
Received: from [192.168.0.16] (97-115-104-237.ptld.qwest.net. [97.115.104.237])
        by smtp.gmail.com with ESMTPSA id r6sm19887749pfh.91.2020.01.28.07.37.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2020 07:38:00 -0800 (PST)
Subject: Re: [PATCH] kbuild: Include external modules compile flags
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dev@openvswitch.org, dsahern@gmail.com
References: <1580161806-8037-1-git-send-email-gvrose8192@gmail.com>
 <CAK7LNAQyh9CFgKd1DtAPFW8DuHNp1gn8YABuP8-LsF=hHK2DFw@mail.gmail.com>
From:   Gregory Rose <gvrose8192@gmail.com>
Message-ID: <f6ffa0d0-8214-8fc0-4fe9-4b70a1581d3e@gmail.com>
Date:   Tue, 28 Jan 2020 07:37:58 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CAK7LNAQyh9CFgKd1DtAPFW8DuHNp1gn8YABuP8-LsF=hHK2DFw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/27/2020 7:35 PM, Masahiro Yamada wrote:
> On Tue, Jan 28, 2020 at 6:50 AM Greg Rose <gvrose8192@gmail.com> wrote:
>> Since this commit:
>> 'commit 9b9a3f20cbe0 ("kbuild: split final module linking out into Makefile.modfinal")'
>> at least one out-of-tree external kernel module build fails
>> during the modfinal make phase because Makefile.modfinal does
>> not include the ccflags-y variable from the exernal module's Kbuild.
> ccflags-y is passed only for compiling C files in that directory.
>
> It is not used for compiling *.mod.c
> This is true for both in-kernel and external modules.
>
> So, ccflags-y is not a good choice
> for passing such flags that should be globally effective.
>
>
> Maybe, KCFLAGS should work.
>
>
> module:
>         $(MAKE) KCFLAGS=...  M=$(PWD) -C /lib/modules/$(uname -r)/build modules
>

Thanks,

I'll see if I can get that to work.

- Greg


>
>> Make sure to include the external kernel module's Kbuild so that the
>> necessary command line flags from the external module are set.
>>
>> Reported-by: David Ahern <dsahern@gmail.com>
>> CC: Masahiro Yamada <yamada.masahiro@socionext.com>
>> Signed-off-by: Greg Rose <gvrose8192@gmail.com>
>> ---
>>   scripts/Makefile.modfinal | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
>> index 411c1e60..a645ba6 100644
>> --- a/scripts/Makefile.modfinal
>> +++ b/scripts/Makefile.modfinal
>> @@ -21,6 +21,10 @@ __modfinal: $(modules)
>>   modname = $(notdir $(@:.mod.o=))
>>   part-of-module = y
>>
>> +# Include the module's Makefile to find KBUILD_EXTRA_SYMBOLS
>> +include $(if $(wildcard $(KBUILD_EXTMOD)/Kbuild), \
>> +             $(KBUILD_EXTMOD)/Kbuild)
>> +
>>   quiet_cmd_cc_o_c = CC [M]  $@
>>         cmd_cc_o_c = $(CC) $(c_flags) -c -o $@ $<
>>
>> --
>> 1.8.3.1
>>
>

