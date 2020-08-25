Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2122CC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 12:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC81020706
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 12:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IekHNPFe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730201AbgHYMM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 08:12:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:27562 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730204AbgHYMMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 08:12:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598357528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=upnq8NEVm+7U4uzaDHupvA1NaUQYK9efVkZAiFGd+EI=;
        b=IekHNPFeUAluz9WSVhURfySD6QxQMzOQ15E0DcuQgOx8WMBVksDqVzXQxXSEW6OIWaRoMe
        UPcRj7GoSdoK+MgqT0B/oZWScikiS8ieE741zlIzLz7fiXABPw1xZ3q2F441YZZn7cHzaH
        +vMc4VSgDsUmPB/aKD/omLCe0qaVLzw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-361-_DVrOnUDPDKKxYnVT8Vqdw-1; Tue, 25 Aug 2020 08:12:06 -0400
X-MC-Unique: _DVrOnUDPDKKxYnVT8Vqdw-1
Received: by mail-wr1-f70.google.com with SMTP id w2so4838459wrr.19
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 05:12:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=upnq8NEVm+7U4uzaDHupvA1NaUQYK9efVkZAiFGd+EI=;
        b=Y5aegRh/k9KZuxCja/hnhpjbCQgVK5oQRLJ9bdbCJi4PP92h0vdfupJwMs84GZz/tP
         KOeXLuBnclHEG/NBI3hUW1IszUkbp4qgGX2IE1bhPW9ndzaafLsjxhNW+jMXdaggmN5d
         ld7Zs0ZXyE/oUcrlZs6KGSWAiWBPXoizJVRaPqgMfxEu+iT+9LmfILsWPEs/8lsqQAbL
         7UYUSINIcdT5crGV9WBc6Xx/j28R4tzjXnT5fENpIyqmvKVnqMgL8Rzp3N9svM5qWMpI
         7YUDClf13mh6AQERRhG02Ul1cfFmjO6d7r8CHRF9b840gx3EK61o/+VEhH/DThEWGaQL
         YE3Q==
X-Gm-Message-State: AOAM5311tmeH6a2hSTCIaqzzwLlGLfwS1X/ENNVd+cVSEFucO2oA/eFS
        JMCqSq484CAtMxaO2tSr+u5z5P+VBm2X9hVzTpmzd8BE0HKabCgS3AXKkFbIxGzjeZOWNsTBGnx
        j8YL752L/MZelzVCE8Nu+CsG1
X-Received: by 2002:a1c:f402:: with SMTP id z2mr1713578wma.87.1598357525844;
        Tue, 25 Aug 2020 05:12:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyDVwpKikgxEP7+hKoX+7FhiabuIK5zACSaMY1YEFAc0TP1HL1kvfWD7azMdBk1T5V9Ygk2hw==
X-Received: by 2002:a1c:f402:: with SMTP id z2mr1713558wma.87.1598357525673;
        Tue, 25 Aug 2020 05:12:05 -0700 (PDT)
Received: from ?IPv6:2a01:cb14:499:3d00:cd47:f651:9d80:157a? ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id j8sm10280508wrs.22.2020.08.25.05.12.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2020 05:12:05 -0700 (PDT)
Subject: Re: [PATCH v2 8/9] frame: Make unwind hints definitions available to
 other architectures
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, benh@kernel.crashing.org
References: <20200730094652.28297-1-jthierry@redhat.com>
 <20200730094652.28297-9-jthierry@redhat.com>
 <20200730145613.lbsexjcqwj67ktmb@treble>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <12615fa7-8ba9-1daa-f648-644bf16110f2@redhat.com>
Date:   Tue, 25 Aug 2020 13:12:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200730145613.lbsexjcqwj67ktmb@treble>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/30/20 3:56 PM, Josh Poimboeuf wrote:
> On Thu, Jul 30, 2020 at 10:46:51AM +0100, Julien Thierry wrote:
>> Unwind hints are useful to provide objtool with information about stack
>> states in non-standard functions/code.
>> While the type of information being provided might be very arch
>> specific, the mechanism to provide the information can be useful for
>> other architectures.
>>
>> Move the relevant unwint hint definitions for all architectures to
>> see.
> 
> The scope of include/linux/frame.h has been creeping, it's no longer
> just about frame pointers.  Maybe we should rename it to objtool.h.
> 

I missed this comment until now, sorry.

The name "objtool.h" might conflict with tools/objtool/objtool.h. What 
about "objtool_utils.h" or "objtool_defs.h" ?

-- 
Julien Thierry

