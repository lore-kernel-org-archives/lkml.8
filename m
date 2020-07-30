Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8DBC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 14:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91FB220829
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 14:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PEa1sYo+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729599AbgG3OmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 10:42:16 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39490 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728462AbgG3OmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 10:42:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596120134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kMSPwb1etFyzoIcdbAVB17SQWsfWen8ZJAVvIL55HPY=;
        b=PEa1sYo+F2QLLCZQTMSTpklAfgYyZzzrajI3lKYK4a5BdQorruOW0g0R3hKzYg4W3VcgAS
        J3JFKAV4vGxeDvDMfrBiYEPsmcF7xPM0wP04Od9d/WndoHJLtJ8hX4KnlIrOogjc8cS+HS
        HMVXOUhtkKTuxtp6+qjjTQWXJ4Zxu0A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-bVNqYHHOP8-mp1Ku_y86zQ-1; Thu, 30 Jul 2020 10:42:12 -0400
X-MC-Unique: bVNqYHHOP8-mp1Ku_y86zQ-1
Received: by mail-wr1-f72.google.com with SMTP id t3so6985219wrr.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 07:42:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kMSPwb1etFyzoIcdbAVB17SQWsfWen8ZJAVvIL55HPY=;
        b=KYPJBlpYy0vQ0HQCNtV19JKGASvvg/f/bS0xmY050ONQ9hraUxHP9GXx5diOSdNC2b
         U/kcatZ+5DEgyFfP8VOo3kxM/T9b+dZ9h8QBE+kRIhLr1m3CUQCOHxDjTzf7Y5ITVUSZ
         Dh7Jy+DNgbthHVf+NLT7KRh3Hcob//itr/DNwg48ONLbaHRtpFVQE4fe9DMe9Raiz+Cd
         FA3UpdbUKBw3TokWeQt0qy9JXpDemztWZuy9jUkECaRYbAKIB2FfPMqFRMRCYmUzJx7X
         yiv7PcwfCNGfVOhFkVLeQ8WJIiHdy+mVJHQ9jl37ZsTFQeWdYNaUYp6DizyHdhV4m93r
         ygZg==
X-Gm-Message-State: AOAM53153TDKRw4Trk+bm+5MbIS2eGZVVHpyUFow7hUug5/MXiaPF5ai
        xZ/qXmy24UttoA0NQsrYTbFoCUNLJ956xoFOo1+AsAjLkW5gYtIfszhO23pZ5QWU5LMDFLyCDyG
        C/hDXb022c5JitQT6kqspMICZ
X-Received: by 2002:a5d:51c3:: with SMTP id n3mr3172352wrv.104.1596120131352;
        Thu, 30 Jul 2020 07:42:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwYtVkLYNSwnOVhiVSEhOm66tDC6ymDuzh1WKYyGYOJyFk3NZUUIlqMiwi/QARFoKvOHrwfOA==
X-Received: by 2002:a5d:51c3:: with SMTP id n3mr3172312wrv.104.1596120130776;
        Thu, 30 Jul 2020 07:42:10 -0700 (PDT)
Received: from ?IPv6:2a01:cb14:499:3d00:cd47:f651:9d80:157a? ([2a01:cb14:499:3d00:cd47:f651:9d80:157a])
        by smtp.gmail.com with ESMTPSA id h7sm6561387wmf.43.2020.07.30.07.42.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2020 07:42:10 -0700 (PDT)
Subject: Re: [PATCH v3 0/4] Remove dependency of check subcmd upon orc
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mhelsley@vmware.com, mbenes@suse.cz
References: <20200730094143.27494-1-jthierry@redhat.com>
 <20200730140623.5aw7lm57j7qof5pm@treble>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <f63f8472-8b05-7457-f9ea-2a9f34e5d486@redhat.com>
Date:   Thu, 30 Jul 2020 15:42:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200730140623.5aw7lm57j7qof5pm@treble>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/30/20 3:06 PM, Josh Poimboeuf wrote:
> On Thu, Jul 30, 2020 at 10:41:39AM +0100, Julien Thierry wrote:
>> Hi,
>>
>> Matt Helsley's change[1] provided a base framework to opt-in/out
>> objtool subcommands at compile time. This makes it easier for
>> architectures to port objtool, one subcommand at a time.
>>
>> Orc generation relies on the check operation implementation. However,
>> the way this is done causes the check implementation to depend on the
>> implementation of orc generation functions to call if orc generation is
>> requested. This means that in order to implement check subcmd, orc
>> subcmd also need to be implemented.
>>
>> These patches aim at removing that dependency, having orc subcmd
>> being built on top of the check subcmd.
>>
>>
>> Changes since v2 [2]:
>> - Rebased on recent tip/objtool/core
> 
> tip/objtool/core is slightly outdated, I got a conflict with patch 1.
> 
> I guess linus/master would be best.

It looks like linus/master is missing the rela -> reloc rework that is 
present in tip/objtool/core, which will conflict with other patches from 
this series.

How shall I proceed?

-- 
Julien Thierry

