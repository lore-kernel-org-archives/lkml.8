Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89847C10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:46:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5159D206B1
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cxLrP2HI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgCLRqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 13:46:53 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41093 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726385AbgCLRqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 13:46:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584035211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/nvU1NadByOB05sCrlj2mgQFDMN81MY810CKny+q7yI=;
        b=cxLrP2HIJso0D+jcGk2uyaUkSXgzc+AZEhTzlNvjuvBlLy0YEvpmTWXMPNCXn8fuTnDZfb
        7B612hawfeeZgkgN5zYAkeVL7VJItQMeOoGGtU3QMUCLZcl/l0/dv0xnEu71hFU2m0034z
        IFo0R106hD0aghdS5fiVrHSe7/o56ms=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-nMR4BdSlMKKDRm4vtBn3hw-1; Thu, 12 Mar 2020 13:46:47 -0400
X-MC-Unique: nMR4BdSlMKKDRm4vtBn3hw-1
Received: by mail-wr1-f72.google.com with SMTP id z13so2959686wrv.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 10:46:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/nvU1NadByOB05sCrlj2mgQFDMN81MY810CKny+q7yI=;
        b=i3BpyaCTepnDkbMNbSx4TQOyaWPZG/Hv7VpWw/FwxovZSU2XbHqFU6ybha1QVxnmrR
         fGkAQoRuxq8NkkeYthZO0EPzjoLPxrTmg0BZv3KymIvC5WbYI61iwIl2gdcFgj/mx+UB
         CXgcUd/8NrB9JhydCreM3YRjxj6oQsoh5B+J753nHfD5ro0yJBXafOojmFa0Tqf+DNgQ
         bHwz/z9Y/HrwKQNfmnZDvULvkLbsB75y6B3idZch2YLJC/iRreVhCqgdLRDQFZ7n3G+B
         8KF3AO2pwNPKTn9e9z3TBSSdlDo+pDCpmx2ZL6cs5unlg99ayNP6v2JsLTcF34JjRw6o
         hK2g==
X-Gm-Message-State: ANhLgQ1O2lFIawwKLQCWQ80JJQ2+/49ETO3ynjoP6dFkvSl0zpiLPnhc
        DUay0H87VND/SNex7gLb5p+GxsTtjNi5iEDJ6kFeTMa9NJ/YiwNYQpFfOVoGVRYte+42y0rmrC2
        9MlGLXhU0E6jQPsbgF+DhXYlO
X-Received: by 2002:a5d:448f:: with SMTP id j15mr11664357wrq.425.1584035206206;
        Thu, 12 Mar 2020 10:46:46 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vv8mKpFON/RGILqzQA3K4wuDvn1i3NrS4SW019eTBOhaumiJdKl9jjAmEzrobx+2fsSOqiNeA==
X-Received: by 2002:a5d:448f:: with SMTP id j15mr11664340wrq.425.1584035205988;
        Thu, 12 Mar 2020 10:46:45 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
        by smtp.gmail.com with ESMTPSA id a7sm12096799wmj.12.2020.03.12.10.46.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 10:46:45 -0700 (PDT)
From:   Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH v4 2/2] x86/purgatory: Make sure we fail the build if
 purgatory.ro has missing symbols
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
References: <20200311214601.18141-1-hdegoede@redhat.com>
 <20200311214601.18141-3-hdegoede@redhat.com>
 <20200312001006.GA170175@rani.riverdale.lan>
Message-ID: <e96ea0cc-954d-2cd3-8d9d-53d57856d8aa@redhat.com>
Date:   Thu, 12 Mar 2020 18:46:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200312001006.GA170175@rani.riverdale.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/12/20 1:10 AM, Arvind Sankar wrote:
> On Wed, Mar 11, 2020 at 10:46:01PM +0100, Hans de Goede wrote:
>> Since we link purgatory.ro with -r aka we enable "incremental linking"
>> no checks for unresolved symbols is done while linking purgatory.ro.
>>
> 
> Do we actually need to link purgatory with -r? We could use
> --emit-relocs to get the relocation sections generated the way the main
> x86 kernel does, no?
> 
> Eg like the below? This would avoid the double-link creating
> purgatory.chk.

So I've changed the patch for this in my local tree over to the version
suggested below and tested kexec with this (and I can confirm that it
still works)

I'm wondering though if it would not be better to keep the purgatory.ro name ?  :

1. The generated ELF binary should still be relocatable
2. .ro files are part of the global .gitignore settings, for the
    new purgatory name we need to add an arch/x86/purgatory/.gitignore file
3. Keeping the purgatory.ro name will make the diff easier to read

Regards,

Hans


> 
> diff --git a/arch/x86/purgatory/Makefile b/arch/x86/purgatory/Makefile
> index fb4ee5444379..5332f95ca1d3 100644
> --- a/arch/x86/purgatory/Makefile
> +++ b/arch/x86/purgatory/Makefile
> @@ -14,8 +14,8 @@ $(obj)/sha256.o: $(srctree)/lib/crypto/sha256.c FORCE
>   
>   CFLAGS_sha256.o := -D__DISABLE_EXPORTS
>   
> -LDFLAGS_purgatory.ro := -e purgatory_start -r --no-undefined -nostdlib -z nodefaultlib
> -targets += purgatory.ro
> +LDFLAGS_purgatory := -e purgatory_start --emit-relocs -nostdlib -z nodefaultlib
> +targets += purgatory
>   
>   KASAN_SANITIZE	:= n
>   KCOV_INSTRUMENT := n
> @@ -55,7 +55,7 @@ CFLAGS_sha256.o			+= $(PURGATORY_CFLAGS)
>   CFLAGS_REMOVE_string.o		+= $(PURGATORY_CFLAGS_REMOVE)
>   CFLAGS_string.o			+= $(PURGATORY_CFLAGS)
>   
> -$(obj)/purgatory.ro: $(PURGATORY_OBJS) FORCE
> +$(obj)/purgatory: $(PURGATORY_OBJS) FORCE
>   		$(call if_changed,ld)
>   
>   targets += kexec-purgatory.c
> @@ -63,7 +63,7 @@ targets += kexec-purgatory.c
>   quiet_cmd_bin2c = BIN2C   $@
>         cmd_bin2c = $(objtree)/scripts/bin2c kexec_purgatory < $< > $@
>   
> -$(obj)/kexec-purgatory.c: $(obj)/purgatory.ro FORCE
> +$(obj)/kexec-purgatory.c: $(obj)/purgatory FORCE
>   	$(call if_changed,bin2c)
>   
>   obj-$(CONFIG_KEXEC_FILE)	+= kexec-purgatory.o
> 

