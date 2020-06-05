Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382AFC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 07:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1121F207D3
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 07:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rMowy/F+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgFEHmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 03:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbgFEHmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 03:42:49 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5005CC08C5C2
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 00:42:49 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id y20so349331wmi.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 00:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=2zBz3bzqiIBLdPn/9IwF2ihYh69MWEi+ZBZyxzI3nxQ=;
        b=rMowy/F+3yHhBXksr7Biapg4pP05Ey0QQeaD8SMWPFkxB5y3Y/nafeSkudoc/4bdJb
         sG5yvGvStSL/YHlWoNqBSuke2MxYlb0lFZOEGZoubgg/KzFwuedKsqDyOwjQvKkTpAJg
         TmJbndYPtxBMLQ/IsIDoeZ/XXXGbXpgDlyao4u2oAlzZZHs48xi6ziq5RJF1vwmsnlDI
         BS1Vqei5TLgX+uH4szf1LZySHVB+cYz7g8WecgDdXGYIJqAm4yhE7OuyHOtBDOaQmHYs
         EVRPPF3wPWERIFPYS/BEiTPxQg+LXK1OORfJnghKLUoEE91cX5PTXfhmHNXwZnIiSW2h
         1qIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=2zBz3bzqiIBLdPn/9IwF2ihYh69MWEi+ZBZyxzI3nxQ=;
        b=fF9G49D8bYmRyiEaro/Plmokn/hbR0mZwIk7kSqwRvgZO4SvlZ55OR9hWNmbRPmwXU
         kBu4WVB/s3eRDV0lwHVCaSDPjQAKKFCcLr5Ai9BACw6jFPIWHA3v2s2yMdY3tkNDynjX
         rbmW26GUDRzCqIGW6oBD9nVxY16huNwO6Hlmall7mED64W/UCPc1KFND7RqBd+UhmI8n
         11UETdEXpD/21IMYg9q6IHfjnyK4rA/NJ//TPom61tNwl5XkpbfDQAtX6kSce44ZrP6Q
         pbLvAWxLZxpaAYPhPgZpXL44zwlA73L4lnxM7N8JVSnF7aEfLc68Ewj3Jq7PhyPGVE6Z
         uGsQ==
X-Gm-Message-State: AOAM532RIovxyk+vL3tNzUHoixsUvzLuxKSoqE/rpY65i5r/cCBKaGbO
        4KFgn43rVJN91zqwFUWbsA==
X-Google-Smtp-Source: ABdhPJwBjzmJ1sZnBR4ZI/rYN6nwZPOZEAdB3By+56a8kjGwP+qFXPm9lT+P+wLirbOSxYhDfPl0zw==
X-Received: by 2002:a1c:7f96:: with SMTP id a144mr1332514wmd.176.1591342967936;
        Fri, 05 Jun 2020 00:42:47 -0700 (PDT)
Received: from earth2.lan (host-92-15-172-76.as43234.net. [92.15.172.76])
        by smtp.gmail.com with ESMTPSA id q1sm9877150wmc.12.2020.06.05.00.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 00:42:47 -0700 (PDT)
From:   "=?ISO-8859-15?B?/YCAgISB?=" <jbi.octave@gmail.com>
X-Google-Original-From: =?ISO-8859-15?B?/YCAgISB?= <djed@earth2.lan>
Date:   Fri, 5 Jun 2020 08:42:35 +0100 (BST)
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
cc:     Steven Rostedt <rostedt@goodmis.org>,
        Jules Irenge <jbi.octave@gmail.com>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        paulmck@kernel.org, mingo@redhat.com, boqun.feng@gmail.com,
        Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 4/5] x86/ftrace: Add annotations for ftrace_arch_code_modify_prepare()
 and ftrace_arch_code_modify_post_process()
In-Reply-To: <20200602231000.6pfrgdgm4vd7sbvn@ltop.local>
Message-ID: <alpine.LFD.2.22.394.2006050829250.4212@earth2.lan>
References: <20200601184552.23128-1-jbi.octave@gmail.com> <20200601184552.23128-5-jbi.octave@gmail.com> <20200601154647.581fa345@oasis.local.home> <20200602231000.6pfrgdgm4vd7sbvn@ltop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 3 Jun 2020, Luc Van Oostenryck wrote:

> On Mon, Jun 01, 2020 at 03:46:47PM -0400, Steven Rostedt wrote:
>> On Mon,  1 Jun 2020 19:45:51 +0100
>> Jules Irenge <jbi.octave@gmail.com> wrote:
>>
>>> Sparse reports warnings
>>>
>>> warning: context imbalance in ftrace_arch_code_modify_prepare()
>>> 	- wrong count at exit
>>> warning: context imbalance in ftrace_arch_code_modify_post_process()
>>> 	- wrong count at exit
>>>
>>> The root cause is that even if
>>>  the annotations on the function are correct,
>>> mutex do not support annotation
>
> Yes.
>
>> Wait what? This looks like either a bug in sparse, or we just remove the
>> annotations. This just makes the code ugly, and looks silly.
>
> The annotations added by commit
>  074376ac0e1d ("ftrace/x86: Anotate text_mutex split between ...
> are indeed wrong (because they don't match what the functions are
> really doing / mutex operations have never been annotated).
> The're also pointless since their prototypes are un-annotated.

Interesting, I would think the best way would then be to remove the 
annotations. There are quite a number of them.

I will have to investigate more on mutex and annotation before moving 
forward.

Thanks for feedback.

Jules
