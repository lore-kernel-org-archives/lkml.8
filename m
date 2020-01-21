Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5327C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 16:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A753B217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 16:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VlYZOAJt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbgAUQh4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 11:37:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46906 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729080AbgAUQhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 11:37:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579624674;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=abtmIMJm04CNK0z3Gup9HgLlCssSlhpt5m2hBJjGsNQ=;
        b=VlYZOAJtX1F5DKzpJkDVBuG150ngoiormNDlHuUuDTW+iWRR6pX8O0y4HYyn27/5jnrXiK
        MKIRcirpvEakzt8xoMVFOfD3rf37PYezqaXMO4tDbJZUu4K0mbubicJwFL0/fwDx5OIXIk
        AT57kOe/v88cpZ1kZtlqfikddph4YDU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-4NcSvj2hPyCPOsShpi4Cpw-1; Tue, 21 Jan 2020 11:37:52 -0500
X-MC-Unique: 4NcSvj2hPyCPOsShpi4Cpw-1
Received: by mail-wr1-f69.google.com with SMTP id c6so1564499wrm.18
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 08:37:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=abtmIMJm04CNK0z3Gup9HgLlCssSlhpt5m2hBJjGsNQ=;
        b=odIWNYHL6Oj4R53Zxx5Vilt8R0pXI0TsAg5KPRDiud+8870Iq6C3+ARqrhrLwfTv2Z
         +dM7Qt2czt16YX5kpGP4Z5uKMhj4QsSweN98TH0JoPjqjQTs2xVtluGxD1ZZIh7I6W4o
         ZTaHcLzzMMyQszO8CHv2n/DLsXa/inTLiPnqio6TRgYQEsxqEDj0kUCGxI313Se3kh2H
         9sO4cjOZEjUpaLFGFZ2s2t7A6JD6BDD1OCnM35CwZ3qQkRcubLlvirO7DPelp0D/6Qaz
         7D2zPMU6HrmvkwD+kqFBhBZ6bccBDfxxLXZjTmSHj9/55BoBuku39g0ToqoZL2ihVKU2
         WZZw==
X-Gm-Message-State: APjAAAWDGBXnLyTTEUdfSr23lVcKsptZoN7w3xkLq/mn9q8FydMC1lNh
        SzSc4XyOcC9UmYxfB/KqVl0SyHOu9RShdW+LHrTVZ3W6T/bGLiA6Xna5tSWA7Vt9ANP0swUc/Gk
        d7N5pi0QO0GXS+vFu1ePbD8xJ
X-Received: by 2002:a1c:2355:: with SMTP id j82mr5012327wmj.135.1579624671071;
        Tue, 21 Jan 2020 08:37:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqzFcLJHP5VCbWnoFVzJPWaritQLFg2yRWXQXM6+awZuDF3lGaFzhf0XxVGrw2rCcAXhcivCKQ==
X-Received: by 2002:a1c:2355:: with SMTP id j82mr5012320wmj.135.1579624670914;
        Tue, 21 Jan 2020 08:37:50 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id g9sm53310585wro.67.2020.01.21.08.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 08:37:50 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Waiman Long <longman@redhat.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH RFC] x86/speculation: Clarify Spectre-v2 mitigation when STIBP/IBPB features are unsupported
In-Reply-To: <20c1c0f2-046e-eb77-d655-75f62ebafcb2@redhat.com>
References: <20200121160257.302999-1-vkuznets@redhat.com> <20c1c0f2-046e-eb77-d655-75f62ebafcb2@redhat.com>
Date:   Tue, 21 Jan 2020 17:37:49 +0100
Message-ID: <87sgk8epeq.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Waiman Long <longman@redhat.com> writes:

> On 1/21/20 11:02 AM, Vitaly Kuznetsov wrote:
>> When STIBP/IBPB features are not supported (no microcode update,
>> AWS/Azure/... instances deliberately hiding SPEC_CTRL for performance
>> reasons,...) /sys/devices/system/cpu/vulnerabilities/spectre_v2 looks like
>>
>>   Mitigation: Full generic retpoline, STIBP: disabled, RSB filling
>>
>> and this looks imperfect. In particular, STIBP is 'disabled' and 'IBPB'
>> is not mentioned while both features are just not supported. Also, for
>> STIBP the 'disabled' state (SPECTRE_V2_USER_NONE) can represent both
>> the absence of hardware support and deliberate user's choice
>> (spectre_v2_user=off)
>>
>> Make the following adjustments:
>> - Output 'unsupported' for both STIBP/IBPB when there's no support in
>>   hardware.
>> - Output 'unneeded' for STIBP when SMT is disabled/missing (and this
>>   switch_to_cond_stibp is off).
>
> I support outputting "unsupported" when the microcode doesn't support
> it. However, I am not sure if "unneeded" is really necessary or not.
> STIBP is not needed when SMT is disabled or when Enhanced IBRS is
> available and used. Your patch handles the first case, but not the
> second. I think it may be easier to just leave it out in case it is not
> needed.

Makes sense. Or, alternatively, we can output 'unneeded' in both cases
to make things explicit and  to distinguish it from the current state of
IBPB where missing means 'unsupported by hardware'.

-- 
Vitaly

