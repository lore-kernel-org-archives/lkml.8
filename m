Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658B2C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 11:31:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39E7E20716
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 11:31:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VDY3zCsg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgCLLbs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 07:31:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50389 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726299AbgCLLbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 07:31:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584012706;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WYedCD1YUZGy9DvS5CpqX6J6lGrla8oQNj4cy6ig+Vg=;
        b=VDY3zCsgQpeT9ZwU2Vj41cCMh7YG8eFh8PVzIoMqMka38vsmqq18q0/kGvTDrmNeULK9sg
        mdKiBbv4m8fF9EkflDhOU49oXl8FBkI0ru96ZjLac98+npIawcZ3hfN34ZEy9H4XS3GYBG
        AAKvJqcvg5HIReAPX3QdydU/lqmVSGo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-z9taIy6tOEyjwrz0qSYHBQ-1; Thu, 12 Mar 2020 07:31:43 -0400
X-MC-Unique: z9taIy6tOEyjwrz0qSYHBQ-1
Received: by mail-wm1-f71.google.com with SMTP id n188so2019252wmf.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 04:31:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WYedCD1YUZGy9DvS5CpqX6J6lGrla8oQNj4cy6ig+Vg=;
        b=cCAElxXyVsPT6t9O6tzq/Zd+xrkM9ZTn958PkojZxUalnKhXnT4uYqr+PgDkAhg2mD
         Ra4Ya4K3vziPQnnMVPkhGsPNqGhElGGuZLyfruRXsd5zZ5Bc1J7XSOsRHJ6SqY1SWbXz
         omLOvhSrl6PB379dP2Cj+4fRO1UNrtexmuokxEN2+Pr79wxhkcklm1HEq92Ki3JRpWft
         hThQDv/G/5z7H0JBBGfcoQOxvPZACQbztA6HZUndWkjYP72Z68grJedIqntVFDCBdFup
         OShJ6PmQXoDM8zisQa809r1T6zkmPOgWIYIbrdCeZLinDnMdKoeBVG4u80IY+63t+azC
         gcYg==
X-Gm-Message-State: ANhLgQ3sLKJhoCJD4npZm5Gn/+ME8reCTfRyDS9oMamfLqwCjeh72r6e
        B2GrW9WPlgtn/hodTuGYTmZ6Vrs6nJdLpZEQKEbrA3L4UPg+i5vwS55JusEA7wBQstStt17rIOT
        Zy1zwZnrESWDiWGBapKSfo21f
X-Received: by 2002:adf:f9c4:: with SMTP id w4mr1801709wrr.98.1584012701189;
        Thu, 12 Mar 2020 04:31:41 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtOZNckdsTW36SkcK19G1I1mmBeaw6EdevdMDHC0vXO4tTiIePYg+w4kW7dMobF7uNBTP1MJA==
X-Received: by 2002:adf:f9c4:: with SMTP id w4mr1801684wrr.98.1584012700893;
        Thu, 12 Mar 2020 04:31:40 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-fc7e-fd47-85c1-1ab3.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:fc7e:fd47:85c1:1ab3])
        by smtp.gmail.com with ESMTPSA id g5sm7903150wrr.57.2020.03.12.04.31.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 04:31:40 -0700 (PDT)
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
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <3d58e77d-41e5-7927-fe84-4c058015e469@redhat.com>
Date:   Thu, 12 Mar 2020 12:31:39 +0100
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

Ok, I've just given that a try and it does indeed catch missing symbols
I'm not sure if it still generates a working purgatory though (I did
not try kexec from a kernel with it).

Since this all is somewhat black magic to me, my goal was to not change
how we build the purgatory while still adding a step which checks for
missing symbols, as my changes from a while back to unify all the SHA256
implementations in the kernel had accidentally caused a missing symbol
which went unnoticed for a while.

Also the same patch, using the 2 step approach has already been merged
for the s390x purgatory code, so doing it your way would lead to 2
different approaches in the kernel.

I do agree that your way does seem to be more elegant though...

I also see that the kbuild test robot has managed to come up with
yet another set of Kconfig options triggering missing symbols.

IMHO this shows that we really need some patch to detect these,
because clearly there are a lot of config-s with missing symbols
in the purgatory out there with no-one noticing.

I will send out a v5 of my patch-set changing the first patch to
also fix the new issue the kbuild test robot has found. I'm going
to leave this patch as is. If you prefer replacing the second patch
in the set (this patch) with your solution then that is fine with me.

Regards,

Hans


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

