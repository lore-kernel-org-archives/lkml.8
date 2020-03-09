Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DA45C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 22:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7711C24649
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 22:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbgCIWeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 18:34:20 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41567 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbgCIWeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 18:34:20 -0400
Received: from mail-pj1-f71.google.com ([209.85.216.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <matthew.ruffell@canonical.com>)
        id 1jBQyX-0004k8-Rt
        for linux-kernel@vger.kernel.org; Mon, 09 Mar 2020 22:34:18 +0000
Received: by mail-pj1-f71.google.com with SMTP id z5so708866pjq.9
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 15:34:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+KQcrw2yUpe9WcR5YMys+lGugYtYd9Ok8ZJgn9f16J4=;
        b=sFbLTyOMdtKfT5TpUOt0+rw7FvmNxAxMBR7oE/4/EhY1ybUrLTZZ+TjIB0DJMAh0vL
         cQXmA8QMy0WoNClv88GewTJsE2Z/uOybAECd6OccPh4Wwqf9Oh/mpK5YguoYzirVgDOS
         rXgWUCcbomwXI2RdirF+mfJVta2z+RVyQsfad5xkR7I8leSt2FkGMEliZbEI6FzE654F
         iHAga4swCXGIO8sbXvVQoCAP5oEIMzSPe8taHkNPWVYjWG3LdgBlGUnpgulLlcMRYEct
         Kwd68aCkUK+EOCUJ6osWEgF3oZ1ohqnjhqrYtPep3akOvrh4bFhIGfpFYQGSi3d06+7d
         TX3A==
X-Gm-Message-State: ANhLgQ3S+W+ANG8+drM2nuLfGeoJwRMwC/TQ+wYWa6tYZ1mIaucVSt/n
        77WcHluWJHBkUKKPQqChkj+KqWbTldIItAafrgy6Sf1CYidMWLmTWxCiDydKDty9REx/4/tfabT
        fuvm14J36iU41y8joq0abe/5uYS8rK10B/LFa56/HFA==
X-Received: by 2002:a17:90a:34f:: with SMTP id 15mr1519159pjf.94.1583793255496;
        Mon, 09 Mar 2020 15:34:15 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs9VxY4puLe/6q81FmP2tIbuWYuBZTOustWorHqidrzJwquI0Ks5GiUbA9IKsHYKfvh7tTcIQ==
X-Received: by 2002:a17:90a:34f:: with SMTP id 15mr1519132pjf.94.1583793255202;
        Mon, 09 Mar 2020 15:34:15 -0700 (PDT)
Received: from [192.168.1.107] (222-154-99-146-fibre.sparkbb.co.nz. [222.154.99.146])
        by smtp.gmail.com with ESMTPSA id t142sm36524584pgb.31.2020.03.09.15.34.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2020 15:34:14 -0700 (PDT)
Subject: Re: [PATCH 0/1] coredump: Fix null pointer dereference when
 kernel.core_pattern is "|"
To:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Paul Wise <pabs3@bonedaddy.net>,
        Neil Horman <nhorman@tuxdriver.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jakub Wilk <jwilk@jwilk.net>
References: <20200220051015.14971-1-matthew.ruffell@canonical.com>
 <645fcbdfdd1321ff3e0afaafe7eccfd034e57748.camel@bonedaddy.net>
From:   Matthew Ruffell <matthew.ruffell@canonical.com>
Message-ID: <87a47997-3cde-bc86-423b-6154849183e9@canonical.com>
Date:   Tue, 10 Mar 2020 11:34:09 +1300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <645fcbdfdd1321ff3e0afaafe7eccfd034e57748.camel@bonedaddy.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Can I please get some feedback on this patch? Would be good to clear up the
null pointer dereference.

Thanks,
Matthew
