Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E89EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 07:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5ACD207F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 07:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VvRt/wlO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731623AbgGaHYf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 03:24:35 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51651 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731419AbgGaHYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 03:24:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596180274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Axelt2RY002V96X/6od/cNKhxMrCAxFb0qQJIDFr3Wc=;
        b=VvRt/wlOUe9wHLhC2FrF9mjZAqzW/oI14cJ+YUwJg4q2fdWi2BMvvQ/unvD5w6N+4qWhGF
        YwiDG8npWmreBRJ6QA/AXTX1phJJKZrSFa6xxkORTPvmWflEQ7TzOTz8j2Dgi5XS4mMpXA
        5nHofAOQeBCfYTTCUlffyHh7lIvdYCw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-rDPsPRtROJKtdZebIe-WMw-1; Fri, 31 Jul 2020 03:24:31 -0400
X-MC-Unique: rDPsPRtROJKtdZebIe-WMw-1
Received: by mail-wm1-f72.google.com with SMTP id h6so1879695wml.8
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 00:24:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Axelt2RY002V96X/6od/cNKhxMrCAxFb0qQJIDFr3Wc=;
        b=iF9uNLObBcW/1Mo5cMmN2okmKzyisDTQfHYN1zEPutSUSlPu0irVYzqxKHuFZ2yL79
         MiAoU6eBjx58zu6DhWBxcuU4WBmN3Q7SvOrNQIRqO5tad8d1+CaSMaNiJC/aEAIZM7XP
         c02Hndl2ATFgahvFOHz+XK6id63VpdpNjGmHpGeHTjgTnT0rz6t3vqi1HWzEO/scXOnt
         H2OFQ7Ji21ABLSJ14d9Np+9VbGLIL+LXj7sse6yAshT0mKbg5HQRv2BanMTmkRQElSOT
         P0oghtrVJjvOM278iePfBQUoD6+HIs1vmxhSg8akxxo95jhE5iOEAO16UjzL+WMAS76f
         IIIw==
X-Gm-Message-State: AOAM533FTBLS3Qady1eY9rBCIBBcQTvoikEQy+8V0B5QLU4oZBflViVL
        wdtR+m7b/ydFlCfrlWNcSre4gSOFxQLbagYTol1hzzDnUiktwjC7XFXMUH8BsEXYV6LyAigoY1f
        i8gwAGCAo7jDUt6cpiU6Ji3l+
X-Received: by 2002:a05:600c:202:: with SMTP id 2mr2557515wmi.139.1596180270311;
        Fri, 31 Jul 2020 00:24:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzuUf4LZZEWzUNzddGf4m3XSjMPOhUMgt/Pblcm5cFiDmLTzeqQjTr9Ai30ee7oPgHoMtk9Mw==
X-Received: by 2002:a05:600c:202:: with SMTP id 2mr2557498wmi.139.1596180270115;
        Fri, 31 Jul 2020 00:24:30 -0700 (PDT)
Received: from ?IPv6:2a01:cb14:499:3d00:cd47:f651:9d80:157a? ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id a3sm12130042wme.34.2020.07.31.00.24.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Jul 2020 00:24:29 -0700 (PDT)
Subject: Re: [PATCH v2 5/9] objtool: Make relocation in alternative handling
 arch dependent
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, mbenes@suse.cz,
        raphael.gault@arm.com, benh@kernel.crashing.org
References: <20200730094652.28297-1-jthierry@redhat.com>
 <20200730094652.28297-6-jthierry@redhat.com>
 <20200730144213.fcitzo4uydshjhxh@treble>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <a4e74e30-1117-fe1f-785b-386a06d3c0ba@redhat.com>
Date:   Fri, 31 Jul 2020 08:24:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200730144213.fcitzo4uydshjhxh@treble>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/30/20 3:42 PM, Josh Poimboeuf wrote:
> On Thu, Jul 30, 2020 at 10:46:48AM +0100, Julien Thierry wrote:
>> As pointed out by the comment in handle_group_alt(), support of
>> relocation for instructions in an alternative group depends on whether
>> arch specific kernel code handles it.
>>
>> So, let objtool arch specific code decide whether a relocation for
>> the alternative section should be accepted.
>>
>> Reviewed-by: Miroslav Benes <mbenes@suse.cz>
>> Signed-off-by: Julien Thierry <jthierry@redhat.com>
>> ---
>>   tools/objtool/arch/x86/arch_special.c | 13 +++++++++++++
> 
> The "arch" in "arch_special.c" is redundant, how about special.c?
> 

Yes, that makes sense.

-- 
Julien Thierry

